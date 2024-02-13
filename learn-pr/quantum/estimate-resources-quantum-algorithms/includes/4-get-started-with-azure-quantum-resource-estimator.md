Let's get some practice with the Azure Quantum Resource Estimator. In the following example, you estimate the physical resources of a .

## Create the quantum algorithm

1. In VS Code, select **View > Command palette** and select **Create: New Jupyter Notebook**. 
1. In the top-right, VS Code will detect and display the version of Python and the virtual Python environment that was selected for the notebook. If you have multiple Python environments, you may need to select a kernel using the kernel picker in the top right. If no environment was detected, see [Jupyter Notebooks in VS Code](https://code.visualstudio.com/docs/datascience/jupyter-notebooks#_setting-up-your-environment) for setup information. 
1. In the first cell of the notebook, import the `qsharp` package.

    ```python
    import qsharp
    ```

1. Add a new cell and copy the following code.


# Estimate the quantum algorithm

Now, you estimate the physical resources for the `RunProgram` operation using the default assumptions. Add a new cell and copy the following code.

```python
result = qsharp.estimate("RunProgram()")
result
```

The `qsharp.estimate` function creates a result object, which can be used to display a table with the overall physical resource counts. You can inspect cost details by collapsing the groups, which have more information. For more information, see [the full report data of the Resource Estimator](xref:microsoft.quantum.overview.resources-estimator-output.data#report-data).

For example, collapse the **Logical qubit parameters** group to see that the code distance is 21 and the number of physical qubits is 882.

|Logical qubit parameter| Value |
|----|---|
|QEC scheme                                                |                           surface_code |
|Code distance                                                                       |            21 |
|Physical qubits                                                                   |            882 |
|Logical cycle time                                                                   |   8 milisecs |
|Logical qubit error rate                                                            |     3.00E-13 |
|Crossing prefactor                                                                    |       0.03|
|Error correction threshold                                                             |      0.01|
|Logical cycle time formula    | (4 * `twoQubitGateTime` + 2 * `oneQubitMeasurementTime`) * `codeDistance`|
|Physical qubits formula     |                                      2 * `codeDistance` * `codeDistance`|

> [!TIP]
> For a more compact version of the output table, you can use `result.summary`.

### Space diagram

The distribution of physical qubits used for the algorithm and the T factories is a factor which may impact the design of your algorithm. You can use the `qsharp-widgets` package to visualize this distribution to better understand the estimated space requirements for the algorithm.

```python
from qsharp_widgets import SpaceChart
SpaceChart(result)
```

In this example, the number of physical qubits required to run the algorithm are 829766, 196686 of which are algorithm qubits and 633080 of which are T factory qubits.

:::image type="content" source="../media/resource-estimator-diagram-jupyter.png" alt-text="Screen shot showing the space diagram of the Resource Estimator.":::

## Change the default values and estimate the algorithm

When submitting a resource estimate request for your program, you can specify some optional parameters. Use the `jobParams` field to access all the target parameters that can be passed to the job execution and see which default values were assumed:

```python
result['jobParams']
```

```output
{'errorBudget': 0.001,
 'qecScheme': {'crossingPrefactor': 0.03,
  'errorCorrectionThreshold': 0.01,
  'logicalCycleTime': '(4 * twoQubitGateTime + 2 * oneQubitMeasurementTime) * codeDistance',
  'name': 'surface_code',
  'physicalQubitsPerLogicalQubit': '2 * codeDistance * codeDistance'},
 'qubitParams': {'instructionSet': 'GateBased',
  'name': 'qubit_gate_ns_e3',
  'oneQubitGateErrorRate': 0.001,
  'oneQubitGateTime': '50 ns',
  'oneQubitMeasurementErrorRate': 0.001,
  'oneQubitMeasurementTime': '100 ns',
  'tGateErrorRate': 0.001,
  'tGateTime': '50 ns',
  'twoQubitGateErrorRate': 0.001,
  'twoQubitGateTime': '50 ns'}}
 ```

You can see that the Resource Estimator takes the `qubit_gate_ns_e3` qubit model, the `surface_code` error correction code, and 0.001 error budget as default values for the estimation.

These are the target parameters that can be customized:

* `errorBudget` - the overall allowed error budget for the algorithm 
* `qecScheme` - the quantum error correction (QEC) scheme 
* `qubitParams` - the physical qubit parameters 
* `constraints` - the constraints on the component-level
* `distillationUnitSpecifications` - the specifications for T factories distillation algorithms

For more information, see [Target parameters](xref:microsoft.quantum.overview.resources-estimator#target-parameters) for the Resource Estimator.

### Change qubit model

You can estimate the cost for the same algorithm using the Majorana-based qubit parameter, `qubitParams`, "qubit_maj_ns_e6".

```python
result_maj = qsharp.estimate("RunProgram()", params={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6"
                }})
EstimateDetails(result_maj)
```

### Change quantum error correction scheme

You can rerun the resource estimation job for the same example on the Majorana-based qubit parameters with a floqued QEC scheme, `qecScheme`.

```python
result_maj = qsharp.estimate("RunProgram()", params={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6"
                },
                "qecScheme": {
                    "name": "floquet_code"
                }})
EstimateDetails(result_maj)
```

### Change error budget

Next, rerun the same quantum circuit with an `errorBudget` of 10%.

```python
result_maj = qsharp.estimate("RunProgram()", params={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6"
                },
                "qecScheme": {
                    "name": "floquet_code"
                },
                "errorBudget": 0.1})
EstimateDetails(result_maj)
```