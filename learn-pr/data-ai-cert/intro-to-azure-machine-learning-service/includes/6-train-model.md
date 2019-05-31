Let's create a new workspace and experiment. You can quickly set up a workspace by using the Azure portal or via Python code. We'll go through each approach here.

## Create a workspace by using the Azure portal

Follow these steps to create a workspace in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true]) using your Azure subscription.

1. In the Search box at the top of the portal, type **machine learning service workspaces**. 

1. Select the "Machine Learning Service Workspaces" option under SERVICES.

    ![The screenshot depicts Machine Learning service workspaces being selected in the search box results.](../media/6-select-ml-service-workspace.png)

1. Select **Add** at the top left of the Machine Learning service workspaces pane, and then enter the necessary information to create the workspace.

    | Field | Description |
    |-------|-------------|
    | Workspace name | Enter a unique name for your workspace. In this example, you use **docs-ws**. The names must be unique across the resource group. Use a name that is easy to remember and different from workspaces that others create. |
    | Subscription | Select the Azure subscription that you want to use. |
    | Resource group | Use an existing resource group in your subscription or enter a name to create a new resource group. A *resource group* is a container that holds related resources for an Azure solution. In this example, you use **docs-aml**. |
    | Location | Select the location closest to your users and the data resources. This location is where the workspace is created. |
    
    ![The screenshot depicts the required information for creating a Machine Learning service workspace, which includes boxes for Workspace name, Subscription, Resource group, and Location.](../media/6-create-ml-service-workspace.png)
    

1. In the newly created workspace, select **Open Azure Notebooks** to create the first experiment.

1. Sign in with the same Microsoft account you used to create the workspace in the Azure portal.

1. After you sign in, a new tab opens and a "Clone Library" prompt appears. Select **Clone**, and then run the notebook.

1. Along with two notebooks, you will see a **Config.json** file. This configuration file contains information about the workspace that you created.

1. Select **01.run-experiment.ipynb** to open the notebook.

1. Run the cells one at a time (<kbd>Shift</kbd>+<kbd>Enter</kbd>) or select **Cells** > **Run All** to run the entire notebook. When you see an asterisk (*) next to a cell, it's running. After the code for that cell finishes, a number appears.

1. After running all the cells in the notebook, you can view the logged values in your workspace.

1. Browse back to the portal page, select **View Experiments**, and then select **my-first-experiment** to see the model run report.

## Create a workspace by using Python

To create a workspace by using Python:

1. Install a Python environment like Anaconda, Miniconda, or Python virtual environment.

1. Create an isolated Python environment.

1. In a command-line or terminal window, create a new Conda environment named **myenv** with Python 3.6:

    ```bash
    # Create
    conda create -n myenv -y Python=3.6
    # Activate
    conda activate myenv
    ```
    
1. Install the SDK.

1. Install the core components of the Machine Learning SDK and Jupyter Notebook server with the following code:

    ```bash
    # Install Jupyter
    conda install nb_conda
    
    # Install the base SDK and Jupyter Notebook
    pip install azureml-sdk[notebooks]
    ```
    
1. Start Jupyter Notebook:

    ```bash
    # Launch
    jupyter notebook
    ```
    
1. In your browser, create a new notebook, choose the `Python 3` kernel, and then sign in to the Azure portal if necessary.

1. Run the following Python code replacing each of the `{placeholder}`s with the proper values for your subscription.

    ```python
    import azureml.core
    print(azureml.core.VERSION)
    
    from azureml.core import Workspace
    ws = Workspace.create(name='myworkspace',
                subscription_id='{azure-subscription-id}', 
                resource_group='{resource-group-name}',
                create_resource_group = True,
                location='{location}'
                )
    ```
    
    |    Field    |    Description    |
    |    -----    |    -----------    |
    | Workspace name | Enter a unique name for your workspace. In this example, you use **docs-ws**. The names must be unique across the resource group. Use a name that is easy to remember and different from workspaces that others create. |
    | Subscription | Select the Azure subscription that you want to use. |
    | Resource group | Use an existing resource group in your subscription or enter a name to create a new resource group. A *resource group* is a container that holds related resources for an Azure solution. In this example, you use **docs-aml**. |
    | Location | Select the location closest to your users and the data resources. This location is where the workspace is created. |
    
1. To view workspace details such as associated storage, container registry, and key vault, use the following code:

    ```python
    ws.get_details()
    ```
    
1. Write a configuration file.

    Details of your workspace must be saved to a configuration JSON file in the current directory. The `write_config()` application programming interface (API) call creates the configuration file in the current directory. The **config.json** file contains the following:

    ```json
    {
        "subscription_id": "{azure-subscription-id}",
        "resource_group": "{resource-group-name}",
        "workspace_name": "myworkspace"
    }
    ```
    
1. The following code will create the configuration file:

    ```python
    # Create the configuration file.
    ws.write_config()
    ```
    
1. Use the workspace:

    ```python
    from azureml.core import Experiment
    
    # create an experiment
    exp = Experiment(workspace=ws, name='trial_exp')
    
    # start a run
    run = exp.start_logging()
    
    # log a number
    run.log('trail', 30)
    
    # log a list (Fibonacci numbers)
    run.log_list('my list', [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]) 
    
    # finish the run
    run.complete()
    ```

> [!IMPORTANT]
> If you have more than 300 MB of content or 2000 files in the current notebook folder, you might get the following error:
>
> ![Screenshot of error when you the current folder has > 300 MB.](../media/6-experiment_over300mberror.png)
>
> This happens because Azure Machine Learning runs training scripts by copying the entire script folder to the target compute context, and then takes a snapshot. The storage limit for experiment snapshots is 300 MB and/or 2000 files.
>
> There are a number of ways to resolve this issue.  If you don't need all the files and can work within the default space constraints, the easiest solution is to exit the notebook, create a new folder with only what you need, open that folder and create the notebook there. On a local machine, you can stop the Jupyter Notebook service, change to the new folder at a command prompt and restart Jupyter Notebook.  On Azure Notebook, just create a new project and copy what you need to it. Then create your notebook there.  
>
> If you cannot get the data within the constraints, then read through [the documentation](https://docs.microsoft.com/azure/machine-learning/service/how-to-save-write-experiment-files#limits) to explore other options.

    
1. View the logged results:

    ```python
    print(run.get_portal_url())
    ```
    
    The link directs you to logged values in the Azure portal.

1. Clean up the resources:

    ```python
    ws.delete(delete_dependent_resources=True)
    ```
