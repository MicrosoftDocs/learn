With the rapid evolution of cloud technologies, there are new use cases emerging every day. In this section, we discuss some of the common cloud use cases.

## Web and mobile applications

A main driver for cloud computing comes from web hosting. Websites and web applications typically are hosted on a server with a dedicated internet connection. Older web hosting services either provided dedicated servers to clients or gave a fraction of a larger UNIX system to multiple clients. Now, with the advent of cloud computing, web/mobile applications can be built on top of existing IaaS/PaaS or even SaaS services.

- **SaaS based**: Using the SaaS model, organizations can deploy one-size-fits-all applications on the web. Common examples include webmail, social networking sites, and utility websites, such as personal organizers, calendars, and planners.
- **PaaS based**: Application developers can use a range of online platforms and tools to create SaaS and mobile applications. Azure App Service, Parse, and Cloud Foundry are popular platforms on which web and mobile applications can be built.
- **IaaS based**: Organizations that need even more customization and flexibility for a web application can adopt the IaaS model by renting out virtual machines from providers such as Azure and Rackspace, and then deploy a fully customized software stack to run the application.

Consider the following scenarios:

- Animoto, an online video slideshow creator, decided to deploy a Facebook application. Traffic to the service surged, which resulted in Animoto scaling up from 50 servers to 3,500 servers in 3 days. Such elastic scalability is made possible through cloud computing.
- Online retail stores that use cloud computing, such as Amazon and Target.com, have been able to size up infrastructure for peak activity (such as the day after Thanksgiving, or Black Friday). Salesforce.com hosts customers ranging from 2 seats to more than 20,000 seats, all using the same web platform.

## Big data analytics

Many organizations have to deal with large amounts of data. This data may emanate from such areas as sensors, experiments, transactional data, and webpage activity. Big data processing usually requires a lot of computational and storage resources but, depending on an organization's needs, may be periodic or seasonal. For example, Amazon may have business intelligence and analytics jobs set up for the end of the day, which may require a few hours of time from a few hundred servers. In these scenarios, cloud computing makes sense because these resources can be acquired on demand. Many firms even have fully automated analytics pipelines that automatically collect, analyze, and store data, with resources being provisioned on demand. Examples of big data scenarios include the following:

- The Union Pacific Railroad mounts infrared thermometers, microphones, and ultrasound scanners alongside its tracks. These sensors scan every train as it passes and send readings to the railroad's datacenters, in which pattern-matching software identifies equipment at risk of failure.
- Traditional retailers, such as Walmart, Sears, and Kmart, are following in the footsteps of online retailers, such as Amazon, by analyzing consumer spending habits to offer personalized marketing campaigns and offers to individual customers.
- Companies such as Time Warner and Comcast are using big data to track media consumption habits of their subscribers and provide value-added information to advertisers and customers. The video game industry tracks the gameplay habits of millions of console owners. Companies such as Riot Games sift through 500 GB of structured data and over 4 TB of operational logs every day.

## On-demand high-performance computing

Modern science is impossible without high-performance computing (HPC). In addition to physical experimentation, computer-based simulation has become popular in fields ranging from astrophysics, quantum mechanics, and oceanography to biochemistry. Such workloads are computationally demanding and typically are run on dedicated clusters or at supercomputing facilities.

Scientists are now increasingly looking toward the cloud for HPC resource demands. Azure VMs offer extremely powerful instances with more CPU and even GPU acceleration for HPC use. Scientists find the availability of vast amounts of computational power appealing, particularly for small projects or time-sensitive, bursty analytics, such as experimental runs before submitting research paper deadlines. Examples of HPC on the cloud include the following:

- A 3,809-instance AWS EC2 cluster was set up by Cycle Computing for a pharmaceutical company to run molecular modeling jobs. The cluster has a total of 30,472 cores, 26.7 TB of RAM, and 2 PB of disk storage.
- Institutions such as St. Jude's Children's Research Hospital, Mt. Sinai Klein lab, and Seattle Children's Hospital run bioinformatics and genomics workloads on Azure.

## Online storage and archival

One of the important resources that are available through cloud computing is storage. From personal storage solutions, such as Dropbox, to large-scale internet storage systems, such as Azure Storage, online storage is a major use case for cloud computing. The online storage options include:

- **Web-based object storage**: Services such as Azure Blob allow users to store terabytes of data as simple objects that can be accessed over HTTP. Many websites use Azure Blob to store static content, such as images.
- **Backup and recovery**: Services such as CrashPlan and Carbonite provide online backup of customer data, which is a great option as a secure, off-site backup solution.
- **Media streaming and content distribution**: Services such as Azure Content Delivery Network not only store large amounts of data but assist in content delivery. Requests to pull data from Azure Content Delivery Network are automatically routed to the nearest server, thereby decreasing latency for time-sensitive media, such as video.
- **Personal storage**: Services such as Dropbox and OneDrive are popular among users to store personal documents online for anytime, anywhere access.

## Rapid application development and testing

One of the major advantages of the cloud is the ability to rapidly deploy and test applications. An entire computing environment can be deployed in minutes and then torn down and discarded just as easily after the testing is complete. For many companies, the value is in allowing developers to quickly create enhancements and features and test them without any risk. Specialized hardware and servers do not need to be ordered and installed. Within mere minutes, a VM can be spun up on the cloud. Applications can also be easily stress/load tested. Existing servers can be cloned to perform scalability studies as well.

<!-- No References in this unit -->
