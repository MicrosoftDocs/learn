
After creating your Databricks workspace, it's time to create your first notebook and Spark cluster.

## What is Apache Spark notebook?

A notebook is a collection of cells. These cells are run to execute code, to render formatted text, or to display graphical visualizations.

## What is a cluster?

The notebooks are backed by clusters, or networked computers, that work together to process your data. The first step is to create a cluster.

## Create a cluster

1. In the Azure portal, click **All resources** menu on the left side navigation and select the Databricks workspace you created in the last unit.
1. Select **Launch Workspace** to open your Databricks workspace in a new tab.
1. In the left-hand menu of your Databricks workspace, select **Clusters**.
1. Select **Create Cluster** to add a new cluster.

    ![The create cluster page](../media/create-a-cluster.png)

1. Enter a name for your cluster. Use your name or initials to easily differentiate your cluster from your coworkers.
1. Select the **Databricks RuntimeVersion**. We recommend the latest runtime and **Scala 2.11**.
1. Specify your cluster configuration. While on the 14 day free trial, the defaults will be sufficient. When the trial is ended, you may prefer to change `Min Workers` to zero. That will allow the compute resources to shut down when you are not in a coding exercise and reduce your charges.
1. Select **Create Cluster**.

## Create a notebook

1. On the left-hand menu of your Databricks workspace, select **Home**.
1. Right-click on your home folder.
1. Select **Create**.
1. Select **Notebook**.

    ![The menu option to create a new notebook](../media/creating-a-notebook.png)

1. Name your notebook **First Notebook**.
1. Set the **Language** to **Python**.
1. Select the cluster to which to attach this notebook.

     > [!NOTE]
     > This option displays only when a cluster is currently running. You can still create your notebook and attach it to a cluster later.

1. Select **Create**.

Now that you've created your notebook, let's use it to run some code.

## Attach and detach your notebook

To use your notebook to run a code, you must attach it to a cluster. You can also detach your notebook from a cluster and attach it to another depending upon your organization's requirements.

![The options that are available when a notebook is attached to a cluster](../media/attach-detach-cluster.png)

If your notebook is attached to a cluster, you can:

- Detach your notebook from the cluster
- Restart the cluster
- Attach to another cluster
- Open the Spark UI
- View the log files of the driver
