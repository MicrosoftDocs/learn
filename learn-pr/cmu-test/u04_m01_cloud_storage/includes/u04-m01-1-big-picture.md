<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u04_cloud_storage\_u04_m01_cloud_storage\x-oli-workbook_page\_u04_m01_1_big_picture.xml -->

Data is simply a collection of raw facts and figures. Applications are responsible for generating, storing, analyzing and consuming data, or some combination thereof. 

The nature and properties of data typically influence the design and implementation of storage systems. Some of the properties include volume, content, and the frequency of access of data. As an example, Facebook recently studied the access patterns of image and video content posted by its users to find that the access rate exponentially decreases as time passes. They used these findings to design and implement a storage system specific to their needs. In video 4.1, we will look at the various properties of data that influence the design of storage systems.

> [!VIDEO https://youtube.com/embed/Y0C5tA4TV0g]

_Video 4.1: Characterizing Data_

##  Structure of Data

Data can be categorized using its dynamicity and structure. Specifically, data can be broadly segmented into one of the four quadrants in Figure 4.1. One categorization represents the structure of the data, which is considered as either **structured** or **unstructured**.

![Figure 4.1: Segmenting data into various types](../media/segmenting_data.png)

_Figure 4.1: Segmenting data into various types_


**Structured data** have a predefined data model that organizes the data in a form that is relatively easy to process, store, retrieve, and manage. Structured data are usually small data that naturally fit in tabular form and hence can easily be stored in traditional databases (e.g., **relational** databases). An example of structured data is customers' contact information that is stored in tables in a customer relationship management (CRM) database. These data fit in a fairly rigid model (called **schema** in relational databases), which can be quickly stored, accessed, and manipulated.

**Unstructured data**, on the other hand, may not necessarily have a predefined, rigid organizational model. Unstructured data may be larger and may not fit naturally in tabular form, making the data unsuitable for storage in a relational database. Thus, unstructured data may be relatively difficult to organize in a form that is simple to process, store, retrieve, and manage. Examples of unstructured data are flat binary files containing text, video, or audio information. It is important to note that unstructured data is not necessarily devoid of structure; a document, video, or audio file may have a file encoding structure or metadata with which it is associated. Hence, data with some form of structure may still be characterized as unstructured if their structure is not helpful to the processing task for which the data are needed. To illustrate, a large cache of text documents (which are unstructured) is difficult to index and search when compared to a relational database containing customer information (which is structured). For the purposes of this course, unstructured data can be defined as data that do not fit naturally in a relational database. In addition, some data may be treated as unstructured (not stored in a database) because they will be accessed using unpredictable access patterns; traditional database optimizations are pointless for such data.

There is a type of data that lies between structured and unstructured, referred to as **semi-structured data**. Semi-structured data does not conform with the formal structure of data models associated with relational databases or other forms of data tables, but nonetheless contains tags or other markers to separate semantic elements and enforce hierarchies of records and fields within the data. Data that is described using markup languages, for example web pages, clickstream data, web objects are examples of semi-structured data. XML and JSON are classic examples of representations of semi-structured data as they inline data with tags that describe the data as well.
##  Dynamicity of Data

Another characterization is the **dynamicity** of the data, which is an indication of how often the data changes. Dynamic data, such as Microsoft Office documents and transactional entries in a financial database, change relatively frequently, whereas fixed data, once created, may not be altered. Examples of fixed data include medical imaging data from MRI and CT scans and broadcast video footage that is archived in a video library.

Segmenting data into one of these quadrants helps in designing and developing a storage solution for the data. Structured data are typically processed using relational databases in which the data can be accessed, managed, and manipulated using precise commands (typically issued in a query language such as SQL). Unstructured data may be stored in flat files in a file system or may be further organized using a NoSQL database (more on NoSQL later in the module).

The structure and dynamicity of data provide guidance on how a storage system can be architected. Large amounts of data that are relatively static can be stored on disk arrays if they are read frequently. Storage systems designed with multi-tiered caching architecture (such as multi-tiered with caching) improve the performance of read operations on such data. 

Certain types of file systems, such as earlier versions of the Hadoop Distributed File System (HDFS), are designed for relatively static data. They allow a file to be written only once, and the file cannot be modified after it is written. Static data, such as drive images and snapshots for backups, can be archived on relatively inexpensive offline storage systems if they do not need to be accessed frequently.

In summary, the nature of data used by an application must be considered before its appropriate storage architecture is chosen.
##  Granularity and Volume of Data

In addition to the type of data, the volume of data that needs to be stored and processed for a particular application must be considered. The volume of data is characterized along two dimensions, the overall size of data (total volume), versus the size of a useful segment of the data (the granularity of data). As an example, consider the case of a photo sharing website that has millions of users posting tens to hundreds of photos to the website. The total size of the data may be tens or hundreds of terabytes or even petabytes, but the average photo may be a few megabytes. Contrast this to a website like youtube, where the total size of all the videos in youtube is many petabytes, and the size of an video can range from a few hundred megabytes to even gigabytes in size.

In this regard, we touch on an often-used term to describe large volumes of data: **big data**. There are many definitions of big data, but one popular description summarizes it as data is too big to be handled using conventional techniques.

The rapidly expanding information and communications technology (ICT) that is permeating all aspects of modern life has led to a massive explosion of data over the last few decades. Major advances in the connectivity and digitization of information has led to increasing amounts of data being created on a daily basis. These data are diverse, ranging from images and videos from mobile phones being uploaded to websites such as Facebook and YouTube, to 24/7 digital TV broadcasts, to surveillance footage from hundreds of thousands of security cameras, to large scientific experiments such as the Large Hadron Collider—all of which produce many terabytes of data every day. International Data Corporation's (IDC) latest Digital Universe Study predicts a 300-fold increase in the amount of data created globally from 130 exabytes (10<sup>28</sup>) in 2012 to 30,000 exabytes in 2020 (Figure 4.2).

![Figure 4.2: Predicted growth of data from 2009 to 2020](../media/predicted_growth_data.png)

_Figure 4.2: Predicted growth of data from 2009 to 2020_


Organizations are trying to leverage or, in fact, cope with the massive amounts of data that are growing at ever-increasing rates. Google, Yahoo!, and Facebook have gone from processing gigabytes and terabytes to the petabyte range, which puts immense pressure on their computing infrastructures that need to be available 24/7 and must scale seamlessly as the amount of data produced rises exponentially. These are the challenges to which present and future storage technologies must respond.

### References

1. _John Gantz and David Reinsel (2012). The Digital Universe in 2020 IDC White paper_
2. _Subramanian Muralidhar, Wyatt Lloyd, Sabyasachi Roy, Cory Hill, Ernest Lin, Weiwen Liu, Satadru Pan, Shiva Shankar, Viswanath Sivakumar, Linpeng Tang and Sanjeev Kumar (2014). f4: Facebook's Warm BLOB Storage System 11th USENIX Symposium on Operating Systems Design and Implementation (OSDI 14) 383-398 USENIX Association_
3. _Thomas Rivera (2012). The Evolution of File Systems SNIA Tutorial_