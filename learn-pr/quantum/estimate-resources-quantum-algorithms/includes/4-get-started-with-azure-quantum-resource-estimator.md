
The Azure Quantum Resource Estimator is a useful tool that allows a wide variety of customizations. Before starting the task you've been entrusted with, you'll first need to practice and get familiar with the tool. As a running example, you'll estimate the physical resources of a multiplier, which implements the multiplication of integer $a$ by integer $b$.

## Enabling the Azure Quantum Resource Estimator 

First, you need to enable the Azure Quantum Resource Estimator tool in your Azure Quantum workspace.

1. Log in to the [Azure portal](https://portal.azure.com/) and select your Azure Quantum workspace.
1. On the left panel, under **Operations**, select **Providers**.
1. Select **+ Add a provider**.
1. Select **+ Add** for **Microsoft Quantum Computing**.
1. Select **Learn & Develop** and select **Add**.

## Create a new Notebook in your workspace

1. Sign in to the [Azure portal](https://portal.azure.com) and select your Azure Quantum workspace.
1. Select **Notebooks**.
1. Select **My notebooks** and click **Add new** to create a new Jupyter notebook.
1. In **Kernel Type**, select **IPython**.
1. Type a name for the file, for example *quickstartResourceEstimator.ipynb*, and click **Create file**.

When your new Notebook opens, it automatically creates the code for the first cell, based on your subscription and workspace information.

```python
from azure.quantum import Workspace
workspace = Workspace (
    subscription_id = <your subscription ID>, 
    resource_group = <your resource group>,   
    name = <your workspace name>,          
    location = <your location>        
    )
```

## Getting started 

First, we connect to the Azure Quantum workspace and select the Azure Quantum Resource Estimator as target. We are also importing the `Microsoft.Quantum.Numerics` package that we will require for our example algorithm. 

Click **+ Code** to add a new cell, then add and run the following code: 

```python
import qsharp
import qsharp.azure  # Connect to your Azure Quantum workspace
targets = qsharp.azure.connect(
   resourceId="", # Fill in with the resourceID of your workspace
   location="") # Fill in with the location of your workspace (for example "westus")

qsharp.packages.add("Microsoft.Quantum.Numerics") #Import Microsoft.Quantum.Numerics package 
qsharp.azure.target("microsoft.estimator") # Select the Azure Quantum Resource Estimator as target
```

> [!NOTE]
> The location and resource ID of your workspace can be found in the **Overview** tab of your Azure Quantum workspace. 
>  :::image type="content" source="../media/azure-quantum-resource-id.png" alt-text="Screenshot of the overview blade of a workspace in Azure portal. Location and resource ID are marked inside a red rectangle.":::

As we said, as a running example you're creating a multiplier using the [MultiplyI](/qsharp/api/qsharp/microsoft.quantum.arithmetic.multiplyi) operation. You can configure the size of the multiplier with a bit width parameter. The operation has two input registers with that bit width, `factor1` and `factor2`, and one output register with the size of twice the bit width, `product`.

Click **+ Code** to add a new cell.

```python

%%qsharp

open Microsoft.Quantum.Arithmetic

operation EstimateMultiplication(bitwidth : Int) : Unit {
    use factor1 = Qubit[bitwidth];
    use factor2 = Qubit[bitwidth];
    use product = Qubit[2 * bitwidth];
    
    MultiplyI(LittleEndian(factor1), LittleEndian(factor2), LittleEndian(product));
}
```
> [!NOTE]
> The *%%qsharp* magic command allows you to enter Q# code directly into a Jupyter  Notebook when using the *Python 3 (ipykernel)*. For more information, see [%%qsharp magic command](/azure/quantum/how-to-python-qdk-local#the-qsharp-magic-command).


## Estimating the algorithm

In order to estimate an operation using the Azure Quantum Resource Estimator target, it must have a `Unit` return value. We can simply create a new instance for a specific bit width, for example 8 in this case.

```python
%%qsharp

operation EstimateMultiplication8() : Unit {
    EstimateMultiplication(8);
}
```
> [!IMPORTANT]
> To submit a Q# operation to the Azure Quantum Resource Estimator target, it must have a `Unit` return value. 

Let's now estimate the physical resources for this operation using the default assumptions. We can submit the operation to the resource estimation target using the `qsharp.azure.execute` function. This will output a table with the overall physical resource counts. You can further inspect more details about the resource estimates by collapsing various groups, which have more information.

```python

result = qsharp.azure.execute(EstimateMultiplication8)
result
```

For example, if you collapse the *Logical qubit parameters* group, you can see that the quantum error correction (QEC) code distance is 13. In the *Physical qubit parameters* group, you can see the physical qubit properties that were assumed for this estimation. For example, see that the time to perform a single-qubit measurement and a single-qubit gate are assumed to be 100 ns and 50 ns, respectively.

## Customizing input parameters

Let's rerun resource estimation for our running example on the Majorana-based qubit parameters `"qubit_maj_ns_e6"`.

```python

result = qsharp.azure.execute(EstimateMultiplication8,
            jobParams={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6" # Specify qubit parameter name
                }})
result
```
You can inspect the result and compare both qubit technologies. For example, notice that now the quantum error correction (QEC) code distance is 5, and the number of physical qubits has decreased from 173592 to 8160. Conversely, the runtime is 6 ms, compared to 3 ms using the previous approach. 



We can update the error correction code too. Let's rerun the resource estimation job on the Majorana-based qubit parameters using Floquet code as the error correction scheme.


```python
result_maj_floquet = qsharp.azure.execute(EstimateMultiplication8,
            jobParams={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6" # Specify qubit parameter name
                },
                "qecScheme": {
                    "name": "floquet_code" # Specify QEC scheme name
                }})

result_maj_floquet
```
Notice that now we need 26208 physical qubits, but the runtime is 0.547 ms. 	



Finally, we can set the error budget to 10%. 

```python
result_maj_floquet_e1 = qsharp.azure.execute(EstimateMultiplication8,
            jobParams={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6" # Specify qubit parameter name
                },
                "qecScheme": {
                    "name": "floquet_code" # Specify QEC scheme name
                },
                "errorBudget": 0.1 # Specify error budget. Must be a number between 0 and 1
                }) 

result_maj_floquet_e1
```

Using this qubit technology and architecture, with an error budget of 10% we would need 4620 physical qubits. This shows that fewer physical qubits are needed, if a higher error rate is acceptable, but if accuracy is important, then more physical qubits are needed to account for error correction.


In the next part, you'll create a quantum algorithm for factoring a large number, and you'll estimate the resources required to run it on a fault-tolerant quantum computer. 

