It's vital to consider different business needs before making a decision on a database implementation. Azure Database for PostgreSQL has the functionality, ease-of-use, and scalability for most business cases. With built-in database administrative functionality that is like DBA, the service is suitable for cloud architects and developers because it lowers the need for managing the underlying operating system and database.

Single server options for small to medium-sized applications are available, starting at a few dollars per month. For larger applications or when high performance is needed, Hyperscale provides a cost-effective distributed solution with no need for application rewrites. Importantly, this service provides flexibility after deployment, allowing the database solution to be tailored to changing business needs.

### Small-to-medium applications and proof of concepts

Single-server deployments of Azure Database for PostgreSQL are well suited for smaller applications and proof of concepts, due to their low cost and ease of deployment. The built-in features such as security and analytics allow developers to focus on application development instead of configuration and maintenance. Where higher degrees of control and responsibility are desired, Azure Flexible server is a suitable alternative.

### Geospatial and logistics applications

PostgreSQL has built-in support for geospatial data, which is ideal for logistics applications. Flexible server is ideal for most workloads, but Hyperscale may be more suitable for larger or real-time applications.

### Large workloads and performance over multiple regions

When performance is desired across multiple regions, Hyperscale is a great choice to make PostgreSQL a high-performance distributed database. Hyperscale efficiently leverages multiple servers, making scaling out over multiple regions easy and cost-effective.

Large databases (approaching 100 GB or more) also tend to suffer from poorer performance when hosted on a single server, and so benefit greatly from Hyperscale.

### Protecting sensitive data

By default, Azure Database for PostgreSQL has two layers of encryption, a customizable firewall, and all the security of the Azure cloud. Azure provides extra security that would normally require security experts or managing advanced security monitoring systems.

Azure Database for PostgreSQL provides business continuity features that include geo-redundant backups with the ability to initiate geo-restore, and deploying read replicas in a different region.

### Mobile in-app databases

Azure Database for PostgreSQL is a cloud-based solution, and is not suitable for hosting inside a mobile or desktop app. If you require mobile in-app functionality, you may want to consider an alternative solution, such as using the file system or SQLite.
