MySQL allows different storage engines to be loaded and unloaded while MySQL is running. This pluggable storage engine architecture is implemented at the table level, allowing different storage engines to be used for different tables. 

Not all storage engines are supported by all versions of MySQL. Use the **SHOW ENGINES** statement to display which storage engines are supported by your MySQL server.

Azure Database for MySQL supports the **InnoDb**, **CSV**, and **MEMORY** storage engines.

After completing this module. you will be able to:

- Describe common storage engines
- Specify a storage engine
- Understand the storage engines supported on Azure Database for MySQL
- Explain tablespaces
- Optimize write ahead logging (WAL)
