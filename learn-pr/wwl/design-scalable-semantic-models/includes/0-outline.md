# Intro

A single table of data can be considered a semantic model, however this won't scale for organizations. 

In order to create reliable and efficient semantic models, consider these principles.

- Understand Type 1 and Type 2 slowly changing dimensions
- Choose a storage mode (when to use DQ or DL)
- Implement a star schema for a semantic model
- Implement relationships, such as bridge tables and many-to-many relationships
- Write calculations that use DAX variables and functions, such as iterators, table filtering, windowing, and information functions
- Implement calculation groups, dynamic format strings, and field parameters
- Identify use cases for and configure large semantic model storage format
- Design and build composite models

# Connect to data | model framework

Choose when to use the different storage mode types, dual storage mode, composite models, and configure large semantic model storage format.

Parameters for incremental refresh as well.

# Design a star schema

Works best in tabular format, also known as star schema with fact and dimension tables. A snowflake is a more complex schema with dimensions further normalized.
? how is this different from a relational database vs. excel ?

relationships, bridge tables, many-to-many, DAX functions. how to handle SCDs.

# data modelling best practices

Be mindful of the data you bring in and only keep what you need. avoid wide tables. pre-aggregate data before loading where possible. reduce calc columns. avoid high cardinality. appropriate data types. limit bi-directional filters. disable auto date/time. use date table. use views, not tables if available in relational db. partitioning/incremental refresh. query folding.

# large semantic model storage format

what about it? should this be a full unit still?

# summary

