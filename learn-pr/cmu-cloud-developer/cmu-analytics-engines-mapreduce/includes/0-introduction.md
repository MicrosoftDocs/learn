MapReduce is a data-parallel framework, originally created by Google<sup>[1][^1]</sup>, for processing big-data applications on large suites of computers. The system attempts to decrease interprocess communication by moving computation toward data. It also transparently tolerates data and computation faults, both highly probable in large-scale cloud settings. Developers, consequently, recognize MapReduce for its scalability, fault tolerance, and elasticity. Now, there are many implementations of the MapReduce programming model available to users on the cloud, many of which rely on Apache Hadoop.

Since its debut, MapReduce has been frequently associated with Hadoop,<sup>[3][^3], [4][^4]</sup> an open-source implementation of MapReduce. Academic, government, and industrial use of Hadoop is growing rapidly.<sup>[2][^2]</sup> For instance, Yahoo! uses it for around 80% to 90% of its jobs<sup>[5][^5]</sup>. Others, such as Facebook and Microsoft, have also advocated for the framework.<sup>[6][^6]</sup> Academia currently uses Hadoop for seismic simulation, natural-language processing, and web data mining, among other applications.<sup>[7][^7], [8][^8]</sup>

Hadoop MapReduce performs most of the labor involved in implementing cloud programs through three main strategies:

- It automatically breaks down jobs into distributed tasks to effectively exploit task parallelism.
- It considers data locality and variations in overall system workloads to schedule jobs and tasks efficiently at participating cluster nodes.
- It transparently tolerates both data and task failures.

## Learning objectives

In this module, you will:
- Identify the underlying distributed programming model of MapReduce
- Explain how MapReduce can exploit data parallelism
- Identify the input and output of map and reduce tasks
- Define task elasticity, and indicate its importance for effective job scheduling
- Explain the map and reduce task-scheduling strategies in Hadoop MapReduce
- List the elements of the YARN architecture, and identify the role of each element
- Summarize the lifecycle of a MapReduce job in YARN
- Compare and contrast the architectures and the resource allocators of YARN and the previous Hadoop MapReduce
- Indicate how job and task scheduling differ in YARN as opposed to the previous Hadoop MapReduce
  
## Prerequisites

- Understand what cloud computing is, including cloud service models and common cloud providers
- Know the technologies that enable cloud computing
- Understand how cloud service providers pay for and bill for the cloud
- Know what datacenters are and why they exist
- Know how datacenters are set up, powered, and provisioned
- Understand how cloud resources are provisioned and metered
- Be familiar with the concept of virtualization
- Know the different types of virtualization
- Understand CPU virtualization
- Understand memory virtualization
- Understand I/O virtualization
- Know about the different types of data and how they're stored
- Be familiar with distributed file systems and how they work
- Be familiar with NoSQL databases and object storage, and how they work
- Know what distributed programming is and why it's useful for the cloud

<br>

<!-- Reference 1 in original course not cited in topic. Removed reference. Renumbered list. -->
***
### References

1. _J. Dean and S. Ghemawat (Dec. 2004). [MapReduce: Simplified Data Processing on Large Clusters](https://static.googleusercontent.com/media/research.google.com/en//archive/mapreduce-osdi04.pdf) OSDI_
2. _H. Herodotou, H. Lim, G. Luo, N. Borisov, L. Dong, F. B. Cetin, and S. Babu (2011). [Starfish: A Self-Tuning System for Big Data Analytics](http://cidrdb.org/cidr2011/Papers/CIDR11_Paper36.pdf) CIDR_
3. _Z. Fadika and M. Govindaraju (Dec. 2010). [LEMO-MR: Low Overhead and Elastic MapReduce Implementation Optimized for Memory and CPU-Intensive Applications](https://www.computer.org/csdl/proceedings-article/cloudcom/2010/4302a001/12OmNwtn3q9) IEEE 2nd Int. Conf. on Cloud Computing Technology and Science (CloudCom)_
4. _[Hadoop](http://hadoop.apache.org/)_
5. _N. B. Rizvandi, A. Y. Zomaya, A. J. Boloori, and J. Taheri (2011). [Preliminary Results: Modeling Relation between Total Execution Time of MapReduce Applications and Number of Mappers/Reducers](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.462.2488) Tech. R. 679, The University of Sydney_
6. _S. Ibrahim, H. Jin, L. Lu, S. Wu, B. He, and L. Qi (Dec. 2010). [LEEN: Locality/Fairness-Aware Key Partitioning for MapReduce in the Cloud](https://www.researchgate.net/publication/221276678_LEEN_LocalityFairness-Aware_Key_Partitioning_for_MapReduce_in_the_Cloud) CloudCom_
7. _M. Hammoud and M. F. Sakr (2011). [Locality-Aware Reduce Task Scheduling for MapReduce](https://web2.qatar.cmu.edu/~mhhammou/mhh_msakr_LARTS_CloudCom2011_paper.pdf) CloudCom_
8. _M. Zaharia, A. Konwinski, A. Joseph, R. Katz, and I. Stoica (2008). [Improving MapReduce Performance in Heterogeneous Environments](https://dl.acm.org/doi/10.5555/1855741.1855744) OSDI_


[^1]: <https://static.googleusercontent.com/media/research.google.com/en//archive/mapreduce-osdi04.pdf> "J. Dean and S. Ghemawat (Dec. 2004). *MapReduce: Simplified Data Processing on Large Clusters* OSDI"
[^2]: <http://cidrdb.org/cidr2011/Papers/CIDR11_Paper36.pdf> "H. Herodotou, H. Lim, G. Luo, N. Borisov, L. Dong, F. B. Cetin, and S. Babu (2011). *Starfish: A Self-Tuning System for Big Data Analytics* CIDR"
[^3]: <https://www.computer.org/csdl/proceedings-article/cloudcom/2010/4302a001/12OmNwtn3q9> "Z. Fadika and M. Govindaraju (Dec. 2010). *LEMO-MR: Low Overhead and Elastic MapReduce Implementation Optimized for Memory and CPU-Intensive Applications* IEEE 2nd Int. Conf. on Cloud Computing Technology and Science (CloudCom)"
[^4]: <http://hadoop.apache.org/> "Hadoop"
[^5]: <http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.462.2488> "N. B. Rizvandi, A. Y. Zomaya, A. J. Boloori, and J. Taheri (2011). *Preliminary Results: Modeling Relation between Total Execution Time of MapReduce Applications and Number of Mappers/Reducers* Tech. R. 679, The University of Sydney"
[^6]: <https://www.researchgate.net/publication/221276678_LEEN_LocalityFairness-Aware_Key_Partitioning_for_MapReduce_in_the_Cloud> "S. Ibrahim, H. Jin, L. Lu, S. Wu, B. He, and L. Qi (Dec. 2010). *LEEN: Locality/Fairness-Aware Key Partitioning for MapReduce in the Cloud* CloudCom"
[^7]: <https://web2.qatar.cmu.edu/~mhhammou/mhh_msakr_LARTS_CloudCom2011_paper.pdf> "M. Hammoud and M. F. Sakr (2011). *Locality-Aware Reduce Task Scheduling for MapReduce* CloudCom"
[^8]: <https://dl.acm.org/doi/10.5555/1855741.1855744> "M. Zaharia, A. Konwinski, A. Joseph, R. Katz, and I. Stoica (2008). *Improving MapReduce Performance in Heterogeneous Environments* OSDI"
