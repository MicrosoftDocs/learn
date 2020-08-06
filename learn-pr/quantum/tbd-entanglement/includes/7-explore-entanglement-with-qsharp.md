In this unit, you're going to see how to create quantum entanglement with Q#.
We'll also present the tool `ResourcesEstimator` provided by the Quantum
Development Kit, that will help us estimate the kind of resources we need to run
our algorithms.

## Creating entanglement with Q\#

Until now, we used only single qubit operations, this is, operations that act
over single qubits individually. However, to get qubits entangled we need
what is called **multi-qubit gates**.

The most prominent example of a multi-qubit gate is the
[`CNOT`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.cnot)
operation. This operation takes two qubits as input, and flips the state of the
second qubit (target qubit) if and only if the state of the first qubit (control
qubit) is $\ket{1}$. With the help of the `H` operation and the `CNOT`, we can
transform a register in the state $\ket{00}$ to the entangled state
$\frac1{\sqrt2}(\ket{00}+\ket{11})$. Let's see how:

$$CNOT(\hat H\ket{0}),\ket{0})=CNOT(\frac1{\sqrt2}(\ket{0}+\ket{1}),\ket{0})=
\frac1{\sqrt2}(CNOT(\ket{0},\ket{0})+CNOT(\ket{1},\ket{0}))=\frac1{\sqrt2}(\ket{00}+\ket{11})$$.



The code in Q# would be:

```qsharp
namespace ExploringEntanglement {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation TestInterference() : Result[] {
        using (qubits = Qubit[2]) {
            H(qubits[0]);
            CNOT(qubits[0],qubits[1]);
            Message("Entangled state before measurement:");
            DumpMachine();
            Message(" ");
            let results = MultiM(qubits);
            Message("Entangled state after measurement:");
            DumpMachine();
            ResetAll(qubits);
            return results;
        }
    }
}
```

And the output:

```output
Entangled state before measurement:
# wave function for qubits with ids (least to most significant): 0;1
|0⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]
|1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|2⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|3⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]

Entangled state after measurement:
# wave function for qubits with ids (least to most significant): 0;1
|0⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|2⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
|3⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
[One,One]
```

### Controlled operations

In Q#, you can use the `Controlled` *functor* to transform any operation to a
controlled operation. For example, the operation `CNOT(control, target)` can
also be expressed as `Controlled X([control], target)`. In general, you can put any
operation in the place of `X`. For example, `Controlled Y([control], target)`
applies the `Y` gate conditioned on the state of the control qubit.

To learn more about the `Controlled` functor and many other Q# features, you can
take a look to the [Q# user guide](https://docs.microsoft.com/quantum/user-guide/using-qsharp/operations-functions#calling-operation-specializations).

> [!NOTE] A functor in Q# is a factory that defines a new operation from another
> operation.

## Estimating resources with Q\#

The Quantum Development Kit has a built-in tool that allows you to estimate the
resources required to run a given Q# code on a quantum computer. It's called
[`ResourcesEstimator`](https://docs.microsoft.com/quantum/user-guide/machines/resources-estimator).
It runs the quantum operation without actually simulating the state of a quantum
computer. For this reason, it can estimate resources for Q# operations that use
thousands of qubits, if the classical part of the code can be run in a
reasonable time.

> [!NOTE]
> The resources estimator is built on top of the quantum trace simulator of the
> Quantum Development Kit. The quantum trace simulator can run quantum programs
> without actually simulating the state of a quantum computer. You can learn
> more about the quantum trace simulator in the [Quantum Development Kit
> documentation](https://docs.microsoft.com/quantum/user-guide/machines/qc-trace-simulator/).

To use a Resources Estimator, write in the command line:

```dotnetcli
dotnet run --simulator ResourcesEstimator
```

This will output a list of the required quantum resources to execute the code.

For example, if we execute it with the last Q# code block above, we get this:

```output
Metric          Sum
CNOT            1
QubitClifford   1
R               0
Measure         4
T               0
Depth           0
Width           2
BorrowedWidth   0
```

We need 1 CNOT gate, 1 Clifford gate to apply `H` and 4 measurements: 2 to
obtain the qubits results, and two to reset them. The width of the circuit, this
is the number of qubits used, is 2 since we only used two qubits. For this
example, it was very simple to know how many resources we needed without having
to use `ResourcesEstimator`. But Q# has high-level functionality and for most
programs it's virtually impossible to know directly how many resources they
need. This makes `ResourcesEstimator` a very useful tool for quantum developers.

To learn more about `ResourcesEstimator` and a detailed description of each of
the parameters of the output and more estimation tools, you can read [the
official
documentation](https://docs.microsoft.com/en-us/quantum/user-guide/machines/resources-estimator).

In the next unit, we're going to present different quantum algorithms that make
use of superposition, interference, and entanglement to outperform classical
computers.
