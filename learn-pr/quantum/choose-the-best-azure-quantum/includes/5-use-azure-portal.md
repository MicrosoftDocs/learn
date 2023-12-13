The Azure Quantum portal includes a notebook gallery with sample notebooks You can use these notebooks to run your own quantum programs.

## Prerequisites

- An Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=academic-15963-cxa) before you begin.

## Create a quantum workspace

1. Sign in to the [Azure portal](https://portal.azure.com), using the credentials for your Azure subscription.
1. Select **Create a resource** and then search for **Azure Quantum**. On the results page, you should see a tile for the **Azure Quantum** service.
1. Select **Azure Quantum** and then select  **Create**. A form to create a workspace will open.
1. Select a subscription to associate with the new workspace.
1. Select **Quick create**.
1. Enter a **name** and select the **region** for the workspace.
1. Select **Create**. 

Deployment of your workspace may take a few minutes. The status and deployment details will be updated in the portal.

## Run a quantum program using Azure Quantum notebooks

To get started, copy the sample notebook from the notebook gallery.

1. Select your Azure Quantum workspace in the [Azure portal](https://portal.azure.com).
1. Select **Notebooks**.
1. Select **Sample gallery**.
1. Locate the **Hello, world: Q#** notebook tile, select the quantum provider (the sample code is identical), and select **Copy to my notebooks**.
1. The sample notebook can be found under **My notebooks** and you can now run the notebook.

:::image type="content" source="../media/create-notebook-steps.png" alt-text="Screenshot of loading a sample Jupyter notebook":::

The notebook first imports the required packages for the sample, then connects to the Azure Quantum service, and then runs a Q# program.

1. In **My notebooks**, select the **hello-world-qsharp-[provider]** notebook.
1. To run the full program from top to bottom, select **Run all**.
1. To walk through the example and run each cell individually from top to bottom, select the cell you want to run and select the **run icon**.

### Stepping through the program 

The *hello world* program runs a simple quantum random number generator and displays a histogram of the results.

Some things to note:

- **The kernel**: In the upper right of the notebook, you can see that the notebook is running the **Python 3 (ipykernel)** kernel, which is the default Python shell for Jupyter Notebooks. When you create a notebook in Azure Quantum, you can select either the **Python 3 (ipykernel)** or the **Azure Quantum Q#** kernel. Both kernels are fully compatible with Q# code.
- **1st cell**: Preloads your subscription information to connect to the Azure Quantum service.
- **2nd cell**: Retrieves the available targets (quantum computers and simulators) in your workspace.
- **3rd and 4th cells**: The Q# code that defines the program. Note the *%%qsharp* magic command which allows you to enter Q# code directly into the notebook when using the **Python 3 (ipykernel)**.
- **5th cell**: Sets the target and submits the job.
- **6th and 7th cells**: Plots and displays the result. The results should be roughly split between 0 and 1.
