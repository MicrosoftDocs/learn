<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m02_mapReduce\x-oli-workbook_page\_u05_m02_1_intro.xml -->

MapReduce is a data-parallel framework, originally created by Google, for processing big-data applications on large suites of computers. The system attempts to decrease interprocess communication by moving computation towards data. It also transparently tolerates data and computation faults, both highly probable in large-scale cloud settings. Developers, consequently, recognize MapReduce for its scalability, fault tolerance, and elasticity. Google utilizes it to process 20PB of data per day, and Amazon recently enhanced its Web Services with Amazon Elastic MapReduce (EMR), effectively a pay-as-you-go cloud analytics engine that enables businesses, researchers, data analysts, and developers to process vast amounts of data easily and cost effectively.

Since its debut, MapReduce has been frequently associated with Hadoop, an open-source implementation of MapReduce. Academic, government, and industrial use of Hadoop is growing rapidly. For instance, Yahoo! uses it for around 80% to 90% of its jobs, and others, such as Facebook and Microsoft, have also advocated the framework. Amazon EMR rests on a Hadoop MapReduce engine hosted in Amazon Elastic Compute Cloud (Amazon EC2) and Amazon Simple Storage Service (Amazon S3). Academia currently uses Hadoop for seismic simulation, natural-language processing, and Web data mining, among other applications.

Hadoop MapReduce performs most of the labor involved in implementing cloud programs through three main strategies: 

- It automatically breaks down jobs into distributed tasks to effectively exploit task parallelism.
- It considers data locality and variations in overall system workloads to schedule jobs and tasks efficiently at participating cluster nodes.
- It transparently tolerates both data and task failures.

### References

1. _Big-Data Analytics Predictions for 2011 ().  http://tdwi.org/articles/2011/03/16/big-data-analytics-predictions.aspx/_
2. _J. Dean and S. Ghemawat (Dec. 2004). Mapreduce: Simplified Data Processing on Large Clusters OSDI_
3. _Amazon Elastic MapReduce ().  http://aws.amazon.com/elasticmapreduce/_
4. _H. Herodotou, H. Lim, G. Luo, N. Borisov, L. Dong, F. B. Cetin, and S. Babu (2011). Starfish: A Self-Tuning System for Big Data Analytics CIDR_
5. _Z. Fadika and M. Govindaraju (Dec. 2010). LEMO-MR: Low Overhead and Elastic MapReduce Implementation Optimized for Memory and CPU-Intensive Applications IEEE 2nd Int. Conf. on Cloud Computing Technology and Science (CloudCom)_
6. _Hadoop ().  http://hadoop.apache.org/_
7. _N. B. Rizvandi, A. Y. Zomaya, A. J. Boloori, and J. Taheri (2011). Preliminary Results: Modeling Relation between Total Execution Time of MapReduce Applications and Number of Mappers/Reducers Tech. R. 679, The University of Sydney_
8. _S. Ibrahim, H. Jin, L. Lu, S. Wu, B. He, and L. Qi (Dec. 2010). LEEN: Locality/Fairness-Aware Key Partitioning for MapReduce in the Cloud CloudComm_
9. _M. Hammoud and M. F. Sakr (2011). Locality-Aware Reduce Task Scheduling for MapReduce CloudCom_
10. _M. Zaharia, A. Konwinski, A. Joseph, R. Katz, and I. Stoica (2008). Improving Mapreduce Performance in Heterogeneous Environments OSDI_