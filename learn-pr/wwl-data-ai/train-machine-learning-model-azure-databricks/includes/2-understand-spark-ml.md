Azure Databricks supports several libraries for machine learning. There's one key library, which has two approaches that are native to Apache Spark: **MLLib** and **Spark ML**.

## MLLib

MLLib is a legacy approach for machine learning on Apache Spark. It builds off of Spark's [Resilient Distributed Dataset](https://spark.apache.org/docs/latest/rdd-programming-guide.html#resilient-distributed-datasets-rdds) (RDD) data structure. This data structure forms the foundation of Apache Spark, but additional data structures on top of the RDD, such as DataFrames, have reduced the need to work directly with RDDs.

As of Apache Spark 2.0, the library entered a maintenance mode. This means that MLLib is still available and has not been deprecated, but there will be no new functionality added to the library. Instead, customers are advised to move to the `org.apache.spark.ml` library, commonly referred to as Spark ML.

## Spark ML

Spark ML is the primary library for machine learning development in Apache Spark. It supports DataFrames in its API, versus the classic RDD approach. This makes Spark ML an easier library to work with for data scientists, as Spark DataFrames share many common ideas with the DataFrames used in Pandas and R.

The most confusing part about MLLib versus Spark ML is that **they are both the same library**. The difference is that the "classic" MLLib namespace is `org.apache.spark.mllib` whereas the Spark ML namespace is `org.apache.spark.ml`. Whenever possible, use the Spark ML namespace when performing new data science activities.
