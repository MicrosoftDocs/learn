
In the previous unit, you learned the steps of the quantum teleportation protocol. Now it's your turn to help Alice and Bob implement their quantum teleportation experiment!

In this unit, you create a program in Q# that uses the quantum teleportation protocol to send the state of a message qubit from Alice to Bob. The program contains four operations that work together to perform the teleportation.

## Create a quantum teleportation program in Q#

To get started with your teleportation program, follow these steps:

1. Open Visual Studio Code (VS Code).
1. Open the **File** menu, and then choose **New Text File** to create a new file.
1. Save the file as **Main.qs**.

### Import the required libraries

To import the libraries that contain the Q# operations and functions that you need to write your program, copy the following code into your **Main.qs** file:

```qsharp
import Std.Diagnostics.*;
import Std.Intrinsic.*;
import Std.Measurement.*;
```

### Define the `Teleport` operation

Create an operation called `Teleport` that implements the quantum teleportation protocol. The operation takes two qubits as input: the `message` qubit that contains the teleported state and the `bob` qubit that receives the teleported state.

```qsharp
operation Teleport(message : Qubit, bob : Qubit) : Unit {
    // Allocate an alice qubit.
    use alice = Qubit();

    // Create some entanglement that we can use to send our message
    H(alice);
    CNOT(alice, bob);

    // Encode the message into the entangled pair
    CNOT(message, alice);

    // Transform the Bell states into computational states for measurement
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

    // Reset alice qubit before releasing
    Reset(alice);
}
```

Let's break down the steps in our `Teleport` operation:

1. Create an `alice` qubit. We now have the three qubits that we need to perform quantum teleportation: `alice`, `bob`, and `message`.
1. Entangle the `alice` and `bob` qubits. We do this in the usual way: apply a Hadamard gate to put the `alice` qubit into a superposition state.
1. Encode the `message` qubit into the entangled pair of `alice` and `bob` qubits. To do this, we apply a CNOT gate with `message` as the control qubit and `alice` as the target qubit. The `alice` and `message` qubit states are now in the Bell basis.
1. Transform the Bell states into computational states. We do this because, in Q#, we can't perform measurements directly on Bell states. Apply a Hadamard gate to the `message` qubit to transform the states into the computational basis. The following table relates the Bell states with their corresponding computational states:

    | Bell state     | Computational basis state |
    |----------------|---------------------------|
    | $\ket{\phi^+}$ | $\ket{00}$                |
    | $\ket{\phi^-}$ | $\ket{01}$                |
    | $\ket{\psi^+}$ | $\ket{10}$                |
    | $\ket{\psi^-}$ | $\ket{11}$                |

1. Measure the `alice` and `message` qubits, and apply the appropriate gates to the `bob` qubit based on the measurement results. First, use the `M` operation to measure `message`. If the result is 1, then apply the $Z$ gate to `bob`. Next, measure `alice` with the `M` operation. If the result is 1, then apply the $X$ gate to `bob`.

This protocol teleports the initial state of the `message` qubit onto the `bob` qubit.

### Define the `SetToPlus` and `SetToMinus` operations

In a real life teleportation protocol, the message qubit can be in any superposition state. Neither Alice nor Bob know the state of the message qubit. The state is teleported from the message qubit to Bob's qubit even though the state isn't known. But in Q#, we have to set the state of the message qubit ahead of the teleportation protocol.

To test our teleportation protocol with the message qubit in different initial states, such as |0⟩, |1⟩, |+⟩, and |−⟩, we create the `SetToPlus` and `SetToMinus` operations. These operations put the message qubit in the desired initial state before we teleport it.

Copy the following code for the `SetToPlus` and `SetToMinus` operations into your **Main.qs** file:

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

Every Q# program must have an entrypoint operation, which is the `Main` operation by default. Here, our `Main` operation runs the teleportation protocol for different initial states of the message qubit, $\ket{0}$, $\ket{1}$, $\ket{+}$, and $\ket{-}$. If the protocol is successful, then Bob's qubit ends up in the same state that we initially set the message qubit to.

Here's the `Main` operation for the quantum teleportation program:

```qsharp
operation Main() : Result[] {
    // Allocate the message and bob qubits
    use (message, bob) = (Qubit(), Qubit());

    // Use the `Teleport` operation to send different quantum states
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

Let's break down the components of the `Main` operation:

1. Allocate two qubits, `message` and `bob`.
1. Create a list of tuples that contain the quantum state, the operation that initializes the `message` qubit into the desired state, and the basis for measurement. The initialization operations are `I` for $\ket{0}$, `X` for $\ket{1}$, `SetToPlus` for $\ket{+}$, and `SetToMinus` for $\ket{-}$.
1. Iterate over the list of tuples to initialize the `message` qubit and display the initial state. Then, call the `Teleport` operation to teleport the state of the `message` qubit onto the `bob` qubit.
1. Measure the `bob` qubit in the corresponding basis and reset the qubits so that you can reuse them for teleportation.
1. Return the measurement results for each teleportation.

If the protocol works correctly, then your measurement results for `bob` match the initialized states for `message`.

### Run the program

Your quantum teleportation program is ready! Run the program to see how quantum teleportation works for different initial states of the message qubit.

The complete program contains the `Teleport` operation, the `SetToPlus` and `SetToMinus` operations, and the `Main` operation. To run your code and analyze the results, follow these steps:

1. Replace the contents of your **Main.qs** file with the following Q# code:

    ```qsharp
    /// This Q# program implements quantum teleportation
    import Std.Diagnostics.*;
    import Std.Intrinsic.*;
    import Std.Measurement.*;

    operation Main() : Result[] {
        // Allocate the message and bob qubits.
        use (message, bob) = (Qubit(), Qubit());

        // Use the `Teleport` operation to send different quantum states
        let stateInitializerBasisTuples = [
            ("|0〉", I, PauliZ),
            ("|1〉", X, PauliZ),
            ("|+〉", SetToPlus, PauliX),
            ("|-〉", SetToMinus, PauliX)
        ];

        mutable results = [];
        for (state, initializer, basis) in stateInitializerBasisTuples {
            // Initialize the message and show its state using the `DumpMachine`
            // function
            initializer(message);
            Message($"Teleporting state {state}");
            DumpMachine();

            // Teleport the message and show the quantum state after
            // teleportation
            Teleport(message, bob);
            Message($"Received state {state}");
            DumpMachine();

            // Measure bob in the corresponding basis and reset the qubits to
            // continue teleporting more messages
            let result = Measure([basis], [bob]);
            set results += [result];
            ResetAll([message, bob]);
        }

        return results;
    }

    /// # Summary
    /// Sends the state of a message qubit to a bob qubit by teleportation
    ///
    /// Notice that after calling Teleport, the state of `message` is collapsed
    ///
    /// # Input
    /// ## message: A qubit whose state we wish to send
    /// ## bob: A qubit initially in the |0〉 state that we want to send
    /// the state of message to
    operation Teleport(message : Qubit, bob : Qubit) : Unit {
        // Allocate an alice qubit.
        use alice = Qubit();

        // Create some entanglement that we can use to send our message
        H(alice);
        CNOT(alice, bob);

        // Encode the message into the entangled pair
        CNOT(message, alice);
        H(message);

        // Measure the qubits to extract the classical data we need to decode
        // the message by applying the corrections on the bob qubit
        // accordingly
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
    /// Sets a qubit in state |0⟩ to |+⟩
    operation SetToPlus(q : Qubit) : Unit is Adj + Ctl {
        H(q);
    }

    /// # Summary
    /// Sets a qubit in state |0⟩ to |−⟩
    operation SetToMinus(q : Qubit) : Unit is Adj + Ctl {
        X(q);
        H(q);
    }
    ```

1. To run your program on the built-in simulator, choose the **Run** code lens above the `Main` operation. Or, press **Ctrl + F5**. Your output appears in the debug console.
1. Check that the received states match the teleported states. For example:

    ```output
    Teleporting state |0〉

     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
      |00⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000

    Received state |0〉

     Basis | Amplitude      | Probability | Phase
     -----------------------------------------------
      |00⟩ |  1.0000+0.0000𝑖 |   100.0000% |   0.0000
    ```

Congratulations! You successfully teleported the state of Alice's qubit to Bob's qubit through the quantum teleportation protocol. All thanks to quantum entanglement!
