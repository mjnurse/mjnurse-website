/*
-	Total jobs: 7803
-	Never compiled (perhaps just copies and not used): 309
-	Sequencers (Sequencers are wrappers around other ETL jobs including Unix / BTEQ executions – They only have one step so we can just collapse these into the other ETL processes / Scripts for estimation): 3,970
-	Not run in last 12 months: 1,730
-	Remainder assumed to be active and processing data: 1,794
*/ 
SELECT   COUNT(*) AS total_jobs
FROM     ds;

SELECT   COUNT(*) AS never_run
FROM     ds
WHERE    num_invocations = '0';

SELECT   COUNT(*) AS sequencers_start_sq
FROM     ds
WHERE    jobname LIKE 'sq%';

SELECT   COUNT(*) not_run_in_last_12_months
FROM     ds
WHERE    SUBSTR(last_ran, 7, 4)||SUBSTR( last_ran, 4,2)||SUBSTR(last_ran,1,2) < '20170701';

DROP TABLE ds1;
CREATE TABLE ds1 AS
SELECT   DISTINCT
         project_name
      ,  LOWER(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(jobname, '([a-z])([A-Z])','\1_\2', 'g'), '([A-Z][a-z])','_\1', 'g'), '^_','')) AS job_name
      ,  CASE WHEN LOWER(jobname) LIKE 'sq%' OR LOWER(jobname) LIKE 'seq%' THEN 'sq' ELSE 'jb' END AS job_type
      ,  stage_count
      ,  '' AS sol
FROM     ds
WHERE    num_invocations != '0'
AND      SUBSTR(last_ran, 7, 4)||SUBSTR( last_ran, 4,2)||SUBSTR(last_ran,1,2) > '20170701';

UPDATE ds1 SET job_name = REPLACE( job_name, 'mdm', '_mdm_');
UPDATE ds1 SET job_name = REPLACE( job_name, 'etl', '');

UPDATE   ds1
SET      job_name = REGEXP_REPLACE( job_name, '__*', '_', 'g' );

DROP TABLE tokens;
CREATE TABLE tokens AS
SELECT   token
      ,  COUNT(*) AS num
FROM
   (  SELECT s.token
      FROM   ds1 t, unnest(string_to_array(REPLACE(t.job_name, '.', '_'), '_')) s(token) ) t
GROUP BY token;

UPDATE ds1 SET job_name =  REPLACE(job_name,'nrt','');

UPDATE ds1 SET sol = sol||'adf'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-adf-%';
UPDATE ds1 SET sol = sol||'aduit'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-aduit-%';
UPDATE ds1 SET sol = sol||'adv'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-adv-%';
UPDATE ds1 SET sol = sol||'agl'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-agl-%';
UPDATE ds1 SET sol = sol||'air'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-air-%';
UPDATE ds1 SET sol = sol||'anc'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-anc-%';
UPDATE ds1 SET sol = sol||'bcr'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-bcr-%';
UPDATE ds1 SET sol = sol||'bdm'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-bdm-%';
UPDATE ds1 SET sol = sol||'bdmcont'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-bdmcont-%';
UPDATE ds1 SET sol = sol||'bma'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-bma-%';
UPDATE ds1 SET sol = sol||'bos'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-bos-%';
UPDATE ds1 SET sol = sol||'box'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-box-%';
UPDATE ds1 SET sol = sol||'bp'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-bp-%';
UPDATE ds1 SET sol = sol||'brt'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-brt-%';
UPDATE ds1 SET sol = sol||'callcredit'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-callcredit-%';
UPDATE ds1 SET sol = sol||'campaign'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-campaign-%';
UPDATE ds1 SET sol = sol||'cc'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-cc-%';
UPDATE ds1 SET sol = sol||'ccc'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-ccc-%';
UPDATE ds1 SET sol = sol||'cdd'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-cdd-%';
UPDATE ds1 SET sol = sol||'cdm'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-cdm-%';
UPDATE ds1 SET sol = sol||'charge'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-charge-%';
UPDATE ds1 SET sol = sol||'con'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-con-%';
UPDATE ds1 SET sol = sol||'conf'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-conf-%';
UPDATE ds1 SET sol = sol||'contact'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-contact-%';
UPDATE ds1 SET sol = sol||'coss'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-coss-%';
UPDATE ds1 SET sol = sol||'cpac'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-cpac-%';
UPDATE ds1 SET sol = sol||'credo'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-credo-%';
UPDATE ds1 SET sol = sol||'cross'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-cross-%';
UPDATE ds1 SET sol = sol||'ctvn'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-ctvn-%';
UPDATE ds1 SET sol = sol||'customs'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-customs-%';
UPDATE ds1 SET sol = sol||'d2d'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-d2d-%';
UPDATE ds1 SET sol = sol||'dataload'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dataload-%';
UPDATE ds1 SET sol = sol||'dcpr'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dcpr-%';
UPDATE ds1 SET sol = sol||'dd2d'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dd2d-%';
UPDATE ds1 SET sol = sol||'dd2ddw'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dd2ddw-%';
UPDATE ds1 SET sol = sol||'dets'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dets-%';
UPDATE ds1 SET sol = sol||'dirt'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dirt-%';
UPDATE ds1 SET sol = sol||'dmo'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dmo-%';
UPDATE ds1 SET sol = sol||'dn'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dn-%';
UPDATE ds1 SET sol = sol||'dockethub'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dockethub-%';
UPDATE ds1 SET sol = sol||'dodr'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dodr-%';
UPDATE ds1 SET sol = sol||'dom'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dom-%';
UPDATE ds1 SET sol = sol||'dtl'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dtl-%';
UPDATE ds1 SET sol = sol||'dttm'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dttm-%';
UPDATE ds1 SET sol = sol||'dup'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dup-%';
UPDATE ds1 SET sol = sol||'dwop'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-dwop-%';
UPDATE ds1 SET sol = sol||'edw'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-edw-%';
UPDATE ds1 SET sol = sol||'eib'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-eib-%';
UPDATE ds1 SET sol = sol||'emhs'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-emhs-%';
UPDATE ds1 SET sol = sol||'emhsso'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-emhsso-%';
UPDATE ds1 SET sol = sol||'enq'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-enq-%';
UPDATE ds1 SET sol = sol||'entries'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-entries-%';
UPDATE ds1 SET sol = sol||'eps'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-eps-%';
UPDATE ds1 SET sol = sol||'equip'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-equip-%';
UPDATE ds1 SET sol = sol||'esb'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-esb-%';
UPDATE ds1 SET sol = sol||'evnt'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-evnt-%';
UPDATE ds1 SET sol = sol||'experian'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-experian-%';
UPDATE ds1 SET sol = sol||'ext'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-ext-%';
UPDATE ds1 SET sol = sol||'fct'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-fct-%';
UPDATE ds1 SET sol = sol||'fleet'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-fleet-%';
UPDATE ds1 SET sol = sol||'fms'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-fms-%';
UPDATE ds1 SET sol = sol||'fuel'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-fuel-%';
UPDATE ds1 SET sol = sol||'gdpr'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-gdpr-%';
UPDATE ds1 SET sol = sol||'haul'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-haul-%';
UPDATE ds1 SET sol = sol||'hazard'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-hazard-%';
UPDATE ds1 SET sol = sol||'hwdc'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-hwdc-%';
UPDATE ds1 SET sol = sol||'ilsm'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-ilsm-%';
UPDATE ds1 SET sol = sol||'interconnect'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-interconnect-%';
UPDATE ds1 SET sol = sol||'international'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-international-%';
UPDATE ds1 SET sol = sol||'intl'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-intl-%';
UPDATE ds1 SET sol = sol||'itinerary'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-itinerary-%';
UPDATE ds1 SET sol = sol||'jst'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-jst-%';
UPDATE ds1 SET sol = sol||'kog'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-kog-%';
UPDATE ds1 SET sol = sol||'kognitio'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-kognitio-%';
UPDATE ds1 SET sol = sol||'labor'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-labor-%';
UPDATE ds1 SET sol = sol||'lead'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-lead-%';
UPDATE ds1 SET sol = sol||'lyngsoe'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-lyngsoe-%';
UPDATE ds1 SET sol = sol||'m5'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-m5-%';
UPDATE ds1 SET sol = sol||'mailing'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mailing-%';
UPDATE ds1 SET sol = sol||'manifest'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-manifest-%';
UPDATE ds1 SET sol = sol||'map'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-map-%';
UPDATE ds1 SET sol = sol||'mars'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mars-%';
UPDATE ds1 SET sol = sol||'marsd2d'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-marsd2d-%';
UPDATE ds1 SET sol = sol||'mc'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mc-%';
UPDATE ds1 SET sol = sol||'md'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-md-%';
UPDATE ds1 SET sol = sol||'mdc'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mdc-%';
UPDATE ds1 SET sol = sol||'mdm'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mdm-%';
UPDATE ds1 SET sol = sol||'mears'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mears-%';
UPDATE ds1 SET sol = sol||'measures'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-measures-%';
UPDATE ds1 SET sol = sol||'meter'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-meter-%';
UPDATE ds1 SET sol = sol||'mi'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mi-%';
UPDATE ds1 SET sol = sol||'mid'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mid-%';
UPDATE ds1 SET sol = sol||'mis'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mis-%';
UPDATE ds1 SET sol = sol||'mist'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mist-%';
UPDATE ds1 SET sol = sol||'mment'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mment-%';
UPDATE ds1 SET sol = sol||'mnfst'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mnfst-%';
UPDATE ds1 SET sol = sol||'mor'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mor-%';
UPDATE ds1 SET sol = sol||'morbos'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-morbos-%';
UPDATE ds1 SET sol = sol||'mp'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mp-%';
UPDATE ds1 SET sol = sol||'mpch'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mpch-%';
UPDATE ds1 SET sol = sol||'mpcv'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mpcv-%';
UPDATE ds1 SET sol = sol||'mpe'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mpe-%';
UPDATE ds1 SET sol = sol||'mpe2'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mpe2-%';
UPDATE ds1 SET sol = sol||'mpm'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mpm-%';
UPDATE ds1 SET sol = sol||'mpr'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mpr-%';
UPDATE ds1 SET sol = sol||'mq2'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mq2-%';
UPDATE ds1 SET sol = sol||'mrschges'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-mrschges-%';
UPDATE ds1 SET sol = sol||'ncoa'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-ncoa-%';
UPDATE ds1 SET sol = sol||'notif'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-notif-%';
UPDATE ds1 SET sol = sol||'np'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-np-%';
UPDATE ds1 SET sol = sol||'npa'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-npa-%';
UPDATE ds1 SET sol = sol||'oee'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-oee-%';
UPDATE ds1 SET sol = sol||'ofpx'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-ofpx-%';
UPDATE ds1 SET sol = sol||'omc'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-omc-%';
UPDATE ds1 SET sol = sol||'ooc'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-ooc-%';
UPDATE ds1 SET sol = sol||'paf'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-paf-%';
UPDATE ds1 SET sol = sol||'parcel'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-parcel-%';
UPDATE ds1 SET sol = sol||'parcels'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-parcels-%';
UPDATE ds1 SET sol = sol||'pbp'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-pbp-%';
UPDATE ds1 SET sol = sol||'pca'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-pca-%';
UPDATE ds1 SET sol = sol||'pcd'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-pcd-%';
UPDATE ds1 SET sol = sol||'pda'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-pda-%';
UPDATE ds1 SET sol = sol||'pdabase'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-pdabase-%';
UPDATE ds1 SET sol = sol||'peg'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-peg-%';
UPDATE ds1 SET sol = sol||'pfw'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-pfw-%';
UPDATE ds1 SET sol = sol||'poise'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-poise-%';
UPDATE ds1 SET sol = sol||'poisenrt'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-poisenrt-%';
UPDATE ds1 SET sol = sol||'pol'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-pol-%';
UPDATE ds1 SET sol = sol||'polbfpo'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-polbfpo-%';
UPDATE ds1 SET sol = sol||'pooo'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-pooo-%';
UPDATE ds1 SET sol = sol||'ppms'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-ppms-%';
UPDATE ds1 SET sol = sol||'preadvice'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-preadvice-%';
UPDATE ds1 SET sol = sol||'premium'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-premium-%';
UPDATE ds1 SET sol = sol||'privacy'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-privacy-%';
UPDATE ds1 SET sol = sol||'psa'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-psa-%';
UPDATE ds1 SET sol = sol||'qc'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-qc-%';
UPDATE ds1 SET sol = sol||'qd'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-qd-%';
UPDATE ds1 SET sol = sol||'qsi'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-qsi-%';
UPDATE ds1 SET sol = sol||'qsinar'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-qsinar-%';
UPDATE ds1 SET sol = sol||'rail'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-rail-%';
UPDATE ds1 SET sol = sol||'rdc'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-rdc-%';
UPDATE ds1 SET sol = sol||'rdcqd'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-rdcqd-%';
UPDATE ds1 SET sol = sol||'rdm'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-rdm-%';
UPDATE ds1 SET sol = sol||'rdmrd'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-rdmrd-%';
UPDATE ds1 SET sol = sol||'redlands'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-redlands-%';
UPDATE ds1 SET sol = sol||'rej'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-rej-%';
UPDATE ds1 SET sol = sol||'relation'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-relation-%';
UPDATE ds1 SET sol = sol||'rep'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-rep-%';
UPDATE ds1 SET sol = sol||'repzone'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-repzone-%';
UPDATE ds1 SET sol = sol||'req'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-req-%';
UPDATE ds1 SET sol = sol||'reqs'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-reqs-%';
UPDATE ds1 SET sol = sol||'revman'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-revman-%';
UPDATE ds1 SET sol = sol||'rfid'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-rfid-%';
UPDATE ds1 SET sol = sol||'rjct'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-rjct-%';
UPDATE ds1 SET sol = sol||'rmgtt'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-rmgtt-%';
UPDATE ds1 SET sol = sol||'routes'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-routes-%';
UPDATE ds1 SET sol = sol||'roy'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-roy-%';
UPDATE ds1 SET sol = sol||'rp'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-rp-%';
UPDATE ds1 SET sol = sol||'sales'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-sales-%';
UPDATE ds1 SET sol = sol||'sapbw'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-sapbw-%';
UPDATE ds1 SET sol = sol||'sb'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-sb-%';
UPDATE ds1 SET sol = sol||'scan'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-scan-%';
UPDATE ds1 SET sol = sol||'scms'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-scms-%';
UPDATE ds1 SET sol = sol||'scv'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-scv-%';
UPDATE ds1 SET sol = sol||'sect'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-sect-%';
UPDATE ds1 SET sol = sol||'sector'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-sector-%';
UPDATE ds1 SET sol = sol||'segregation'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-segregation-%';
UPDATE ds1 SET sol = sol||'serv'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-serv-%';
UPDATE ds1 SET sol = sol||'service'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-service-%';
UPDATE ds1 SET sol = sol||'siebel'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-siebel-%';
UPDATE ds1 SET sol = sol||'sig'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-sig-%';
UPDATE ds1 SET sol = sol||'sign'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-sign-%';
UPDATE ds1 SET sol = sol||'site'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-site-%';
UPDATE ds1 SET sol = sol||'sk'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-sk-%';
UPDATE ds1 SET sol = sol||'sp'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-sp-%';
UPDATE ds1 SET sol = sol||'sps'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-sps-%';
UPDATE ds1 SET sol = sol||'spstg'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-spstg-%';
UPDATE ds1 SET sol = sol||'src'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-src-%';
UPDATE ds1 SET sol = sol||'srv'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-srv-%';
UPDATE ds1 SET sol = sol||'ss'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-ss-%';
UPDATE ds1 SET sol = sol||'st'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-st-%';
UPDATE ds1 SET sol = sol||'stives'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-stives-%';
UPDATE ds1 SET sol = sol||'td'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-td-%';
UPDATE ds1 SET sol = sol||'tdf'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-tdf-%';
UPDATE ds1 SET sol = sol||'tech'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-tech-%';
UPDATE ds1 SET sol = sol||'theft'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-theft-%';
UPDATE ds1 SET sol = sol||'tib'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-tib-%';
UPDATE ds1 SET sol = sol||'tnr'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-tnr-%';
UPDATE ds1 SET sol = sol||'tns'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-tns-%';
UPDATE ds1 SET sol = sol||'tods'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-tods-%';
UPDATE ds1 SET sol = sol||'top'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-top-%';
UPDATE ds1 SET sol = sol||'tpt'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-tpt-%';
UPDATE ds1 SET sol = sol||'track'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-track-%';
UPDATE ds1 SET sol = sol||'traffic'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-traffic-%';
UPDATE ds1 SET sol = sol||'trck'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-trck-%';
UPDATE ds1 SET sol = sol||'udc'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-udc-%';
UPDATE ds1 SET sol = sol||'udprn'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-udprn-%';
UPDATE ds1 SET sol = sol||'un'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-un-%';
UPDATE ds1 SET sol = sol||'unitdis'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-unitdis-%';
UPDATE ds1 SET sol = sol||'wand'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-wand-%';
UPDATE ds1 SET sol = sol||'wasps'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-wasps-%';
UPDATE ds1 SET sol = sol||'wave'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-wave-%';
UPDATE ds1 SET sol = sol||'webform'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-webform-%';
UPDATE ds1 SET sol = sol||'wir'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-wir-%';
UPDATE ds1 SET sol = sol||'wo'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-wo-%';
UPDATE ds1 SET sol = sol||'xfm'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-xfm-%';
UPDATE ds1 SET sol = sol||'zodocket'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-zodocket-%';
UPDATE ds1 SET sol = sol||'zonal'||',' WHERE '-'||REPLACE(job_name,'_','-')||'-' LIKE '%-zonal-%';

