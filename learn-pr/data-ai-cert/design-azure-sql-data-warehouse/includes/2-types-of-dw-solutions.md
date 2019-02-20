There are three common types of data warehouse solutions:

1. **Enterprise Data Warehouse**: An Enterprise Data Warehouse is a centralized data store that provides analytics and decision support services across the whole enterprise. Data flows into the warehouse from multiple transactional systems, relational databases, and other data sources on a periodic basis. The stored data is used for historical and trend analysis reporting. The data warehouse acts as a central repository for many subject areas and contains the "single source of truth."
1. **Data Mart**: A Data Mart serves the same purpose as a data warehouse but is designed for the needs of a _single team or business unit_ such as sales or human resources. It's smaller and more focused and tends to serve a single subject area.
1. **Operational Data Store** (ODS): An ODS is used as an interim store to integrate real-time, or near real-time data from multiple sources for additional operations on the data. Since the data is refreshed in real time, it's widely preferred to perform routine activities such as storing the records of employees, or aggregating data from multiple sites for real-time reporting purposes.

> [!TIP]
> A data warehouse is useful to reduce stress on production systems and to reorganize, index, or filter multiple data sources into a single storage area. To accomplish this goal, deliberate thought and design needs to be put into how you organize and structure the data. It's not a dumping ground for tables from various sources without any design put into it!

## Designing a data warehouse solution

Data warehouse solutions can also be classified by their technical _relational constructs_ and the methodologies used to define them. Two typical architectural approaches are:

### Bottom-Up Architectural Design by Dr. Ralph Kimball

This approach is based on the notion of "Connected Data Marts." The Data Warehouse creation starts with building individual Data Marts for departmental subject areas and then connecting them via a "Data Warehouse Bus" using the Conforming Dimensions. The core building blocks of this approach are dependent on the star schema model that provides the Multidimensional OLAP Cube capabilities for data analysis within a relational database and SQL. 

This approach offers the benefit of starting small with independent departmental Data Marts and then connecting them via the DW bus using the conformed dimensions common to each star schema.  This approach allows the gradual buildup of the larger warehouse with relatively smaller investments over a period of time, which provides a quicker path to return on investment (ROI) in the solution.

### Top-Down Architectural Design by Dr. Bill Inmon 

This approach is about creating one single integrated "Normalized Warehouse", which means the internal relational constructs follow the rules of normalization. This architectural style supports the transitional integrity followed by the data coming directly from the OLTP source systems. Hence this approach can provide more consistent and reliable data but requires rigor in design, development, and testing. This approach also requires substantial financial investments early on, and the ROI does not start until the entire data warehouse becomes fully functional.

> [!IMPORTANT]
> A common myth is that these two architectures are incompatible. However, this is false. Kimball and Inmon can be used together as necessary to provide a better solution.