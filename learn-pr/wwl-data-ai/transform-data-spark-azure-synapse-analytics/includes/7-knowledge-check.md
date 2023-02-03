

## Multiple Choice

Which method of the Dataframe object is used to save a Dataframe as a file?

() toFile() {{That's incorrect. The write() method is the correct way to write a DataFrame as a file.}}
(x) write() {{That's correct. This is the correct method to write a DataFrame as a file.}}
() save() {{That's incorrect. This is not the correct method to write a DataFrame as a file.}}

## Multiple Choice

Which method is used to split the data across folders when saving a Dataframe?

() splitBy() {{That's incorrect. The partitionBy method is the correct method to partition (split) data across folders}}
() distributeBy() {{That's incorrect.The partitionBy method is the correct method to split across folders when saving a DataFrame.}}
(x) partitionBy() {{That's correct. This method is an expressive and convenient operation in PySpark which partitions the DataFrame based on given columns and distributes the partitions across the nodes in the cluster.}}

## Multiple Choice

What happens if you drop an external table that is based on existing files?

() An error – you must delete the files first {{That's incorrect. The files and table are loosely-coupled, deleting the files does not remove the table from the metastore.}}
(x) The table is dropped from the metastore but the files remain unaffected {{That's correct. The tables are loosely coupled from the files allowing the table to be dropped while the files remain.}}
() The table is dropped from the metastore and the files are deleted{{That's incorrect. The files are loosely-coupled and dropping the table has no impact on the existing files.}}
