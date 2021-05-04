In the Azure portal, navigate to the Azure Synapse workspace you want to use, and select **Open Synapse Studio**.

![Open Synapse Studio to Create a Notebook](../media/open-synapse-studio-to-create-notebook.png)

Once the Azure Synapse Studio has launched, select **Develop**.

![Develop Hub Synapse Studio](../media/develop-hub-synapse.png)

From there, select the **"+"** icon, and then select **Notebook**. A new notebook is created and opened with an automatically generated name.

![Select Create New Notebook](../media/create-new-notebook.png)

In the **Properties** window, provide a name for the notebook.

![Properties for Notebook](../media/settings-for-new-notebook.png)

On the toolbar, select **Publish**.

If there is only one Apache Spark pool in your workspace, then it's selected by default. Use the drop-down to select the correct Apache Spark pool if none is selected. Add code by using the **"+"** icon or the **"+ Cell"** icon and select **Code cell** to input code or **Markdown cell** to input markdown content. When adding a code cell, the default language is PySpark. In the code cell below, you are going to use Pyspark. However, other supported languages are Scala, SQL, and .NET for Spark.

You can select the code below, and paste it into a code cell in your notebook. Run the code, and you'll find that a Spark DataFrame has been created:

   ```python
   new_rows = [('CA',22, 45000),("WA",35,65000) ,("WA",50,85000)]
   demo_df = spark.createDataFrame(new_rows, ['state', 'age', 'salary'])
   demo_df.show()
   ```

When you want to run a cell, you can use the following methods:

* Press SHIFT + ENTER.
* Select the blue play icon to the left of the cell.
* Select the Run all button on the toolbar.

![Run code within a Notebook](../media/run-code-notebook.png)

You can see the Apache Spark pool instance status below the cell you are running and also on the status panel at the bottom of the notebook.
In the output cell, you see the output.



