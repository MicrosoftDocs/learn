ApacheSpark is an open-source Big Data platform that uses scale-out, i.e. multiple machines work together to process data. Unlike Hadoop, Spark works in-memory as much as possible. This results in much faster processing than Hadoop.

## What is HDInsight?

![Screenshot of HDInsight Icon](../media/6-hdinsight-icon.png)

HDInsight is an Azure Platform as a Service (PaaS)  Apache Haddop offering. It is based on the Hortonworks distribution of Hadoop. When you provision an HDInsight cluster, you specify which type a Hadoop platform you want. For scalable machine learning, we are only concerned with the HDInsight Spark implementation.

Spark on HDInsight support massive scale for data querying, wrangling, and machine learning model training. A cluster has a master server that controls the other servers of the cluster. By working on a problem split among multiple machines, performance is greatly enhanced. For HDInsight to run, it needs Azure Blob storage because it needs a place to store data.

A version of HDInsight Spark is offered that includes R Server as a processing front end. The R Server proprietary model training libraries scale out machine learning over the Spark cluster for Big Data model training. HDInsight integrates with other Azure Services as shown below.

![Screenshot of Spark Framework](../media/6-spark-framework.png)

## How to use it

Performing data science using HDInsight Spark is simple because once you spin up a Spark cluster, you can run everyday tools such as Jupyter Notebook and Zeppelin Notebook. Since these technologies alone run slowly for larges-scale data, running them on HDI Spark solves that problem.

## Summary

Data scientists who are comfortable working with the native Spark interface and want complete custom control of the data science process, should consider HDInsight Spark. For the data science team looking for a user friendly, secure, collaborative, Spark based environment, with everything you need, Azure Databricks may be a better solution.