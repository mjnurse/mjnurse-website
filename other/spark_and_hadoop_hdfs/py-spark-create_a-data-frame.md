---
title: PySpark Create a DataFrame
---

File: `test.json`.

```
> echo '{"name":"martin", "status":"cool"}' > test.json
> echo '{"name":"phil", "status":"dull"}' >> test.json
```

Copy file into hdfs.

```
> hdfs dfs -mkdir hdfs://localhost:9000/user/martin/
> hdfs dfs -put test.json hdfs://localhost:9000/user/martin/test.json
```

Start PySpark

```
> PySpark
```

Load file into dataframe.

```python
>>> df = spark.read.json("test.json")
>>> df.show()
+------+------+
|  name|status|
+------+------+
|martin|  cool|
|  phil|  dull|
+------+------+
```

