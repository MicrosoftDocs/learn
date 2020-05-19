In this module you will understand the difference between Classic Migration and SAP Database Migration Option (DMO) sometimes referred to as one-step and one-step migration, respectively.

* **Classical Migration:** SAP’s Software Provisioning Manager (SWPM) is used as the Software Logistics (SL) tool and is exclusively for database migrations. Classical Migration uses a heterogenous system copy approach and is sometimes referred to as two-step migration.
* **SAP Database Migration Option (DMO):** DMO facilitates both an SAP upgrade and a database migration to the SAP HANA database using one tool. DMO process is often referred to as a one-step migration.

You will see how the Software Update Manager (SUM) tool creates a shadow repository for an existing database while a target database is created in parallel; eventually the shadow repository is copied and the SAP database connection is switched to the target database.

Lastly, you will see how Very Large Databases (VLDB) are moved to Azure. Database sizes over 20TB require some additional techniques and procedures to achieve a migration from on-premises to Azure within an acceptable downtime and a low risk.
