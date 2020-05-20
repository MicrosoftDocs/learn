To train and deploy models using Azure Machine Learning designer, you need compute on which to run the training process, test the model, and host the model in a deployed service.

## Create compute targets

Compute targets are cloud-based resources on which you can run model training and data exploration processes.

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), view the **Compute** page (under **Manage**). This is where you manage the compute targets for your data science activities. There are four kinds of compute resource you can create:
    - **Compute Instances**: Development workstations that data scientists can use to work with data and models.
    - **Compute Clusters**: Scalable clusters of virtual machines for on-demand processing of experiment code.
    - **Inference Clusters**: Deployment targets for predictive services that use your trained models.
    - **Attached Compute**: Links to existing Azure compute resources, such as Virtual Machines or Azure Databricks clusters.
2. On the **Compute Instances** tab, add a new compute instance with the following settings. You'll use this to train and test your model:
    - **Compute name**: *enter a unique name*
    - **Virtual Machine type**: CPU
    - **Virtual Machine size**: Standard_DS3_v2
3. While the compute instance is being created, switch to the  **Inference Clusters** tab, and add a new cluster with the following settings. You'll use this to deploy your model as a service.
    * **Compute name**: aks-cluster
    * **Kubernetes Service**: Create new
    * **Region**: *Select a different region than the one used for your workspace*
    * **Virtual Machine size**: Standard_DS2_v2 (*Use the filter to find this in the list*)
    * **Cluster purpose**: Dev-test
    * **Number of nodes**: 2
    * **Network configuration**: Basic
    * **Enable SSL configuration**: Unselected
4. Verify that the inference cluster is in the *Creating* state - it will take a while to be created, so leave it for now.

> [!NOTE]
> If you decide not to complete this module, be sure to stop your compute instance and delete the inference cluster in order to avoid leaving your compute running and incurring unnecessary charges to your Azure subscription. Alternatively, if you're finished exploring Azure Machine Learning, delete the entire resource group in your Azure subscription.

The compute targets will take some time to be created. You can move onto the next unit while you wait.
