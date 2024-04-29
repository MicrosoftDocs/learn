The Azure Quantum portal includes a notebook gallery with sample notebooks You can use these notebooks to run your own quantum programs.

## Have an Azure subscription

To access Azure portal you need An Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=academic-15963-cxa) before you begin.

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


### Create a notebook

1. Select your Azure Quantum workspace in the [Azure portal](https://portal.azure.com).
1. Select **Notebooks**.
1. Click **My Notebooks** and click **Add New**.
1. Type a name for the file, for example *submit-quantum-job.ipynb*, and click **Create file**.
1. The notebook can be found under **My notebooks** and you can now run the notebook.

### Connect to your Azure Quantum workspace

To connect to the Azure Quantum service, your need the resource ID and the location of your Azure Quantum workspace. You can find this values in the **Overview** section of your workspace in the Azure portal.

Copy the following code in a new cell in your notebook and replace the values for `resource_id` and `location` with the values for your workspace.

```python

import azure.quantum

workspace = Workspace ( 
    resource_id = "", # Add your resource_id 
    location = ""  # Add your workspace location (for example, "westus") 
)
```

### Write a Q# operation

1. First, you need to import the `qsharp` package to enable the "%%qsharp" magic command used in later cells. Add the following code in a new cell in your notebook.

    ```python
    import qsharp
    ```

1. Copy the following code in a new cell in your notebook. This code defines a Q# operation that generates a random bit using the `%%qsharp` 'magic' command.

    ```python
    %%qsharp
    
    operation Random() : Result {
        use q = Qubit();
        H(q);
        let result = M(q);
        Reset(q);
        return result
    }
    
    operation RandomNBits(N: Int): Result[] {
        mutable results = [];
        for i in 0 .. N - 1 {
            let r = Random();
            set results += [r];
        }
        return results
    }
    ```

    - The operation `Random` uses the `H` gate to put a qubit in a superposition of `0` and `1`, then measures the qubit to get a random bit. The `Reset` operation resets the qubit to the `|0⟩` state.
    - The operation `RandomNBits` takes an integer `N` as input and returns an array of `N` random bits.

### Run the Q# operation

1. Add the following code in a new cell in your notebook to run the `RandomNBits` operation for 100 shots against the Rigetti simulator.

    ```python
    operation = qsharp.compile("RandomNBits(4)")
    target = workspace.get_targets("rigetti.sim.qvm")
    job = target.submit(operation, "my-azure-quantum-job", input_params={ "count": 100 })
    
    # Wait for the job to complete
    job.get_results()
    ```

1. To run the full program from top to bottom, select **Run all**.
1. To walk through the example and run each cell individually from top to bottom, select the cell you want to run and select the **run icon**.


