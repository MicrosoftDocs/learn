Now we'll look at a special class of storage systems that are designed as a cloud service that is provided over the internet. In the context of our discussion on cloud storage thus far, object storage in clouds can be considered to be a special case of key-value stores provided as a service over the internet.

Providing storage as a service to clients over the internet requires abstracting the underlying storage implementation details and providing a simple and clean interface that can be used in applications. Cloud adopters are increasingly choosing the cloud object model for storage on the cloud. 

With the concept of objects, object-based storage systems abstract the existing file system approach at a higher level. Object-based storage systems are typically layered over existing file systems. There is no notion of hierarchies in object-based storage systems, which instead use a flat data environment. 

An **object** can be considered as a generic container that can store any arbitrary type of information. Designing interfaces for such arbitrary data may be difficult, but in storage parlance, a basic set of operations can be easily defined for any arbitrary object. These operations are create, read, update, and delete (CRUD), which are typically made available through some kind of API that can be accessed through HTTP or other network protocols using REST- or SOAP-style calls. 

## REST

**Representational state transfer** (REST) relies on a stateless, client-server, cacheable communications protocol and is typically implemented over HTTP. A stateless protocol treats each request as an independent operation, and each communication between a client and server is treated as an independent pair of requests and responses. The following video discusses HTTP and RESTful interfaces:
<br>

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4pSF5]

REST is an **architectural style** for designing networked applications and does not refer to a single protocol. REST is a design strategy for communications among various entities in a networked application. The idea is to use a simple mechanism instead of CORBA, WSDL, or RPC to connect and transfer information between machines over a network. Any interface that uses REST principles is called a **RESTful** interface. 

A RESTful interface uses HTTP requests to post (create and/or update), read (make queries and get information), and delete data. Thus, a RESTful interface can be used for CRUD operations. 

A RESTful interface consists of the following components:

- A uniform resource identifier (URI), such as an HTTP URL through which the service can be accessed. 
- An internet media type for the data supported by the service (typically XML or JSON). 
- A set of operations that is supported by the web service using HTTP methods (GET, PUT, POST, and DELETE). 
- An HTTP-driven API.

Thus, a program that needs to connect to a service with a RESTful interface can use standard HTTP GET, PUT, POST, and DELETE requests. An example of a REST request is covered shortly. 

The major advantages of REST are that it is:

- A platform-independent approach that is ideally suited for the internet. 
- A language-independent interface because all instructions are passed over HTTP so that, for example, a C# client can talk to a Python server. 
-  A standards-based communication because it runs on top of HTTP.
- Operational in the presence of firewalls as long as HTTP or HTTPS traffic is not filtered. 

## Object storage systems - Amazon S3

The following video covers the basics ideas behind object storage systems:

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4q0qD]

An example of object-based storage on the cloud is Amazon's Simple Storage Service (S3). S3 allows users to store **objects** in **buckets**. Each object can be created, read, and deleted. Note that in the S3 model, although no native update-object method exists, an entire object can be deleted and re-created, similar to a file overwrite. However, S3 supports object versioning and can maintain multiple versions of an object on S3 if it is explicitly enabled by the object owner. 

Here is an example of a RESTful HTTP call to Amazon S3 to create a bucket named `mybucket`. The HTTP call includes authorization information for the client to access the bucket. 

``` text
PUT /mybucket HTTP/1.1
Content-Length: 0
User/Agent: jClientUpload
Host: s3.amazonaws.com
Date: Sun, 05 Aug 2007 15:33:59 GMT
Authorization: AWS 15B4D3461F177624206A:YFhSWKDg3qDnGbV7JCnkfdz/IHY= LE:k3nL7gH3+PadhTEVn5EXAMPLE
```

S3 can process the request and will send back an HTTP response similar to the following:

``` text
HTTP/1.1 200 OK
x-amz-id-2: tILPE8NBqoQ2Xn9BaddGf/YlLCSiwrKP+OQOpbi5zazMQ3pC56KQgGk
x-amz-request-id: 676918167DFF7F8C
Date: Sun, 05 Aug 2007 15:30:28 GMT
Location: /mybucket
Content-Length: 0
Server: AmazonS3
```

In the response, Amazon has acknowledged the request, indicated that the request was successful (with a "200 OK" message), and returned some information regarding the request. The `x-amz-id-2` and `x-amz-request-id` fields are unique identifiers that can be used to keep track of responses for troubleshooting and debugging purposes. 

## Cloud object storage standards: CDMI

The lack of a common standard for object storage is an issue plaguing cloud object storage. The most popular cloud-based object storage system is Amazon S3, which is proprietary.

The Storage Networking Industry Association (SNIA) is promoting an open standard for cloud objects, called **Cloud Data Management Interface (CDMI)**. 

![CDMI](../media/cdmi.png)

_Figure 22: CDMI_

CDMI defines data objects and data containers with tagged metadata (as key-value pairs) and uses RESTful interfaces, with JSON as the data exchange format. CDMI can be used for accessing and managing data on a storage cloud (Figure 22). An example of a client interaction with a storage cloud using CDMI is shown in Figure 23.

![CDMI client interacting with a CDMI storage cloud](../media/cdmi-cloud.png)

_Figure 23: A CDMI client interacting with a CDMI storage cloud_

The CDMI client can issue requests over HTTPS. The **MimeType** indicates the type of CDMI resource with which the client is interacting (an object, a container) and returns standard HTTP status codes, indicating the status of the request. 

The CDMI model is illustrated in Figure 24. A CDMI resource exists on a root location, indicated by the root URI: `https://<offering>`. The example contains two containers, A and B, that contain one object each. Note that each CDMI entity can support metadata, as indicated with the key-value tags associated with every entity.

![CDMI data model](../media/cdmi-data-model.png)

_Figure 24: The CDMI data model_

In addition, CDMI supports the following resource types: 
- **cdmi-capability:** A special entity that describes the capabilities of this particular cloud store. This entity is important and can be used to discover the capabilities of a cloud (e.g., backup and replication).
- **cdmi-domain:** Allows for the creation of domains (e.g., groups of users with object access permissions).
- **cdmi-queue:** Allows for the creation of queues of objects that operate in first in, first out (FIFO) order. Applications can use such queues to implement notification or messaging systems.

The advantages of CDMI include the following:

- Its vendor-neutral specification of a cloud object storage system allows for simpler data migration from one cloud to another.
- It enables **cloud peering** for storage, which is a concept wherein resources from different clouds can be connected to enable seamless data sharing between clouds. 
- It adheres to existing standards, such as RESTful interfaces for data access, and can work with multiple underlying storage abstractions, such as shared and networked file systems.
- It is a mature standard, which has a reference implementation and ISO standardization.

The disadvantage of CDMI is that its adoption is yet to be seen. The CDMI standard is backed by many storage companies, but it is not yet officially supported by vendors such as Amazon, and the standard's success remains unclear.
