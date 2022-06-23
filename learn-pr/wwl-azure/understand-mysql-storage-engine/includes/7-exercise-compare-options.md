In these lab exercises you will compare two different MySQL storage engines:

- InnoDb
- Memory

> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you do not have an Azure subscription, create an [Azure free trial](https://azure.microsoft.com/free).

To complete these exercises, you must have:

- Created a resource group (see Module 1, Unit 5)
- Created an Azure Database for MySQL Flexible Server (see Module 1, Unit 5)
- Downloaded and installed MySQL Workbench (see Module 2, Unit 5)
- Downloaded the scripts for this exercise from [GitHub](https://github.com/MicrosoftLearning/mslearn-mysql/tree/main/labfiles).

## Create a database

1. Open MySQL Workbench and connect to your Azure Database for MySQL Flexible Server.
1. Select **File**, **Open SQL Script**, and navigate to the **EnginesLab1.sql** script. Select **Open**.
1. Highlight and run the first section - **Supported engines**. This displays the storage engines supported by your server, and whether the storage engine supports transactions.
1. Highlight and run the section - **Create database**. This creates a new user database and selects it as the current database.

## Investigate transactions and the InnoDB storage engine

1. Highlight and run the section - **Create an InnoDB table**. This creates a new table called Cat.
1. Highlight and run the section - **Insert three rows**. This inserts three rows into the Cat table and returns the three rows.
1. Highlight and run the section - **Insert a row within a transaction**. The transaction was committed, so there should be four rows.
1. Highlight and run the section - **Insert a row and rollback the transaction**. There should still be four rows because we rolled back the transaction.

## Investigate transactions and the memory storage engine

1. Highlight and run the section - **Create a Memory table**. This creates a new table called CatM.
1. Highlight and run the section - **Insert and display three rows**. This inserts three rows into the Cat table and returns the three rows.
1. Highlight and run the section - **Insert a row within a transaction**. The transaction was committed, so there should be four rows. This appears to work, but the Memory storage engine does not support transactions, so it ignores the presence of a transaction.
1. Highlight and run the section - **Insert a row and rollback the transaction**. There should still be four rows because we rolled back the transaction. Note the warning in the Output window for ROLLBACK. There are now five rows. The Memory storage engine does not support transactions and ROLLBACK had no effect.

## Understand the memory storage engine

### Create a database

1. Open MySQL Workbench and connect to your Azure Database for MySQL Flexible Server.
1. Select **File**, **Open SQL Script**, and navigate to the **EnginesLab2.sql** script.
1. Highlight and run the section - **Create database**. This creates a new user database and selects it as the current database.

### Understand the memory storage engine

1. Highlight and run the section - **Create a table using Memory storage engine**.
1. Highlight and run the section - **Populate the** **table**. The query returns three rows in the resultset.
1. Use the Azure portal to restart the Azure Database for MySQL flexible server.
1. Highlight and run the section - **The table is empty**. Note that table has no rows, but the table object still exists.
1. Highlight and run the section - **Repopulate the** **table**. The query returns three rows in the resultset.
1. Close MySQL Workbench and in the Azure portal, **STOP** your Azure Database for MySQL Server.
