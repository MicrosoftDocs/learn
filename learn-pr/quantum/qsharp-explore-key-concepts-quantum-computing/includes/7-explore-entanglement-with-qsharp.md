Now you're going to create quantum entanglement with Q#. You're also going to
estimate the resources you need to run our algorithms with the tool
`ResourcesEstimator` provided by the Quantum Development Kit.

## Create the project

Start by creating a Q# project like you did previously in this module. To do so:

1. On the **View** menu, select **Command Palette**.
1. Enter **Q#: Create New Project**.
1. Select **Standalone console application**.
1. Select a directory to hold your project, such as your home directory. Enter *ExploringEntanglement* as the project name, then select **Create Project**.
1. From the window that appears at the bottom, select **Open new project**.

Like before, you see two files: the project file and *Program.qs*, which contains starter code.

## Create entanglement with Q\#

Until now, you used only single qubit operations, this is, operations that act
over single qubits individually. However, to get qubits entangled you need
what is called **multi-qubit gates**.

The most prominent example of a multi-qubit gate is the
[`CNOT`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.cnot?azure-portal=true)
operation. This operation takes two qubits as input, and flips the state of the
second qubit (target qubit) if and only if the state of the first qubit (control
qubit) is $\ket{1}$. With the help of the `H` operation and the `CNOT`, you can
transform a register in the state $\ket{00}$ to the entangled state
$\frac1{\sqrt2}(\ket{00}+\ket{11})$. You can see how:

$$CNOT(\hat H\ket{0}),\ket{0})=CNOT(\frac1{\sqrt2}(\ket{0}+\ket{1}),\ket{0})=
\frac1{\sqrt2}(CNOT(\ket{0},\ket{0})+CNOT(\ket{1},\ket{0}))=\frac1{\sqrt2}(\ket{00}+\ket{11}).$$

To implement this in Q#:

1. Modify *Program.qs* like this and then save the file:

   :::code language="qsharp" source="code/7-program-1.qs":::

1. Open the integrated terminal. From the **Terminal** menu, select **New Terminal**.

1. From the terminal, run `dotnet run`:

   ```bash
      dotnet run
   ```

   Your output will be something like this:

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

   You can see how you obtained the same outcome for both qubits, as you might
   expect if the state were entangled. However, check entanglement you must
   run this code multiple times to see that it wasn't just luck. Try to run the
   code several times to see if the results are consistent.

### Controlled operations

In Q#, you can use the `Controlled` *functor* to transform any operation to a
controlled operation. For example, the operation `CNOT(control, target)` can
also be expressed as `Controlled X([control], target)`. In general, you can put any
operation in the place of `X`. For example, `Controlled Y([control], target)`
applies the `Y` gate conditioned on the state of the control qubit.

To learn more about the `Controlled` functor and many other Q# features, you can
take a look to the [Q# user guide](https://docs.microsoft.com/quantum/user-guide/using-qsharp/operations-functions#calling-operation-specializations?azure-portal=true).

> [!NOTE]
> A functor in Q# is a factory that defines a new operation from another
> operation.

## Estimate resources with Q\#

The Quantum Development Kit has a built-in tool that allows you to estimate the
resources required to run a given Q# code on a quantum computer. It's called
[`ResourcesEstimator`](https://docs.microsoft.com/quantum/user-guide/machines/resources-estimator?azure-portal=true).
It "runs" the quantum operation without actually simulating the state of a quantum
computer. For this reason, it can estimate resources for Q# operations that use
thousands of qubits, if the classical part of the code can be run in a
reasonable time. To use a Resources Estimator:

1. Run your program from the command line selecting the `ResourcesEstimator` as
   yout simulator.

   ```dotnetcli
   dotnet run --simulator ResourcesEstimator
   ```

   Note that you can use the `ResourcesEstimator` without any changes to your Q#
   code.

2. This will output a list of the required quantum resources to execute the code.

   For example, if you execute it with the last Q# code block above, you get this:

   ```output
   Metric          Sum
   CNOT            1
   QubitClifford   1
   R               0
   Measure         2
   T               0
   Depth           0
   Width           2
   BorrowedWidth   0
   ```

   We need 1 CNOT gate, 1 Clifford gate to apply `H` and 2 measurements to
   obtain the qubits results. The width of the circuit is the number of qubits
   used, 2 in this case since you only used two qubits. For this example, it was
   very simple to know how many resources you needed without having to use
   `ResourcesEstimator`. But Q# is a high-level programming language, and for
   most programs it's virtually impossible to know directly how many resources
   they need. You will find that `ResourcesEstimator` is a very useful tool as
   you advance in your path to become a Q# quantum developer.

   >[!NOTE]
   > Clifford gates are a basic kind of quantum operation and are useful to
   > estimate the amount of resources needed to perform a quantum computation. You 
   > can learn more about them in the [Wikipedia page on Clifford gates](https://en.wikipedia.org/wiki/Clifford_gates).

   To learn more about `ResourcesEstimator` and a detailed description of each of
   the parameters of the output and more estimation tools, you can read [the
   official
   documentation](https://docs.microsoft.com/quantum/user-guide/machines/resources-estimator?azure-portal=true).

   In the next unit, you're going to see two different quantum algorithms that
   make use of superposition, interference, and entanglement to outperform
   classical computers.
