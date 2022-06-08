In this module you will learn about the PostgresQL **vacuum** process. 

Whenever an insert or delete operation is performed in the database, the old row is not physically deleted, but marked for deletion. This can result in database "bloat" with old rows taking up disk space. PostgreSQL includes a server process to reclaim lost space called **vacuum**.

In this module you will learn about vacuum, and how to configure server parameters to optimize the vacuum process.

After you have completed this module, you will be able to:

- Explain the purpose of the vacuum process.
- Configure vacuum server parameters.
