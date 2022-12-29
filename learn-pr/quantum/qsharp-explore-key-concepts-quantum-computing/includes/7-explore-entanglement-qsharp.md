Now you'll create quantum entanglement in Q#. This time, instead of writing and running your program locally, you'll write a Q# program using an online Jupyter notebook in your Azure Quantum workspace. 

A [Jupyter](https://jupyter.org/) notebook is a document that contains both rich text and code and can run in your browser, and can run Q# and Python code in Azure Quantum.  Notebooks can be created directly in the Azure Quantum portal and offer features such as preloaded connection information and standard Q# libraries. 

If you don´t have an Azure Quantum workspace yet, check the [Get started with Azure Quantum](/training/modules/get-started-azure-quantum/?azure-portal=true) module.

## Create a new Notebook in your workspace

1. Sign in to the [Azure portal](https://portal.azure.com/) and select the workspace you created in the previous step.
1. In the left blade, select **Notebooks**.
1. Select **My Notebooks** and select **Add New**.
1. In **Kernel Type**, select **IQ#**.
1. Type a name for the file, for example *Entanglement.ipynb*, and select **Create file**.

When your new Notebook opens, it automatically creates the code for the first cell, based on your subscription and workspace information.

```dotnetcli
%azure.connect "/subscriptions/\<subscription ID>/\<resource group>/providers/Microsoft.Quantum/Workspaces/\<workspace>" \<location>
```

> [!NOTE]
> *%azure.connect* is an IQ# Magic command, a set of commands that help streamline tasks in Jupyter Notebooks.

If you run this cell, it should authenticate to your subscription and display a list of available providers and their targets. 

## Initialize a qubit using measurement

The first step is to define a Q# operation that  initializes a qubit to a known state. You call this to set a qubit to a *classical* state, meaning it either returns `Zero` 100% of the time or returns `One` 100% of the time. `Zero` and `One` are Q# values that represent the only two possible results of a measurement of a qubit.

Select **+Code** to add a new cell and add the following code:

```qsharp
operation SetQubitState(desired : Result, target : Qubit) : Unit {
    if desired != M(target) {
        X(target);
    }
}
```

> [!NOTE]
> The `Microsoft.Quantum.Intrinsic` and `Microsoft.Quantum.Canon` namespaces, which are used by operations in this code, are automatically opened in every cell of an Azure Quantum notebook.

The code example introduces two standard operations, `M` and `X`, which transform the state of a qubit. 

The  `SetQubitState` operation:

1. Takes two parameters: a type `Result`, named `desired`, that represents the desired state for the qubit to be in (0 or 1), and a type `Qubit`. 
1. Performs a measurement operation, `M`, which measures the state of the qubit (`Zero` or `One`) and compares the result to the value specified in `desired`.
1. If the measurement doesn't match the compared value, it runs an `X` operation, which flips the state of the qubit to where the probabilities of a measurement returning `Zero` and `One` are reversed. This way, `SetQubitState` always puts the target qubit in the desired state. 

## Test the measurement

Next, to demonstrate the effect of the `SetQubitState` operation, create another operation named `TestBellState`. 

Add another new cell and add the following code:

```qsharp
operation TestBellState(count : Int, initial : Result) : (Int, Int, Int, Int) {
    mutable numOnesQ1 = 0;
    mutable numOnesQ2 = 0;

    // allocate the qubits
    use (q1, q2) = (Qubit(), Qubit());   
    for test in 1..count {
        SetQubitState(initial, q1);
        SetQubitState(Zero, q2);
        
        // measure each qubit
        let resultQ1 = M(q1);            
        let resultQ2 = M(q2);           

        // Count the number of 'Ones':
        if resultQ1 == One {
            set numOnesQ1 += 1;
        }
        if resultQ2 == One {
            set numOnesQ2 += 1;
        }
    }

    // reset the qubits
    SetQubitState(Zero, q1);             
    SetQubitState(Zero, q2);
    

    // Return number of |0> states, number of |1> states
    Message("q1:Zero, One  q2:Zero, One");
    return (count - numOnesQ1, numOnesQ1, count - numOnesQ2, numOnesQ2 );

}
```

The `TestBellState`operation:

1. Takes two parameters: `count`, the number of times to run a measurement, and `initial`, the desired state to initialize the qubit. 
1. Calls the `use` statement to initialize two qubits.
1. Loops for `count` iterations. For each loop, it
    1. Calls `SetQubitState` to set a specified `initial` value on the first qubit.
    1. Calls `SetQubitState` again to set the second qubit to a `Zero` state. 
    1. Uses the `M` operation to measure each qubit.
    1. Stores the number of measurements for each qubit that return `One`.
1. After the loop completes, it calls `SetQubitState` again to reset the qubits to a known state (`Zero`) to allow others to
allocate the qubits in a known state. This is required by the `use` statement. 
1. Finally, it uses the `Message` function to display a message to the console before returning the results.

### Test the code

Before moving on to the procedures for superposition and entanglement, test the code up to this point to see the initialization and measurement of the qubits. 

To run the `TestBellState` operation, you use the `%simulate` magic command to call the Azure Quantum full-state simulator. You need to specify the `count` and `initial` arguments, for example, `count=1000` and `initial=1`. This initializes the first qubit to `One` and measures each qubit 1000 times. Add a new cell with the following command and select **Run all**:

```dotnetcli
%simulate TestBellState count=1000 initial=1
```

and you should observe the following output:

```output
q1:Zero, One  q2:Zero, One
(0, 1000, 1000, 0)
```

Because the qubits haven't been manipulated yet, they've retained their initial values: the first qubit returns `One` every time, and the second qubit returns `Zero`.

If you run the cell again with `initial=0`, you should observe that the first qubit also returns `Zero` every time.

```dotnetcli
%simulate TestBellState count=1000 initial=0
```

```output
q1:Zero, One q2:Zero, One
(1000, 0, 1000, 0)
```

## Put a qubit in superposition in Q\#

Currently, the qubits in the program are all in a *classical* state, that is, they're either 1 or 0. You know this because the program initializes the qubits to a known state, and you haven't added any processes to manipulate them.  Before entangling the qubits, you'll put the first qubit into a *superposition* state, where a measurement of the qubit will return `Zero` 50% of the time and `One` 50% of the time. Conceptually, the qubit can be thought of as being in a linear combination of all states between the `Zero` and `One`.

To put a qubit in superposition, Q# provides the `H`, or *Hadamard*, operation. Recall the `X` operation from the [Initialize a qubit using measurement](#initialize-a-qubit-using-measurement) procedure earlier, which flipped a qubit from 0 to 1 (or vice versa); the `H` operation flips the qubit *halfway* into a state of equal probabilities of 0 or 1. When measured, a qubit in superposition should return roughly an equal number of `Zero` and `One` results.

In the previous cell with the `TestBellState`, add the `H` operation inside the `for` loop:

```qsharp
    for test in 1..count {
        use (q1, q2) = (Qubit(), Qubit());   
        for test in 1..count {
            SetQubitState(initial, q1);
            SetQubitState(Zero, q2);
            
            H(q1);                // Add the H operation after initialization and before measurement

            // measure each qubit
            let resultQ1 = M(q1);            
            let resultQ2 = M(q2); 
```

Initialize the qubit to 1 again in the `%simulate` command and select **Run all**, and you can see the results of the first qubit in superposition:

```dotnetcli
%simulate TestBellState count=1000 initial=1
```

```output
q1:Zero, One  q2:Zero, One
(523, 477, 1000, 0)      // results will vary
```

Every time you run the program, the results for the first qubit will vary slightly, but will be close to 50% `One` and 50% `Zero`, while the results for the second qubit will remain `Zero` all the time.

```output
Q1:Zero/One  Q2:Zero/One
(510, 490, 1000, 0)
```

Initializing the first qubit to `Zero` returns similar results.

```dotnetcli
%simulate TestBellState count=1000 initial=0
```

```output
Q1:Zero/One  Q2:Zero/One
(504, 496, 1000, 0)
```

## Create entanglement between two qubits in Q\#

Until now, you've used only single-qubit operations. These operations act
on single qubits individually. To entangle qubits, you need
*multiqubit gates*.

The most prominent example of a multiqubit gate is the `CNOT` operation, which stands for *Controlled-NOT*. This operation takes two qubits as input. Then it flips the state of the second qubit (the target qubit) if, and only if, the state of the first qubit (the control qubit) is $|1\rangle$. With the help of the `H` operation and the `CNOT` operation, you can transform a register in the state $|00\rangle$ to the entangled state $\frac1{\sqrt2}(|00\rangle+|11\rangle)$.

Here's how it works:

1. Prepare a superposition in the control qubit by applying $H$.

   $$H |0_c\rangle= \frac{1}{\sqrt{2}}(|0_c\rangle+|1_c\rangle)$$
   
   > [!NOTE]
   > We use the subscripts ${}_c$ and ${}_t$ to specify the control and target qubits for the $CNOT$ operator.
   > By convention, the first qubit always refers to the control qubit. The second qubit always refers to the target qubit.

1. Apply the $CNOT$ operator to the joint state of both the control qubit in superposition and
the target qubit in the state $|0_t\rangle$.

   $$CNOT \frac{1}{\sqrt2}(|0_c0_t\rangle+|1_c0_t\rangle)=\frac{1}{\sqrt2}(CNOT|0_c0_t\rangle+CNOT|1_c0_t\rangle)= \frac{1}{\sqrt2}(|0_c0_t\rangle+|1_c1_t\rangle)$$


To enable entanglement, Q# provides the `CNOT` operation. The result of running this operation on two qubits is to flip the second qubit if the first qubit is `One`.

Add the `CNOT` operation to the `for` loop immediately after the `H` operation. The `TestBellState` operation should now look like this:

```qsharp
operation TestBellState(count : Int, initial : Result) : (Int, Int, Int, Int) {
    mutable numOnesQ1 = 0;
    mutable numOnesQ2 = 0;

    // allocate the qubits
    use (q1, q2) = (Qubit(), Qubit());   
    for test in 1..count {
        SetQubitState(initial, q1);
        SetQubitState(Zero, q2);

        H(q1);
        CNOT(q1, q2);                   // added CNOT operation
        
        // measure each qubit
        let resultQ1 = M(q1);            
        let resultQ2 = M(q2);           

        // Count the number of 'Ones':
        if resultQ1 == One {
            set numOnesQ1 += 1;
        }
        if resultQ2 == One {
            set numOnesQ2 += 1;
        }
    }

    // reset the qubits
    SetQubitState(Zero, q1);             
    SetQubitState(Zero, q2);
    

    // Return number of |0> states, number of |1> states
    Message("q1:Zero, One  q2:Zero, One");
    return (count - numOnesQ1, numOnesQ1, count - numOnesQ2, numOnesQ2 );

}

```

Select **Run all** to run the updated operation and you should see:

```output
Q1:Zero/One  Q2:Zero/One
(502, 498, 502, 498)      // actual results will vary
```

The statistics for the first qubit haven't changed (a 50/50 chance of a `Zero` or a `One` after measurement), but the measurement results for the second qubit are **always** the same as the measurement of the first qubit, regardless of what the qubit is initialized to. The `CNOT` operation has entangled the two qubits, so that whatever happens to one of them, happens to the other. 

> [!NOTE]
> To thoroughly check for entanglement, you must run this code multiple times to make sure that the result wasn't just luck. Click **Run all** to run the code several times to see if the results are consistent.
   
The state $\frac1{\sqrt2}(|00\rangle+|11\rangle)$ isn't the only entangled state you can obtain by applying the operators $H$ and $CNOT$ sequentially. For example,
you can obtain the state $\frac1{\sqrt2}(|01\rangle+|10\rangle)$ if your initial
state is $|01\rangle$. 

The following table summarizes the four possibilities.

| Initial state  | After applying $H$ to the control qubit        | After applying $CNOT$                           |
|----------------|------------------------------------------------|-------------------------------------------------|
| $\|0_c0_t\rangle$ | $\frac{1}{\sqrt{2}}(\|0_c0_t\rangle+\|1_c0_t\rangle)$ | $\frac{1}{\sqrt{2}}(\|0_c0_t\rangle+\|1_c1_t\rangle)$ |
| $\|0_c1_t\rangle$ | $\frac{1}{\sqrt{2}}(\|0_c1_t\rangle+\|1_c1_t\rangle)$ | $\frac{1}{\sqrt{2}}(\|0_c1_t\rangle+\|1_c0_t\rangle)$ |
| $\|1_c0_t\rangle$ | $\frac{1}{\sqrt{2}}(\|0_c0_t\rangle-\|1_c0_t\rangle)$ | $\frac{1}{\sqrt{2}}(\|0_c0_t\rangle-\|1_c1_t\rangle)$ |
| $\|1_c1_t\rangle$ | $\frac{1}{\sqrt{2}}(\|0_c1_t\rangle-\|1_c1_t\rangle)$ | $\frac{1}{\sqrt{2}}(\|0_c1_t\rangle-\|1_c0_t\rangle)$ |
   

### Controlled operations

In Q#, you can use the `Controlled` *functor* to transform any operation to a
controlled operation. For example, you can express the operation `CNOT(control, target)` 
as `Controlled X([control], target)`. In general, you can put any
operation in the place of `X`. For example, `Controlled Y([control], target)`
applies the `Y` gate, conditioned on the state of the control qubit.

Q# is a versatile language. You can choose various ways to achieve the
same result. Now you're going to replicate the code by using `Controlled X` instead of
`CNOT`.

1. Add a new cell and replace the `CNOT(q1, q2)` operation with the `Controlled X([q1], q2)` operation. Your program should look like this:

   ```qsharp
   operation TestBellState(count : Int, initial : Result) : (Int, Int, Int, Int) {
       mutable numOnesQ1 = 0;
       mutable numOnesQ2 = 0;

       // allocate the qubits
       use (q1, q2) = (Qubit(), Qubit());   
       for test in 1..count {
           SetQubitState(initial, q1);
           SetQubitState(Zero, q2);

           H(q1);
           Controlled X([q1], q2);                   // added CONTROLLED-X operation

           // measure each qubit
           let resultQ1 = M(q1);            
           let resultQ2 = M(q2);           

           // Count the number of 'Ones':
           if resultQ1 == One {
               set numOnesQ1 += 1;
           }
           if resultQ2 == One {
               set numOnesQ2 += 1;
           }
       }

       // reset the qubits
       SetQubitState(Zero, q1);             
       SetQubitState(Zero, q2);


       // Return number of |0> states, number of |1> states
       Message("q1:Zero, One  q2:Zero, One");
       return (count - numOnesQ1, numOnesQ1, count - numOnesQ2, numOnesQ2 );

   }

   ```

1. Select **Run all** to run the updated operation and you should see:

   ```output
   Q1:Zero/One  Q2:Zero/One
   (502, 498, 502, 498)      // actual results will vary
   ```


Your program should behave exactly like the program you created in the previous example, because the operations are equivalent.


> [!NOTE]
> A functor in Q# is a map from the implementations of operations to new
> operations. For example, by adding the keyword `Controlled` in front of an
> operation `Operation1`, you define a new operation `Controlled Operation1`. 
>
> Q# has only two functors: 
> - `Controlled`, which creates controlled versions of
> the operations 
> - `Adjoint`, which creates the adjoint version of the operations 
>
> For more information
> about these functors and many other Q# features, see the [Q# user guide](/quantum/user-guide/).



In the next part, you'll explore two quantum algorithms that use superposition, interference, and entanglement to outperform classical computers.
