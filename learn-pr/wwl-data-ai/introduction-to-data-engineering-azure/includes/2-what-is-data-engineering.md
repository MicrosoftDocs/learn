
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

### Data Integration

Data Integration is the process of changing data structure(s) and format(s) from multiple sources and systems into a single cohesive structure. These source systems may be similar in structure which includes data types, table/file formats, and primary source system and this will be refined further in the data transformation step.

### Data Transformation

Data transformation is an extension of exploratory data analysis (EDA) which is the process of creating a correspondence between records and fields of a source schema to (often different) records and fields in a destination schema.
An example of data transformation is to map shipping and billing address information from a purchase order to an customer invoice. This is the most basic type of mapping. Data transformation can also apply to operations such as:

- Averaging data from a looping record and sending the output to a single field in the destination schema.
- Converting character data to its ASCII format.
- Adding or subtracting data from one or more records and putting the result in a single field in the destination schema.
- splitting data, such as name into last_name and first_name attributes (columns)

### Data Consolidation

Data consolidation in this context is different from what is done in the data integration phase as this section deals with consolidating the massive amounts of cleansed disparate sources throughout the process into a coherent storage pattern that may include a relational store, a blob stores, and even data lake stores. Several factors will drive this decision including costs, organizational maturity, organizational adoption of cloud technologies, and access approaches and tools. 

### Common Languages

One of the most common languages a data engineer might traditionally use is SQL or Structured Query Language but the emergence of Python, Scala, and even R have increased the flexibility and collaboration between roles using common tools, such as notebooks that allow for data engineers, data analysts, and data scientists to work together towards a single solution. This type of tooling also allows for the use of the markdown language so processes, rules, and steps can be documented with the code.
