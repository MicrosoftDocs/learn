## Multiple Choice
What is the benefit of using Fabric notebooks over manual uploads for data ingestion?
(x) Notebooks provide automation, ensuring a smooth and systematic approach to ingestion and transformation {{Correct. Fabric notebooks provide automation for ingestion and transformation, ensuring a smooth and systematic approach.}}
( ) Pipelines allow you to orchestrate the Copy Data and transformations {{Incorrect. Pipelines may require dataflows or notebooks for transformations, but they do not provide automation for ingestion like notebooks do.}}
( ) Fabric notebooks offer a UI experience for large datasets {{Incorrect. Dataflows offer a UI experience, but they are not as performant with large datasets.}}

## Multiple Choice
What is the purpose of V-Order and Optimize Write in Delta tables?
( ) To enable faster and more efficient writes by various compute engines. {{Incorrect. V-Order enables faster and more efficient reads, not writes.}}
(x) To improve the performance and reliability of Delta tables by applying special sorting, distribution, encoding, and compression on parquet files at write-time, and reducing the number of files written and increasing their size. {{Correct. V-Order and Optimize Write are used to improve the performance and reliability of Delta tables by applying special sorting, distribution, encoding, and compression on parquet files at write-time, and reducing the number of files written and increasing their size.}}
( ) To reduce the size of Delta tables and increase their number of files. {{Incorrect. Optimize Write reduces the number of files written and increases their size, but it's not used to reduce the size of Delta tables.}}

## Multiple Choice
What is the purpose of doing basic cleaning when loading data into Fabric lakehouse?
( ) To remove all null values and empty entries from the data {{Incorrect. Basic cleaning involves removing duplicates, handling errors, and converting null values, but not necessarily getting rid of empty entries.}}
(x) To ensure data quality and consistency {{Correct. Basic cleaning is done to ensure data quality and consistency before moving on to transformation and modelling steps.}}
( ) To make the data more complex for data scientists to explore {{Incorrect. Basic cleaning is done to ensure data quality and consistency.}}
