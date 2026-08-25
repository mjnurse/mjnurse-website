---
title: Spark Write DataFrame Different Compression Codecs
---

Load large(ish) csv.

```bash
> hdfs dfs -put spotify_millsongdata.csv

> hdfs dfs -ls /user/martin/
Found 1 items

-rw-r--r--   1 martin supergroup     71.4 M 2022-12-01 15:44 /user/martin/spotify_millsongdata.csv
```

```scala
scala> val df = spark.read.csv("spotify_millsongdata.csv")
```

Write parquet file with different compression codec's.

```scala
scala> df.write.option("compression","none").save("spotify-none")

scala> df.write.option("compression","snappy").save("spotify-snappy")

scala> df.write.option("compression","gzip").save("spotify-snappy")
```

```bash
> hdfs dfs -du -h /user/martin/
25.0 M  25.0 M  /user/martin/spotify-gzip
71.1 M  71.1 M  /user/martin/spotify-none
38.5 M  38.5 M  /user/martin/spotify-snappy
71.4 M  71.4 M  /user/martin/spotify_millsongdata.csv
```

