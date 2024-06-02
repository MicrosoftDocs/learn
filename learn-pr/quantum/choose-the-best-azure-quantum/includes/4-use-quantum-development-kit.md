The Azure Quantum Development Kit (QDK) extension for Visual Studio Code allows you to create and run your programs in a local development environment. You can also connect to your Azure Quantum workspace and run your programs on the quantum computers and simulators of the providers you selected for your workspace.

## Install the required tools

1. Install [Visual Studio Code](https://code.visualstudio.com/) or open [VS Code for the Web](https://vscode.dev/quantum).
2. Install the [Azure Quantum Development Kit](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode) (Modern QDK) VS Code extension.
3. If you want to run your programs on real hardware, you also need:

    - An Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=academic-15963-cxa) before you begin.
    - An Azure Quantum workspace.

    > [!TIP]
    > If you have an Azure Quantum workspace, you can benefit from **USD500 free** in Azure Quantum Credits when you submit your Q# programs to Azure Quantum.

## Create and run a Q# program in Visual Studio Code

The QDK includes a set of Q# samples that you can use to learn more about Q# and quantum computing. To view the samples, open a new Q# file and type `sample`, then select the sample you want to view from the list of options.

1. Open Visual Studio Code and select **File** > **New Text File** to create a new file.
1. Save the file as `RandomNum.qs`. This file will contain the Q# code for your program.
1. Copy and save the following code in the `RandomNum.qs` file.

    ```qsharp
    namespace Sample {
    
        @EntryPoint()
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
    }
    ```

### Explore the Q# code

1. Hover over the `H` operation to see a short summary of the definition. 
1. Place your cursor in front of the `H` operation, right-click, and select **Go to Definition**.  This opens a read-only view of the standard library code for the function.

### Run the program locally

1. To test run your program locally on the built-in simulator, select **Run Q# File** from the play icon drop-down in the top-right, or press **Ctrl+F5**. Your output will appear in the debug console.
1. To debug your program before submitting it to Azure Quantum, select **Debug Q# file** from the play icon, or **press F5**. Use the debugging controls at the top to step over, into, and out of the code. 

### Connect to Azure Quantum and submit your job

If you have an Azure Quantum workspace, you can connect to it from VS Code and submit your Q# programs to Azure Quantum. For this example, you submit the `RandomNum.qs` program to the Rigetti simulator.

1. Open the **QUANTUM WORKSPACES** section in the **Explorer** view of the VS Code sidebar.
1. Select **Add an existing workspace** and follow the prompts to connect to your preferred directory, subscription, and workspace. 
1. Once you are connected, expand your workspace and expand the **Rigetti** provider.
1. Select **rigetti.sim.qvm** as your target.
1. Click the **⏵︎ (Play)** icon to the right of the target, or run the **"Q#: Submit current Q# program"** command from the **Command Palette**. If you get a popup, select **Change the QIR target profile and continue**. 
1. Enter a name and the number of shots for the job submission in the input boxes.
1. Press **Enter** to submit the job. The job status will display at the bottom of the screen.
1. Expand **Jobs** and hover over your job, which displays the times and status of your job. 
1. To view the results, select the cloud icon next to the job name to download the results from your workspace storage and display it in VS Code.

## Extra - Create an Azure Quantum notebook

The QDK allows you to create Azure Quantum notebooks in VS Code. Azure Quantum notebooks are Jupyter notebooks that allow you to run quantum programs on the quantum computers and simulators of the providers you selected for your Azure Quantum workspace.

To create an Azure Quantum notebook:

1. In VS Code, open the **View** menu and select **Command Palette**.
1. Type **Q#: Create an Azure Quantum notebook**.
1. A Jupyter Notebook opens in a new tab. The notebook includes a code cell that imports the required packages for the sample, connects to the Azure Quantum service, and runs a Q# program.
