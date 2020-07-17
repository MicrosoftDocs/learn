In this unit we are going to explore quantum interfernce with Q# and see how we
can create quantum entanglement with Q#. We will also present the tool
`ResourcesEstimator` of the Quantum Development Kit, that will help us to know
what kind of resources do we need in order tu run our algorithms.

## An example of interference with Q#

In a previous unit we saw how if we superpose the states $\ket{\psi_1}=
\frac1{\sqrt2}\ket{0}+\frac1{\sqrt2}\ket{1}$ and $\ket{\psi_2}=
\frac1{\sqrt2}\ket{0}-\frac1{\sqrt2}\ket{1}$ the probability amplitudes of
$\ket{1}$ vanish and for $\ket{0}$ double.

How can we see this effect with Q#? Well, we can implement it with the help of
the `H` operation. We already know that $\hat H \ket{0} = \ket{\psi_1}$, we used
it for the quantum random bit generator. But what happens if we apply $\hat H$
to the state $\ket{1}$? What happens is that we obtain $\ket{\psi_2}$. In fact,
this is how we define the `H` operation.

Let's see what happens if we apply `H` twice to the state $\ket{0}$:

$$\hat H \hat H \ket{0}= \hat H \frac1{\sqrt2}(\ket{0}+\ket{1})$$

Since $\hat H$ is a linear operator:

$$=\frac1{\sqrt2}(\hat H \ket{0}+\hat H \ket{1})=
\frac1{\sqrt2}(\ket{\psi_1}+\ket{\psi_2})$$ 

Thus, applying $\hat H$ twice to $\ket{0}$ is mathematically the same as superposing
the states $\psi_1$ and $\psi_2$. We know how to code that with Q#, so let's if
interference takes place.

The code would be:

```qsharp
namespace ExploringInterference {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;
    
    @EntryPoint()
    operation TestInterference() : Result {
        using (q = Qubit()) {
        Message(" ");
        Message("At the beginning the qubit is in the state |0>.");
        DumpMachine();
        H(q);
        Message(" ");
        Message("After applying H the qubit is in a uniform superposition.");
        DumpMachine();
        H(q);
        Message(" ");
        Message("If we apply H again, interference gives back the state to |0>.");
        DumpMachine();
        Message(" ");
        Message("If we measure we always obtain 'Zero'.");
        return MResetZ(q);
        }
    }
}
```

And the result is:

```output
At the beginning the qubit is in the state |0>.
# wave function for qubits with ids (least to most significant): 0
|0?:     1,000000 +  0,000000 i  ==     ******************** [ 1,000000 ]     --- [  0,00000 rad ]
|1?:     0,000000 +  0,000000 i  ==                          [ 0,000000 ]

After applying H the qubit is in a uniform superposition.
# wave function for qubits with ids (least to most significant): 0
|0?:     0,707107 +  0,000000 i  ==     ***********          [ 0,500000 ]     --- [  0,00000 rad ]
|1?:     0,707107 +  0,000000 i  ==     ***********          [ 0,500000 ]     --- [  0,00000 rad ]

If we apply H again, interference gives back the state to |0>.
# wave function for qubits with ids (least to most significant): 0
|0?:     1,000000 +  0,000000 i  ==     ********************* [ 1,000000 ]     --- [  0,00000 rad ]
|1?:     0,000000 +  0,000000 i  ==                           [ 0,000000 ]     --- [  0,00000 rad ]

If we measure we always obtain 'Zero'.
Zero
```

We can see that it behaves just as we expected.

## Exploring the relative phase with Q#

If you paid attention you would have noticed that `DumpMachine` also give us
information about the phases of each amplitude. However, so far we have been
only seen amplitudes with zero phase. Let's see how it looks like when a state
has amplitudes with non-zero phases.

We know that the state $\ket{\psi_2}$ has a negative amplitude for the state
$\ket{1}$, so let's see what it outputs `DumpMachine` if we put the register
into the state $\ket{\psi_2}$. To do it we just need to first transform
$\ket{0}$ into $\ket{1}$ with help of the `[X]`(todo) operation, and then apply
`H` to obtain $\ket{1}.$ 

The code would be:

```qsharp
namespace ExploringInterference {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation TestInterference() : Unit {
        using (q = Qubit()) {
        X(q);
        H(q);
        DumpMachine();
        Reset(q);
        }
    }
}
```

And the output:

```output
# wave function for qubits with ids (least to most significant): 0
|0?:     0,707107 +  0,000000 i  ==     ***********          [ 0,500000 ]     --- [  0,00000 rad ]
|1?:    -0,707107 +  0,000000 i  ==     ***********          [ 0,500000 ] ---     [  3,14159 rad ]
```

We see how the phase for the state $\ket{0}$ is $\pi$ radians. This is because
the negative numbers in the complex plane lie in the negative part of the
x-axis, and therefore $\pi$ radians in polar coordinates. Note that, although
the phase is non-zero, the probabilities remain the same.

And what about complex amplitudes? If instead of using `X` we use the operation
`Y` we will rotate the amplitudes to the imaginary axis. Let's see the effect.

The code would be:

```qsharp
namespace ExploringInterference {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation TestInterference() : Unit {
        using (q = Qubit()) {
        Y(q);
        H(q);
        DumpMachine();
        Reset(q);
        }
    }
}
```

And the output:

```output
|0?:     0,000000 +  0,707107 i  ==     ***********          [ 0,500000 ]        [  1,57080 rad ]
|1?:     0,000000 + -0,707107 i  ==     ***********          [ 0,500000 ]        [ -1,57080 rad ]
```

We get a phase of $\frac\pi2$ for $\ket{0}$ and $-\frac\pi2$ for $\ket{1}$.
Those angles correspond to the positive and negative parts of the imaginary
y-axis of the complex plane.

## Creating entanglement with Q#

Until now we used only single qubit operations, this is, operations that act
over single qubits individually. However, to get qubits entangled we need
what is called **multi-qubit gates**.

The most prominent example of a multi-qubit gate is the [`CNOT`](todo)
operation. This operation takes two qubits as input, and flips the state of the
second qubit (target qubit) if and only if the state of the first qubit (control
qubit) is $\ket{1}$. With the help of the `H` operation and the `CNOT` we can
transform a register in the state $\ket{00}$ to the entangled state
$\frac1{\sqrt2}(\ket{00}+\ket{11})$. Let's see how:

$$CNOT(\hat H\ket{0}),\ket{0})=CNOT($\frac1{\sqrt2}(\ket{0}+\ket{1}),\ket{0})=
\frac1{\sqrt2}(CNOT(\ket{0},\ket{0})+CNOT(\ket{1},ket{0}))=\frac1{\sqrt2}(\ket{00}+\ket{11})$$