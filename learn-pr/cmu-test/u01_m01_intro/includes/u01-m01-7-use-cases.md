<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u01_intro\_u01_m01_intro\x-oli-workbook_page\_u01_m01_7_use_cases.xml -->

## Use Cases for the Cloud

With the rapid evolution of cloud technologies, there are new use cases emerging every day. In this section, we discuss some of the common cloud use cases.

## Web/Mobile Applications

A main driver for cloud computing comes from Web hosting. Websites and Web applications typically are hosted on a server with a dedicated internet connection. Older Web hosting services either provided dedicated servers to clients or gave a fraction of a larger UNIX system to multiple clients. Now, with the advent of cloud computing, Web/mobile applications can be built on top of existing IaaS/PaaS or even SaaS services.

- **SaaS based:** Using the SaaS model, organizations can deploy one-size-fits-all applications on the Web. Common examples include WebMail, social networking sites, and utility websites, such as personal organizers, calendars, and planners.
- **PaaS based:** Application developers can use a range of online platforms and tools to create SaaS and mobile applications. Platforms such as Google App Engine, Parse, and AppScale are popular platforms on which Web and mobile applications can be built.
- **IaaS based:** Applications that need even more customization and flexibility can adopt the IaaS model by renting out virtual machines from providers such as EC2 and Rackspace and deploy a fully customized software stack to run the Web application.

Consider the following scenarios:

- Animoto, an online video slideshow creator, decided to deploy a Facebook application. Traffic to the service surged, which resulted in Animoto scaling up from 50 servers to 3,500 servers in 3 days. Such elastic scalability is made possible through cloud computing.
- Online retail stores that use cloud computing, such as Amazon and Target.com, have been able to size up infrastructure for peak activity (such as the day after Thanksgiving, or Black Friday). Salesforce.com hosts customers ranging from 2 seat to more than 20,000 seat customers, all using the same Web platform.

## Big Data Analytics

Many organizations have to deal with large amounts of data. This data may emanate from such areas as sensors, experiments, transactional data, and Web page activity. Big data processing usually requires a lot of computational and storage resources but, depending on an organization's needs, may be periodic or seasonal. For example, Amazon may have business intelligence and analytics jobs setup for the end of the day, which may require a few hours of time from a few hundred servers. In these scenarios, cloud computing makes sense because these resources can be acquired on demand. Many firms even have fully automated analytics pipelines that automatically collect, analyze, and store data, with resources being provisioned on demand. Examples of big data scenarios include the following:

- The Union Pacific Railroad mounts infrared thermometers, microphones, and ultrasound scanners alongside its tracks. These sensors scan every train as it passes and send readings to the railroad's data centers, in which pattern-matching software identifies equipment at risk of failure.
- Traditional retailers, such as Walmart, Sears, and Kmart, are following in the footsteps of online retailers, such as Amazon, by analyzing consumer spending habits to offer personalized marketing campaigns and offers to individual customers.
- Companies such as Time Warner and Comcast are using big data to track media consumption habits of their subscribers and provide value-added information to advertisers and customers. The video games industry tracks the gameplay habits of millions of console owners. Companies such as Riot Games sift through 500GB of structured data and over 4TB of operational logs every day.

## On-Demand, High-Performance Computing

Modern science is impossible without high-performance computing (HPC). In addition to physical experimentation, computer-based simulation has become popular in fields ranging from astrophysics, quantum mechanics, and oceanography to biochemistry. Such workloads are computationally demanding and typically are run on dedicated clusters or at supercomputing facilities.

Scientists are now increasingly looking toward the cloud for HPC resource demands. Amazon EC2 offers extremely powerful instances with more CPU and even GPU-acceleration for HPC use. Scientists find the availability of vast amounts of computational power appealing, particularly for small projects or time-sensitive, bursty analytics, such as experimental runs before submitting research paper deadlines. Examples of HPC on the cloud include the following:

- A 3,809-instance EC2 cluster was set up by Cycle Computing, Inc. for a pharmaceutical company to run molecular modeling jobs. The cluster has a total of 30,472 cores, 26.7TB of RAM, and 2PB of disk storage.
- Companies such as Pfizer, Unilever, Spiral Genetics, Integrated Proteomics Applications, and Bioproximity run bioinformatics and genomics workloads on Amazon EC2 instances.
- NASA JPL uses high-performance Amazon EC2 instances to process high-resolution satellite images.

## Online Storage and Archival

One of the important resources that is available through cloud computing is storage. From personal storage solutions, such as Dropbox, to large-scale Internet storage systems, such as Amazon S3, online storage is a major cloud computing use case. The online storage options include:

- **Web-based object storage:** Services such as Amazon S3 allow users to store terabytes of data as simple objects that can be accessed over HTTP. Many websites use Amazon S3 to store static content, such as images.
- **Backup and recovery:** Services such as CrashPlan and Carbonite provide online backup of customer data, which is a great option as a secure, off-site backup solution.
- **Media streaming and content distribution:** Services such as Amazon CloudFront not only store large amounts of data but assist in content delivery. Requests to pull data from CloudFront are automatically routed to the nearest server, thereby decreasing latency for time-sensitive media, such as video.
- **Personal storage:** Services such as Dropbox and Google Drive are popular among users to store personal documents online for anytime, anywhere access.

## Rapid Application Development and Testing

One of the major advantages of the cloud is the ability to rapidly deploy and test applications. An entire computing environment can be deployed in minutes and then torn down and discarded just as easily after the testing is complete. For many companies, the value is in allowing developers to quickly create enhancements and features and test them without any risk. Specialized hardware and servers do not need to be ordered and installed. Within mere minutes, a virtual server can be spun up on EC2. Applications can also be easily stress/load tested. Existing servers can be cloned to perform scalability studies as well.
