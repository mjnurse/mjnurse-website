---
title: @ Elasticsearch CLI
---
## Definition file `es.def`

```bash
@ Elasticsearch 

cmd ES_HOST="${ES_HOST:-localhost}"
cmd ES_PORT="${ES_PORT:-9200}"
cmd if [[ "${ES_PATH%/}" != "" ]]; then ES_PATH="/${ES_PATH%/}"; fi
cmd ES_PROTOCOL="${ES_PROTOCOL:-http}"

@@ CLI uses environment variables: 
@@ - ES_PROTOCOL (default: http), 
@@ - ES_HOST (default: localhost)
@@ - ES_PORT (default: 9200), 
@@ - ES_PATH (default: <blank>), and 
@@ - ES_AUTH (default: <blank> - no auth required)
@@ Use command show settings (ss) to see environment variable values.

cmd pj() { if command -v jq >/dev/null 2>&1; then jq .; else cat; fi; }

cmd cols() { python3 -c 'import sys,json;f=lambda d,p="":[f(v["properties"],p+k+".") if isinstance(v,dict) and "properties" in v else print(p+k) for k,v in d.items()];[f(i["mappings"]["properties"]) for i in json.load(sys.stdin).values()]'; }

cmd q() { \
    local method="$1"; \
    shift; \
    if [[ "$ES_AUTH" != "" ]]; then \
        ES_AUTH="-u $ES_AUTH"; \
    fi; \
    curl -s -X $method $ES_AUTH $ES_PROTOCOL://$ES_HOST:$ES_PORT$ES_PATH/"$@"; \
}

# ----------------------------------------------------------------------------------------------------------------------------------
= HELP
# ----------------------------------------------------------------------------------------------------------------------------------

show settings (ss) :: \
    echo Environment Variables:; \
    echo ----------------------; \
    echo "ES_PROTOCOL: $ES_PROTOCOL"; \
    echo "ES_HOST:     $ES_HOST"; \
    echo "ES_PORT:     $ES_PORT"; \
    echo "ES_PATH:     $ES_PATH"; \
    if [[ "$ES_AUTH" == "" ]]; then \
        echo "ES_AUTH:     not set"; \
    else \
        echo "ES_AUTH:     is set"; \
    fi


# ----------------------------------------------------------------------------------------------------------------------------------
= CLUSTER
# ----------------------------------------------------------------------------------------------------------------------------------

clear cache (cc) [<index_name>] :: \
    q POST "$1/_cache/clear" \
    !! cat /tmp/es_idx_list 2>&1

cluster overview (co) :: \
    q GET ""

cluster health (ch) :: \
    q GET "_cluster/health?human&pretty"

cluster stats (cs) :: \
    q GET "_cluster/stats?human&pretty"

cluster recovery stats (crs) :: \
    q GET "_cat/recovery?v"

# ----------------------------------------------------------------------------------------------------------------------------------
= INDEX INTERROGATION
# ----------------------------------------------------------------------------------------------------------------------------------

count (c) <index_name> :: \
    q GET "$1/_count?pretty" \
    !! cat /tmp/es_idx_list 2>&1

list aliases (la) [<filter>] [<order_by_field_name>] :: \
    q GET "_cat/aliases/$1?v&s=$2"

list indices (li) [-s] [<index_name>] :: \
    ord="index"; \
    if [[ "$1" == "-s" ]]; then \
        ord="store.size"; \
        shift; \
    fi; \
    q GET "_cat/indices/$1?v&h=health,status,index,pri,rep,sc,docs.count,docs.deleted,store.size,pri.store.size&s=$ord" | tee /tmp/es_idx_list; \
    sed -i 's/^[^ ][^ ]*  *[^ ][^ ]*  *//; s/ .*//' /tmp/es_idx_list \
    !! cat /tmp/es_idx_list 2>&1

list open (lo) [<index_name>] :: \
    q GET "_cat/indices/$1?v&h=health,status,index,pri,rep,sc,docs.count,docs.deleted,store.size,pri.store.size&s=index" | sed "/ close  /d" \
    !! cat /tmp/es_idx_list 2>&1

list dot indices (ldi) :: \
    q GET "_cat/indices/.*?v&s=index" \
    !! cat /tmp/es_idx_list 2>&1

list shards (ls) [<index_name>] [<order_by_field_name>] :: \
    q GET "_cat/shards/$1?v&h=index,shard,prirep,sc,state,docs,store,node&s=index,shard,prirep&s=$2" \
    !! cat /tmp/es_idx_list 2>&1

list shard details (lsd) [<index_name>] [<order_by_field_name>] :: \
    q GET "_cat/shards/$1?v&h=index,shard,prirep,state,docs,store,ip,segments.count,unassigned.reason,unassigned.for,node&s=$2" \
    !! cat /tmp/es_idx_list 2>&1

list segments (le) [<index_name>] :: \
    q GET "_cat/segments/$1?v&s=index,shard,prirep" \
    !! cat /tmp/es_idx_list 2>&1

list segmented shards (lss) [<index_name>] :: \
    q GET "_cat/shards/$1?v&h=index,shard,prirep,state,docs,node,segments.count&s=index,shard,prirep,node" \
    !! cat /tmp/es_idx_list 2>&1

list avg segments per shard (lass) [<index_name>] :: \
    q GET "_cat/segments/$1?v&s=index,shard,prirep" | tail -n +2 | sed 's/[[:space:]]\+/ /g' | cut -d ' ' -f1,2 | \
    sort | uniq -c | \
    awk '{c=$1; i=$2; sh=$3; se_c[i]+=c; sh_c[i]++} END {printf "%-52s Avg Segments\n","Index"; for (i in se_c) {avg=se_c[i]/sh_c[i]; printf "%-60s %.2f\n", i, avg}}' | sort \
    !! cat /tmp/es_idx_list 2>&1

list fields (lf) <index_name> :: \
    q GET "$1/_mapping" | cols \
    !! cat /tmp/es_idx_list 2>&1

get index mapping (gim) <index_name> :: \
    q GET "$1/_mapping?pretty" | \
    sed -e ':a' -e 'N' -e '$!ba' \
       -e 's/\n *\([^"]*"type"\)/ \1/g' \
       -e 's/\n *\([^"]*"normalizer"\)/ \1/g' \
       -e 's/\n *\([^"]*"index"\)/ \1/g' \
       -e 's/\n *\([^"]*"ignore_above"\)/ \1/g' \
       -e 's/\n *\([^"]*"fields"\)/ \1/g' \
       -e 's/\n *\([^"]*"keyword"\)/ \1/g' \
       -e 's/\n *\([^"]*"raw"\)/ \1/g' \
       -e 's/\([a-z0-9"]\) *\n */\1 /g' \
       -e 's/} *\n *}/} }/g' \
       -e 's/} *\n *}/} }/g' \
    !! cat /tmp/es_idx_list 2>&1

list unassigned shards (lus) :: q GET "_cat/shards?v&h=index,shard,prirep,state,docs,segments.count&s=index,shard,prirep" 

forcemerge progress (fmp) :: \
    q GET "_cat/nodes?v&h=name,cpu,load_1m,merges.current,merges.current_docs,merges.total,merges.total_docs&s=name"

# ----------------------------------------------------------------------------------------------------------------------------------
= INDEX MANIPULATION
# ----------------------------------------------------------------------------------------------------------------------------------

add index to alias (aita) <index_name> <alias_name> :: \
    q POST "_aliases" -H 'Content-Type: application/json' -d '{"actions":[{"add":{"index":"'$1'","alias":"'$2'"}}]}' \
    !! cat /tmp/es_idx_list 2>&1

remove index from alias (rifa) <index_name> <alias_name> :: \
    read -p "Are you sure [yN]? " yn; \
    if [[ ${yn^} == Y ]]; then \
         q DELETE "$1/_aliases/$2"; \
    fi \
    !! cat /tmp/es_idx_list 2>&1

create index (ci) <index_name> <number_of_shards> <number_of_replicas> :: \
    q PUT "$1" -H 'Content-Type: application/json' -d '{"settings":{"index":{"number_of_shards":'$2',"number_of_replicas":'$3'}}}' \
    !! cat /tmp/es_idx_list 2>&1

create index from mapping (cifm) <index_name> <number_of_shards> <number_of_replicas> <mapping-json> :: \
    q PUT "$1" -H 'Content-Type: application/json' -d '{"settings":{"index":{"number_of_shards":'$2',"number_of_replicas":'$3'}},"mappings":'"$4"'}' \
    !! cat /tmp/es_idx_list 2>&1

clone index (clni) <index_name> <new_index_name> :: \
    q POST "$1/_clone/$2" \
    !! cat /tmp/es_idx_list 2>&1

delete index (di) <index_name> :: \
    read -p "Are you sure [yN]? " yn; \
    if [[ ${yn^} == Y ]]; then \
         q DELETE "$1"; \
    fi \
    !! cat /tmp/es_idx_list 2>&1

open index (opi) <index_name> :: \
    q POST "$1/_open" \
    !! cat /tmp/es_idx_list 2>&1

close index (cli) <index_name> :: \
    q POST "$1/_close" \
    !! cat /tmp/es_idx_list 2>&1

enable read only (ero) <index_name> :: \
    q PUT "$1/_settings" -H 'Content-Type: application/json' -d '{"index.blocks.write": true}' \
    !! cat /tmp/es_idx_list 2>&1

enable read write (erw) <index_name> :: \
    q PUT "$1/_settings" -H 'Content-Type: application/json' -d '{"index.blocks.write": false}' \
    !! cat /tmp/es_idx_list 2>&1

reindex index (ri) <source_index_name> <dest_index_name> :: \
    q POST "_reindex" -H 'Content-Type: application/json' -d '{"source":{"index":"'$1'"},"dest":{"index":"'$2'"}}' \
    !! cat /tmp/es_idx_list 2>&1

move shard (ms) <index_name> <shard_num> <from_node_name> <to_node_name> :: \
    q POST "_cluster/reroute" -H 'Content-Type: application/json' -d '{"commands":[{"move":{"index":"'$1'","shard":'$2',"from_node":"'$3'","to_node":"'$4'"}}]}' \
    !! cat /tmp/es_idx_list 2>&1

alter number replicas (anr) <index_name> <number_of_replicas> :: \
    q PUT "$1/_settings" -H 'Content-Type: application/json' -d '{"index":{"number_of_replicas":'$2'}}' \
    !! cat /tmp/es_idx_list 2>&1

disable shard allocation (dsa) :: \
    q PUT "_cluster/settings" -H 'Content-Type: application/json' -d '{"persistent":{"cluster.routing.allocation.enable":"primaries"}}'

reenable shard allocation (rsa) :: \
    q PUT "_cluster/settings" -H 'Content-Type: application/json' -d '{"persistent":{"cluster.routing.allocation.enable":null}}'

forcemerge (fm) <index_name> <max_num_segments> :: \
    q POST "$1/_forcemerge?max_num_segments=$2" \
    !! cat /tmp/es_idx_list 2>&1

refresh (r) <index_name> :: \
    q POST "$1/_refresh" \
    !! cat /tmp/es_idx_list 2>&1

# ----------------------------------------------------------------------------------------------------------------------------------
= INDEX ENTRY MANIPULATION
# ----------------------------------------------------------------------------------------------------------------------------------

add entry (ae) <index_name> <entry_json> :: q POST "$1/_doc" -H 'Content-Type: application/json' -d "$2" \
    !! cat /tmp/es_idx_list 2>&1

delete entry (de) <index_name> [<_id>] :: \
    if [[ "$2" == "" ]]; then \
        read -p "This will delete ALL RECORDS - Are you sure [yN]? " yn; \
        if [[ ${yn^} == Y ]]; then \
            q POST "$1/_delete_by_query" -H 'Content-Type: application/json' \
                 -d '{ "query": { "match_all": {} } }' | pj; \
        fi; \
    else \
        q POST "$1/_delete_by_query" -H 'Content-Type: application/json' \
             -d '{ "query": { "ids": { "values": [ "'$2'" ] } } }' | pj; \
    fi \
    !! cat /tmp/es_idx_list 2>&1 \
    ## No <id> will mean all documents deleted



# ----------------------------------------------------------------------------------------------------------------------------------
= NODES
# ----------------------------------------------------------------------------------------------------------------------------------

list nodes (ln) :: \
    q GET "_cat/nodes?v&h=name,ip,nodeRole,m,heapPercent,ramPercent,cpu,load_1m,load_5m,load_15m,disk.total,disk.used_percent&s=name"

list node attributes (lna) :: \
    q GET "_cat/nodeattrs?v&s=node"

list nodes queries (lnq) :: \
    q GET "_cat/nodes?v&h=name,nodeRole,search,queryTotal,searchFetchTotal,requestCacheHitCount&s=name"

search nodes (sn) :: \
    q GET "_nodes"

node active threads (at) :: \
    q GET "_cat/thread_pool?v&s=node_name,name"

node thread pool sizes (tps) :: \
    q GET "_cat/thread_pool?v&h=node_name,name,size,active,queue,queue_size,largest,min,max&s=node_name,name"

node perf overview (npo) :: \
    q GET "_cat/nodes?v&h=ip,port,role,master,cpu,ft,ftt,iic,iif,mt,mtt,d,mcs"

# ----------------------------------------------------------------------------------------------------------------------------------
= SEARCH
# ----------------------------------------------------------------------------------------------------------------------------------

search (s) <index_name> [<search_term>] :: \
    if [[ "$2" == "" ]]; then term="*"; else term="$2"; fi; \
    q GET "$1/_search?q=${term}&pretty" | pj \
    !! cat /tmp/es_idx_list 2>&1

search json (sj) <index_name> <search_json> :: \
    q GET "$1/_search?pretty" -H 'Content-Type: application/json' -d "$2" \
    !! cat /tmp/es_idx_list 2>&1

search match (sm) <index_name> <field_name> <value> :: \
    q GET "$1/_search?pretty" -H 'Content-Type: application/json' -d '{"query": { "match": { "'$2'": "'$3'" } } }' \
    !! cat /tmp/es_idx_list 2>&1

search term (st) <index_name> <field_name> <value> :: \
    q GET "$1/_search?pretty" -H 'Content-Type: application/json' -d '{"query": { "term": { "'$2'": "'$3'" } } }' \
    !! cat /tmp/es_idx_list 2>&1

search summary (ss) <index_name> <search_term> :: \
    q GET "$1/_search?size=0&pretty" -H 'Content-Type: application/json' -d '{"aggs": {"count": {"terms": { "field" : "'$2'", "size" : 100 } } } }' \
    !! cat /tmp/es_idx_list 2>&1

# ----------------------------------------------------------------------------------------------------------------------------------
= SQL
# ----------------------------------------------------------------------------------------------------------------------------------

sql (sql) <sql> :: \
    q="${1//\"/\\\"}"; \
    q="${q//\`/\'}"; \
    echo '{"query": "'"$q"'"}'; \
    curl -s -X POST "http://$ES_HOST:$ES_PORT/_sql?format=txt" \
         -H 'Content-Type: application/json' \
         -d '{"query": "'"$q"'"}' \
    ## Tips: tablenames in \x22\x22, can use: DESCRIBE \x22<table>\x22


# ----------------------------------------------------------------------------------------------------------------------------------
= TASKS
# ----------------------------------------------------------------------------------------------------------------------------------

list tasks (lt) [<sort_field>] :: \
    q GET "_cat/tasks?v&h=action,type,start_time,timestamp,running_time,node&s=$1"

list tasks detail (ltd) [<sort_field>] :: \
    q GET "_cat/tasks?v&s=$1"

# ----------------------------------------------------------------------------------------------------------------------------------
= REPOS / SNAPSHOTS
# ----------------------------------------------------------------------------------------------------------------------------------

add repo (are) <repo_name> <repo_location> [<base_path>] :: \
    q PUT "_snapshot/$1?pretty" -H 'Content-Type: application/json' -d '{ "type": "fs", "settings": { "location": "'$2'", "base_path": "'$3'" } } '

delete repo (dre) <repo_name> :: \
    read -p "Are you sure [yN]? " yn; \
    if [[ ${yn^} == Y ]]; then \
         q DELETE "_snapshot/$1?pretty"; \
    fi

list repos (lre) :: \
    q GET "_cat/repositories?v"

create snapshot (csn) <repo_name> <snapshot_name> :: \
    q PUT "_snapshot/$1/$2?pretty"

delete snapshot (dsn) <repo_name> <snapshot_name> :: \
    read -p "Are you sure [yN]? " yn; \
    if [[ ${yn^} == Y ]]; then \
         q DELETE "_snapshot/$1/$2?pretty"; \
    fi

list snapshots (lsn) :: \
    q GET "_cat/snapshots?v"

snapshot details (snd) <repo_name> <snapshot_name> :: \
    q GET "_snapshot/$1/$2?pretty"

restore snaphot (rsn) <repo_name> <snapshot_name> :: \
    q POST "_snapshot/$1/$2/_restore?pretty"

# ----------------------------------------------------------------------------------------------------------------------------------
= GENERIC
# ----------------------------------------------------------------------------------------------------------------------------------

generic (g) <type-GET/POST/PUT> <api_call> :: curl -s -X $1 "http://$ES_HOST:$ES_PORT/$2"

query-es settings (qes) :: query-es -s





### get cluster settings - shows what has been set through api, does not show config file settings:
###
### curl -s -X GET http://$ES_HOST:$ES_PORT'/_cluster/settings?pretty'

### debug
### enable debug for every node:
###
### curl -s -X PUT http://$ES_HOST:$ES_PORT'/_cluster/settings?pretty' -d'{"transient": {"logger.discovery.zen":"TRACE"}}'

### debug security logger:
###
### "logger.org.elasticsearch.xpack.security" : "TRACE"
### debug ldap logger:
###
### "logger.org.elasticsearch.xpack.security.authc.ldap" : "TRACE"
### dump of all cluster state: nodes, indexes, shards and placements - BIG:
###
### curl -s -X PUT http://$ES_HOST:$ES_PORT'/_cluster/state'

### overview:
###
### get _cat/nodes?v&s=name&h=name,fielddataMemory,fielddataEvictions
### detailed stats on a per field/node basis:
###
### GET /_nodes/stats/indices/fielddata?fields=*
### performance: request cache
### This cache is hit first on the coordinating node and caches a result in its entirety
###
### full request cache stats on a per cluster and per index basis:
###
### GET /_stats/request_cache?human
### TODO: more
###
### performance: shard cache
### This cache is hit second on the participating nodes and caches the shard contents
###
### https://www.elastic.co/guide/en/elasticsearch/reference/master/shard-request-cache.html
###

### templates
### list templates:
###
### curl -s -X GET http://$ES_HOST:$ES_PORT'/_cat/templates?v'

### get security templates:
###
### curl -s -X GET http://$ES_HOST:$ES_PORT'/_template/security-index-template?pretty'

### shards, replicas & recovery
### view the shard states for an index:
###
### curl -k -s -X GET http://$ES_HOST:$ES_PORT'/_cat/shards/ams-txn-061918_jaro?v&s=index,node,sh&h=index,node,sh,pr,state,docs,store,recoverysource.type,unassigned.reason,unassigned.for'

### explain allocation - explain why we have unallocated shards:
###
### curl -s -X GET http://$ES_HOST:$ES_PORT'/_cluster/allocation/explain?pretty'



# PUT _cluster/settings
# {
#   "transient": {
#     "cluster.routing.allocation.disk.watermark.low": "100gb",
#     "cluster.routing.allocation.disk.watermark.high": "50gb",
#     "cluster.routing.allocation.disk.watermark.flood_stage": "10gb",
#     "cluster.info.update.interval": "1m"
#   }
# }
```

## Alias file

```bash
# Completion function
_es_complete() {
    local cur prev all
    all=""
    for ((i = 1; i < ${#COMP_WORDS[@]}; i++)); do
        word="${COMP_WORDS[i]}"
        [[ $word != -* ]] && all+="$word "
    done
    all="$(echo $all | xargs)"
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev_step=1
    prev="${COMP_WORDS[COMP_CWORD-$prev_step]}"
    while [[ "${prev:0:1}" == "-" ]]; do
        let prev_step=prev_step+1
        prev="${COMP_WORDS[COMP_CWORD-$prev_step]}"
    done

        if [[ "$all" == "clear cache" || "$prev" == "ecc" || "$prev" == "@ecc" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "count" || "$prev" == "ec" || "$prev" == "@ec" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "list indices" || "$prev" == "eli" || "$prev" == "@eli" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "list open" || "$prev" == "elo" || "$prev" == "@elo" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "list dot indices" || "$prev" == "eldi" || "$prev" == "@eldi" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "list shards" || "$prev" == "els" || "$prev" == "@els" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "list shard details" || "$prev" == "elsd" || "$prev" == "@elsd" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "list segments" || "$prev" == "ele" || "$prev" == "@ele" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "list segmented shards" || "$prev" == "elss" || "$prev" == "@elss" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "list avg segments per shard" || "$prev" == "elass" || "$prev" == "@elass" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "list fields" || "$prev" == "elf" || "$prev" == "@elf" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "get index mapping" || "$prev" == "egim" || "$prev" == "@egim" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "add index to alias" || "$prev" == "eaita" || "$prev" == "@eaita" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "remove index from alias" || "$prev" == "erifa" || "$prev" == "@erifa" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "create index" || "$prev" == "eci" || "$prev" == "@eci" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "create index from mapping" || "$prev" == "ecifm" || "$prev" == "@ecifm" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "clone index" || "$prev" == "eclni" || "$prev" == "@eclni" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "delete index" || "$prev" == "edi" || "$prev" == "@edi" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "open index" || "$prev" == "eopi" || "$prev" == "@eopi" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "close index" || "$prev" == "ecli" || "$prev" == "@ecli" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "enable read only" || "$prev" == "eero" || "$prev" == "@eero" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "enable read write" || "$prev" == "eerw" || "$prev" == "@eerw" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "reindex index" || "$prev" == "eri" || "$prev" == "@eri" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "move shard" || "$prev" == "ems" || "$prev" == "@ems" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "alter number replicas" || "$prev" == "eanr" || "$prev" == "@eanr" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "forcemerge" || "$prev" == "efm" || "$prev" == "@efm" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "refresh" || "$prev" == "er" || "$prev" == "@er" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "add entry" || "$prev" == "eae" || "$prev" == "@eae" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "delete entry" || "$prev" == "ede" || "$prev" == "@ede" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1 )" -- "$cur") )
        fi
        if [[ "$all" == "search" || "$prev" == "es" || "$prev" == "@es" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "search json" || "$prev" == "esj" || "$prev" == "@esj" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "search match" || "$prev" == "esm" || "$prev" == "@esm" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "search term" || "$prev" == "est" || "$prev" == "@est" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
        if [[ "$all" == "search summary" || "$prev" == "ess" || "$prev" == "@ess" ]]; then
            COMPREPLY=( $(compgen -W "$(cat /tmp/es_idx_list 2>&1)" -- "$cur") )
        fi
}
complete -F _es_complete es @ehe @ess @ecc @eco @ech @ecs @ecrs @ec @ela @eli @elo @eldi @els @elsd @ele @elss @elass @elf @egim @elus @efmp @eaita @erifa @eci @ecifm @eclni @edi @eopi @ecli @eero @eerw @eri @ems @eanr @edsa @ersa @efm @er @eae @ede @eln @elna @elnq @esn @eat @etps @enpo @es @esj @esm @est @ess @esql @elt @eltd @eare @edre @elre @ecsn @edsn @elsn @esnd @ersn @eg @eqes

# Shortcut aliases
alias @ehe='es ehe'
alias @ess='es ess'
alias @ecc='es ecc'
alias @eco='es eco'
alias @ech='es ech'
alias @ecs='es ecs'
alias @ecrs='es ecrs'
alias @ec='es ec'
alias @ela='es ela'
alias @eli='es eli'
alias @elo='es elo'
alias @eldi='es eldi'
alias @els='es els'
alias @elsd='es elsd'
alias @ele='es ele'
alias @elss='es elss'
alias @elass='es elass'
alias @elf='es elf'
alias @egim='es egim'
alias @elus='es elus'
alias @efmp='es efmp'
alias @eaita='es eaita'
alias @erifa='es erifa'
alias @eci='es eci'
alias @ecifm='es ecifm'
alias @eclni='es eclni'
alias @edi='es edi'
alias @eopi='es eopi'
alias @ecli='es ecli'
alias @eero='es eero'
alias @eerw='es eerw'
alias @eri='es eri'
alias @ems='es ems'
alias @eanr='es eanr'
alias @edsa='es edsa'
alias @ersa='es ersa'
alias @efm='es efm'
alias @er='es er'
alias @eae='es eae'
alias @ede='es ede'
alias @eln='es eln'
alias @elna='es elna'
alias @elnq='es elnq'
alias @esn='es esn'
alias @eat='es eat'
alias @etps='es etps'
alias @enpo='es enpo'
alias @es='es es'
alias @esj='es esj'
alias @esm='es esm'
alias @est='es est'
alias @ess='es ess'
alias @esql='es esql'
alias @elt='es elt'
alias @eltd='es eltd'
alias @eare='es eare'
alias @edre='es edre'
alias @elre='es elre'
alias @ecsn='es ecsn'
alias @edsn='es edsn'
alias @elsn='es elsn'
alias @esnd='es esnd'
alias @ersn='es ersn'
alias @eg='es eg'
alias @eqes='es eqes'
```

## Bash script

```bash
#!/usr/bin/env bash
debug_yn=n
[[ "$1" == "-d" ]] && { debug_yn=y; shift; }
[[ "${CLI_DEBUG^^}" == "TRUE" ]] && debug_yn=y

C_CYA="\x1b[96m" C_GRE="\x1b[92m" C_MAG="\x1b[95m" C_WHI="\x1b[97m" C_DEF="\x1b[0m"

# param 1 - actual number of parameters
# param 2 - required number of parameters
# param 3 - incorrect parameters message
check_params() {
  [[ "$1" < "$2" ]] && { echo -e "$3"; exit; }
}

print_command() {
  [[ $debug_yn == y ]] && { echo "COMMAND: $*" | sed 's/"/\"/g'; echo "COMMAND: $*" | sed 's/./-/g'; }
}
section="HELP"

if [[ "$1" == "help" || "$1" == "ehe" ]]; then
   [[ "$1" == "ehe" ]] && shift || shift 1
   usage="\x1b[95mhelp \x1b[96m(ehe)\x1b[97m [filter]\x1b[92m # Show help, optionally filtered by pattern\x1b[0m"
   check_params $# 0 "Usage: $usage"
   
echo -e "\x1b[92m-------------\x1b[0m"
echo -e "\x1b[92mElasticsearch\x1b[0m"
echo -e "\x1b[92m-------------\x1b[0m"

echo -e "\x1b[97mCLI uses environment variables:\x1b[0m"
echo -e "\x1b[97m- ES_PROTOCOL (default: http),\x1b[0m"
echo -e "\x1b[97m- ES_HOST (default: localhost)\x1b[0m"
echo -e "\x1b[97m- ES_PORT (default: 9200),\x1b[0m"
echo -e "\x1b[97m- ES_PATH (default: <blank>), and\x1b[0m"
echo -e "\x1b[97m- ES_AUTH (default: <blank> - no auth required)\x1b[0m"
echo -e "\x1b[97mUse command show settings (ss) to see environment variable values.\x1b[0m"

echo -e "\x1b[95mgenerated:2026-07-14 10:39\x1b[0m"
echo
filter="$1"
if [[ -n "$filter" ]]; then
  # Show all section headers but only matching commands
  while IFS= read -r line; do
    if [[ "$line" =~ ^section= ]]; then
      # Always show section headers
      echo -e "\x1b[92m${line#section=}\x1b[0m"
    elif [[ "$line" =~ usage= ]]; then
      # Show command if it matches the filter
      cmd_line="${line#*usage=}"
      if echo "$cmd_line" | grep -iq "$filter"; then
        echo -e "   $cmd_line"
      fi
    fi
  done < <(egrep "^section=|^   usage=" "$0" | sed 's/\"//g')
else
  # Show everything
  while IFS= read -r line; do echo -e "${line}${CRESET}"; done < <(egrep "^section=|^   usage=" "$0" | sed "s/.*usage=/   /; s/.*section=/\x1b[92m/; s/\"//g")
fi
   exit
fi
ES_HOST="${ES_HOST:-localhost}"
ES_PORT="${ES_PORT:-9200}"
if [[ "${ES_PATH%/}" != "" ]]; then ES_PATH="/${ES_PATH%/}"; fi
ES_PROTOCOL="${ES_PROTOCOL:-http}"
pj() { if command -v jq >/dev/null 2>&1; then jq .; else cat; fi; }
cols() { python3 -c 'import sys,json;f=lambda d,p="":[f(v["properties"],p+k+".") if isinstance(v,dict) and "properties" in v else print(p+k) for k,v in d.items()];[f(i["mappings"]["properties"]) for i in json.load(sys.stdin).values()]'; }
q() { local method="$1"; shift; if [[ "$ES_AUTH" != "" ]]; then ES_AUTH="-u $ES_AUTH"; fi; curl -s -X $method $ES_AUTH $ES_PROTOCOL://$ES_HOST:$ES_PORT$ES_PATH/$@; }

if [[ "$1 $2" == "show settings" || "$1" == "ess" ]]; then
   [[ "$1" == "ess" ]] && shift || shift 2
   usage="\x1b[95mshow settings \x1b[96m(ess)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " echo Environment Variables:; echo ----------------------; echo \"ES_PROTOCOL: $ES_PROTOCOL\"; echo \"ES_HOST:     $ES_HOST\"; echo \"ES_PORT:     $ES_PORT\"; echo \"ES_PATH:     $ES_PATH\"; if [[ \"$ES_AUTH\" == \"\" ]]; then echo \"ES_AUTH:     not set\"; else echo \"ES_AUTH:     is set\"; fi"
   echo Environment Variables:; echo ----------------------; echo "ES_PROTOCOL: $ES_PROTOCOL"; echo "ES_HOST:     $ES_HOST"; echo "ES_PORT:     $ES_PORT"; echo "ES_PATH:     $ES_PATH"; if [[ "$ES_AUTH" == "" ]]; then echo "ES_AUTH:     not set"; else echo "ES_AUTH:     is set"; fi
   exit
fi
section="CLUSTER"

if [[ "$1 $2" == "clear cache" || "$1" == "ecc" ]]; then
   [[ "$1" == "ecc" ]] && shift || shift 2
   usage="\x1b[95mclear cache \x1b[96m(ecc)\x1b[97m [index_name]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q POST \"$1/_cache/clear\""
   q POST "$1/_cache/clear"
   exit
fi

if [[ "$1 $2" == "cluster overview" || "$1" == "eco" ]]; then
   [[ "$1" == "eco" ]] && shift || shift 2
   usage="\x1b[95mcluster overview \x1b[96m(eco)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"\""
   q GET ""
   exit
fi

if [[ "$1 $2" == "cluster health" || "$1" == "ech" ]]; then
   [[ "$1" == "ech" ]] && shift || shift 2
   usage="\x1b[95mcluster health \x1b[96m(ech)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cluster/health?human&pretty\""
   q GET "_cluster/health?human&pretty"
   exit
fi

if [[ "$1 $2" == "cluster stats" || "$1" == "ecs" ]]; then
   [[ "$1" == "ecs" ]] && shift || shift 2
   usage="\x1b[95mcluster stats \x1b[96m(ecs)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cluster/stats?human&pretty\""
   q GET "_cluster/stats?human&pretty"
   exit
fi

if [[ "$1 $2 $3" == "cluster recovery stats" || "$1" == "ecrs" ]]; then
   [[ "$1" == "ecrs" ]] && shift || shift 3
   usage="\x1b[95mcluster recovery stats \x1b[96m(ecrs)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/recovery?v\""
   q GET "_cat/recovery?v"
   exit
fi
section="INDEX INTERROGATION"

if [[ "$1" == "count" || "$1" == "ec" ]]; then
   [[ "$1" == "ec" ]] && shift || shift 1
   usage="\x1b[95mcount \x1b[96m(ec)\x1b[97m <index_name>\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " q GET \"$1/_count?pretty\""
   q GET "$1/_count?pretty"
   exit
fi

if [[ "$1 $2" == "list aliases" || "$1" == "ela" ]]; then
   [[ "$1" == "ela" ]] && shift || shift 2
   usage="\x1b[95mlist aliases \x1b[96m(ela)\x1b[97m [filter] [order_by_field_name]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/aliases/$1?v&s=$2\""
   q GET "_cat/aliases/$1?v&s=$2"
   exit
fi

if [[ "$1 $2" == "list indices" || "$1" == "eli" ]]; then
   [[ "$1" == "eli" ]] && shift || shift 2
   usage="\x1b[95mlist indices \x1b[96m(eli)\x1b[97m [-s] [index_name]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " ord=\"index\"; if [[ \"$1\" == \"-s\" ]]; then ord=\"store.size\"; shift; fi; q GET \"_cat/indices/$1?v&h=health,status,index,pri,rep,sc,docs.count,docs.deleted,store.size,pri.store.size&s=$ord\" | tee /tmp/es_idx_list; sed -i 's/^[^ ][^ ]*  *[^ ][^ ]*  *//; s/ .*//' /tmp/es_idx_list"
   ord="index"; if [[ "$1" == "-s" ]]; then ord="store.size"; shift; fi; q GET "_cat/indices/$1?v&h=health,status,index,pri,rep,sc,docs.count,docs.deleted,store.size,pri.store.size&s=$ord" | tee /tmp/es_idx_list; sed -i 's/^[^ ][^ ]*  *[^ ][^ ]*  *//; s/ .*//' /tmp/es_idx_list
   exit
fi

if [[ "$1 $2" == "list open" || "$1" == "elo" ]]; then
   [[ "$1" == "elo" ]] && shift || shift 2
   usage="\x1b[95mlist open \x1b[96m(elo)\x1b[97m [index_name]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/indices/$1?v&h=health,status,index,pri,rep,sc,docs.count,docs.deleted,store.size,pri.store.size&s=index\" | sed \"/ close  /d\""
   q GET "_cat/indices/$1?v&h=health,status,index,pri,rep,sc,docs.count,docs.deleted,store.size,pri.store.size&s=index" | sed "/ close  /d"
   exit
fi

if [[ "$1 $2 $3" == "list dot indices" || "$1" == "eldi" ]]; then
   [[ "$1" == "eldi" ]] && shift || shift 3
   usage="\x1b[95mlist dot indices \x1b[96m(eldi)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/indices/.*?v&s=index\""
   q GET "_cat/indices/.*?v&s=index"
   exit
fi

if [[ "$1 $2" == "list shards" || "$1" == "els" ]]; then
   [[ "$1" == "els" ]] && shift || shift 2
   usage="\x1b[95mlist shards \x1b[96m(els)\x1b[97m [index_name] [order_by_field_name]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/shards/$1?v&h=index,shard,prirep,sc,state,docs,store,node&s=index,shard,prirep&s=$2\""
   q GET "_cat/shards/$1?v&h=index,shard,prirep,sc,state,docs,store,node&s=index,shard,prirep&s=$2"
   exit
fi

if [[ "$1 $2 $3" == "list shard details" || "$1" == "elsd" ]]; then
   [[ "$1" == "elsd" ]] && shift || shift 3
   usage="\x1b[95mlist shard details \x1b[96m(elsd)\x1b[97m [index_name] [order_by_field_name]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/shards/$1?v&h=index,shard,prirep,state,docs,store,ip,segments.count,unassigned.reason,unassigned.for,node&s=$2\""
   q GET "_cat/shards/$1?v&h=index,shard,prirep,state,docs,store,ip,segments.count,unassigned.reason,unassigned.for,node&s=$2"
   exit
fi

if [[ "$1 $2" == "list segments" || "$1" == "ele" ]]; then
   [[ "$1" == "ele" ]] && shift || shift 2
   usage="\x1b[95mlist segments \x1b[96m(ele)\x1b[97m [index_name]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/segments/$1?v&s=index,shard,prirep\""
   q GET "_cat/segments/$1?v&s=index,shard,prirep"
   exit
fi

if [[ "$1 $2 $3" == "list segmented shards" || "$1" == "elss" ]]; then
   [[ "$1" == "elss" ]] && shift || shift 3
   usage="\x1b[95mlist segmented shards \x1b[96m(elss)\x1b[97m [index_name]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/shards/$1?v&h=index,shard,prirep,state,docs,node,segments.count&s=index,shard,prirep,node\""
   q GET "_cat/shards/$1?v&h=index,shard,prirep,state,docs,node,segments.count&s=index,shard,prirep,node"
   exit
fi

if [[ "$1 $2 $3 $4 $5" == "list avg segments per shard" || "$1" == "elass" ]]; then
   [[ "$1" == "elass" ]] && shift || shift 5
   usage="\x1b[95mlist avg segments per shard \x1b[96m(elass)\x1b[97m [index_name]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/segments/$1?v&s=index,shard,prirep\" | tail -n +2 | sed 's/[[:space:]]\+/ /g' | cut -d ' ' -f1,2 | sort | uniq -c | awk '{c=$1; i=$2; sh=$3; se_c[i]+=c; sh_c[i]++} END {printf \"%-52s Avg Segments\n\",\"Index\"; for (i in se_c) {avg=se_c[i]/sh_c[i]; printf \"%-60s %.2f\n\", i, avg}}' | sort"
   q GET "_cat/segments/$1?v&s=index,shard,prirep" | tail -n +2 | sed 's/[[:space:]]\+/ /g' | cut -d ' ' -f1,2 | sort | uniq -c | awk '{c=$1; i=$2; sh=$3; se_c[i]+=c; sh_c[i]++} END {printf "%-52s Avg Segments\n","Index"; for (i in se_c) {avg=se_c[i]/sh_c[i]; printf "%-60s %.2f\n", i, avg}}' | sort
   exit
fi

if [[ "$1 $2" == "list fields" || "$1" == "elf" ]]; then
   [[ "$1" == "elf" ]] && shift || shift 2
   usage="\x1b[95mlist fields \x1b[96m(elf)\x1b[97m <index_name>\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " q GET \"$1/_mapping\" | cols"
   q GET "$1/_mapping" | cols
   exit
fi

if [[ "$1 $2 $3" == "get index mapping" || "$1" == "egim" ]]; then
   [[ "$1" == "egim" ]] && shift || shift 3
   usage="\x1b[95mget index mapping \x1b[96m(egim)\x1b[97m <index_name>\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " q GET \"$1/_mapping?pretty\" | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n *\([^\"]*\"type\"\)/ \1/g' -e 's/\n *\([^\"]*\"normalizer\"\)/ \1/g' -e 's/\n *\([^\"]*\"index\"\)/ \1/g' -e 's/\n *\([^\"]*\"ignore_above\"\)/ \1/g' -e 's/\n *\([^\"]*\"fields\"\)/ \1/g' -e 's/\n *\([^\"]*\"keyword\"\)/ \1/g' -e 's/\n *\([^\"]*\"raw\"\)/ \1/g' -e 's/\([a-z0-9\"]\) *\n */\1 /g' -e 's/} *\n *}/} }/g' -e 's/} *\n *}/} }/g'"
   q GET "$1/_mapping?pretty" | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n *\([^"]*"type"\)/ \1/g' -e 's/\n *\([^"]*"normalizer"\)/ \1/g' -e 's/\n *\([^"]*"index"\)/ \1/g' -e 's/\n *\([^"]*"ignore_above"\)/ \1/g' -e 's/\n *\([^"]*"fields"\)/ \1/g' -e 's/\n *\([^"]*"keyword"\)/ \1/g' -e 's/\n *\([^"]*"raw"\)/ \1/g' -e 's/\([a-z0-9"]\) *\n */\1 /g' -e 's/} *\n *}/} }/g' -e 's/} *\n *}/} }/g'
   exit
fi

if [[ "$1 $2 $3" == "list unassigned shards" || "$1" == "elus" ]]; then
   [[ "$1" == "elus" ]] && shift || shift 3
   usage="\x1b[95mlist unassigned shards \x1b[96m(elus)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/shards?v&h=index,shard,prirep,state,docs,segments.count&s=index,shard,prirep\""
   q GET "_cat/shards?v&h=index,shard,prirep,state,docs,segments.count&s=index,shard,prirep"
   exit
fi

if [[ "$1 $2" == "forcemerge progress" || "$1" == "efmp" ]]; then
   [[ "$1" == "efmp" ]] && shift || shift 2
   usage="\x1b[95mforcemerge progress \x1b[96m(efmp)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/nodes?v&h=name,cpu,load_1m,merges.current,merges.current_docs,merges.total,merges.total_docs&s=name\""
   q GET "_cat/nodes?v&h=name,cpu,load_1m,merges.current,merges.current_docs,merges.total,merges.total_docs&s=name"
   exit
fi
section="INDEX MANIPULATION"

if [[ "$1 $2 $3 $4" == "add index to alias" || "$1" == "eaita" ]]; then
   [[ "$1" == "eaita" ]] && shift || shift 4
   usage="\x1b[95madd index to alias \x1b[96m(eaita)\x1b[97m <index_name> <alias_name>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q POST \"_aliases\" -H 'Content-Type: application/json' -d '{\"actions\":[{\"add\":{\"index\":\"'$1'\",\"alias\":\"'$2'\"}}]}'"
   q POST "_aliases" -H 'Content-Type: application/json' -d '{"actions":[{"add":{"index":"'$1'","alias":"'$2'"}}]}'
   exit
fi

if [[ "$1 $2 $3 $4" == "remove index from alias" || "$1" == "erifa" ]]; then
   [[ "$1" == "erifa" ]] && shift || shift 4
   usage="\x1b[95mremove index from alias \x1b[96m(erifa)\x1b[97m <index_name> <alias_name>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " read -p \"Are you sure [yN]? \" yn; if [[ ${yn^} == Y ]]; then q DELETE \"$1/_aliases/$2\"; fi"
   read -p "Are you sure [yN]? " yn; if [[ ${yn^} == Y ]]; then q DELETE "$1/_aliases/$2"; fi
   exit
fi

if [[ "$1 $2" == "create index" || "$1" == "eci" ]]; then
   [[ "$1" == "eci" ]] && shift || shift 2
   usage="\x1b[95mcreate index \x1b[96m(eci)\x1b[97m <index_name> <number_of_shards> <number_of_replicas>\x1b[0m"
   check_params $# 3 "Usage: $usage"
   print_command " q PUT \"$1\" -H 'Content-Type: application/json' -d '{\"settings\":{\"index\":{\"number_of_shards\":'$2',\"number_of_replicas\":'$3'}}}'"
   q PUT "$1" -H 'Content-Type: application/json' -d '{"settings":{"index":{"number_of_shards":'$2',"number_of_replicas":'$3'}}}'
   exit
fi

if [[ "$1 $2 $3 $4" == "create index from mapping" || "$1" == "ecifm" ]]; then
   [[ "$1" == "ecifm" ]] && shift || shift 4
   usage="\x1b[95mcreate index from mapping \x1b[96m(ecifm)\x1b[97m <index_name> <number_of_shards> <number_of_replicas> <mapping-json>\x1b[0m"
   check_params $# 4 "Usage: $usage"
   print_command " q PUT \"$1\" -H 'Content-Type: application/json' -d '{\"settings\":{\"index\":{\"number_of_shards\":'$2',\"number_of_replicas\":'$3'}},\"mappings\":'\"$4\"'}'"
   q PUT "$1" -H 'Content-Type: application/json' -d '{"settings":{"index":{"number_of_shards":'$2',"number_of_replicas":'$3'}},"mappings":'"$4"'}'
   exit
fi

if [[ "$1 $2" == "clone index" || "$1" == "eclni" ]]; then
   [[ "$1" == "eclni" ]] && shift || shift 2
   usage="\x1b[95mclone index \x1b[96m(eclni)\x1b[97m <index_name> <new_index_name>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q POST \"$1/_clone/$2\""
   q POST "$1/_clone/$2"
   exit
fi

if [[ "$1 $2" == "delete index" || "$1" == "edi" ]]; then
   [[ "$1" == "edi" ]] && shift || shift 2
   usage="\x1b[95mdelete index \x1b[96m(edi)\x1b[97m <index_name>\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " read -p \"Are you sure [yN]? \" yn; if [[ ${yn^} == Y ]]; then q DELETE \"$1\"; fi"
   read -p "Are you sure [yN]? " yn; if [[ ${yn^} == Y ]]; then q DELETE "$1"; fi
   exit
fi

if [[ "$1 $2" == "open index" || "$1" == "eopi" ]]; then
   [[ "$1" == "eopi" ]] && shift || shift 2
   usage="\x1b[95mopen index \x1b[96m(eopi)\x1b[97m <index_name>\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " q POST \"$1/_open\""
   q POST "$1/_open"
   exit
fi

if [[ "$1 $2" == "close index" || "$1" == "ecli" ]]; then
   [[ "$1" == "ecli" ]] && shift || shift 2
   usage="\x1b[95mclose index \x1b[96m(ecli)\x1b[97m <index_name>\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " q POST \"$1/_close\""
   q POST "$1/_close"
   exit
fi

if [[ "$1 $2 $3" == "enable read only" || "$1" == "eero" ]]; then
   [[ "$1" == "eero" ]] && shift || shift 3
   usage="\x1b[95menable read only \x1b[96m(eero)\x1b[97m <index_name>\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " q PUT \"$1/_settings\" -H 'Content-Type: application/json' -d '{\"index.blocks.write\": true}'"
   q PUT "$1/_settings" -H 'Content-Type: application/json' -d '{"index.blocks.write": true}'
   exit
fi

if [[ "$1 $2 $3" == "enable read write" || "$1" == "eerw" ]]; then
   [[ "$1" == "eerw" ]] && shift || shift 3
   usage="\x1b[95menable read write \x1b[96m(eerw)\x1b[97m <index_name>\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " q PUT \"$1/_settings\" -H 'Content-Type: application/json' -d '{\"index.blocks.write\": false}'"
   q PUT "$1/_settings" -H 'Content-Type: application/json' -d '{"index.blocks.write": false}'
   exit
fi

if [[ "$1 $2" == "reindex index" || "$1" == "eri" ]]; then
   [[ "$1" == "eri" ]] && shift || shift 2
   usage="\x1b[95mreindex index \x1b[96m(eri)\x1b[97m <source_index_name> <dest_index_name>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q POST \"_reindex\" -H 'Content-Type: application/json' -d '{\"source\":{\"index\":\"'$1'\"},\"dest\":{\"index\":\"'$2'\"}}'"
   q POST "_reindex" -H 'Content-Type: application/json' -d '{"source":{"index":"'$1'"},"dest":{"index":"'$2'"}}'
   exit
fi

if [[ "$1 $2" == "move shard" || "$1" == "ems" ]]; then
   [[ "$1" == "ems" ]] && shift || shift 2
   usage="\x1b[95mmove shard \x1b[96m(ems)\x1b[97m <index_name> <shard_num> <from_node_name> <to_node_name>\x1b[0m"
   check_params $# 4 "Usage: $usage"
   print_command " q POST \"_cluster/reroute\" -H 'Content-Type: application/json' -d '{\"commands\":[{\"move\":{\"index\":\"'$1'\",\"shard\":'$2',\"from_node\":\"'$3'\",\"to_node\":\"'$4'\"}}]}'"
   q POST "_cluster/reroute" -H 'Content-Type: application/json' -d '{"commands":[{"move":{"index":"'$1'","shard":'$2',"from_node":"'$3'","to_node":"'$4'"}}]}'
   exit
fi

if [[ "$1 $2 $3" == "alter number replicas" || "$1" == "eanr" ]]; then
   [[ "$1" == "eanr" ]] && shift || shift 3
   usage="\x1b[95malter number replicas \x1b[96m(eanr)\x1b[97m <index_name> <number_of_replicas>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q PUT \"$1/_settings\" -H 'Content-Type: application/json' -d '{\"index\":{\"number_of_replicas\":'$2'}}'"
   q PUT "$1/_settings" -H 'Content-Type: application/json' -d '{"index":{"number_of_replicas":'$2'}}'
   exit
fi

if [[ "$1 $2 $3" == "disable shard allocation" || "$1" == "edsa" ]]; then
   [[ "$1" == "edsa" ]] && shift || shift 3
   usage="\x1b[95mdisable shard allocation \x1b[96m(edsa)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q PUT \"_cluster/settings\" -H 'Content-Type: application/json' -d '{\"persistent\":{\"cluster.routing.allocation.enable\":\"primaries\"}}'"
   q PUT "_cluster/settings" -H 'Content-Type: application/json' -d '{"persistent":{"cluster.routing.allocation.enable":"primaries"}}'
   exit
fi

if [[ "$1 $2 $3" == "reenable shard allocation" || "$1" == "ersa" ]]; then
   [[ "$1" == "ersa" ]] && shift || shift 3
   usage="\x1b[95mreenable shard allocation \x1b[96m(ersa)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q PUT \"_cluster/settings\" -H 'Content-Type: application/json' -d '{\"persistent\":{\"cluster.routing.allocation.enable\":null}}'"
   q PUT "_cluster/settings" -H 'Content-Type: application/json' -d '{"persistent":{"cluster.routing.allocation.enable":null}}'
   exit
fi

if [[ "$1" == "forcemerge" || "$1" == "efm" ]]; then
   [[ "$1" == "efm" ]] && shift || shift 1
   usage="\x1b[95mforcemerge \x1b[96m(efm)\x1b[97m <index_name> <max_num_segments>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q POST \"$1/_forcemerge?max_num_segments=$2\""
   q POST "$1/_forcemerge?max_num_segments=$2"
   exit
fi

if [[ "$1" == "refresh" || "$1" == "er" ]]; then
   [[ "$1" == "er" ]] && shift || shift 1
   usage="\x1b[95mrefresh \x1b[96m(er)\x1b[97m <index_name>\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " q POST \"$1/_refresh\""
   q POST "$1/_refresh"
   exit
fi
section="INDEX ENTRY MANIPULATION"

if [[ "$1 $2" == "add entry" || "$1" == "eae" ]]; then
   [[ "$1" == "eae" ]] && shift || shift 2
   usage="\x1b[95madd entry \x1b[96m(eae)\x1b[97m <index_name> <entry_json>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q POST \"$1/_doc\" -H 'Content-Type: application/json' -d \"$2\""
   q POST "$1/_doc" -H 'Content-Type: application/json' -d "$2"
   exit
fi

if [[ "$1 $2" == "delete entry" || "$1" == "ede" ]]; then
   [[ "$1" == "ede" ]] && shift || shift 2
   usage="\x1b[95mdelete entry \x1b[96m(ede)\x1b[97m <index_name> [_id]\x1b[92m # No <id> will mean all documents deleted\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " if [[ \"$2\" == \"\" ]]; then read -p \"This will delete ALL RECORDS - Are you sure [yN]? \" yn; if [[ ${yn^} == Y ]]; then q POST \"$1/_delete_by_query\" -H 'Content-Type: application/json' -d '{ \"query\": { \"match_all\": {} } }' | pj; fi; else q POST \"$1/_delete_by_query\" -H 'Content-Type: application/json' -d '{ \"query\": { \"ids\": { \"values\": [ \"'$2'\" ] } } }' | pj; fi"
   if [[ "$2" == "" ]]; then read -p "This will delete ALL RECORDS - Are you sure [yN]? " yn; if [[ ${yn^} == Y ]]; then q POST "$1/_delete_by_query" -H 'Content-Type: application/json' -d '{ "query": { "match_all": {} } }' | pj; fi; else q POST "$1/_delete_by_query" -H 'Content-Type: application/json' -d '{ "query": { "ids": { "values": [ "'$2'" ] } } }' | pj; fi
   exit
fi
section="NODES"

if [[ "$1 $2" == "list nodes" || "$1" == "eln" ]]; then
   [[ "$1" == "eln" ]] && shift || shift 2
   usage="\x1b[95mlist nodes \x1b[96m(eln)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/nodes?v&h=name,ip,nodeRole,m,heapPercent,ramPercent,cpu,load_1m,load_5m,load_15m,disk.total,disk.used_percent&s=name\""
   q GET "_cat/nodes?v&h=name,ip,nodeRole,m,heapPercent,ramPercent,cpu,load_1m,load_5m,load_15m,disk.total,disk.used_percent&s=name"
   exit
fi

if [[ "$1 $2 $3" == "list node attributes" || "$1" == "elna" ]]; then
   [[ "$1" == "elna" ]] && shift || shift 3
   usage="\x1b[95mlist node attributes \x1b[96m(elna)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/nodeattrs?v&s=node\""
   q GET "_cat/nodeattrs?v&s=node"
   exit
fi

if [[ "$1 $2 $3" == "list nodes queries" || "$1" == "elnq" ]]; then
   [[ "$1" == "elnq" ]] && shift || shift 3
   usage="\x1b[95mlist nodes queries \x1b[96m(elnq)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/nodes?v&h=name,nodeRole,search,queryTotal,searchFetchTotal,requestCacheHitCount&s=name\""
   q GET "_cat/nodes?v&h=name,nodeRole,search,queryTotal,searchFetchTotal,requestCacheHitCount&s=name"
   exit
fi

if [[ "$1 $2" == "search nodes" || "$1" == "esn" ]]; then
   [[ "$1" == "esn" ]] && shift || shift 2
   usage="\x1b[95msearch nodes \x1b[96m(esn)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_nodes\""
   q GET "_nodes"
   exit
fi

if [[ "$1 $2 $3" == "node active threads" || "$1" == "eat" ]]; then
   [[ "$1" == "eat" ]] && shift || shift 3
   usage="\x1b[95mnode active threads \x1b[96m(eat)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/thread_pool?v&s=node_name,name\""
   q GET "_cat/thread_pool?v&s=node_name,name"
   exit
fi

if [[ "$1 $2 $3 $4" == "node thread pool sizes" || "$1" == "etps" ]]; then
   [[ "$1" == "etps" ]] && shift || shift 4
   usage="\x1b[95mnode thread pool sizes \x1b[96m(etps)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/thread_pool?v&h=node_name,name,size,active,queue,queue_size,largest,min,max&s=node_name,name\""
   q GET "_cat/thread_pool?v&h=node_name,name,size,active,queue,queue_size,largest,min,max&s=node_name,name"
   exit
fi

if [[ "$1 $2 $3" == "node perf overview" || "$1" == "enpo" ]]; then
   [[ "$1" == "enpo" ]] && shift || shift 3
   usage="\x1b[95mnode perf overview \x1b[96m(enpo)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/nodes?v&h=ip,port,role,master,cpu,ft,ftt,iic,iif,mt,mtt,d,mcs\""
   q GET "_cat/nodes?v&h=ip,port,role,master,cpu,ft,ftt,iic,iif,mt,mtt,d,mcs"
   exit
fi
section="SEARCH"

if [[ "$1" == "search" || "$1" == "es" ]]; then
   [[ "$1" == "es" ]] && shift || shift 1
   usage="\x1b[95msearch \x1b[96m(es)\x1b[97m <index_name> [search_term]\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " if [[ \"$2\" == \"\" ]]; then term=\"*\"; else term=\"$2\"; fi; q GET \"$1/_search?q=${term}&pretty\" | pj"
   if [[ "$2" == "" ]]; then term="*"; else term="$2"; fi; q GET "$1/_search?q=${term}&pretty" | pj
   exit
fi

if [[ "$1 $2" == "search json" || "$1" == "esj" ]]; then
   [[ "$1" == "esj" ]] && shift || shift 2
   usage="\x1b[95msearch json \x1b[96m(esj)\x1b[97m <index_name> <search_json>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q GET \"$1/_search?pretty\" -H 'Content-Type: application/json' -d \"$2\""
   q GET "$1/_search?pretty" -H 'Content-Type: application/json' -d "$2"
   exit
fi

if [[ "$1 $2" == "search match" || "$1" == "esm" ]]; then
   [[ "$1" == "esm" ]] && shift || shift 2
   usage="\x1b[95msearch match \x1b[96m(esm)\x1b[97m <index_name> <field_name> <value>\x1b[0m"
   check_params $# 3 "Usage: $usage"
   print_command " q GET \"$1/_search?pretty\" -H 'Content-Type: application/json' -d '{\"query\": { \"match\": { \"'$2'\": \"'$3'\" } } }'"
   q GET "$1/_search?pretty" -H 'Content-Type: application/json' -d '{"query": { "match": { "'$2'": "'$3'" } } }'
   exit
fi

if [[ "$1 $2" == "search term" || "$1" == "est" ]]; then
   [[ "$1" == "est" ]] && shift || shift 2
   usage="\x1b[95msearch term \x1b[96m(est)\x1b[97m <index_name> <field_name> <value>\x1b[0m"
   check_params $# 3 "Usage: $usage"
   print_command " q GET \"$1/_search?pretty\" -H 'Content-Type: application/json' -d '{\"query\": { \"term\": { \"'$2'\": \"'$3'\" } } }'"
   q GET "$1/_search?pretty" -H 'Content-Type: application/json' -d '{"query": { "term": { "'$2'": "'$3'" } } }'
   exit
fi

if [[ "$1 $2" == "search summary" || "$1" == "ess" ]]; then
   [[ "$1" == "ess" ]] && shift || shift 2
   usage="\x1b[95msearch summary \x1b[96m(ess)\x1b[97m <index_name> <search_term>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q GET \"$1/_search?size=0&pretty\" -H 'Content-Type: application/json' -d '{\"aggs\": {\"count\": {\"terms\": { \"field\" : \"'$2'\", \"size\" : 100 } } } }'"
   q GET "$1/_search?size=0&pretty" -H 'Content-Type: application/json' -d '{"aggs": {"count": {"terms": { "field" : "'$2'", "size" : 100 } } } }'
   exit
fi
section="SQL"

if [[ "$1" == "sql" || "$1" == "esql" ]]; then
   [[ "$1" == "esql" ]] && shift || shift 1
   usage="\x1b[95msql \x1b[96m(esql)\x1b[97m <sql>\x1b[92m # Tips: tablenames in \x22\x22, can use: DESCRIBE \x22<table>\x22\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " q=\"${1//\\"/\\\\"}\"; q=\"${q//\`/\'}\"; echo '{\"query\": \"'\"$q\"'\"}'; curl -s -X POST \"http://$ES_HOST:$ES_PORT/_sql?format=txt\" -H 'Content-Type: application/json' -d '{\"query\": \"'\"$q\"'\"}'"
   q="${1//\"/\\\"}"; q="${q//\`/\'}"; echo '{"query": "'"$q"'"}'; curl -s -X POST "http://$ES_HOST:$ES_PORT/_sql?format=txt" -H 'Content-Type: application/json' -d '{"query": "'"$q"'"}'
   exit
fi
section="TASKS"

if [[ "$1 $2" == "list tasks" || "$1" == "elt" ]]; then
   [[ "$1" == "elt" ]] && shift || shift 2
   usage="\x1b[95mlist tasks \x1b[96m(elt)\x1b[97m [sort_field]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/tasks?v&h=action,type,start_time,timestamp,running_time,node&s=$1\""
   q GET "_cat/tasks?v&h=action,type,start_time,timestamp,running_time,node&s=$1"
   exit
fi

if [[ "$1 $2 $3" == "list tasks detail" || "$1" == "eltd" ]]; then
   [[ "$1" == "eltd" ]] && shift || shift 3
   usage="\x1b[95mlist tasks detail \x1b[96m(eltd)\x1b[97m [sort_field]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/tasks?v&s=$1\""
   q GET "_cat/tasks?v&s=$1"
   exit
fi
section="REPOS / SNAPSHOTS"

if [[ "$1 $2" == "add repo" || "$1" == "eare" ]]; then
   [[ "$1" == "eare" ]] && shift || shift 2
   usage="\x1b[95madd repo \x1b[96m(eare)\x1b[97m <repo_name> <repo_location> [base_path]\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q PUT \"_snapshot/$1?pretty\" -H 'Content-Type: application/json' -d '{ \"type\": \"fs\", \"settings\": { \"location\": \"'$2'\", \"base_path\": \"'$3'\" } } '"
   q PUT "_snapshot/$1?pretty" -H 'Content-Type: application/json' -d '{ "type": "fs", "settings": { "location": "'$2'", "base_path": "'$3'" } } '
   exit
fi

if [[ "$1 $2" == "delete repo" || "$1" == "edre" ]]; then
   [[ "$1" == "edre" ]] && shift || shift 2
   usage="\x1b[95mdelete repo \x1b[96m(edre)\x1b[97m <repo_name>\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " read -p \"Are you sure [yN]? \" yn; if [[ ${yn^} == Y ]]; then q DELETE \"_snapshot/$1?pretty\"; fi"
   read -p "Are you sure [yN]? " yn; if [[ ${yn^} == Y ]]; then q DELETE "_snapshot/$1?pretty"; fi
   exit
fi

if [[ "$1 $2" == "list repos" || "$1" == "elre" ]]; then
   [[ "$1" == "elre" ]] && shift || shift 2
   usage="\x1b[95mlist repos \x1b[96m(elre)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/repositories?v\""
   q GET "_cat/repositories?v"
   exit
fi

if [[ "$1 $2" == "create snapshot" || "$1" == "ecsn" ]]; then
   [[ "$1" == "ecsn" ]] && shift || shift 2
   usage="\x1b[95mcreate snapshot \x1b[96m(ecsn)\x1b[97m <repo_name> <snapshot_name>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q PUT \"_snapshot/$1/$2?pretty\""
   q PUT "_snapshot/$1/$2?pretty"
   exit
fi

if [[ "$1 $2" == "delete snapshot" || "$1" == "edsn" ]]; then
   [[ "$1" == "edsn" ]] && shift || shift 2
   usage="\x1b[95mdelete snapshot \x1b[96m(edsn)\x1b[97m <repo_name> <snapshot_name>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " read -p \"Are you sure [yN]? \" yn; if [[ ${yn^} == Y ]]; then q DELETE \"_snapshot/$1/$2?pretty\"; fi"
   read -p "Are you sure [yN]? " yn; if [[ ${yn^} == Y ]]; then q DELETE "_snapshot/$1/$2?pretty"; fi
   exit
fi

if [[ "$1 $2" == "list snapshots" || "$1" == "elsn" ]]; then
   [[ "$1" == "elsn" ]] && shift || shift 2
   usage="\x1b[95mlist snapshots \x1b[96m(elsn)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " q GET \"_cat/snapshots?v\""
   q GET "_cat/snapshots?v"
   exit
fi

if [[ "$1 $2" == "snapshot details" || "$1" == "esnd" ]]; then
   [[ "$1" == "esnd" ]] && shift || shift 2
   usage="\x1b[95msnapshot details \x1b[96m(esnd)\x1b[97m <repo_name> <snapshot_name>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q GET \"_snapshot/$1/$2?pretty\""
   q GET "_snapshot/$1/$2?pretty"
   exit
fi

if [[ "$1 $2" == "restore snaphot" || "$1" == "ersn" ]]; then
   [[ "$1" == "ersn" ]] && shift || shift 2
   usage="\x1b[95mrestore snaphot \x1b[96m(ersn)\x1b[97m <repo_name> <snapshot_name>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " q POST \"_snapshot/$1/$2/_restore?pretty\""
   q POST "_snapshot/$1/$2/_restore?pretty"
   exit
fi
section="GENERIC"

if [[ "$1" == "generic" || "$1" == "eg" ]]; then
   [[ "$1" == "eg" ]] && shift || shift 1
   usage="\x1b[95mgeneric \x1b[96m(eg)\x1b[97m <type-GET/POST/PUT> <api_call>\x1b[0m"
   check_params $# 2 "Usage: $usage"
   print_command " curl -s -X $1 \"http://$ES_HOST:$ES_PORT/$2\""
   curl -s -X $1 "http://$ES_HOST:$ES_PORT/$2"
   exit
fi

if [[ "$1 $2 $3" == "query es settings" || "$1" == "eqes" ]]; then
   [[ "$1" == "eqes" ]] && shift || shift 3
   usage="\x1b[95mquery es settings \x1b[96m(eqes)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " query-es -s"
   query-es -s
   exit
fi

if [[ "$1" == "" ]]; then
  echo "No option passed"
else
  echo "$*: invalid option"
fi
echo "Try "es help" for more information."
```
