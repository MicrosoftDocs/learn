
In the previous unit, you reviewed the steps of the quantum teleportation protocol. Now it's your turn to help Alice and Bob with their quantum teleportation experiment! 

In this unit, you'll create a quantum teleportation program in Q# that uses the quantum teleportation protocol to send the state of a qubit from Alice to Bob. 

## Create a quantum teleportation program in Q#

1. Open Visual Studio Code.
1. Select **File > New Text File** and save it as **Main.qs**.
1. Select **View -> Command Palette** and type **Q#: Set the Azure Quantum QIR target profile**. Press **Enter**.
1. Select **Q#: Unrestricted**.

### Import the required libraries

First, you need to import the required libraries to use the Q# operations and functions. Copy and paste the following code into your **Main.qs** file.

```qsharp
import Microsoft.Quantum.Diagnostics.*; // Aka Std.Diagnostics.*;
import Microsoft.Quantum.Intrinsic.*; // Aka Std.Intrinsic.*;
import Microsoft.Quantum.Measurement.*; // Aka Std.Measurement.*;
```

### Define the `Teleport` operation

First, you need to define the `Teleport` operation that implements the quantum teleportation protocol. The operation takes two qubits as input: the `message` qubit that contains the quantum state to be teleported and the `bob` qubit that will receive the state. 

```qsharp
operation Teleport(message : Qubit, bob : Qubit) : Unit {
        // Allocate an alice qubit.
        use alice = Qubit();

        // Create some entanglement that we can use to send our message.
        H(alice);
        CNOT(alice, bob);

        // Encode the message into the entangled pair.
        CNOT(message, alice);
        H(message);

        // Measure the qubits to extract the classical data we need to decode
        // the message by applying the corrections on the bob qubit
        // accordingly.
        if M(message) == One {
            Z(bob);
        }
        if M(alice) == One {
            X(bob);
        }

        // Reset alice qubit before releasing.
        Reset(alice);
    }
```

Let's break down the `Teleport` operation:

1. The operation uses the `alice` qubit and creates entanglement between `alice` and `bob` qubits. The `message` qubit is then entangled with the `alice` qubit, so the two qubits are entangled with the `bob` qubit, and the `message` is encoded.
1. Then, you need to measure `alice` and `message` qubits in the Bell basis. How can you express a measurement in the Bell basis in Q#? You can't. Or at least not directly. In Q# you have the `M` operation, which performs a measurement in the $Z$-basis or computational basis. So to use the `M` operation correctly, you need to transform the Bell states into the computational basis states. You can do this by applying a `H` operation to the `message` qubit. The following table shows the correspondence between the Bell states and the computational basis states.

    | Bell state | Computational basis state |
    |------------|---------------------------|
    | $\ket{\phi^+}$ | $\ket{00}$ |
    | $\ket{\phi^-}$ | $\ket{01}$ |
    | $\ket{\psi^+}$ | $\ket{10}$ |
    | $\ket{\psi^-}$ | $\ket{11}$ |

    > [!TIP]
    > A good exercise is to verify the equivalence of the Bell states and the computational basis states after applying the Hadamard operation to the first qubit. Good luck!

1. Finally, the `if` statements check the measurement results and apply corrections to the `bob` qubit accordingly. If the `message` qubit is measured in `One`, you apply the Z gate to the `bob` qubit. If the `alice` qubit is also measured in `One` you apply the X gate to the `bob` qubit. 

### Define the `SetToPlus` and `SetToMinus` operations

In case you'd like to teleport qubits in different states, such as |0⟩, |1⟩, |+⟩, and |−⟩, you have to define the initialized states. You already have the `Teleport` operation to teleport the qubit, but you need to prepare the qubit in the correct state before teleporting it.

You need to define two more operations, `SetToPlus` and `SetToMinus`, to set a qubit in state |0⟩ to |+⟩ and |−⟩, respectively.

```qsharp
    /// Sets a qubit in state |0⟩ to |+⟩.
    operation SetToPlus(q : Qubit) : Unit is Adj + Ctl {
        H(q);
    }

    /// Sets a qubit in state |0⟩ to |−⟩.
    operation SetToMinus(q : Qubit) : Unit is Adj + Ctl {
        X(q);
        H(q);
    }
```

### Define the `Main` operation

Every Q# program must have a `Main` operation that serves as the entry point for the program. The `Main` operation runs the teleportation protocol for different quantum states, $\ket{0}$, $\ket{1}$, $\ket{+}$, and $\ket{-}$. 

Let's break down the `Main` operation:

1. The operation allocates two qubits, `message` and `bob`.
1. It defines a list of tuples that contain the quantum state, the initializer operation needed to initialize the qubit in such state, and the basis for the teleportation. The initializer operations are `I` for $\ket{0}$, `X` for $\ket{1}$, `SetToPlus` for $\ket{+}$, and `SetToMinus` for $\ket{-}$. The `SetToPlus` and `SetToMinus` operations are defined in the previous steps.
1. The operation iterates over the list of tuples and initializes the `message` qubit in the corresponding state and uses `DumpMachine` to display the state. It then teleports the state of the `message` qubit to the `bob` qubit using the `Teleport` operation defined in the previous steps.
1. After teleporting the state, the operation measures the `bob` qubit in the corresponding basis and resets the qubits to continue teleporting more messages.
1. Finally, the operation returns the measurement results for each teleportation.

```qsharp
operation Main() : Result[] {
    // Allocate the message and bob qubits.
    use (message, bob) = (Qubit(), Qubit());

    // Use the `Teleport` operation to send different quantum states.
    let stateInitializerBasisTuples = [
        ("|0〉", I, PauliZ),
        ("|1〉", X, PauliZ),
        ("|+〉", SetToPlus, PauliX),
        ("|-〉", SetToMinus, PauliX)
    ];

    mutable results = [];
    for (state, initializer, basis) in stateInitializerBasisTuples {
        // Initialize the message and show its state using the `DumpMachine`
        // function.
        initializer(message);
        Message($"Teleporting state {state}");
        DumpMachine();

        // Teleport the message and show the quantum state after
        // teleportation.
        Teleport(message, bob);
        Message($"Received state {state}");
        DumpMachine();

        // Measure bob in the corresponding basis and reset the qubits to
        // continue teleporting more messages.
        let result = Measure([basis], [bob]);
        set results += [result];
        ResetAll([message, bob]);
    }

    return results;
}
```

### Run the program

Your quantum teleportation program is ready! You can run the program to see how quantum teleportation works for different quantum states. The program initializes the `message` qubit in different states and teleports the state to the `bob` qubit.

The following code contains the `Teleport` operation, the `SetToPlus` and `SetToMinus` operations, and the `Main` operation that runs the teleportation protocol for different quantum states.

1. Your **Main.qs** file should look like this:

    ```qsharp
    /// This Q# program implements quantum teleportation.
    import Microsoft.Quantum.Diagnostics.*;
    import Microsoft.Quantum.Intrinsic.*;
    import Microsoft.Quantum.Measurement.*;

    operation Main() : Result[] {
        // Allocate the message and bob qubits.
        use (message, bob) = (Qubit(), Qubit());

        // Use the `Teleport` operation to send different quantum states.
        let stateInitializerBasisTuples = [
            ("|0〉", I, PauliZ),
            ("|1〉", X, PauliZ),
            ("|+〉", SetToPlus, PauliX),
            ("|-〉", SetToMinus, PauliX)
        ];

        mutable results = [];
        for (state, initializer, basis) in stateInitializerBasisTuples {
            // Initialize the message and show its state using the `DumpMachine`
            // function.
            initializer(message);
            Message($"Teleporting state {state}");
            DumpMachine();

            // Teleport the message and show the quantum state after
            // teleportation.
            Teleport(message, bob);
            Message($"Received state {state}");
            DumpMachine();

            // Measure bob in the corresponding basis and reset the qubits to
            // continue teleporting more messages.
            let result = Measure([basis], [bob]);
            set results += [result];
            ResetAll([message, bob]);
        }

        return results;
    }

    /// # Summary
    /// Sends the state of one qubit to a bob qubit by using teleportation.
    ///
    /// Notice that after calling Teleport, the state of `message` is collapsed.
    ///
    /// # Input
    /// ## message
    /// A qubit whose state we wish to send.
    /// ## bob
    /// A qubit initially in the |0〉 state that we want to send
    /// the state of message to.
    operation Teleport(message : Qubit, bob : Qubit) : Unit {
        // Allocate an alice qubit.
        use alice = Qubit();

        // Create some entanglement that we can use to send our message.
        H(alice);
        CNOT(alice, bob);

        // Encode the message into the entangled pair.
        CNOT(message, alice);
        H(message);

        // Measure the qubits to extract the classical data we need to decode
        // the message by applying the corrections on the bob qubit
        // accordingly.
        if M(message) == One {
            Z(bob);
        }
        if M(alice) == One {
            X(bob);
        }

        // Reset alice qubit before releasing.
        Reset(alice);
    }

    /// # Summary
    /// Sets a qubit in state |0⟩ to |+⟩.
    operation SetToPlus(q : Qubit) : Unit is Adj + Ctl {
        H(q);
    }

    /// # Summary
    /// Sets a qubit in state |0⟩ to |−⟩.
    operation SetToMinus(q : Qubit) : Unit is Adj + Ctl {
        X(q);
        H(q);
    }
    ```

1. To run your program on the built-in simulator, click on **Run** above the `Main` operation or press **Ctrl+F5**. Your output will appear in the debug console.
1. Check that the received states match the teleporting states. For example: 

    ```output
    Teleporting state |0〉
    
    DumpMachine:
    
     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
      |00⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000
    
    Received state |0〉
    ```

Congratulations! You successfully teleport the state of Alice's qubit to Bob's qubit using the quantum teleportation protocol. All thanks to quantum entanglement! 

In the next unit, you'll test your knowledge of quantum teleportation and entanglement.