# Summary

In this module, you explored the foundational concepts of Unity Catalog in Azure Databricks. You started by understanding common data governance challenges—fragmented permissions, duplicated data, and scattered audit trails—that arise when managing data across multiple workspaces and storage systems.

You then learned how Unity Catalog's metastore architecture addresses these challenges. The three-level namespace (catalog, schema, table) provides a logical structure for organizing data objects, while the metastore acts as a central registry that workspaces connect to.

For working with data outside of managed tables, you examined how storage credentials and external locations enable secure access to Azure Data Lake Storage Gen2. You also learned how Lakehouse Federation lets you query data from external databases without moving it, and how Delta Sharing enables secure data sharing both within Databricks and with external tools.

Finally, you navigated Catalog Explorer, the central interface for creating and managing Unity Catalog objects—from storage credentials to catalogs to foreign catalogs.

These fundamentals prepare you for the next steps in your Unity Catalog journey: implementing security policies, managing user permissions, and configuring advanced governance features in later modules.
