There are three common types of data warehouse solutions:

- **Enterprise data warehouse**: An enterprise data warehouse (EDW) is a centralized data store that provides analytics and decision support services across the entire enterprise. Data flows into the warehouse from multiple transactional systems, relational databases, and other data sources on a periodic basis. The stored data is used for historical and trend analysis reporting. The data warehouse acts as a central repository for many subject areas. It contains the "single source of truth."
- **Data mart**: A data mart serves the same purpose as a data warehouse, but it's designed for the needs of a _single team or business unit_, like sales or human resources. A data mart is smaller and more focused, and it tends to serve a single subject area.
- **Operational data store**: An operational data store (ODS) is an interim store that's used to integrate real-time or near real-time data from multiple sources for additional operations on the data. Because the data is refreshed in real time, it's widely preferred for performing routine activities like storing the records of employees or aggregating data from multiple sites for real-time reporting.

> [!TIP]
> A data warehouse is useful when the goal is to reduce stress on production systems and to reorganize, index, or filter multiple data sources into a single storage area. To accomplish this goal, the organization should deliberately think about and design how it organizes and structures its data. A data warehouse isn't an unstructured dumping ground for tables from various sources.

## Designing a data warehouse solution

Data warehouse solutions can be classified by their technical _relational constructs_ and the methodologies that are used to define them. There are two typical architectural approaches used to design data warehouses:

### Bottom-Up Architectural Design, by Ralph Kimball

Bottom-up architectural design is based on _connected data marts_. You start creating your data warehouse by building individual data marts for departmental subject areas. Then, you connect the data marts via a _data warehouse bus_ by using _conforming dimensions_. The core building blocks of this approach are dependent on the star schema model that provides the multidimensional OLAP cube capabilities for data analysis within a relational database and SQL. 

The benefit of this approach is that you can start small. You gradually build up the larger data warehouse through relatively smaller investments over a period of time. This option provides a quicker path to return on investment (ROI) in the solution.

### Top-Down Architectural Design, by Bill Inmon 

The top-down architectural approach is about creating a single, integrated _normalized warehouse_. In a normalized warehouse, the internal relational constructs follow the rules of normalization. This architectural style supports transitional integrity because the data comes directly from the OLTP source systems.

This approach can provide more consistent and reliable data, but it requires rigorous design, development, and testing. This approach also requires substantial financial investments early on, and the ROI doesn't start until the entire data warehouse becomes fully functional.

> [!IMPORTANT]
> A common myth is that bottom-up and top-down architectures are incompatible. However, the principles described by Kimball and Inmon can be used together as needed to provide a better solution.