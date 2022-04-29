After creating your Databricks workspace, it's time to create your first notebook. To execute your notebook, you will attach the cluster you created in the previous unit.

## What is Apache Spark notebook?

A notebook is a collection of cells. These cells are run to execute code, to render formatted text, or to display graphical visualizations.

## Create a notebook

1. In the Azure portal, click **All resources** menu on the left side navigation and select the Databricks workspace you created in the last unit.

2. Select **Launch Workspace** to open your Databricks workspace in a new tab.

3. On the left-hand menu of your Databricks workspace, select **Home**.

4. Right-click on your home folder.

5. Select **Create**.

6. Select **Notebook**.

   ![The menu option to create a new notebook.](../media/create-notebook.png)

7. Name your notebook **First Notebook**.

8. Set the **Language** to **Python**.

9. Select the cluster to which to attach this notebook.

   > [!NOTE] 
   >
   > This option displays only when a cluster is currently running. You can still create your notebook and attach it to a cluster later.

10. Select **Create**.

Now that you've created your notebook, let's use it to run some code.

## Attach and detach your notebook

To use your notebook to run a code, you must attach it to a cluster. You can also detach your notebook from a cluster and attach it to another depending upon your organization's requirements.

![The options that are available when a notebook is attached to a cluster.](../media/attach-detach-cluster.png)

If your notebook is attached to a cluster, you can:

- Detach your notebook from the cluster
- Restart the cluster
- Attach to another cluster
- Open the Spark UI
- View the log files of the driver
