With the rapid evolution of cloud technologies, new use cases emerge every day. In this section, we discuss some of the common and most compelling use cases for the cloud and present some real-world examples.

# Web and Mobile Applications

A main driver for cloud computing comes from web hosting. Web sites and web applications typically are hosted on a server with a dedicated internet connection. Older web hosting services either provided dedicated servers to clients or gave a fraction of a larger UNIX system to multiple clients. Now, with the advent of cloud computing, web and mobile applications can be built on top of existing IaaS, PaaS, and even SaaS services.

- **SaaS-based**: Using the SaaS model, organizations can deploy one-size-fits-all applications on the web. Common examples include web mail, social networking sites, and utility web sites such as personal organizers, calendars, and planners.

- **PaaS-based**: Application developers can use a range of online platforms and tools to create PaaS and mobile applications. Platforms such as Google App Engine, Parse, and AppScale are popular platforms on which web and mobile applications can be built.

- **IaaS-based**: Applications that need even more customization and flexibility can adopt the IaaS model by renting out virtual machines from providers such as EC2 and Rackspace and deploy a fully customized software stack to run the Web application.

Consider the following scenarios:

- Animoto, an online video slideshow creator, decided to deploy a Facebook application. Traffic to the service surged, which resulted in Animoto scaling up from 50 servers to 3,500 servers in 3 days. Such elastic scalability is made possible through cloud computing.

- Online retail stores that use cloud computing, such as Amazon and Target.com, have been able to size up infrastructure for peak activity (such as the day after Thanksgiving). Salesforce.com hosts customers ranging from those with 2 seats to more than 20,000 seats, all using the same Web platform.

Domino's Pizza relies on a combination of services provided by AWS and Azure to power its business. For example, it uses Azure App Service and Azure Cosmos DB -- both PaaS services -- for online ordering and delivery tracking, enabling it to scale up and down as needed to meet demand. Domino's also uses SaaS-based Microsoft Dynamics ERP to meet its enterprise resource planning needs<sup>[1][^1]</sup>.

# Big-Data Analytics

Many organizations have to deal with large amounts of data. This data may emanate from such areas as sensors, experiments, transactional data, and web-page activity. Big-data processing usually requires a lot of computational and storage resources but, depending on an organization\'s needs, may be periodic or seasonal. For example, Amazon may have business intelligence and analytics jobs set up for the end of the day, which may require a few hours of time from a few hundred servers. In these scenarios, cloud computing makes sense because these resources can be acquired on demand. Many firms even have fully automated analytics pipelines that automatically collect, analyze, and store data, with resources being provisioned on demand. Examples of big data scenarios include the following:

- The Union Pacific Railroad mounts infrared thermometers, microphones, and ultrasound scanners alongside its tracks. These sensors scan every train as it passes and send readings to the railroad\'s data centers, in which pattern-matching software identifies equipment at risk of failure.

- Traditional retailers such as Walmart are following in the footsteps of online retailers such as Amazon by analyzing consumer spending habits to offer personalized marketing campaigns and offers to individual customers.

- Companies such as Time Warner and Comcast are using big data to track media consumption habits of their subscribers and provide value-added information to advertisers and customers. The video games industry tracks the gameplay habits of millions of console owners. Companies such as Riot Games sift through 500GB of structured data and over 4TB of operational logs every day.

The cloud also plays a role in analytics by offering managed implementations of popular tools such as Apache Hadoop and Apache Spark that can be ready to use in minutes, and subsequently deleted when no longer needed. Purchasing, deploying, and configuring a Spark cluster can take months and requires significant expertise. With the cloud, and with services such as Azure Databricks and Databricks in AWS, clusters provisioned with the latest version of Spark can be deployed with a few button clicks.

# On-Demand High-Performance Computing

Modern science is impossible without high-performance computing (HPC). In addition to physical experimentation, computer-based simulation has become popular in fields ranging from astrophysics and quantum mechanics to oceanography and biochemistry. Such workloads are computationally demanding and typically are run on dedicated clusters or at supercomputing facilities.

Scientists are increasingly looking to the cloud to fulfill the need for HPC resources. For HPC use, AWS, Azure, and GCP offer extremely powerful virtual machines with faster CPUs and state-of-the-art GPUs. Scientists find the availability of vast amounts of computational power appealing, particularly for small projects or time-sensitive, bursty analytics such as experimental runs before submitting deadlines for research papers. Examples of HPC in the cloud include the following:

- A 3,809-instance EC2 cluster was set up by Cycle Computing, Inc. for a pharmaceutical company to run molecular modeling jobs. The cluster has a total of 30,472 cores, 26.7TB of RAM, and 2PB of disk storage.

- Companies such as Pfizer, Unilever, Spiral Genetics, Integrated Proteomics Applications, and Bioproximity run bioinformatics and genomics workloads on Amazon EC2 instances.

- NASA JPL uses high-performance Amazon EC2 instances to process high-resolution satellite images.

In 2015, risk-management and financial-services firm Willis Tower Watson teamed with Microsoft to deploy an HPC cluster containing 100,000 cores and used it to calculate the cost of providing insurance to every person in the world<sup>[2][^2]</sup>. The entire process, from provisioning to downloading the results, took less than 12 hours. On a single-core CPU, the same job would have required almost 20 years to execute.

# Online Storage and Archival

One of the important resources that is available through cloud computing is storage. From personal storage solutions, such as Dropbox, to large-scale Internet storage systems, such as Amazon S3, online storage is a major cloud computing use case. The online storage options include:

- **Web-based object storage**: Services such as Amazon S3 and Azure Storage allow users to store terabytes of data as simple objects that can be accessed over HTTP. Many websites use Amazon S3 and Azure Storage to store static content, such as images.

- **Backup and recovery**: Services such as CrashPlan and Carbonite provide online backup of customer data, which is a great option as a secure, off-site backup solution.

- **Media streaming and content distribution**: Services such as Amazon CloudFront and Azure CDN not only store large amounts of data, but assist in content delivery. Requests to pull data from CloudFront are automatically routed to the nearest server, thereby decreasing latency for time-sensitive media, such as video.

- **Personal storage**: Services such as Dropbox and Google Drive are popular among users to store personal documents online for anytime, anywhere access.

# Rapid Application Development and Testing

One of the major advantages of the cloud is the ability to rapidly deploy and test applications. An entire computing environment can be deployed in minutes and then torn down and discarded once testing is complete. For many companies, the value is in allowing developers to quickly create enhancements and features and test them without any risk. Specialized hardware and servers do not need to be ordered and installed. Within minutes, a virtual server can be spun up in Amazon EC2, Azure Virtual Machines, or Google Compute Engine. Applications can also be easily stress/load tested. Existing servers can be cloned to perform scalability studies as well.

The cloud is also fueling investments in *DevOps*, which increases an organization's ability to deliver software in less time while achieving higher quality. Organizations create DevOps pipelines that include virtual build servers coupled to cloud-based source-code repositories. Developers check code changes into the repository, which triggers an automatic build in a process known as *continuous integration* (CI). Another feature of DevOps is *continuous delivery* (CD), in which updated builds are automatically tested and rolled out to a staging or production environment. Products such as AWS CodePipeline, AWS CodeBuild, and Azure DevOps enable these types of scenarios and are rapidly becoming the backbone of the software-development process at enterprises large and small.

# Machine Learning and Artificial Intelligence

Machine learning (ML) and the subset of machine learning (ML) known as artificial intelligence (AI) are touching lives every day. Credit-card companies use ML/AI models to check for fraud in real time; retailers use them to entice customers with additional purchases and forecast demand; linguists use them to translate speech in real time; restaurants use them to improve food quality<sup>3</sup>; and researchers use them to analyze the human genome for cancer indicators<sup>[4][^4]</sup>.

Training ML/AI models frequently requires vast quantities of compute power. One example is the *convolutional neural network* (CNN), which excels at tasks involving computer vision -- for example, determining whether a photo contains a picture of a dog or a cat. These models are typically trained with batches of images comprising billions of pixels and frequently contain 100 or more layers. Training a CNN of this size is impractical on a single computer, but is accomplished relatively efficiently on an HPC cluster equipped with GPUs to facilitate parallel processing.

A recent trend in cloud computing has providers making ML and AI available as SaaS services. With Azure's Custom Vision Service, for example, you can train a neural network to discriminate between cat pictures and dog pictures in a matter of minutes and at virtually no cost. Specific examples of companies that use cloud-based ML and AI services to improve their business processes include:

- Expedia uses machine-learning services powered by AWS's recommendations engine to streamline the hotel booking process<sup>[5][^5]</sup>.

- British Petroleum (BP) uses Azure Machine Learning to improve its ability to forecast recovery factors -- the percentage of hydrocarbons that can be extracted from an underground deposit -- for potential oil and gas reservoirs<sup>[6][^6]</sup>.

- iGenius combined Google's Cloud AI machine-learning APIs with Google App Engine to build the world's first digital marketing advisor<sup>[7][^7]</sup>.

The explosion in ML and AI research, investment, advances, and applications in recent years is primarily attributable to cloud computing, which makes the vast amounts of computing power required to train new models and improve existing ones available to researchers at institutions large and small.

### References

1. _Microsoft (2017). *Azure's Platform as a Service is the pepperoni on the pizza for Domino's*. <https://news.microsoft.com/en-au/features/azures-platform-service-pepperoni-pizza-dominos/>_

2. _Microsoft (2016). *What would you do with 100,000 cores? - Big compute at global scale*. <https://azure.microsoft.com/blog/what-would-you-do-with-100000-cores-big-compute-at-global-scale/>_

3. _Tom's Guide (2019). *Domino's Now Using AI and Cameras to Make \'Perfect\' Pizzas*_

4. _Computational and Structural Biotechnology Journal (2015). *Machine learning applications in cancer prognosis and prediction*. <https://www.sciencedirect.com/science/article/pii/S2001037014000464>_

5. _PhocusWire (2019). *How Expedia is using deep learning to improve the hotel booking process*. <https://www.phocuswire.com/Expedia-Partner-Solutions-machine-learning>_

6. _Microsoft (2019). *BP explores Azure AI to boost safety, increase efficiency, and drive business success*. <https://customers.microsoft.com/story/bp-mining-oil-gas-azure-machine-learning>_

7. _Google. *iGenius: Creating crystal, the first virtual digital marketing advisor*. <https://cloud.google.com/customers/igenius/>_

[^1]: <https://news.microsoft.com/en-au/features/azures-platform-service-pepperoni-pizza-dominos/>  "Microsoft (2017). *Azure's Platform as a Service is the pepperoni on the pizza for Domino's*."

[^2]: <https://azure.microsoft.com/blog/what-would-you-do-with-100000-cores-big-compute-at-global-scale/>  "Microsoft (2016). *What would you do with 100,000 cores? - Big compute at global scale*."

[^4]: <https://www.sciencedirect.com/science/article/pii/S2001037014000464>  "Computational and Structural Biotechnology Journal (2015). *Machine learning applications in cancer prognosis and prediction*."

[^5]: <https://www.phocuswire.com/Expedia-Partner-Solutions-machine-learning>  "PhocusWire (2019). *How Expedia is using deep learning to improve the hotel booking process*."

[^6]: <https://customers.microsoft.com/story/bp-mining-oil-gas-azure-machine-learning>  "Microsoft (2019). *BP explores Azure AI to boost safety, increase efficiency, and drive business success*."

[^7]: <https://cloud.google.com/customers/igenius/>  "Google. *iGenius: Creating crystal, the first virtual digital marketing advisor*."
