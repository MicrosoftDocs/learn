In the previous unit, you learned that the Microsoft Quantum resource estimator takes three main input parameters: the physical qubit parameters, the quantum error correction (QEC) scheme, and the error budget.

Now let's get some practice with the resource estimator. In this unit, you use the resource estimator to estimate the physical resources requirements for a simple quantum program.

## Install the required packages

To use the resource estimator, install the latest `qdk` Python library with the `jupyter` extra from the Microsoft Quantum Development Kit (QDK).  

```bash
python -m pip install --upgrade "qdk[jupyter]"
```

If you haven't already installed the QDK extension for Visual Studio Code (VS Code), then see [Install the QDK Extension](/azure/quantum/install-overview-qdk#install-the-qdk-extension).

## Create the quantum algorithm in a Jupyter notebook

Let's write the quantum algorithm in a Jupyter notebook. To create a Jupyter notebook with the QDK in VS Code, follow these steps:

1. Open VS Code.
1. Open the **View** menu and then choose **Command Palette**. An input box appears.

1. In the input box, enter and choose **Create: New Jupyter Notebook**.
1. In the notebook's first cell, import the `qsharp` package and the `EstimateDetails` function:

    ```python
    import qsharp
    from qsharp_widgets import EstimateDetails
    ```

1. Choose the **＋ Code** button to add a new cell.
1. Copy the following `RandomBit` code to the new cell:

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
            // Qubits are only accessible for the duration of the scope where they
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

## Estimate resources for the quantum algorithm

Run the resource estimator to estimate the physical resources needed to run the `RandomBit` operation. If you don't specify any parameters, then the resource estimator uses the following default parameter values:

- `qubit_gate_ns_e3` for the qubit model
- `surface_code` for the error correction code
- 0.001 for the error budget

To run the resource estimator, follow these steps:

1. Add a new cell and copy the following code to that cell:

   ```python
   result = qsharp.estimate("RandomBit()")
    
   EstimateDetails(result)
   ```

   The `qsharp.estimate` function creates a result object that contains information from the resource estimator. We pass `result` to the `EstimateDetails` function, which displays a set of tables in dropdowns that contain the output from the resource estimator.
1. Expand the first table, called **Physical resource estimates**. This table shows the runtime, the reliable quantum operations per second, and the number of qubits required to run the algorithm.

   | Physical resource estimate | Value       |
   | ---------------------------|-------------|
   | Runtime                    | 2 microsecs |
   | rQOPS                      | 3.00M       |
   | Physical qubits            | 300         |

   The `RandomBit` operation requires 300 physical qubits and takes two microseconds to run.

1. Choose the **Physical resource estimates** dropdown again to collapse the table.
1. To inspect the other tables, choose a dropdown to expand the corresponding table. For example, choose the **Logical qubit parameters** dropdown. This table shows that the code distance is 5, and that there's 50 physical qubits per logical qubit.

    | Logical qubit parameter    | Value                                                                     |
    |----------------------------|---------------------------------------------------------------------------|
    | QEC scheme                 | `surface_code`                                                            |
    | Code distance              | 5                                                                         |
    | Physical qubits            | 50                                                                        |
    | Logical cycle time         | 2 microsecs                                                               |
    | Logical qubit error rate   | 3.00e-5                                                                   |
    | Crossing prefactor         | 0.03                                                                      |
    | Error correction threshold | 0.01                                                                      |
    | Logical cycle time formula | (4 * `twoQubitGateTime` + 2 * `oneQubitMeasurementTime`) * `codeDistance` |
    | Physical qubits formula    | 2 * `codeDistance` * `codeDistance`                                       |

1. Use the `jobParams` field to access all the target parameters that you can pass to the job, and to examine the default values for parameters that you don't specify. Create a new cell and copy the following code to that cell:

    ```python
    result['jobParams']
    ```

1. Run the new cell and inspect the output:

    ```output
    {'qecScheme': {'name': 'surface_code',
      'errorCorrectionThreshold': 0.01,
      'crossingPrefactor': 0.03,
      'distanceCoefficientPower': 0,
      'logicalCycleTime': '(4 * twoQubitGateTime + 2 * oneQubitMeasurementTime) * codeDistance',
      'physicalQubitsPerLogicalQubit': '2 * codeDistance * codeDistance',
      'maxCodeDistance': 50},
     'errorBudget': 0.001,
     'qubitParams': {'instructionSet': 'GateBased',
      'name': 'qubit_gate_ns_e3',
      'oneQubitMeasurementTime': '100 ns',
      'oneQubitGateTime': '50 ns',
      'twoQubitGateTime': '50 ns',
      'tGateTime': '50 ns',
      'oneQubitMeasurementErrorRate': 0.001,
      'oneQubitGateErrorRate': 0.001,
      'twoQubitGateErrorRate': 0.001,
      'tGateErrorRate': 0.001,
      'idleErrorRate': 0.001},
     'constraints': {'maxDistillationRounds': 3},
     'estimateType': 'singlePoint'}
     ```

For this algorithm, the resource estimator uses the `qubit_gate_ns_e3` qubit model, the `surface_code` error correction code, and 0.001 for the error budget. These are the default values for these parameters because you didn't specify their values when you called the resource estimator.

## Change the default values and estimate the resources again

To run the Estimator with parameter values other than the defaults, specify other values for parameters when you call the resource estimator. Let's change the qubit model, the QEC scheme, and the error budget.

### Change the qubit model

Estimate the cost to run the same algorithm on a Majorana machine. To do this, pass the `qubitParams` parameter with the `name` field set to `qubit_maj_ns_e6` when you call the resource estimator.

In a new cell, copy and run the following code:

```python
result_maj = qsharp.estimate("RandomBit()", params={
                "qubitParams": {
                    "name": "qubit_maj_ns_e6"
                }})

EstimateDetails(result_maj)
```

Expand the dropdowns in the output to explore how the resource costs differ for the Majorana machine compared to the gate-based machine.

### Change the QEC scheme

Next, estimate the cost for the same algorithm on a Majorana machine with a Floquet QEC scheme. To do this, pass the `qecScheme` parameter with the `name` field set to `floquet_code` when you call the resource estimator.

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

Expand the dropdowns in the output to explore how the resource costs differ for the Floquet QEC scheme compared to the surface code scheme.

### Change the error budget

Finally, estimate the cost for the same parameters as your previous estimate, but increase the error budget to 10%. To do this, pass the `errorBudget` parameter with the value set to 0.1 when you call the resource estimator.

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

Congratulations! You successfully used the resource estimator to estimate the physical resources required to run a simple quantum algorithm. You also customized the parameters to see how they affect the resource estimates.

In the next unit, you estimate the resources needed for a much more complex quantum program: Shor's algorithm.
