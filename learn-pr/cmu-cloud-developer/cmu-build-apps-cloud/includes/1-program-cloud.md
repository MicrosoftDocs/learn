Designing programs that are destined for the cloud requires special considerations. Depending on the type of application and the expected load, developers can utilize some of the features provided by cloud providers to enhance the scalability and maintainability of programs. Use of automatic scaling systems and load balancers allows developers to dynamically grow or shrink infrastructure based on the utilization of hardware or a program-computed load factor. 

There are multiple considerations that a developer must account for when developing or migrating an application to the cloud, particularly those that concern performance and security. 

## Performance factors for applications on the cloud

The environment in a cloud-centric datacenter is different from what developers might be used to when designing and deploying applications on owned infrastructure. Some developers find it hard to fine-tune or enhance the performance of their applications because they do not have access to the physical hardware layout or specifications on public clouds. We will try to enumerate some of the top concerns, with specific emphasis on factors that affect application performance on the cloud:

### Resource bandwidth and latency

A primary concern for developing and deploying cloud applications is latency. Developers must plan their applications with strict latency requirements in mind. One approach is to compile the distribution of client locations. This will allow developers to find the optimal set of datacenter locations that can be used to optimize end-user performance and responsiveness. This is particularly true in web applications, where individual HTTP requests for static web content can represent an important fraction of the webpage load times.

Apart from latency, applications may also have strict bandwidth requirements, particularly those that deal with rich multimedia content such as audio and video. Many cloud providers allow cloud developers to specify performance parameters during provisioning in the form of IOPS requirements for compute and storage resources. In addition, many cloud providers allow developers to set up virtual networks. The implementation and adoption of software-defined networking and storage (covered in later modules) provide additional insights into newer techniques used by datacenters to manage traffic from multiple clients, while managing individual requirements as specified in the client SLOs.

The techniques mentioned above are primarily targeted at static content. A far more difficult problem is to optimize the latency of access to distributed data storage systems, particularly those that have to handle writes and updates. We will learn a bit more about these concerns in later modules.

### Multi-tenancy

Applications on public datacenters typically run on shared infrastructure. This aspect of cloud services raises several important issues. While modern virtualization technologies provide an isolated environment in terms of application environment and security, they typically cannot ensure **performance isolation**. Therefore, virtualized resources on clouds cannot guarantee consistent performance at all times. The performance of a resource at any given time is a function of the total load on the resources from all tenants, also known as the **interference** experienced from other tenants sharing the same hardware.

Some cloud providers, such as Azure, provide clients the ability to provision certain types of resources (such as VMs) on **dedicated hardware**. This provides protection against wide fluctuations in resource performance, delivering fairly consistent performance for the resources. However, dedicated hardware instances cost considerably more than regular on-demand instances, as Azure needs to assign a server exclusively for the resources.

A related aspect of multi-tenancy is the issue of **provisioning variation**, wherein identical requests for virtual resources on public clouds are not mapped identically onto physical resources, thereby causing a variation in performance.<sup>[1][^1]</sup> For example, two identical requests for virtual machines (`VM1` and `VM2`) could be routed to two different physical machines (`A` and `B`). Physical machine A might have four other tenants competing for resources on the same machine, while machine B may have only two. The client is charged the same for virtual machines `VM1` and `VM2`, but can potentially experience different performance on these machines. 

### Security settings

Public clouds are subject to increased attack vectors, as we saw in unit 1. Developers must be extremely cautious in ensuring that they follow best practices, protocols, and procedures when deploying and maintaining applications on the cloud. As a result, additional performance overheads may be experienced due to the use of security protocols mandated by public clouds.

Because we discussed these protocols in an earlier module, we won't discuss these again in detail. Any code deployed on a public cloud should go through a strict process of manual and automated source code reviews and static analysis, as well as dynamic vulnerability analysis and penetration testing. Guidelines for deploying applications securely are shown on the next page. 
<br>
***
### References

1. _Rehman, M.S and Sakr, M.F (2010). [Initial Findings for Provisioning Variation in Cloud Computing](https://ieeexplore.ieee.org/document/5708489) from the 2010 IEEE Second International Conference on Cloud Computing Technology and Science (CloudCom)_

[^1]: <https://ieeexplore.ieee.org/document/5708489> "Rehman, M.S and Sakr, M.F (2010). *Initial Findings for Provisioning Variation in Cloud Computing* from the 2010 IEEE Second International Conference on Cloud Computing Technology and Science (CloudCom)"
