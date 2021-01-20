THIS ARTICLE IS STILL IN PROGRESS

Now let's see how you can use Azure Quantum to test quantum algorithms, first in
a simulator, and then in real hardware.

In [previous modules](todo) of this learning path, you created a version of
Grover's algorithm in Q# and run it in a local simulator. Now let's run the same
algorithm in a trapped ion quantum computer.

## Create the Q# project for IonQ

Use Visual Studio Code to create a Q# Project.

1. In VS Code open the **View** menu, and select **Command Palette**.

1. Type `Q#: Create New Project`.

1. Select **Standalone console application**.

1. Select a directory to hold your project, such as your home directory and name
   your project. For example, enter `GroversJob` as the project name and select
   **Create Project**.

1. From the window that appears at the bottom, select **Open new project**.

1. You should see two files: the project file and `Program.qs`, which contains
   starter code.

1. Start by opening the `MyFirstJob.csproj` file and adding the
   `ExecutionTarget` property, which will give you design-time feedback on the
   compatibility of your program for IonQ's hardware in VS Code.

    ```xml
    <PropertyGroup Sdk="Microsoft.Quantum.Sdk/y.yy.yyyyyyyy">
        <OutputType>Exe</OutputType>
        <TargetFramework>netcoreapp3.1</TargetFramework>
        <ExecutionTarget>ionq.qpu</ExecutionTarget>
      </PropertyGroup>
    </Project>
    ```

   with `yy.yy.yyyyyyyy` being the number of the last version of the Quantum
   Development Kit. If your QDK Visual Studio Code extension is updated, the
   version should already be up to date.

## Adapt Grover's algorithm to run in hardware

Fortunately, you don't need control flow features to be implement Grover's
algorithm, so you can easily adapt the Q# code of previous modules to run on
IonQ's targets.

For the moment, we have a limited number of qubits available, so you will run a
very simple version of Grover's algorithm. Open the file `Program.qs` and add
the following content:

### Write the core part of Grover's algorithm

1. First, add the Grover's diffusion operation:

   ```qsharp
       operation ReflectAboutUniform(inputQubits : Qubit[]) : Unit {
               within {
                   ApplyToEachCA(H, inputQubits);
                   ApplyToEachCA(X, inputQubits);
               } apply {
                   Controlled Z(Most(inputQubits), Tail(inputQubits));
               }
           }
       }
   ```

   Recall that this operation is called The operation `ReflectAboutUniform`
   because it can be geometrically interpreted as a reflection in the ket space
   about the uniform superposition state.

1. Now, write the full Grover's search operation that takes a phase oracle as
   input:

    ```qsharp
    operation RunGroversSearch(register : Qubit[], phaseOracle : ((Qubit[]) => Unit is Adj), iterations : Int) : Unit {
        ApplyToEachCA(H, register);
        for (_ in 1 .. iterations) {
            phaseOracle(register);
            ReflectAboutUniform(register);
        }
    }
   ```

   Recall that the number of iterations is given by the formula:
   $N_{\text{iterations}}=\frac{pi}{4}\sqrt{\frac{N}{M}}$, where $M$ is the
   number of possible states and $M$ is the number of solutions.

### Implement an oracle

This is just a demonstration we are going to solve a trivial task. You are going
to give an integer as input to then use the quantum computer to find such integer
using a Grover's task.

1. First you need to implement a marking oracle that takes an integer as input
   and marks the register using a controlled operation. You can achieve it using
   the following operation:
   ```qsharp
        operation markingNumber (
            idxMarked : Int,
            inputQubits : Qubit [],
            target : Qubit
        ) : Unit is Adj+Ctl {
            (ControlledOnInt(idxMarked, X))(inputQubits, target);
        }
   ```
   This operation takes as input your input integer and flips the state of the
   target qubit if the control register state corresponds to the input integer.
   To do it uses the operation
   [`ControledOnInt`](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.canon.applycontrolledonint)
   from the Standard library.

2. Since the general operation to run Grover's algorithm that you defined takes phase  oracles as inputs, you need to transform your marking oracle as a phase oracle using the phase kickback trick. We can use the very same operation that we used in the module [Solve graph coloring problems by using Grover's search](https://docs.microsoft.com/en-us/learn/modules/solve-graph-coloring-problems-grovers-search/4-implement-quantum-oracle). The operation is:

   ```qsharp
    operation ApplyMarkingOracleAsPhaseOracle(
        markingOracle : ((Qubit[], Qubit) => Unit is Adj), 
        register : Qubit[]
    ) : Unit is Adj {
        using (target = Qubit()) {
            within {
                X(target);
                H(target);
            } apply {
                markingOracle(register, target);
            }
        }
    }
   ```

   These two operations combined invert the phase of the state that corresponds to the integer that you introduce. This is a crucial step of each iteration of the Grover's search.

### Calculate the number of iterations

The ideal number of Grover iterations to perform is provided by the number of
possible solutions and the total number of states. In this case, we have a
single possible solution, so we define the function `NIterations` that takes
the number of qubits as input:

```qsharp
function NIterations(nQubits : Int) : Int {
    let nItems = 1 <<< nQubits;
    let angle = ArcSin(1. / Sqrt(IntAsDouble(nItems)));
    let nIterations = Round(0.25 * PI() / angle - 0.5);
    return nIterations;
}
```

### Create a runnable operation

Now you just need define the main operation that you will run in Azure Quantum
hardware. To do it, you need to flag the operation with the `@EntryPoint` label
just before the operation. You can define here the inputs that will be
introduced through the Azure CLI as arguments of your operation.

> [!NOTE]
> Keep in mind that for Azure Quantum targets the output of the main operation needs to be a `Result`, either a single result (`Result`) or an array of results (`Result[]`).

The full code should be:

```qsharp
namespace AzureGrovers {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;

    @EntryPoint()
    operation GroversTest(nQubits : Int, idxMarked : Int) : Result[] {
        // Define the oracle that for the factoring problem.
        let markingOracle = markingNumber(idxMarked, _, _);
        let phaseOracle = ApplyMarkingOracleAsPhaseOracle(markingOracle, _);
        // Set the number of iterations of the algorithm
        let nIterations = NIterations(nQubits);

        // Initialize the register to run the algorithm
        using (qubits = Qubit[nQubits]){
                // Run the algorithm
                RunGroversSearch(qubits, phaseOracle, nIterations);
                // Obtain the results and reset the register
                return ForEach(MResetZ, qubits);
        }
    }

    function NIterations(nQubits : Int) : Int {
        let nItems = 1 <<< nQubits;
        let angle = ArcSin(1. / Sqrt(IntAsDouble(nItems)));
        let nIterations = Round(0.25 * PI() / angle - 0.5);
        return nIterations;
    }

    operation markingNumber (
        idxMarked : Int,
        inputQubits : Qubit [],
        target : Qubit
    ) : Unit is Adj+Ctl {
        (ControlledOnInt(idxMarked, X))(inputQubits, target);
    }

    operation ApplyMarkingOracleAsPhaseOracle(
        markingOracle : ((Qubit[], Qubit) => Unit is Adj), 
        register : Qubit[]
    ) : Unit is Adj {
        using (target = Qubit()) {
            within {
                X(target);
                H(target);
            } apply {
                markingOracle(register, target);
            }
        }
    }

    operation RunGroversSearch(register : Qubit[], phaseOracle : ((Qubit[]) => Unit is Adj), iterations : Int) : Unit {
        ApplyToEachCA(H, register);
        for (_ in 1 .. iterations) {
            phaseOracle(register);
            ReflectAboutUniform(register);
        }
    }

    operation ReflectAboutUniform(inputQubits : Qubit[]) : Unit {
        within {
            ApplyToEachCA(H, inputQubits);
            ApplyToEachCA(X, inputQubits);
        } apply {
            Controlled Z(Most(inputQubits), Tail(inputQubits));
        }
    }
    
}
```

## Submit your job to Azure Quantum

### Test the code in the simulator

### Run your code against hardware

