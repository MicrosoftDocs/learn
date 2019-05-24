Suppose you work at a law firm that has satellite offices in a number of major cities. Each office has previously taken responsibility for managing their own IT systems. The firm now wants to control the systems from head office, because inconsistencies between application versions are causing variations in case work.

You have been tasked with upgrading the databases, and need to ensure the databases will be compatible with SQL Server 2017. You begin by manually inspecting stored procedures and configuration settings in each of the databases. However, this takes a long time and is very repetitive. As well as testing compatibility, you realize that you will need a standard path for upgrading the databases. You will also need to reassure the business that the databases will be of equal or improved performance after the upgrade.

You can solve these problems by installing the **Microsoft Data Migration Assistant (DMA)** on your local machine. This tool compares a database’s current version to a target version and highlights any compatibility issues between these versions. DMA also advises you of new features in the target version which can be used to leverage the performance of your database. Finally, DMA can upgrade your database.

Here, you will see how the Data Migration Assistant can find compatibility and performance issues in your databases prior to upgrading.

## Learning objectives

In this module, you will:  

- Decide if DMA is the best tool to use for a given administration task
- Install DMA on your client machine
- Identify compatibility issues prior to upgrade
- Upgrade a database using DMA

## Prerequisites  

- Experience administering SQL Server databases
- Knowledge of SQL Server editions and versions
- Understanding of upgrading SQL Server databases