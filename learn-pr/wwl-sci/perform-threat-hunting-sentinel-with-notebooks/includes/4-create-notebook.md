To get started with Notebooks, use the *Getting Started Guide For Microsoft Sentinel ML Notebooks* notebook.

1. In the Microsoft Sentinel navigation menu, expand the *Threat Management* section, and select **Notebooks**

1. You need to create an Azure Machine Learning (ML) Workspace. From the menu, select **Configure Azure Machine Learning**, then **Create new Azure ML workspace**.

1. In the Subscription box, select your subscription.

1. Select **Create a new Resource group** and choose a name for your new resource group.

1. In the Workspace details section:

    - Give your workspace a unique name.

    - Choose your Region

    - Keep the default Storage account, Key vault, and Application insights information.

    - The Container registry option can remain as None.

1. At the bottom of the page, select **Review + create**. Then on the next page, select **create**. It takes a moment to deploy the workspace.

    > [!NOTE]
    > It takes a few minutes to deploy the Machine Learning workspace.

1. After *Your deployment is complete* message appears, return to Microsoft Sentinel.

1. Navigate to the Threat Management section, and select **Notebooks**.

1. Select the **Templates** tab.

1. Select the **A Getting Started Guide For Microsoft Sentinel ML Notebooks** from the list.

1. Select **Create from template** button on the bottom of the detail pane.

1. Review the default options and then select **Save**.

1. Select the **Launch notebook** button.

1. Select **Close** if an informational window appears in the Microsoft Azure Machine Learning studio.

1. 1. In the command bar, to the right of the **Compute:**  selector, select the **+** symbol to *Create Azure ML compute* instance. **Hint:** It might be hidden inside the ellipsis icon **(...)**.

    > [!NOTE]
    > You can have more screen space by hiding the Azure ML Studio left menu selections. Select the *Hamburger menu* (3 horizontal lines on the top left), and by collapsing the Notebooks Files by selecting the **<<** icon.

1. Type a unique name in the *Compute name* field. This identifies your compute instance.

1. Scroll down and select the first option available.

    > [!TIP]
    > Workload type: Development on Notebooks (or other IDE) and light weight testing.

1. Select the **Review + Create** button at the bottom of the screen, then scroll down and select **Create**. Close any feedback window that appears. This takes a few minutes. You see a notification (bell icon) when it completes and the *Compute instance* left icon turns from blue to green.

1. Once the Compute is created and running, verify that the kernel to use is *Python 3.10 - Pytorch and Tensorflow*.

    > [!TIP]
    > This is shown in the right of the menu bar. If that kernel isn't selected, select the *Python 3.10 - Pytorch and Tensorflow* option from the drop-down list. You can select the **Refresh** icon on the far right to see the kernel options.

1. Select the **Authenticate** button and wait for the authentication to complete.

1. Clear all the results from the notebook by selecting the **Clear all outputs** (Eraser icon) from the menu bar and follow the *Getting Started* tutorial.

    > [!TIP]
    > This can be found by selecting the ellipsis (...) from the menu bar.

1. Review section *1 Introdution* in the notebook and proceed to section *2 Initializing the notebook and MSTICPy*.

    > [!TIP]
    > Section 1.2 *Running code in notebooks* lets you practice running small lines of Python code.

1. In section *2 Initializing the notebook and MSTICPy*, review the content on initializing the notebook and installing the MSTICPy package.

1. Run the *Python code* to initialize the cell by selecting the **Run cell** button (Play icon) to the left of the code.

1. It should take >30 seconds to run. Once it completes, review the output messages and *disregard any warnings about the Python kernel version* or other error messages.

1. The code ran successfully if *msticpyconfig.yaml* was created in the *utils* folder in the *file explorer* pane on the left. It can take another 30 seconds for the file to appear. If it doesn't appear, select the **Refresh** icon in the *file explorer* pane.

    > [!TIP]
    > You can clear the output messages by selecting the ellipsis (...) on the left of the code window for the *Output menu* and selecting the *Clear output* (square with an x*) icon.

1. Select the **msticpyconfig.yaml** file in the *file explorer* pane on the left to review the contents of the file and then close it.

1. Proceed to section *3 Querying data with MSTICPy* and review the contents. Don't run the *Multiple Microsoft Sentinel workspaces* code cell as it fails, but the other code cells can be run successfully.

> [!NOTE]
> If you can't complete the steps above to access the Notebook, you can follow it on its GitHub viewer page instead. [Getting Started with Azure ML Notebooks and Microsoft Sentinel](https://nbviewer.org/github/Azure/Azure-Sentinel-Notebooks/blob/master/A%20Getting%20Started%20Guide%20For%20Azure%20Sentinel%20ML%20Notebooks.ipynb)
