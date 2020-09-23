In this section, you explore quantum interference and relative phases by using Q# and the `DumpMachine` function.

## Create the project

Start by creating a Q# project like you did previously in this module:

1. On the **View** menu, select **Command Palette**.
1. Enter *Q#: Create New Project*.
1. Select **Standalone console application**.
1. Select a directory to hold your project. For example, choose your home directory. Enter *ExploringInterference* as the project name. Then select **Create Project**.
1. In the window that appears below, select **Open new project**.

Like before, you see two files: the project file and *Program.qs*, which contains starter code.

## Make two states interfere

As we saw in the previous part, when we put the states $\ket{\psi_1}=
\frac1{\sqrt2}\ket{0}+\frac1{\sqrt2}\ket{1}$ and $\ket{\psi_2}=
\frac1{\sqrt2}\ket{0}-\frac1{\sqrt2}\ket{1}$ in a superposition, the probability
amplitude of $\ket{1}$ vanishes. For $\ket{0}$, the probability amplitude doubles.

To see this effect in Q#, you can use the `H`
operation. You already know that $ H \ket{0} = \ket{\psi_1}$. You used this principle 
for the quantum random bit generator. But if you apply $ H$ to the state
$\ket{1}$, you obtain $\ket{\psi_2}$.

You then apply `H` twice to the state $\ket{0}$:

$$ H  H \ket{0}=  H \frac1{\sqrt2}(\ket{0}+\ket{1}).$$

Because $ H$ is a linear operator:

$$=\frac1{\sqrt2}( H \ket{0}+ H \ket{1})=
\frac1{\sqrt2}(\ket{\psi_1}+\ket{\psi_2}).$$

So applying $ H$ twice to $\ket{0}$ is mathematically the same as
superposing the states $\ket{\psi_1}$ and $\ket{\psi_2}$.

Here are the steps in Q#:

1. Modify *Program.qs* like the following example. Then save the file.

   :::code language="qsharp" source="code/5-program-1.qs":::

   Here, you apply the operation `H` twice while using `DumpMachine` to inspect the intermediate
   states.

   > [!NOTE]
   > To apply an operation twice in Q#, you apply the operation to the
   > target register in sequential lines. Do not insert the application of the
   > operation as the argument of the second operation. Otherwise, `H(H(q))` yields a
   > compilation error.

2. Open the integrated terminal. On the **Terminal** menu, select **New Terminal**.

3. In the terminal, run `dotnet run`:

   ```dotnetcli
   dotnet run
   ```

At the end of the program, you must get the result `Zero`. You should
see the following output.

```output
At the beginning the qubit is in the state |0>.
# wave function for qubits with ids (least to most significant): 0
|0⟩:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
|1⟩:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]

After applying H the qubit is in a uniform superposition.
# wave function for qubits with ids (least to most significant): 0
|0⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]
|1⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]

If you apply H again, interference gives back the state to |0>.
# wave function for qubits with ids (least to most significant): 0
|0⟩:     1.000000 +  0.000000 i  ==     ********************* [ 1.000000 ]     --- [  0.00000 rad ]
|1⟩:     0.000000 +  0.000000 i  ==                           [ 0.000000 ]     --- [  0.00000 rad ]

If you measure you always obtain 'Zero'.
Zero
```

You can see how applying `H` twice recovers the initial state of the qubit.
It's recovered because the superposition states that the first `H`
operation created destructively interfere when you superpose the states again in the 
second `H` operation.

## Explore the relative phases in Q#

You might have noticed that `DumpMachine` also gives us
information about the phase of each amplitude. So far you have
seen only amplitudes that have zero phases (that is, real positive amplitudes). Let's look at a state
that has amplitudes with nonzero phases.

You know that the state $\ket{\psi_2}$ has a negative amplitude for the state
$\ket{1}$. You can create this state in Q#:

1. Modify *Program.qs* like the following example. Then save the file.

   :::code language="qsharp" source="code/5-program-2.qs":::

   In this code, you:
   1. Transform $\ket{0}$ into $\ket{1}$ by using the [X](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.X?azure-portal=true) operation.
   1. Apply `H` to obtain $\ket{\psi_2}$.
   1. Use `DumpMachine` to inspect the phases of the state $\ket{\psi_2}$.

1. In the terminal, run `dotnet run`:

   ```dotnetcli
   dotnet run
   ```

Here's an example of the output that you should expect:

```output
# wave function for qubits with ids (least to most significant): 0
|0⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]
|1⟩:    -0,707107 +  0.000000 i  ==     ***********          [ 0.500000 ] ---     [  3,14159 rad ]
```

You see that the phase for the state $\ket{1}$ is $\pi$ radians. You see this phase because
the negative numbers in the complex plane are in the negative part of the
x-axis. The result is $\pi$ radians in polar coordinates. Although
the phase is nonzero, the probabilities remain the same.

And what about complex amplitudes? If instead of using `X` you use the operation
`Y`, the amplitudes rotate to the imaginary axis. To see this effect:

1. Modify *Program.qs* to use the following code:

   :::code language="qsharp" source="code/5-program-3.qs":::

   This code is like the code in the previous example, but it replaces `X` with `Y`.

1. In the terminal, run `dotnet run`:

   ```dotnetcli
   dotnet run
   ```

You should expect the following output.

```output
|0⟩:     0.000000 +  0.707107 i  ==     ***********          [ 0.500000 ]        [  1.57080 rad ]
|1⟩:     0.000000 + -0,707107 i  ==     ***********          [ 0.500000 ]        [ -1.57080 rad ]
```

You get a phase of $\frac\pi2$ for $\ket{0}$ and a phase of $-\frac\pi2$ for $\ket{1}$.
Those angles correspond to the positive and negative parts of the imaginary
y-axis of the complex plane.

Next, let's explore the concept of quantum entanglement in the context of quantum computing.
