> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you do not have an Azure subscription, you can create an [Azure free trial](https://azure.microsoft.com/free).

## Before you start

1. You have installed and started Azure Database for PostgreSQL flexible server.
1. You have installed Azure Data Studio.
1. Download the lab scripts from [PostgreSQL Labs](https://github.com/MicrosoftLearning/mslearn-postgres).
1. Open Azure Data Studio and connect to your Azure Database for PostgreSQL flexible server.
1. If you haven't yet created the zoodb, select **File**, **Open file** and navigate to the folder where you saved the scripts. Select **Lab2_ZooDb.sql** and **Open**. Run the script.


## Create a stored procedure

1. At the top of the screen, use the drop-down arrow to make zoodb the current database.
1. In Azure Data Studio, select **File**, **Open File**, and then navigate to the lab scripts. Select **Lab5_StoredProcedure.sql** and then select **Open**. If necessary, reconnect to the server.
1. Highlight the section under **Create stored procedure** from **CREATE PROCEDURE** to **END $$.** Read through the procedure. You will see that it declares some input parameters and uses them to insert rows into the enclosure table and the animal table.
1. Keep Azure Data Studio open with the file open, ready for the next exercise.

## Call the stored procedure

1. Highlight the section under **Call the stored procedure**. This calls the stored procedure by passing values to the input parameters.
1. Highlight and run the two **SELECT** statements. You can see that a new row has been inserted into enclosure, and five new rows inserted into animal.

## Create and call a table-valued function

1. In Azure Data Studio, select **File**, **Open File**, and then navigate to the lab scripts. Select **Lab5_Table_Function.sql** and then select **Open**.
1. Highlight and run the first **SELECT** statement to check that the zoodb database is selected.
1. Highlight and run the **repopulate_zoo()** stored procedure to start with clean data.
1. Highlight and run the section under **Create a table valued function**. This function returns a table called **enclosure_summary**. Read through the function code to understand how the table is populated.
1. Highlight and run the two select statements, passing in a different enclosure ID each time.
1. Highlight and run the section under **How to use a table valued function with a LATERAL join**. This shows the table-valued function being used in place of a table name in a join.

## Optional exercise - In-built functions

1. In Azure Data Studio, select **File**, **Open File**, and then navigate to the lab scripts. Select **SimpleFunctions.sql** and then select **Open**.
1. Highlight and run each function to see how it works. Refer to the [online documentation](https://www.postgresql.org/docs/13/functions.html) for more information about each function.
1. Close Azure Data Studio without saving the scripts.
1. STOP your Azure Database for PostgreSQL server so that you are not charged when you are not using the server.
