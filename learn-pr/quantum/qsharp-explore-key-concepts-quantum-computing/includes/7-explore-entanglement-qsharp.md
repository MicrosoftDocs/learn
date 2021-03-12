Now you'll create quantum entanglement in Q#. You'll also
estimate the resources that you need to run our algorithms. To estimate resources, you'll use the 
`ResourcesEstimator` tool that the Quantum Development Kit (QDK) provides.

## Create the project

Start by creating a Q# project like you did previously in this module: 

1. On the **View** menu, select **Command Palette**.
1. Enter *Q#: Create New Project*.
1. Select **Standalone console application**.
1. Select a directory to hold your project. For example, use your home directory. Enter *ExploringEntanglement* as the project name. Then select **Create Project**.
1. In the window that appears below, select **Open new project**.

Like before, you see two files: the project file and *Program.qs*, which contains starter code.

## Create entanglement in Q\#

Until now, you've used only single-qubit operations. These operations act
on single qubits individually. To entangle qubits, you need
*multiqubit gates*.

The most prominent example of a multiqubit gate is the
[`CNOT`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.cnot?azure-portal=true)
operation. This operation takes two qubits as input. Then it flips the state of the
second qubit (the target qubit) if, and only if, the state of the first qubit (the control
qubit) is $|1\rangle$. With the help of the `H` operation and the `CNOT` operation, you can
transform a register in the state $|00\rangle$ to the entangled state
$\frac1{\sqrt2}(|00\rangle+|11\rangle)$.

Here's how it works:

1. Prepare a superposition in the control qubit by applying $H$.

   $$H |0_c\rangle= \frac{1}{\sqrt{2}}(|0_c\rangle+|1_c\rangle)$$
   
   > [!NOTE]
   > We use the subscripts ${}_c$ and ${}_t$ to specify the control and target qubits for the $CNOT$ operator.
   > By convention, the first qubit always refers to the control qubit. The second qubit always refers to the target qubit.

1. Apply the $CNOT$ operator to the joint state of both the control qubit in superposition and
the target qubit in the state $|0_t\rangle$.

   $$CNOT \frac{1}{\sqrt2}(|0_c0_t\rangle+|1_c0_t\rangle)=\frac{1}{\sqrt2}(CNOT|0_c0_t\rangle+CNOT|1_c0_t\rangle)= \frac{1}{\sqrt2}(|0_c0_t\rangle+|1_c1_t\rangle)$$

To implement this pattern in Q#:

1. Modify *Program.qs* like the following example. Then save the file.

   :::code language="qsharp" source="code/7-program-1.qs" highlight="11":::

1. Open the integrated terminal. On the **Terminal** menu, select **New Terminal**.

1. In the terminal, run `dotnet run`:

   ```dotnetcli
   dotnet run
   ```

Your output looks something like this:

```output
Entangled state before measurement:
# wave function for qubits with ids (least to most significant): 0;1
|0⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]
|1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|2⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|3⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]

State after measurement:
# wave function for qubits with ids (least to most significant): 0;1
|0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|2⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|3⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
[One,One]
```

You obtained the same outcome for both qubits, as you might
expect if the state were entangled. But to thoroughly check for entanglement, you must
run this code multiple times to make sure that the result wasn't just luck. Run the
code several times to see if the results are consistent.
   
The state $\frac1{\sqrt2}(|00\rangle+|11\rangle)$ isn't the only entangled state
you can obtain by applying the operators $H$ and $CNOT$ sequentially. For example,
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

1. Modify *Program.qs* like the following code. Then save the file.

   :::code language="qsharp" source="code/7-program-2.qs":::

1. In the terminal, run `dotnet run`:

   ```dotnetcli
   dotnet run
   ```

Your program should behave exactly like the program you created in the
previous example, because the operations are equivalent.



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
> about these functors and many other Q# features, see the [Q# user
> guide](/quantum/user-guide/).

## Estimate resources by using Q\#

The QDK provides a built-in tool that allows you to estimate the
resources that a quantum computer requires to run a given Q# code. The tool is called
[`ResourcesEstimator`](https://docs.microsoft.com/quantum/user-guide/machines/resources-estimator?azure-portal=true).
It "runs" the quantum operation without actually simulating the state of a quantum
computer. For this reason, it can estimate resources for Q# operations that use
thousands of qubits, if the classical part of the code can be run in a
reasonable time frame. 

To use `ResourcesEstimator`:

1. Run your program from the command line, and select `ResourcesEstimator` as
   your simulator.

   ```dotnetcli
   dotnet run --simulator ResourcesEstimator
   ```

   You can use `ResourcesEstimator` without changing your Q#
   code.

2. Review the printed list of the quantum resources that are required to execute the code.

For example, if you run the program by using the preceding Q# code block, you get this output:

```output
Metric          Sum    Max
CNOT            1       1
QubitClifford   1       1
R               0       0
Measure         2       2
T               0       0
Depth           0       0
Width           2       2
BorrowedWidth   0       0
```

> [!NOTE] 
> The output includes two columns. For the moment, you don't need to
> worry about how the columns differ, because both columns display the same content. They might
> not be identical for some advanced applications of the QDK that are out of scope for
> this module.

In this example, the program contains only one operation. The output shows that the following resources are needed to
obtain the qubits results:
- 1 CNOT gate
- 1 Clifford gate to apply `H`
- 2 measurements 

The width of the circuit is the number of qubits that are
needed to run a program. In the output, the width is 2 because you used only two qubits.

For this example, you could easily know how many resources you needed
without using `ResourcesEstimator`. But Q# is a high-level
programming language. It's virtually impossible to know
directly how many resources most programs need. You'll find 
`ResourcesEstimator` to be a useful tool as you advance 
as a Q# quantum developer.

>[!NOTE]
> Clifford gates are a basic kind of quantum operation. They help you
> estimate how many resources you need to perform a quantum
> computation. Both $H$ and $CNOT$ are examples of Clifford operations. The
> `QubitClifford` row includes only single-qubit Clifford operations. 
>
>For more information,
> see the Wikipedia page about [Clifford
> gates](https://en.wikipedia.org/wiki/Clifford_gates).

For more information about `ResourcesEstimator`, about each of
the parameters in the output, and about other estimation tools, 
see [QDK resources estimator](https://docs.microsoft.com/quantum/user-guide/machines/resources-estimator?azure-portal=true).

In the next part, you'll explore two quantum algorithms that use superposition, interference, and entanglement to outperform classical computers.
