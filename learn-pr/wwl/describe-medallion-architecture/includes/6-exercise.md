Now it's your turn to create a lakehouse in Fabric and move data through the medallion architecture. You'll also learn how to query and report on data in your Fabric lakehouse.

> [!NOTE]
> You need a Microsoft Fabric trial license with the Fabric preview enabled in your tenant. See [**Getting started with Fabric**](/fabric/get-started/fabric-trial) to enable your Fabric trial license.

Launch the exercise and follow the instructions.

[![Button to launch exercise.](../media/launch-exercise.png)](https://aka.ms/mslearn-fabric-warehouse)

<!--
Overall process:

  - manual upload to bronze
  - copy csvs from Bronze to a dataframe using a notebook, dedup, replace nulls dump into a big wide delta table in silver
  - use the same notebook to build out the star schema (create unique IDSs for the customer and the product, can do this in either SQL, Python or Spark https://learn.microsoft.com/en-us/sql/t-sql/functions/row-number-transact-sql?view=sql-server-ver16 - a row number with a partition or
  use a Python window function https://linuxhint.com/pyspark-row-number-window-function/ 

Is it a best practice to do a Bronze, Silver, and Gold notebok?

Separate notebooks would enable reusability -->
