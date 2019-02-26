
After creating your Databricks workspace, it's time to create your first notebook and Spark cluster.

## What is Apache Spark notebook?

A notebook is a collection cells. These cells are run to execute code, render formatted text, or display graphical visualizations.

## What is a cluster?

The notebooks are backed by clusters, or networked computers that work together to process your data. So, the first step is to create a cluster.

## Creating a cluster

1. On the left-hand menu of your Databricks workspace, click **Clusters**.
1. Click **Create Cluster** to add a new cluster.

![A screenshot showing the create cluster page](../media/create-a-cluster.png)

1. Enter a name for your cluster. Use your name or initials to easily differentiate your cluster from your coworkers.
1. Select the **Databricks RuntimeVersion**. We recommend the latest runtime (4.0 or newer) and Scala 2.11.
1. Specify your cluster configuration.
    - For clusters created on a Community Edition, share the default values are sufficient for the remaining fields.
    - For all other environments, refer to your company's policy on creating and using clusters.
1. Click **Create Cluster**.

> [!NOTE]
> Check with your local system administrator to see if there is a recommended default cluster at your company to use for the rest of the class. This could save you some money!

## Creating a notebook

1. On the left-hand menu of your Databricks workspace, click **Home**.
1. Right-click on your home folder.
1. Select **Create**.
1. Select **Notebook**.

![A screenshot showing the menu option to create a new notebook](../media/creating-a-notebook.png)

1. Name your notebook First Notebook.
1. Set the language to Python.
1. Select the cluster to which to attach this Notebook.

 > [!NOTE]
 > This option displays only when a cluster is currently running. You can still create your notebook and attach it to a cluster later.

1. Click **Create**.

Now that you've created your notebook, let's use it to run some code.

## Attaching and detaching your notebook

To use your notebook to run a code, you must attach it to a cluster. You can also detach your notebook from a cluster and attach it to another depending upon your organization's requirements.

![A screenshot showing options available when a notebook is attached to a cluster](../media/attach-detach-cluster.png)

If your notebook is attached to a cluster you can:

- Detach your notebook from the cluster
- Restart the cluster
- Attach to another cluster
- Open the Spark UI
- View the Driver's log files