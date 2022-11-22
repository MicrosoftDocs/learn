In this module, you'll learn about the PostgreSQL **vacuum** process. 

Whenever an insert or delete operation is performed in the database, the old row isn't physically deleted, but marked for deletion. When this happens, it can result in database "bloat" with old rows taking up disk space. PostgreSQL includes a server process to reclaim lost space called **vacuum**.

In this module you'll learn about vacuum, and how to configure server parameters to optimize the vacuum process.

After you've completed this module, you'll be able to:

- Explain the purpose of the vacuum process.
- Configure vacuum server parameters.
