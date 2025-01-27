In the previous unit, you learned that the Azure Quantum Resource Estimator works by taking three main inputs: the physical qubit parameters, the quantum error correction (QEC) scheme, and the error budget. 

Let's get some practice with the Azure Quantum Resource Estimator. In this unit, you estimate the physical resources of a simple program using the Azure Quantum Resource Estimator.

## Install the required packages

First, install the latest Azure Quantum `qsharp` and `qsharp-widgets` packages.  

```bash
python -m pip install --upgrade qsharp qsharp-widgets 
```

## Create the quantum algorithm in a Jupyter notebook

To get started with the Resource Estimator, you estimate the required resources for a simple quantum algorithm that generates a random bit.

1. Open Visual Studio Code.
1. Select **View > Command palette** and select **Create: New Jupyter Notebook**.
1. In the notebook's first cell, import the `qsharp` package:

    ```python
    import qsharp
    from qsharp_widgets import EstimateDetails
    ```

1. Add a new cell and copy the following code:

    ```qsharp
    %%qsharp
    /// # Sample
    /// Random Bit
    ///
    /// # Description
    /// This Q# program generates a random bit by setting a qubit in a superposition
    /// of the computational basis states |0〉 and |1〉, and returning the measurement
    /// result.
    
        operation RandomBit() : Result {
            // Qubits are only accesible for the duration of the scope where they
            // are allocated and are automatically released at the end of the scope.
            use qubit = Qubit();
    
            // Set the qubit in superposition by applying a Hadamard transformation.
            H(qubit);
    
            // Measure the qubit. There is a 50% probability of measuring either 
            // `Zero` or `One`.
            let result = M(qubit);
    
            // Reset the qubit so it can be safely released.
            Reset(qubit);
            return result;
        }
    ```

## Estimate the quantum algorithm

Now, run the Resource Estimator to estimate the physical resources for the `RandomBit` operatio. If you don't specify anything, the Resource Estimator uses the default assumptions, that is the `qubit_gate_ns_e3` qubit model, the `surface_code` error correction code, and 0.001 error budget.

1. Add a new cell and copy the following code:

    ```python
    result = qsharp.estimate("RandomBit()")
    result
    ```

    The `qsharp.estimate` function creates a result object, which can be used to display a table with the overall physical resource counts. The first table shows the main physical-resource estimates. The `RandomBit` operation requires 300 qubits and takes two microseconds to run on a quantum computer.

    |Physical resource estimates| Value |
    |----|---|
    |Runtime| 2 microsecs|
    |rQOPS| 3.00M|
    |Physical qubits| 300|

1. You can inspect cost details by collapsing the groups, which have more information. For example, collapse the **Logical qubit parameters** group to see that the code distance is 5 and the number of physical qubits per logical qubit is 50.

    |Logical qubit parameter| Value |
    |----|---|
    |QEC scheme                                                |                           surface_code |
    |Code distance                                                                       |            5 |
    |Physical qubits                                                                   |            50 |
    |Logical cycle time                                                                   |   2 microsecs |
    |Logical qubit error rate                                                            |     3.00E-5 |
    |Crossing prefactor                                                                    |       0.03|
    |Error correction threshold                                                             |      0.01|
    |Logical cycle time formula    | (4 * `twoQubitGateTime` + 2 * `oneQubitMeasurementTime`) * `codeDistance`|
    |Physical qubits formula     |                                      2 * `codeDistance` * `codeDistance`|

1. You can use the `jobParams` field to access all the target parameters that can be passed to the job execution and see which default values were assumed:

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

    You can see that the Resource Estimator takes the `qubit_gate_ns_e3` qubit model, the `surface_code` error correction code, and 0.001 error budget, which are the default values for the estimation.

## Change the default values and estimate the algorithm

If you don't want to use the default values, you can specify optional parameters. Let's change the qubit model, the QEC scheme, and the error budget.

### Change qubit model

You estimate the cost for the same algorithm using the Majorana-based qubit parameter, `qubit_maj_ns_e6`. To do this, you need to pass the `qubitParams` parameter with the `name` field set to `qubit_maj_ns_e6`.

In a new cell, copy and run the following code:

```python
result_maj = qsharp.estimate("RandomBit()", params={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6"
                }})
EstimateDetails(result_maj)
```

### Change quantum error correction scheme

You estimate the cost for the same algorithm using the Majorana-based qubit parameters with a floqued QEC scheme, `qecScheme`. To do this, you also need to pass the `qecScheme` parameter with the `name` field set to `floquet_code`.

In a new cell, copy and run the following code:

```python
result_maj = qsharp.estimate("RandomBit()", params={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6"
                },
                "qecScheme": {
                    "name": "floquet_code"
                }})
EstimateDetails(result_maj)
```

### Change error budget

Next, estimate the cost for the same parameters with an `errorBudget` of 10%. To do this, you need to pass the `errorBudget` parameter with the value set to 0.1.

In a new cell, copy and run the following code:

```python
result_maj = qsharp.estimate("RandomBit()", params={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6"
                },
                "qecScheme": {
                    "name": "floquet_code"
                },
                "errorBudget": 0.1})
EstimateDetails(result_maj)
```

Congratulations! You've successfully estimated the physical resources for a simple quantum algorithm using the Azure Quantum Resource Estimator and customized the parameters to see how they affect the resource estimates.

In the next unit, you'll level up the difficulty and estimate the resources for the Shor's algorithm using the Azure Quantum Resource Estimator.
