Now that you understand some of the basics, it's your turn to build a quantum random number generator (RNG).

The quantum RNG uses a Hadamard operation to put a qubit into superposition. The measurement results in a zero or a one. But how can we use this behavior to generate larger numbers?

Let's say you repeat the process four times, generating this sequence of binary digits:

$${0, 1, 1, 0}$$

If you concatenate, or combine, these bits into a bit string, you can form a larger number. In this example, the bit sequence ${0110}$ is equivalent to six in decimal.

$${0110_{\ binary} \equiv 6_{\ decimal}}$$

You'll build out your quantum RNG in two phases. In this part, you build out the first phase, which is to generate a single random bit.

To do so, you:

> [!div class="checklist"]
> * Create a Q# project.
> * Add code that uses the Hadamard operation to put a qubit into superposition and read its value.
> * Run the program.

In the next part, you build out the second phase, which combines bits to form a larger number.

## Create the Q# project

Here, you create a Q# project just like you did earlier.

1. On the **View** menu, select **Command Palette**.
1. Enter **Q#: Create New Project**.
1. Select **Standalone console application**.
1. Select a directory to hold your project, such as your home directory. Enter *quantum-rng* as the project name, then select **Create Project**.
1. From the window that appears at the bottom, select **Open new project**.

    Like before, you see two files: the project file and *Program.qs*, which contains starter code.

## Include the Measurement library

To measure a qubit, you use the [M](/qsharp/api/qsharp/microsoft.quantum.intrinsic.m?azure-portal=true) operation. After you measure a qubit, you need to use the [Reset](/qsharp/api/qsharp/microsoft.quantum.intrinsic.reset?azure-portal) operation to place the qubit back in the zero state. The `Microsoft.Quantum.Intrinsic` library provides both of these these operations.

To simplify the process, you can use the [MResetZ](/qsharp/api/qsharp/microsoft.quantum.measurement.mresetz) operation. This operation combines `M` and `Reset` as one operation.

The `Microsoft.Quantum.Measurement` library provides the `MResetZ` operation. Let's ensure that library is referenced now.

1. In Visual Studio, open *Program.qs*.
1. Near the top of the file, add this `open` directive:

    TODO: open Microsoft.Quantum.Measurement;

## TODO: Create the quantum operation

Recall that in the *quantum-hello* program, you defined the `HelloQ` operation like this:

```qsharp
operation HelloQ() : Unit {
    Message("Hello quantum world!");
}
```

Here, you define the `GenerateRandomBit` operation. This operation takes no input and produces a value of type `Result`. The `Result` type represents the result of a measurement and can have two possible values: `Zero` and `One`.

TODO: Remember to put this in a file and highlight. Update NS.

To define the operation:

1. Replace the contents of *Program.qs* with this:

    ```qsharp
    namespace Qrng {
        open Microsoft.Quantum.Intrinsic;
        open Microsoft.Quantum.Canon;
        open Microsoft.Quantum.Measurement;
    
    
        @EntryPoint()
        operation GenerateRandomBit() : Result {
        }
    }
    ```

    Recall that `@EntryPoint` tells the Q# compiler that this is where to begin execution of the program.

1. Add this code to the `GenerateRandomBit` operation:

    TODO:

    ```qsharp
    namespace Qrng {
        open Microsoft.Quantum.Intrinsic;
        open Microsoft.Quantum.Canon;
        open Microsoft.Quantum.Measurement;
    
    
        @EntryPoint()
        operation GenerateRandomBit() : Result {
            using (q = Qubit())  {  // Allocate a qubit.
                H(q);               // Put the qubit to superposition. It now has a 50% chance of being measured 0 or 1.
                return MResetZ(q);  // Measure the qubit value.
            }
        }
    }
    ```

    TODO: The `using` directive XXX.
    H ...
    MResetZ ... and returns

    1. In Q#, to obtain a qubit we need to "ask" the computer for them with the
       block `using` in which we specify how many qubits we need and its name. In
       our case we just need one qubit. Every qubit we borrow with the command
       `using` starts by default in the `0` state.
    2. We can put our qubit in a quantum superposition by applying the `H()`
       operation from the Intrinsic library. We only need to specify the target
       qubit inside the brackets.
    3. After throwing our qubit in a quantum superposition we can measure the state.
       In Q#, at the end of every operation, we need to make sure that any used
       qubit is initialized back to the state `0`. We can do both operations with an
       `MResetZ` operation from the Intrinsic library. Alternatively, you can use an
       `M()`  operation followed by a `Reset()` operation from the Intrinsic
       library.
    4. We return the result of our measurement, which is a random bit.

## Run the program

TODO: Let's try it out!

1. In Visual Studio Code, go to the terminal. If you closed it, from the **View** menu, select **Terminal** or **Integrated Terminal**.
1. Run `dotnet run`.

    ```bash
    dotnet run
    ```
1. TODO: YOU SEE:

    ```output
    Hello quantum world!
    ```
1. Run the program again. This time, you can skip the build phase by using the `--no-build` flag.

    ```bash
    dotnet run --no-build
    ```

    TODO: YOU SEE:

    ```output
    Hello quantum world!
    ```

Next, you'll implement the second phase of your quantum RNG: combining multiple random bits to form a larger number. Leave your project open in Visual Studio Code for the next part.