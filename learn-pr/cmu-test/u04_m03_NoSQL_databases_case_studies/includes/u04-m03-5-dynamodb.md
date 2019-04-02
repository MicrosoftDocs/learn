<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u04_cloud_storage\_u04_m03_NoSQL_databases_case_studies\x-oli-workbook_page\_u04_m03_5_dynamodb.xml -->
##  Amazon's DynamoDB
[DynamoDB](http://aws.amazon.com/dynamodb) is a proprietary, highly available NoSQL data store offered by Amazon Web Services. DynamoDB has evolved from Dynamo, a distributed key-value storage system first described by Amazon in . Dynamo shares some of the properties of databases as well as distributed hash tables (DHTs) and is designed using several techniques in distributed systems, including consistent hashing, quorum, and antientropy<!-- , etc. -->. 

###  DynamoDB Data Model
Information in DynamoDB is stored in _Tables_. A table consists of multiple _items_, each of which has one or more _attributes_. DynamoDB has a flexible schema, and items can have any number of attributes. The only restriction in DynamoDB is that the size of an item must not exceed 400KB (This includes the sum of the lengths of individual attributes names and values for a single item). An example of an item in DynamoDB is given below:

``` text
{                                        
   Title = "Book 101 Title"
   ISBN = "111-1111111111"
   Authors = "Author 1"
   Price = -2
   Dimensions = "8.5 x 11.0 x 0.5"
   PageCount = 500
   InPublication = true
   ProductCategory = "Book" 
} 
```



When a table is created in DynamoDB, one attribute must be designated as the _primary key_ of the table, and is used to identify every item in the table. The attribute must appear in every item in a DynamoDB table. Primary keys can be of two types: they can either be a _Hash Type_ primary key, which consists of a single attribute as the key, a _Hash and Range Type_ primary key, which consists of two attributes. In the hash and range type primary key, the first attribute is a hash index, while the second attribute is a range attribute.

DynamoDB supports attributes that can be _scalar_ (such as number, string, binary, boolean or null values), _multi-valued_ (as a string, number or binary set of values), or can be a _document_ type (such as a _list_ or _map_).

###  Operations in DynamoDB
DynamoDB provides operations to create, update and delete tables. Once a table is created users can set a performance level for the table (designated as _provisioned throughput_). This enables Amazon to configure the DynamoDB backend to be able to maintain a guaranteed performance level, measured as a number of requests/second that the table will handle.

DynamoDB allows users to _add_, _update_ or _delete_ items from a table. Operations that interact with a single item in DynamoDB are known as _queries_. DynamoDB also supports conditional updates, where an update to a table can happen based on a user-specified condition. 

Operations that interact with multiple items at a time are known as _scan_. A scan will effectively read every single item in a DynamoDB table. DynamoDB has a 1MB limit on the amount of data returned by any single operation, including scans. As you can expect, scans can be slow in DynamoDB, especially when done on large tables.

###  DynamoDB Architecture
Amazon's DynamoDB is based on the Dynamo architecture, which was described in . Amazon made changes to the architecture since, but the basic principles remain more or less the same. Dynamo uses many of the techniques discussed in the section on Cassandra above, including consistent hashing, replication, hinted hand-off, anti-entropy using merkle trees and more. Dynamo was among the first distributed systems to use a combination of all these techniques in a single system.

###  Consistency in DynamoDB
Data stored in DynamoDB tables are replicated across 3 Amazon data centers to ensure that data is not lost in the event of a data-center wide failure. DynamoDB gives users the option to specify the consistency of read operation. By default, all reads as _eventually consistent_ and may not reflect the results of a recently completed write. If the application requires strong consistency, that can be specified when making the read request to DynamoDB; this results in a performance hit as multiple replicas may have to consulted before the result of a read can be sent back to the client, but all prior writes that were successfully completed will be reflected in the read operation.

###  DynamoDB Use Cases
DynamoDB can be used to meet specific challenges for certain types of applications:

_Latency-sensitive applications_: DynamoDB is engineered to provide extremely low latency, especially for read workloads. 

_Applications that require fast scalability and predictable performance_: DynamoDB as a service is extremely easy to scale up as demand increases. AWS provides monitoring systems to inform application developers about the number of requests being served by a table. Based on this information, developers can request additional provisioned capacity from DynamoDB to handle higher loads. This makes DynamoDB one of the easiest services to scale out as demand increases.

_Applications with a simple data model_: DynamoDB's data model is extremely simplified and basically only allows for inserts and updates to data items index with a key. DynamoDB does not support complex queries such as joins and is slow on operations such as aggregations, which require scans of the entire table. DynamoDB is more suited for applications with more transactional workloads than analytical workloads. 