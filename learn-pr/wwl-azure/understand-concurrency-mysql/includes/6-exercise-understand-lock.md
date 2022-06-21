> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you do not have an Azure subscription, create an [Azure free trial](https://azure.microsoft.com/free).

In order to complete this exercise, you must have:

- Created a resource group (see Module 1, Unit 5)
- Created an Azure Database for MySQL Flexible Server (see Module 1, Unit 5)
- Downloaded and installed MySQL Workbench (see Module 2, Unit 5)
- Created a Zoo database (see Module 2, Unit 5)
- Downloaded the scripts for this exercise from [GitHub](https://github.com/MicrosoftLearning/mslearn-mysql/tree/main/labfiles).

## Preparation - Configure MySQL Workbench

1. Open MySQL Workbench and from the top menu select **Edit** > **Preferences**.
1. From the left navigation under **General Editors**, select **Others**.
1. Under **Others**, check **Allow more than one instance of MySQL Workbench to run**.
    :::image type="content" source="../media/workbench-preferences.png" alt-text="Screenshot showing the Workbench Preferences, Others settings page." lightbox="../media/workbench-preferences.png":::
1. From the left navigation, select **SQL Editor**.
1. Under MySQL Session, change the **DBMS connection read timeout interval (in seconds):** to 300. (The default value was 30 seconds.)
1. Select **OK**, and then close MySQL Workbench.
1. Open MySQL Workbench and connect to your Azure Database for MySQL Flexible Server.
1. Select **File**, **Open SQL Script**, and select **Lab5_repopulateAnimals.sql**.
1. Select **Query** > **Execute (All or Selection)**. This creates the stored procedure RepopulateAnimals.
    :::image type="content" source="../media/workbench-preferences-sql-editor.png" alt-text="Screenshot showing the Workbench Preferences, S Q L Editor settings page." lightbox="../media/workbench-preferences-sql-editor.png":::

## Understand transactions

1. In MySQL Workbench, select **File**, **Open SQL Script**, and select **Lab5_transactions.sql**.
1. Highlight and run the first section - **Use the ZooDb database**. This makes ZooDb the current database and verifies we are using the correct database.
1. Highlight and run the section - **Repopulate animal table**. This makes sure you start with clean data.
1. Highlight and run the section - **Query autocommit**. This returns 1, indicating that **autocommit** is ON.
1. Highlight and run the section - **When autocommit is on each SQL statement is a transaction**.
1. **Highlight and run the section -** Name has been changed to Vampire bat #1. This shows that the previous UPDATE statement has been committed.
1. Highlight and run the section - **Explicit transaction**. An explicit transaction starts with START TRANSACTION and finishes with COMMIT; The SELECT statement returned the Name change, indicating that the change has been committed.
1. Highlight and run the section - **A transaction is Atomic**. The SELECT statement returned the result set with the additional row. ALL columns in the statement are included because the statement is atomic - either everything is committed, or nothing is committed.
1. Highlight and run the section - **Rollback the transaction**.
1. Highlight and run the section - Verify that the changes have been rolled back. This verifies that the row for Animal ID 29 was not committed - and that all columns were rolled back.
1. Leave MySQL Workbench open, ready for the next exercise.

## Understand locking

> [!NOTE]
> For this exercise you will need two instances of MySQL Workbench open to simulate two users. Make sure you have completed the steps in Preparation - Configure MySQL Workbench.

1. In the open instance of MySQL Workbench, select **File** > **Open SQL Script**, then navigate to **Lab5_basic_locking.sql** and select **Open**.
1. Open a second instance of MySQL Workbench. Select **Database**, **Connect to Database**, then select the **Stored Connection** to connect to your Azure Database for MySQL flexible server.
1. Select **File** > **Open SQL Script**, then navigate to **Lab5_basic_locking.sql** and select **Open**. You should now have two instances of MySQL Workbench open, with **Lab5_basic_locking.sql** open in each one. The first instance of MySQL Workbench will be referred to as **Instance A** and the second instance of MySQL Workbench will be referred to as **Instance B**.
1. In Instance A - highlight and run the section marked **1. Run this in Instance A**. This starts a transaction, setting the Name of AnimalID = 14 to "Percy Penguin".
1. In Instance B - highlight and run the section marked **2. Run this in Instance B**. The select statement returns AnimalID = 14, but the name has not been changed. This is because the transaction in Instance A was not committed. When Instance B attempts to update the name it is prevented by a lock held by Instance A.
1. In Instance A - highlight and run the section marked **3. Run this in Instance A**. This shows two transactions. Transaction in instance B is waiting for the transaction in Instance A to complete. When Instance A commits the transaction, there are no open transactions because Instance B has been able to complete. We can also now see the change made by Instance B - the name has been updated to "Percival Penguin." Leave both instances of MySQL Workbench open for the next exercise.

## Understand isolation levels

1. In Instance A - highlight and run the section marked **10. Run this in Instance A**. This starts a transaction but does not finish it.
1. In Instance B - highlight and run the section marked **11. Run this in Instance B**.
1. In Instance A - highlight and run the section marked **12. Run this in Instance A**. This is still within the same transaction started in step 1.

> [!NOTE]
> Try this exercise with different isolation levels.

## Understand deadlock

1. Open MySQL Workbench and connect to your Azure Database for MySQL flexible server. This instance of MySQL Workbench will be referred to as **Instance A**.
1. Open a second instance of MySQL Workbench and connect to your Azure Database for MySQL flexible server. This instance of MySQL Workbench will be referred to as **Instance B**.
1. In Instance A, highlight and run the sections - **Use ZooDb and avoid locks timing out**.
1. In Instance B, highlight and run the sections - **Use ZooDb and avoid locks timing out**.
1. In Instance A, highlight and run the section - **Repopulate Animal table, and start a transaction**. This starts a transaction but does not finish it with either COMMIT or ROLLBACK.
1. In Instance B, highlight and run the section - **Two updates in the reverse order to Instance A**.
1. In Instance A, highlight and run the section - **The server rolls back one of the two transactions**. The server automatically recognizes the deadlock and rolls back one of the two transactions. The select statement only returns the committed transactions.
