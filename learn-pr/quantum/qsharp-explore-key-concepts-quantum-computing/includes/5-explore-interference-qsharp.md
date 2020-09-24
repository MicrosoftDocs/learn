In this section, you explore quantum interference and relative phases by using Q# and the `DumpMachine` function.

## Create the project

Start by creating a Q# project like you did previously in this module. To do so:

1. On the **View** menu, select **Command Palette**.
1. Enter **Q#: Create New Project**.
1. Select **Standalone console application**.
1. Select a directory to hold your project, such as your home directory. Enter *ExploringInterference* as the project name, then select **Create Project**.
1. From the window that appears at the bottom, select **Open new project**.

Like before, you see two files: the project file and *Program.qs*, which contains starter code.

## Make two states interfere

In the previous part, when putting the states $|\psi_1\rangle=
\frac1{\sqrt2}|0\rangle+\frac1{\sqrt2}|1\rangle$ and $|\psi_2\rangle=
\frac1{\sqrt2}|0\rangle-\frac1{\sqrt2}|1\rangle$ in a superposition, the probability
amplitude of $|1\rangle$ vanishes, and for $|0\rangle$ it doubles.

To see this effect in Q#, you can implement it with the help of the `H`
operation. You already know that $ H |0\rangle = |\psi_1\rangle$, which you used
for the quantum random bit generator. But if you apply $ H$ to the state
$|1\rangle$, you obtain $|\psi_2\rangle$.

If you then apply `H` twice to the state $|0\rangle$:

$$ H  H |0\rangle=  H \frac1{\sqrt2}(|0\rangle+|1\rangle).$$

Since $ H$ is a linear operator:

$$=\frac1{\sqrt2}( H |0\rangle+ H |1\rangle)=
\frac1{\sqrt2}(|\psi_1\rangle+|\psi_2\rangle).$$

Thus, applying $ H$ twice to $|0\rangle$ is mathematically the same as
superposing the states $|\psi_1\rangle$ and $|\psi_2\rangle$.

To do so with Q#:

1. Modify *Program.qs* like this and then save the file:

   :::code language="qsharp" source="code/5-program-1.qs":::

   Here, you apply the operation `H` twice while inspecting the intermediate
   states with `DumpMachine`.

   > [!NOTE]
   > To apply an operation twice in Q# you apply the operation to the
   > target register in sequential lines. DON'T insert the application of the
   > operation as the argument of the second operation. `H(H(q))` yields a
   > compilation error.

2. Open the integrated terminal. From the **Terminal** menu, select **New Terminal**.

3. From the terminal, run `dotnet run`:

   ```dotnetcli
   dotnet run
   ```

   At the end of the program, you must get the result `Zero`. You should
   see the following output

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
   This occurs because the states of the superposition created by the first `H`
   operation destructively interfere when you superpose them again with the 
   second `H` operation.

## Explore the relative phases with Q#

You may have noticed that `DumpMachine` also gives us
information about the phase of each amplitude. However, so far you have
only seen amplitudes with zero phase (i.e., real positive amplitudes). Let's see how it looks like when a state
has amplitudes with non-zero phases.

You know that the state $|\psi_2\rangle$ has a negative amplitude for the state
$|1\rangle$. You can create such state with Q#.

1. First, modify *Program.qs* like this and save the file:

   :::code language="qsharp" source="code/5-program-2.qs":::

   In this code you:
   1. Transform $|0\rangle$ into $|1\rangle$ with help of the [X](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.intrinsic.X?azure-portal=true) operation.
   1. Apply `H` to obtain $|\psi_2\rangle$.
   1. Use `DumpMachine` to inspect the phases of the state $|\psi_2\rangle$.

1. From the terminal, run `dotnet run`:

   ```dotnetcli
   dotnet run
   ```

   Here you have an example of the output that you should expect:

   ```output
   # wave function for qubits with ids (least to most significant): 0
   |0⟩:     0.707107 +  0.000000 i  ==     ***********          [ 0.500000 ]     --- [  0.00000 rad ]
   |1⟩:    -0,707107 +  0.000000 i  ==     ***********          [ 0.500000 ] ---     [  3,14159 rad ]
   ```

   You see how the phase for the state $|1\rangle$ is $\pi$ radians. This is because
   the negative numbers in the complex plane lie in the negative part of the
   x-axis, and so it's $\pi$ radians in polar coordinates. Note that, although
   the phase is non-zero, the probabilities remain the same.

And what about complex amplitudes? If instead of using `X` you use the operation
`Y`, you'll rotate the amplitudes to the imaginary axis. To see this effect:

1. Modify the code of *Program.qs* to be:

   :::code language="qsharp" source="code/5-program-3.qs":::

   This code is the same code above by replacing `X` by `Y`.

1. From the terminal, run `dotnet run`:

   ```dotnetcli
   dotnet run
   ```

   You should expect the following output.

   ```output
   |0⟩:     0.000000 +  0.707107 i  ==     ***********          [ 0.500000 ]        [  1.57080 rad ]
   |1⟩:     0.000000 + -0,707107 i  ==     ***********          [ 0.500000 ]        [ -1.57080 rad ]
   ```

   you get a phase of $\frac\pi2$ for $|0\rangle$ and $-\frac\pi2$ for $|1\rangle$.
   Those angles correspond to the positive and negative parts of the imaginary
   y-axis of the complex plane.

Next, let's explore the concept of quantum entanglement in the context of quantum computing.
