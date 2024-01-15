Let's get some practice with the Azure Quantum Resource Estimator. In the following example, you estimate the physical resources of a Shor's algorithm sample.

## Load a Q# sample program

1. In VS Code, select **File > New File** and save the file as **ShorRE.qs**. 
1. Open **ShorRE.qs** and type `sample`, then select **Shor sample** and save the file.

## Run the Resource Estimator

The Resource Estimator offers six pre-defined qubit parameters, four of which have gate-based instruction sets and two that have a Majorana instruction set. It also offers two quantum error correction codes, `surface_code` and `floquet_code`.

In this example, you run the Resource Estimator using the `qubit_gate_us_e3` qubit parameter and the `surface_code` quantum error correction code.

1. Select **View -> Command Palette**, or press **Ctrl+Shift+P**, and type “resource” which should bring up the `Q#: Calculate Resource Estimates` option. Select this option to open the Resource Estimator window.
1. You can select one or more **Qubit parameter + Error Correction code** types to estimate the resources for. For this example, select **qubit_gate_us_e3** and click **OK**.
1. Specify the **Error budget** or accept the default value 0.001. For this example, leave the default value and press **Enter**.
1. Press **Enter** to accept the default filename, in this case, **ShorRE.qs**.

## View the results

1. The result of the resource estimation is displayed in the **Q# Estimate** window.
1. The **Results** tab displays a summary of the resource estimation. **Click the icon** next to the first row to select the columns you want to display. You can select from run name, qubit type, qec scheme, error budget, logical qubits, logical depth, code distance, T states, T factories, T factory fraction, runtime, rQOPS, and physical qubits.

    :::image type="content" source="../media/resource-estimator-local-tab-1.png" alt-text="Screen shot showing how to display the menu to select the resource estimate outputs of your choice.":::

    > [!NOTE]
    > If you select more than one qubit parameters and error correction codes in the configuration, the results are displayed in different rows in the **Results** tab. Clicking on a result from the table brings up the corresponding space diagram and report data.

1. The **Space diagram** tab displays the distribution of physical qubits used for the algorithm and the [T factories](/azure/quantum/concepts-tfactories). 

    :::image type="content" source="../media/resource-estimator-local-diagram.png" alt-text="Screen shot showing the space diagram of the Resource Estimator .":::

1. Finally, the **Resource Estimates** tab displays the full list of output data for the Resource Estimator. You can inspect cost details by collapsing the groups, which have more information. For example, try to collapse the **Logical qubit parameters** group.

    |Logical qubit parameter| Value |
    |----|---|
    |QEC scheme                                                |                           surface_code |
    |Code distance                                                                       |            17 |
    |Physical qubits                                                                   |            578 |
    |Logical cycle time                                                                   |   10 milisecs |
    |Logical qubit error rate                                                            |     3.00E-11 |
    |Crossing prefactor                                                                    |       0.03|
    |Error correction threshold                                                             |      0.01|
    |Logical cycle time formula    | (4 * `twoQubitGateTime` + 2 * `oneQubitMeasurementTime`) * `codeDistance`|
    |Physical qubits formula     |                                      2 * `codeDistance` * `codeDistance`|

    > [!TIP]
    > Click **Show detailed rows** to display the description of each output of the report data. 

