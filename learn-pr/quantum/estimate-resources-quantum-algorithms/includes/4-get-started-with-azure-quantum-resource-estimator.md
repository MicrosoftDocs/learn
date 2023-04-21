
The Azure Quantum Resource Estimator is a useful tool that is highly customizable. Before you start to work on the task you've been given, first you need to get familiar with the tool and get some practice. In the following example, you estimate the physical resources of a multiplier, which implements the multiplication of integer $a$ by integer $b$.

## Enable the Azure Quantum Resource Estimator

First, enable the Azure Quantum Resource Estimator tool in your Azure Quantum workspace:

1. Sign in to the [Azure portal](https://portal.azure.com/) and select your Azure Quantum workspace.
1. On the left menu, under **Operations**, select **Providers**.
1. Select **Add a provider**.
1. For **Microsoft Quantum Computing**, select **Add**.
1. Select **Learn & Develop**, and then select **Add**.

## Create a new notebook in your workspace

Next, create a new Jupyter notebook in your Azure Quantum workspace:

1. In your Azure Quantum workspace, select **Notebooks**.
1. Select **My notebooks**, and then select **Add new** to create a new Jupyter notebook.
1. For **Kernel Type**, select **IPython**.
1. Enter a name for the file, for example, *quickstartResourceEstimator.ipynb*.
1. Select **Create file**.

When your new notebook opens, it automatically creates the code for the first cell based on your subscription and workspace information.

```python
from azure.quantum import Workspace
workspace = Workspace (
    subscription_id = <your subscription ID>, 
    resource_group = <your resource group>,   
    name = <your workspace name>,          
    location = <your location>        
    )
```

## Get started

The first step is to connect to your Azure Quantum workspace and select the Azure Quantum Resource Estimator as target. You also are importing the `Microsoft.Quantum.Numerics` package that you use in your example algorithm.

Select **Code** to add a new cell, and then enter and run the following code:

```python
import qsharp
import qsharp.azure  # Connect to your Azure Quantum workspace
targets = qsharp.azure.connect(
   resourceId="<your resourceID>", # Fill in with the resource ID of your workspace
   location="<your location>") # Fill in with the location of your workspace (for example "westus")

qsharp.packages.add("Microsoft.Quantum.Numerics") # Import the Microsoft.Quantum.Numerics package to create the multiplier for this example
qsharp.azure.target("microsoft.estimator") # Select the Azure Quantum Resource Estimator as target
```

> [!NOTE]
> You can find the location and resource ID of your workspace on the **Overview** tab of your Azure Quantum workspace.
>
> :::image type="content" source="../media/azure-quantum-resource-id.png" alt-text="Screenshot of the overview pane of a workspace in the Azure portal. Location and resource ID are marked inside a red rectangle.":::

As a running example, you're creating a multiplier by using the [MultiplyI](/qsharp/api/qsharp/microsoft.quantum.arithmetic.multiplyi) operation. You can configure the size of the multiplier by using a `bitwidth` parameter that can be passed as an input argument. The operation has two input registers that have that bit width, `factor1` and `factor2`. It has one output register with the size of twice the bit width, `product`.

Select **Code** to add a new cell, and then enter and run the following code:

```python
%%qsharp

open Microsoft.Quantum.Arithmetic;

operation EstimateMultiplication(bitwidth : Int) : Unit {
    use factor1 = Qubit[bitwidth];
    use factor2 = Qubit[bitwidth];
    use product = Qubit[2 * bitwidth];
    
    MultiplyI(LittleEndian(factor1), LittleEndian(factor2), LittleEndian(product));
}
```

> [!NOTE]
> The `%%qsharp` magic command allows you to enter Q# code directly in a Jupyter notebook when you use the Python 3 kernel (ipykernel). For more information, see [%%qsharp magic command](/azure/quantum/how-to-python-qdk-local#the-qsharp-magic-command).

## Estimate the algorithm

Now, estimate the physical resources for this operation by using the default assumptions. You can submit the operation to the resource estimator target by using the `qsharp.azure.execute` function. This function calls the `EstimateMultiplication` operation and passes the operation argument `bitwidth=8`.

Select **Code** to add a new cell, and then enter and run the following code:

```python
result = qsharp.azure.execute(EstimateMultiplication, bitwidth=8)
result
```

The `qsharp.azure.execute` function creates a table that shows the overall physical resource counts. You can inspect cost details by collapsing the groups, which have more information. For example, if you collapse the *Logical qubit parameters* group, you can see that the QEC code distance is 13. In the *Physical qubit parameters* group, you can see the physical qubit properties that were assumed for this estimation. For example, the time to perform a single-qubit measurement and a single-qubit gate are assumed to be 100 ns and 50 ns, respectively.

## Customize target parameters

To customize target parameters, rerun resource estimation for the example by using the Majorana-based qubit parameters `"qubit_maj_ns_e6"`.

Select **Code** to add a new cell, and then enter and run the following code:

```python
result = qsharp.azure.execute(EstimateMultiplication, bitwidth=8, 
            jobParams={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6" # Specify the qubit parameter name
                }})
result
```

You can inspect the result and compare both qubit technologies. For example, now the QEC code distance is 5, and the number of physical qubits has decreased from 173,592 to 8,160. Conversely, the runtime is 6 ms, compared to 3 ms when you use the previous approach.

You can update the error correction code, too. Select **Code** to add a new cell and rerun the resource estimation job on the Majorana-based qubit parameters. This time, use Floquet code as the error correction scheme:

```python
result_maj_floquet = qsharp.azure.execute(EstimateMultiplication, bitwidth=8,
            jobParams={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6" # Specify the qubit parameter name
                },
                "qecScheme": {
                    "name": "floquet_code" # Specify the QEC scheme name
                }})

result_maj_floquet
```

Now, you need 26,208 physical qubits, but the runtime is 0.547 ms.

Finally, set the error budget to 10 percent.

Select **Code** to add a new cell, and then enter and run the following code:

```python
result_maj_floquet_e1 = qsharp.azure.execute(EstimateMultiplication, bitwidth=8, 
            jobParams={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6" # Specify the qubit parameter name
                },
                "qecScheme": {
                    "name": "floquet_code" # Specify the QEC scheme name
                },
                "errorBudget": 0.1 # Specify the error budget, a number between 0 and 1
                }) 

result_maj_floquet_e1
```

Using this qubit technology and architecture, with an error budget of 10, you would need 4,620 physical qubits. This resource estimation shows that fewer physical qubits are needed if a higher error rate is acceptable. But if accuracy is important, then you need more physical qubits to account for error correction.

Next, create a quantum algorithm for factoring a large number, and estimate the resources required to run the algorithm on a fault-tolerant quantum computer.
