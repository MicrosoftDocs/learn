Now let's see how you can use Azure Quantum to test quantum algorithms, first on a simulator and then on real hardware.

If you took a [previous module](https://docs.microsoft.com/learn/modules/solve-graph-coloring-problems-grovers-search/6-implement-grovers-algorithm/?azure-portal=true) of this learning path, you created a version of Grover's algorithm in Q# and ran it on a local simulator. Now let's run the same algorithm in a trapped ion quantum computer.

## Create the Q# project for IonQ

Use Visual Studio Code to create a Q# Project.

1. In Visual Studio Code, open the **View** menu, and select **Command Palette**.

1. Enter **Q#: Create New Project**.

1. Select **Standalone console application**.

1. Select a directory to hold your project, such as your home directory, and name your project. For example, enter **MyGroversJob** as the project name, and select **Create Project**.

1. From the window that appears at the bottom, select **Open new project**.

1. You should see two files: the project file and *Program.qs*, which contains starter code.

1. Start by opening the *MyFirstJob.csproj* file and adding the `ExecutionTarget` property, which will give you design-time feedback on the compatibility of your program for IonQ's hardware in Visual Studio Code.

    ```xml
    <PropertyGroup Sdk="Microsoft.Quantum.Sdk/y.yy.yyyyyyyy">
        <OutputType>Exe</OutputType>
        <TargetFramework>netcoreapp3.1</TargetFramework>
        <ExecutionTarget>ionq.qpu</ExecutionTarget>
      </PropertyGroup>
    </Project>
    ```

   with `yy.yy.yyyyyyyy` being the number of the last version of the Quantum Development Kit (QDK). If your QDK Visual Studio Code extension is updated, the version should already be up to date.

## Adapt Grover's algorithm to run in hardware

Fortunately, you don't need control flow features to implement the basic variant of Grover's algorithm, so you can easily adapt the Q# code of previous modules to run on IonQ's targets.

For the moment, we have a limited number of qubits available, so you'll run a simple version of Grover's algorithm.

### Write the core part of Grover's algorithm

Open the file *Program.qs*, and add the following content:

1. First, add the Grover's diffusion operation:

   :::code language="qsharp" source="../code/5-program-1.qs":::


1. Now, write the full Grover's search operation that takes a phase oracle as input:

   :::code language="qsharp" source="../code/5-program-2.qs":::

   Recall that the number of iterations is given by the formula $N_{\text{iterations}}=\frac{\pi}{4}\sqrt{\frac{N}{M}}$, where $N$ is the number of possible states and $M$ is the number of solutions.

### Implement an oracle

Because this is just a demonstration, we're going to solve a trivial task. You're going to give an integer as input to the oracle, and then use the quantum computer to find this integer.

1. First, you need to implement a marking oracle that takes an integer as input and marks the basis state that corresponds to that integer. You can do this step by using the following operation:

   :::code language="qsharp" source="../code/5-program-3.qs":::

   This operation takes as input the integer to be marked and flips the state of the target qubit if the control register state corresponds to the input integer. To do this, it uses the function [`ControledOnInt`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.canon.controlledonint/?azure-portal=true) from the Standard library.

1. Because the general operation to run Grover's algorithm that you defined takes a phase oracle as an input, you need to transform your marking oracle into a phase oracle by using the phase kickback trick. We can use the same operation that we used in the module [Solve graph coloring problems by using Grover's search](https://docs.microsoft.com/learn/modules/solve-graph-coloring-problems-grovers-search/4-implement-quantum-oracle/?azure-portal=true):

   :::code language="qsharp" source="../code/5-program-4.qs":::

   These two operations combined flip the phase of the basis state that corresponds to the input integer. This step is crucial for each iteration of the Grover's search.

### Calculate the number of iterations

The ideal number of Grover iterations to perform is defined by the number of correct solutions and the total number of possible states. In this case, we have a single correct solution, so we define the function `NIterations` that takes the number of qubits as input:

:::code language="qsharp" source="../code/5-program-5.qs":::

### Create a runnable operation

Now you need to define the main operation that you'll run on Azure Quantum hardware. You need to annotate the operation with the `@EntryPoint` attribute just before the operation signature. The input parameters of the operation will be provided through the Azure CLI as command-line arguments of the job submission.

> [!NOTE]
> For Azure Quantum targets, the output of the main operation needs to have a `Result` data type, either a single result (`Result`) or an array of results (`Result[]`).

The full code should be:

   :::code language="qsharp" source="../code/5-program-6.qs":::

## Submit your job to Azure Quantum

Now your code is ready to submit the job to Azure Quantum. First you'll evaluate the resources that your code requires. Then you'll try your code in the IonQ's simulator, and finally you'll run it against hardware.

In this example, we'll set the number of qubits to 2, and the marked integer is going to be 1.

### Estimate the resources for your job

To estimate the resources of the job, the QDK offers you the `ResourcesEstimator` tool that was presented in the module [Explore the key concepts of quantum computing by using Q#](https://docs.microsoft.com/learn/modules/qsharp-explore-key-concepts-quantum-computing/7-explore-entanglement-qsharp/?azure-portal=true).

To use `ResourcesEstimator`:

1. Run your program from the command line, and select `ResourcesEstimator` as your simulator.

   ```dotnetcli
   dotnet run -- --n-qubits 2 --idx-marked --simulator ResourcesEstimator
   ```

1. Review the printed list of the quantum resources that are required to run the job.

   ```output
   Metric          Sum     Max
   CNOT            11      11
   QubitClifford   20      20
   R               0       0
   Measure         2       2
   T               7       7
   Depth           5       5
   Width           3       3
   QubitCount      3       3
   BorrowedWidth   0       0
   ```

As you can see, this job only requires three qubits, since the `QubitCount` is 3. Also, we can see that this job uses 11 `CNOT` gates and 20 `QubitClifford` gates. This information might be useful to estimate the cost of running the job in different providers.

### Test the code in the simulator

Now that you know what resources you need to run your job, you can test it on the simulator.

1. Open the Azure CLI, and submit the job by using the following command:

   ```azurecli
   az quantum job submit --target-id ionq.simulator -- --n-qubits 2 --idx-marked 1
   ```

   You should obtain something like this example:

   ```output
   Name          Id                                    Status    Target          Submission time
   ------------  ------------------------------------  --------  --------        --------------------------------
   MyGroversJob  yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy  Waiting   ionq.simulator  2021-01-20T21:34:35.406875+00:00
   ```

1. To check on the status, use the `az quantum job show` command. Make sure to replace the `job-id` parameter with the `Id` output by the previous command:

   ```dotnetcli
    az quantum job show -o table --job-id yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy 
   ```

1. Eventually, you'll see the `Status` in the preceding table change to `Succeeded`. After that happens, you can get the results from the job by running `az quantum job output`:

   ```dotnetcli
   az quantum job output -o table --job-id yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy 
   ```

   And the output should be:

   ```output
    Result    Frequency
    --------  -----------  -------------------------
    [1,0]     1.00000000   ▐████████████████████   |
   ```

In this particular case, Grover's algorithm theoretically succeeds with 100 percent probability.

Remember that the integer is represented as its binary notation in little endian (with the least significant bit written first). Binary result 10 is exactly the decimal 1 we used as the input.

### Run your code against hardware

To run your code against hardware, you just need to repeat the same steps as for the simulator but changing the target to `ionq.qpu`. You can also choose the number of `shots` to run your program (the default value is 500).

For example, if you choose five shots by using the following command:

```azcli
az quantum job submit --target-id ionq.simulator -- --n-qubits 2 --idx-marked 1 --shots 5
```

You might obtain a result similar to this example:

```output
--------  -----------  -------------------------
[1,0]     0.60000000   ▐████████████           |
[0,1]     0.40000000   ▐███████                |
```

As you can see, the marked integer can't be inferred reliably from the histogram, even though the algorithm theoretically succeeds with a 100 percent of probability. This is because real qubits are subject to noise, and errors can sometimes lead to incorrect computations. To account for these errors, it can be convenient to increase the number of shots to reduce the effect of noise and get a more accurate histogram.

For example, if you choose 1,000 shots, you should obtain something like this example:

```output
Result    Frequency
--------  -----------  -------------------------
[0,0]     0.07220000   ▐█                      |
[1,0]     0.80560000   ▐████████████████       |
[0,1]     0.04500000   ▐█                      |
[1,1]     0.07720000   ▐██                     |

```

This result is a more accurate statistical representation of the theoretical outcome of the program that enables you to infer the correct result.

In the next unit, you're going to see some ideas to continue exploring quantum computing with Azure Quantum.
