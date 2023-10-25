
The Quantum Development Kit (QDK) extension for Visual Studio Code allows you to create and run your programs in a local development environment. 

## Prerequisites

- An Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=academic-15963-cxa) before you begin.
- An Azure Quantum workspace.
- Install [Visual Studio Code](https://code.visualstudio.com/).
- Install the [Microsoft QDK for VS Code extension](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode).

## Create a Q# program in Visual Studio Code

1. Open Visual Studio Code and select **File** > **New File** to create a new file.
1. Save the file as `QuantumRNG.qs`. This file will contain the Q# code for your program.
1. Copy and save the following code in the `QuantumRNG.qs` file.

    ```qsharp
    namespace QuantumRNG {
        open Microsoft.Quantum.Intrinsic;
        open Microsoft.Quantum.Measurement;
        open Microsoft.Quantum.Canon;

        @EntryPoint()
        operation GenerateRandomBits() : Result[] {
            use qubits = Qubit[4];
            ApplyToEach(H, qubits);
            return MultiM(qubits);
        }
    }
    ```

### Explore the Q# code

1. Hover over `H` operation to see a short summary of the definition. 
1. Place your cursor in front of the `H` operation, right-click and select **Go to Definition**.  This opens a read-only view of the standard library code for the function.

## Sign in to Azure Quantum

1. Select **View** > **Explorer** or press **Ctrl+Shift+E**, then expand the **QUANTUM WORKSPACES** section.
1. Click on **Sign in**. This will open a browser window to sign in to Azure Quantum.
1. Follow the instructions and select your Azure Quantum workspace. (This may prompt several times for permission as it requests access to the Azure subscription and Quantum workspace).

> [!NOTE]
> If prompted to, configure the storage resource for your workspace to use CORS ([cross-origin resource sharing](/rest/api/storageservices/cross-origin-resource-sharing--cors--support-for-the-azure-storage-services)). For more information, see [Enabling CORS requests](https://github.com/microsoft/qsharp/wiki/Enabling-CORS). 

## Run the program on quantum hardware

1. Open the **QUANTUM WORKSPACES** section in the Explorer view of the VS Code sidebar.
2. Select your Azure Quantum workspace.
3. Select one of the targets from the list. For example, select Quantinnum, `quantinuum.qpu.h1-1`.
4. Click the **⏵︎ (Play)** button to the right of the target, or run the **"Q#: Submit current Q# program"** command from the **Command Palette** while a provider is selected.
5. Enter a name and the number of shots for the job submission in the input boxes.
6. Once the job completed successfully, click on the icon to the right of the job in the tree view to download the results.

   ```output
   Result     Frequency
   ---------  -----------  -------------------------
   [0,0,0,0]  0.05200000   ▐█                      |
   [1,0,0,0]  0.07200000   ▐█                      |
   [0,1,0,0]  0.05000000   ▐█                      |
   [1,1,0,0]  0.06800000   ▐█                      |
   [0,0,1,0]  0.04600000   ▐█                      |
   [1,0,1,0]  0.06000000   ▐█                      |
   [0,1,1,0]  0.06400000   ▐█                      |
   [1,1,1,0]  0.07600000   ▐██                     |
   [0,0,0,1]  0.04800000   ▐█                      |
   [1,0,0,1]  0.06200000   ▐█                      |
   [0,1,0,1]  0.07400000   ▐█                      |
   [1,1,0,1]  0.08000000   ▐██                     |
   [0,0,1,1]  0.05800000   ▐█                      |
   [1,0,1,1]  0.06800000   ▐█                      |
   [0,1,1,1]  0.05200000   ▐█                      |
   [1,1,1,1]  0.07000000   ▐█                      |
   ```

The histogram you receive may be slightly different than the one above, but you should find that the states generally are observed with equal frequency.