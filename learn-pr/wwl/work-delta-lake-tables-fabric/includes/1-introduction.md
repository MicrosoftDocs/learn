---
ms.custom:
  - build-2023
---
Tables in a Microsoft Fabric lakehouse are based on the 
Linux foundation *Delta Lake* table format, commonly used in Apache Spark. Delta Lake is an open-source storage layer for Spark that enables relational database capabilities for batch and streaming data. By using Delta Lake, you can implement a lakehouse architecture to support SQL-based data manipulation semantics in Spark with support for transactions and schema enforcement. The result is an analytical data store that offers many of the advantages of a relational database system with the flexibility of data file storage in a data lake.

While you don't need to work directly with Delta Lake APIs in order to use tables in a Fabric lakehouse, an understanding of the Delta Lake metastore architecture and familiarity with some of the more specialized Delta table operations can greatly expand your ability to build advanced analytics solutions on Microsoft Fabric.
