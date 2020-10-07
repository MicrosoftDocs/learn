The Azure ecosystem offers three different open source database platforms. Each platform has different attributes that facilitate moving to the cloud quickly and painlessly. Each of these services comes with native high availability, automatic patching, automatic backups and the highest level of security protection. These offerings are fully supported by Microsoft from the service all the way through the database engine.

Azure Database for MySQL is a full managed enterprise grade database service that is ready to easily lift and shift customer environments to the Azure cloud. Customers can use their existing frameworks and languages to ensure that a migration doesn’t disrupt any business activity. In addition, the service has built-in high availability and dynamic scaling, which helps to meet any fluctuation in performance demands.

Azure Database for MariaDB is similar to the MySQL offering. It also allows for continued use of frameworks and languages of your choice. High availability and dynamic scaling are also provided by the service to ensure that customer demands are met within a moment’s notice.

Azure Database for PostgreSQL helps customers to build large scalable applications. The service allows for horizontal scaling and is available with Hyperscale which allows for unparalleled performance. It also integrates with several native features such as geospatial support, rich indexing, and JSONB along with other extensions. Azure Database for PostgreSQL Hyperscale is ideal for multi-tenant applications, with minor code changes to allow for data sharding.

## Service tiers

There are three service tiers for each offering. Each tier has an ideal workload for which it is designed and allows you to choose from a variety of performance options.

- Basic – This tier is best for light workloads that need minimal compute and I/O performance.

- General Purpose – This tier is great for most workloads requiring scalable I/O throughput along with a healthy balance of compute and memory.

- Memory Optimized – This tier is suitable for workloads that demand high performance and require in-memory speed for quick processing of transactions along with higher concurrency.

The service tiers offered by the open source platforms provide a wide range of performance options and allow you to choose the best one for your given workload. The following versions shown in the table are available in the service for each database.

| **Database**| **Supported Versions** |
| - | - |
| **MariaDB**| 10.2-10.3 |
| **MySQL**| 5.6-8.0 |
| **Postgres**| 9.5-11 |

While the Azure service will perform minor upgrades, in order to execute a major upgrade you will need to restore from a backup into a new version.
