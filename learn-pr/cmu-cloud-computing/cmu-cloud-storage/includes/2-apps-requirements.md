Applications can deal with data in many ways. Some applications serve as storage and retrieval systems of data. They may archive data for a variety of reasons. Backup software archives user data in a snapshot fashion, allowing the user to restore the state of their computer and files in the event of a hardware failure or accidental deletion. Large websites such as archive.org crawl popular websites and preserve a snapshot allowing users to view the previous versions. A retailer may want to store information regarding every individual transaction for accounting and tax purposes. 

Other applications retrieve data to enable decision making. One example of this is business intelligence systems. A business intelligence system can process millions of transactions and infer sales trends. This information could be used to enable inventory and marketing decisions to be made by the retailer.

Applications can also extract knowledge for analysis. As an example, Google<sup>[1][^1]</sup> discovered that search trends of certain keywords are highly correlated with physician visits for influenza-like symptoms.

Data can also enable a service. Almost any type of dynamic web service that responds to user requests is an example of this. Specific instances include mapping and navigation software. By collecting information about road networks and addresses, a system (such as Google Maps) can respond to direction-related queries.

## Application requirements

Different applications have different requirements of storage systems. Netflix, for example, needs to serve high-bandwidth video to millions of users across the countries in which it operates. Bing search, on the other hand, must analyze a query and retrieve accurate results for that query within a very short period of time. In this section, we will look briefly at the various requirements imposed by applications on storage systems:

- **Capacity**: Storage systems must be able to handle the capacity requirements for an application. A storage system should be able to handle the entire volume of data that is required by the application, and must also be scalable in some form to meet the near-term and future requirements of the application.
- **Performance**: Storage systems should be able to handle application expectations of performance. This can be broadly broken down into the following requirements:
    - **Latency**: The system should respond to requests within a certain expected time frame. In web-scale systems, this requirement is quite important as it directly relates to the user's experience.
    - **Bandwidth**: The system should be able to move data at a certain rate. For applications that rely on continuous feeds of data (such as video), this is a crucial metric.

- **Access patterns**: The particular patterns in which an application accesses data can be used to design and implement efficient storage systems. Specifically, the following patterns are of interest to storage system designers:
    - **Granularity of access**: Refers to the smallest amount of data retrieved in a typical operation. This can range from a few bytes to multiple megabytes, depending on the type of application.
    - **Frequency of access**: Refers to how often data is accessed from the system. If there are certain elements that are constantly accessed, they provide avenues for optimization through techniques such as caching. 
    - **Locality of access**: Refers to spatial and temporal locality. An example of locality is how distant data elements are when they are retrieved for the application. Locality can be considered both at the micro level (how far apart is the stride in an array index during a matrix multiplication) and at the macro level (which datacenter worldwide should respond to this particular user's request).

- **Durability**: This refers to the application's expectations of how the data on the system needs to be persisted.
- **Fault tolerance**: Fault tolerance is a generic term that denotes several attributes of a system. They can be described in terms of the following requirements:
    - **Reliability**: If a particular data item is reported as written by a system, can it always be retrieved back from the system?
    - **Availability**: Is there a particular period of time where the system does not respond to requests? How often does this happen? Is my application affected by this, and what can be done to minimize the impact of this downtime?
    - **Accuracy**: How accurate are the results returned by the system? This may seem like a trivial question for a simple system that consists of only a single data store, but if a system is distributed with multiple copies of the same data, this may be a very significant issue. Some applications can deal with data that is a bit stale, but others require an accurate answer every single time. 

- **Security**: How secure does the data need to be when it is stored and accessed by the application? Is it protected against accidental or malicious access and/or modification and deletion? What kind of access restrictions can be imposed on users and applications that access this system?
- **Provenance**: The process by which one can trace and record the origin of data as well as its movement between storage systems. For an application, is the functionality of being able to track all this information necessary? For certain applications dealing with sensitive and/or confidential data, it is a requirement.

These requirements dictate the design of applications. Applications that require large capacity or need scalability in the near or long term need to be architected accordingly. As you will see in this module, storage systems that deal with large volumes of data are typically too slow or expensive to be contained within a monolithic system. These are typically distributed over multiple machines. 

Strict performance requirements are usually translated into design choices involving caching or replication. Such systems are designed using the access patterns to determine optimal strategies for performance improvement. For applications that are serving clients over the internet, multiple datacenters may be involved to provide faster performance and a better user experience by redirecting users to the closest available server that has the required data.

In order to use certain replication or caching techniques, the application must decide what level or accuracy or freshness it needs for the data retrieved from the system. Certain applications may be OK if they receive stale data, but others require the most accurate and up-to-date data. This in turn affects the level of consistency that the storage system must provide to the application.
<br>
***
### References

1. _Ginsberg, Jeremy and Mohebbi, Matthew H and Patel, Rajan S and Brammer, Lynnette and Smolinski, Mark S and Brilliant, Larry (2009). [Detecting influenza epidemics using search engine query data](https://static.googleusercontent.com/media/research.google.com/en//archive/papers/detecting-influenza-epidemics.pdf) Nature_

[^1]: <https://static.googleusercontent.com/media/research.google.com/en//archive/papers/detecting-influenza-epidemics.pdf> "Ginsberg, Jeremy and Mohebbi, Matthew H and Patel, Rajan S and Brammer, Lynnette and Smolinski, Mark S and Brilliant, Larry (2009). *Detecting influenza epidemics using search engine query data* Nature"
