In this unit, you're going to explore quantum interference and relative phases
with Q# and the `DumpMachine` function.

## An example of interference with Q\#

In unit 3, when putting the states $\ket{\psi_1}=
\frac1{\sqrt2}\ket{0}+\frac1{\sqrt2}\ket{1}$ and $\ket{\psi_2}=
\frac1{\sqrt2}\ket{0}-\frac1{\sqrt2}\ket{1}$ in a superposition, the probability
amplitude of $\ket{1}$ vanishes, and for $\ket{0}$ it doubles.

To see this effect in Q#, we can implement it with the help of the `H`
operation. We already know that $\hat H \ket{0} = \ket{\psi_1}$, which we used
for the quantum random bit generator. But if we apply $\hat H$ to the state
$\ket{1}$, we obtain $\ket{\psi_2}$.

If we then apply `H` twice to the state $\ket{0}$:

$$\hat H \hat H \ket{0}= \hat H \frac1{\sqrt2}(\ket{0}+\ket{1}).$$

Since $\hat H$ is a linear operator:

$$=\frac1{\sqrt2}(\hat H \ket{0}+\hat H \ket{1})=
\frac1{\sqrt2}(\ket{\psi_1}+\ket{\psi_2}).$$

Thus, applying $\hat H$ twice to $\ket{0}$ is mathematically the same as
superposing the states $\psi_1$ and $\psi_2$. We know how to code that with Q#.

The code would be:

:::code language="qsharp" source="code/5-program-1.qs":::

And the result is:

```output
At the beginning the qubit is in the state |0>.
# wave function for qubits with ids (least to most significant): 0
|0⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
|1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]

After applying H the qubit is in a uniform superposition.
# wave function for qubits with ids (least to most significant): 0
|0⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]
|1⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]

If we apply H again, interference gives back the state to |0>.
# wave function for qubits with ids (least to most significant): 0
|0⟩:     1.000000 +  0.000000 i  ==     ********************* [ 1.000000 ]     --- [  0.00000 rad ]
|1⟩:     0.000000 +  0.000000 i  ==                           [ 0.000000 ]     --- [  0.00000 rad ]

If we measure we always obtain 'Zero'.
Zero
```

We can see that it behaves just as we expected.

## Exploring the relative phase with Q\#

You may have noticed that `DumpMachine` also gives us
information about the phase of each amplitude. However, so far we have
only seen amplitudes with zero phase. Let's see how it looks like when a state
has amplitudes with non-zero phases.

We know that the state $\ket{\psi_2}$ has a negative amplitude for the state
$\ket{1}$. Let's observe it using `DumpMachine`. We should first transform
$\ket{0}$ into $\ket{1}$ with help of the [`X`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.X?azure-portal=true) operation, and then apply
`H` to obtain $\ket{1}.$

The code would be:

:::code language="qsharp" source="code/5-program-2.qs":::

And the output:

```output
# wave function for qubits with ids (least to most significant): 0
|0⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]
|1⟩:    -0,707107 +  0.000000 i  ==     ***********          [ 0.500000 ] ---     [  3,14159 rad ]
```

We see how the phase for the state $\ket{0}$ is $\pi$ radians. This is because
the negative numbers in the complex plane lie in the negative part of the
x-axis, and so it's $\pi$ radians in polar coordinates. Note that, although
the phase is non-zero, the probabilities remain the same.

And what about complex amplitudes⟩ If instead of using `X` we use the operation
`Y` we'll rotate the amplitudes to the imaginary axis. Let's see the effect.

The code would be:

:::code language="qsharp" source="code/5-program-3.qs":::

And the output:

```output
|0⟩:     0.000000 +  0.707107 i  ==     ***********          [ 0.500000 ]        [  1.57080 rad ]
|1⟩:     0.000000 + -0,707107 i  ==     ***********          [ 0.500000 ]        [ -1.57080 rad ]
```

We get a phase of $\frac\pi2$ for $\ket{0}$ and $-\frac\pi2$ for $\ket{1}$.
Those angles correspond to the positive and negative parts of the imaginary
y-axis of the complex plane.

In the next unit we are going to introduce the concept of quantum entanglement
in the context of quantum computing.