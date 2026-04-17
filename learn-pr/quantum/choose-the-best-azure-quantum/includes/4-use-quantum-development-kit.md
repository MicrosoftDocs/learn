In this unit, you learn how to use the Microsoft Quantum Development Kit (QDK) extension for Visual Studio Code (VS Code) to create and run Q# programs in a local development environment. You also learn how to connect to your Azure Quantum workspace and run your programs on the quantum computers and simulators of the providers that you selected for your quantum workspace.

## Install the required tools

1. Install [VS Code](https://code.visualstudio.com/).
1. Install the [Microsoft Quantum Development Kit](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode) extension. Or, open [VS Code for the Web](https://vscode.dev/quantum), which already includes the QDK extension.
1. To run your programs on real hardware, you need an Azure subscription and an Azure Quantum workspace. If you don't have an Azure account, then create a [free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn&?WT.mc_id=academic-15963-cxa) before you begin.

## Create and run a Q# program in VS Code

The QDK includes a set of Q# samples that you can use to learn about the Q# programming language and quantum computing. To view the samples, open a new Q# file and type `sample`, and then select a sample from the list of options.

To write your own Q# file, follow these steps:

1. Open VS Code.
1. Open the **File** menu, and then choose **New Text File** to create a new file.
1. Save the file as `Main.qs`. This file will contain the Q# code for your program.
1. Copy and save the following code in your `Main.qs` file:

    ```qsharp
    operation Main() : Result {
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

### Explore the Q# code

The QDK uses IntelliSense to assist your development. For example:

1. Hover over the `H` operation to see a short summary of the operation definition.
1. Place your cursor in front of the `H` operation, right-click, and then choose **Go to Definition**.  This opens a read-only view of the standard library code for the operation.

### Run the program locally

To run your program on the built-in simulator, choose the **Run** code lens above the `Main` operation, or press **Ctrl + F5**. Your program's output appears in the debug console.

### Connect to Azure Quantum and submit your job

You can connect to your Azure Quantum workspace from VS Code and submit your Q# programs to Azure Quantum. For example, to submit your `Main.qs` program to the Rigetti simulator, follow these steps:

1. Expand the **QUANTUM WORKSPACES** dropdown section in the **Explorer** view of the VS Code sidebar.
1. If you haven't already added a quantum workspace, then choose **Add an existing workspace** and follow the prompts to connect to a directory, subscription, and workspace.
1. Expand the dropdown for your workspace, then expand the **Providers** dropdown, and then expand the **rigetti** dropdown.
1. Choose **rigetti.sim.qvm** as your target.
1. Choose the **⏵︎ (Run)** icon next to the target, or run the **"QDK: Submit current QDK program"** command from the **Command Palette**.
1. In the input box that appears, enter a job name and the number of shots for the job.
1. Press **Enter** to submit the job. The job status appears.
1. In the **QUANTUM WORKSPACES** menu, expand the **Jobs** dropdown under your workspace and hover over your job. This displays timestamps and the job status for your job.
1. To view your job results as a histogram, choose the histogram icon next to the job name. To download your job results as text, choose the text icon next to the job name.

## Create a Microsoft Quantum notebook

The QDK allows you to create Jupyter notebooks in VS Code. You can write Q#, Python, and OpenQASM code in Jupyter notebooks, and run the code on the quantum computers and simulators of the providers that you selected for your Azure Quantum workspace.

To create a Jupyter notebook that connects to Azure Quantum in VS Code, follow these steps:

1. In VS Code, open the **View** menu and choose **Command Palette**.
1. Enter **QDK: Create a Microsoft Quantum notebook**.
1. A Jupyter notebook opens in a new tab. The notebook includes code cells that import the required packages for the sample, connect to the Azure Quantum service, and run a Q# program.
