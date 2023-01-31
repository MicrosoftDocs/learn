
A data engineer is focused and has expertise in working with multiple types of data to perform various operations. This work might include integrating, transforming, and consolidating data from multiple structured, semi-structured, and unstructured data systems into data consumable by downstream analysts or systems.

The data engineer will often work with multiple types of data to perform a number of operations often using a number of scripting or coding languages that are appropriate to their individual organization. This may include Python, SQL, Scala, R, and more.

## Types of Data

There are three primary types of data that a data engineer will interact with on any give project and depending upon the type dictates optimal storage methods and how you interact with it.

### Structured Data

Structured data primarily comes from source systems that are table based, such as a database server which can be through a direct connection or direct query or from a flat file such as a comma separated (csv) file. The primary elements of a structured file is that the rows and columns are aligned consistently throughout the file.

### Semi-structured Data

Semi-strucutred data, as the name implies is data, such as java script object notation (json) files which may require flattening prior to loading into your source system. This data when flattened doesn't have to fit neatly into a table structure and when forced into a relational structure can contain many null values. This doesn't mean it has no value, in fact, many times it provides key insights that just need to be handled in a different manner than relational or strucutred data.

### Unstructured Data

Not only SQL (NoSQL) is a type of data that may contain key-value pairs data and doesn't adhere to standard relational models. This is a popular data storage format type and allows for a very quick way to store transactional data in a compact form that is optimized for data entry. Other types of unstructured data that are commonly used include portable data format (PDF), word processor documents, and simple text documents.

## Common data operations

As a data engineer some of the main tasks that you will perform in Azure are data integration, data transformation, and data consolidation with the use of tools such as Azure Synapse Analytics, Azure Synapse Notebooks, and scripting languages including python, SQL, and more.

You can view many common data operations in the image below:

![Image of pipelines from dataset to sink](./media/../../media/3-understand-pipelines.png)

### Data Integration

Data Integration is the process of sourcing data from multiple sources and utilizing the linking service to have a steady flow of data available for processing. From a high level, data integration is about data movement and preparing it for transformation.

### Data Transformation

Data transformation is where the data is prepared through cleansing, applying business rules, performing lookups to existing data to extract and replace key values, removing duplicates and corrupt data and many other elements to ensure our data is properly prepared to support downstream business needs. These operations on the data happen as it streams through the Pipeline data flow.

Some example transformations may include:

- Performing dimension key lookup and checking for new entries to ensure data integrity
- Removing duplicate records
- replacing null values in records or removing them entirely
- splitting data, such as name into last_name and first_name 
- Applying business logic calculations to new fields in records, such as Net and Gross Values or key performance indicator (KPI) measures based on values in the source dataset(s)

### Common Languages

One of the most common languages a data engineer might traditionally use is SQL or Structured Query Language but the emergence of Python, Scala, and even R have increased the flexibility and collaboration between roles using common tools, such as notebooks that allow for data engineers, data analysts, and data scientists to work together towards a single solution. This type of tooling also allows for the use of the markdown language so processes, rules, and steps can be documented with the code.
