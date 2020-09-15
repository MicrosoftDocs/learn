Now, you will implement a quantum oracle for the graph coloring problem.

## Create the project

Start by creating a Q# project like you did for the quantum random number generator in the [Create your first Q# program by using the Quantum Development Kit](https://docs.microsoft.com/learn/modules/qsharp-create-first-quantum-development-kit?azure-portal=true) module. To do so:

1. On the **View** menu, select **Command Palette**.
1. Enter **Q#: Create New Project**.
1. Select **Standalone console application**.
1. Select a directory to hold your project, such as your home directory. Enter *ExploringGroversSearch* as the project name, then select **Create Project**.
1. From the window that appears at the bottom, select **Open new project**.

Like before, you see two files: the project file and *Program.qs*, which contains starter code. 

For each of the code snippets in this module, you should copy the whole snippet to replace the contents of the file *Program.qs*. 
After that, open the integrated terminal (from the **Terminal** menu, select **New Terminal**) and run `dotnet run`:

```dotnetcli
dotnet run
```


## Representing the graph

We need two parameters to represent a graph: the number of vertices and the list of edges. 

In Q#, we will store the number of vertices `nVertices` as an integer, and the list of edges `edges` as an array of tuples. Each tuple describes one edge of the graph as a pair of indices of vertices connected by this edge; we will use zero-based indices, so the index value can be between 0 and `nVertices` - 1.

![Figure 1. A graph](../media/2-valid-coloring.png)

The structure of our example graph can be represented as follows:

:::code language="qsharp" source="code/4-program-1.qs":::

## Representing the vertex coloring

Graph coloring is described by an array of `nVertices` colors. 
To simplify the representation, we will look for a four-coloring of the graph - a coloring that uses at most four colors, encoded with integers 0 through 3. 

We need to represent our coloring in a bit string, so we'll use a bit string of length 2 * `nVertices`, with the first pair of bits encoding the color of vertex 0, the second pair - the color of vertex 1, and so on.

Here is how the coloring of the example graph above will be encoded and interpreted:

:::code language="qsharp" source="code/4-program-2.qs":::

This code will produce the following output:

```output
Vertex 0 - color #0 (red)
Vertex 1 - color #1 (green)
Vertex 2 - color #2 (blue)
Vertex 3 - color #3 (yellow)
Vertex 4 - color #1 (green)
```

When we work with graph coloring in a quantum program, we use the same encoding, but with the basis states $|0\rangle$ and $|1\rangle$ instead of the classical bits `false` and `true`. 
The same coloring would be represented as a 10-qubit state $|0010011101\rangle$.

## Implementing the oracle

A typical approach to implementing a quantum oracle for a given function is as follows:

1. Break down the classical function into small building blocks that are easy to implement.  
  Any Boolean function can be implemented using [primitive logic gates](https://en.wikipedia.org/wiki/Logic_gate). You can either use primitive logic gates to get a low-level representation or higher level building blocks that take advantage of Q# library operations implementing them.

2. Replace each classical block with a sequence of quantum gates that implement it using amplitude encoding.  
  Each of the primitive logic gates can be implemented using one or several quantum gates. Sometimes we'll need to allocate an extra qubit to hold the computation result of the gate. For example,  
   * Classical NOT gate is equivalent to the X gate.
   * Classical XOR gate can be implemented using the CNOT gate.
   * Classical AND gate can be realized using [Toffoli gate](https://en.wikipedia.org/wiki/Toffoli_gate) and an extra qubit.

3. If the algorithm calls for phase encoding of the function, transform the operation to use phase encoding instead.  
  This step uses a standard trick called "phase kickback".

Let's see how this approach works for our vertex coloring problem!

### Step 1. Check whether the colors of two vertices are the same

The smallest building block for checking whether the given graph coloring is valid is taking a pair of vertices connected by an edge and checking whether their assigned colors are the same or different.

The operation that implements this check has to take two 2-qubit registers as inputs, representing the colors of the vertices, and a qubit we'll use to mark the result of the comparison by flipping its state if the colors are the same.
To compare the registers, we compare their corresponding bits to each other; if all pairs of bits are the same, then the registers are the same.
To compare a pair of bits, we can compute their XOR: if it is 0, the bits are the same, otherwise they are different.

Here is the Q# code that implements this check and uses it to compare two registers: the first one in the $|00\rangle$ state and the second one in an equal superposition of all basis states.

:::code language="qsharp" source="code/4-program-3.qs":::

> [!NOTE]
> The [`DumpRegister`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.diagnostics.dumpregister) function is similar to `DumpMachine` you've seen in the previous modules, but it prints the information about the state of a subset of qubits (a register), rather than all qubits used by the program. 
> It can only be used if that register is not entangled with the rest of the qubits.

> [!NOTE]
> In this module we'll focus on high-level behavior of quantum oracles and (in the following units) Grover's search algorithm. 
> We encourage you to dig deeper into the code on your own, in particular, to look up any unfamiliar operations and language constructs in the [Q# documentation](https://docs.microsoft.com/quantum).

Here is the output of this code:

```output
The starting state of qubits c1 and target:
# wave function for qubits with ids (least to most significant): 2;3;4
∣0❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣1❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣2❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣3❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣4❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
∣5❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
∣6❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
∣7❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]

The state of qubits c1 and target after the equality check:
# wave function for qubits with ids (least to most significant): 2;3;4
∣0❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
∣1❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣2❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣3❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣4❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣5❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
∣6❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
∣7❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
```

> [!NOTE]
> As a reminder, the indices in `DumpMachine`/`DumpRegister` output are encoded in little endian, so the index `|1❭` corresponds to bit string `100`, with the least significant bit stored first.

We see that in the beginning the state of the system is 

$$|00\rangle\_{c0} \otimes \frac12\big(|00\rangle + |10\rangle + |01\rangle + |11\rangle\big)\_{c1} \otimes |0\rangle\_{target}$$

After we apply the equality check, the state of the register `c0` doesn't change (you can verify this by adding another `DumpRegister` call), but the amplitudes of the combined state of the register `c1` and the `target` qubit change: the amplitude of the $|00\rangle\_{c1} \otimes |0\rangle\_{target}$ state becomes 0, and the amplitude of the $|00\rangle\_{c1} \otimes |1\rangle\_{target}$ state becomes $0.25$. In fact, these two amplitudes are swapped as the result of applying this check.

Indeed, since the colors encoded in the state $|00\rangle\_{c0} \otimes |00\rangle\_{c1} \otimes |0\rangle\_{target}$ are equal, the state of the `target` qubit for this basis state gets flipped, giving us the resulting state

$$|00\rangle_{c0} \otimes \frac12\big(|00\rangle_{c1} \otimes |1\rangle_{target} + |10\rangle_{c1} \otimes |0\rangle_{target} + |01\rangle_{c1} \otimes |0\rangle_{target} + |11\rangle_{c1} \otimes |0\rangle_{target} \big)$$

> [!NOTE]
> Note that the `target` qubit becomes entangled with the register `c1`: you can no longer separate their states!
> If the value of the function we're evaluating is the same for all inputs, the target qubit will stay not entangled with the input register, storing this value instead. 
> In our case, some inputs yield $f(x) = 0$ and some yield $f(x) = 1$, so you cannot separate the information about the inputs from the information about the output any longer.

### Step 2. Check whether the vertex coloring is valid

Now that we know how to check that the colors of two vertices are different, we can represent the vertex coloring validation as follows:

1. Iterate over all pairs of vertices connected by edges.
2. For each pair, check that the colors of these vertices are different.
3. If all pairs of vertices satisfy this condition, the coloring is valid.

To implement these steps as a quantum operation, we'll need to allocate extra qubits to store the results of pairwise color comparisons, one qubit per edge. 
We will start with those qubits in $|0\rangle$ state and compare colors of vertices in each pair using `MarkColorEquality` operation we've seen above; it will flip the state of the qubit to $|1\rangle$ if the colors of the corresponding pair of vertices are the same.

Finally, we will compute the final result: if all extra qubits allocated are in $|0\rangle$ state, we flip the state of our target qubit to indicate that the vertex coloring is valid.

Here is the Q# code that validates that the vertex coloring is valid.

:::code language="qsharp" source="code/4-program-4.qs":::

Here is the output of this code:

```output
The coloring is valid
```

#### Bonus exercises

* Experiment with the colorings and the graph structures to see which ones are deemed valid and invalid. An example of invalid coloring for this graph would be `[false, false, true, false, false, true, true, true, true, true]`, which describes a graph with vertices 3 and 4 assigned the same color. 
* Modify the code to run on superpositions of inputs and see what happens. 


### Step 3. Convert amplitude encoding into phase encoding

Now, we have an operation that can mark the qubit states that represent valid colorings in the state of an extra qubit. How can we use it to implement another operation that would mark such states using their phases?

We can do it using so-called "phase kickback trick": 

1. Allocate an extra qubit in the $\frac{1}{\sqrt2}(|0\rangle - |1\rangle)$ state.
2. Apply the marking operation $U^{state}$ with this extra qubit as target.  
What happens to the register that encodes the coloring at this step? 
   * If the basis state $|x\rangle$ encodes an invalid coloring, the state will not change.
   * On the other hand, if the basis state $|x\rangle$ encodes an valid coloring, the operation $U^{state}$ will flip the state of the extra qubit, converting it to $\frac{1}{\sqrt2}(|1\rangle - |0\rangle)$, which is equivalent to multiplying the whole state by $-1$.

If you apply these steps to a basis state, you won't be able to tell the difference - the global phase will not be observable. 
But if you apply these steps to a superposition state, you'll see that the basis states that encode valid colorings will acquire the $-1$ relative phase - and that's exactly the effect we need the phase operation to have!

Here is what the phase kickback trick looks like in Q#. We'll use the operation that implements color check, which makes the effects easier to see in the output, but you can use the same trick on any operation.

:::code language="qsharp" source="code/4-program-5.qs":::

```output
The starting state of qubits c1:
# wave function for qubits with ids (least to most significant): 2;3
∣0❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣1❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣2❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣3❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]

The state of qubits c1 after the equality check:
# wave function for qubits with ids (least to most significant): 2;3
∣0❭:    -0.500000 +  0.000000 i  ==     *****                [ 0.250000 ] ---     [  3.14159 rad ]
∣1❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣2❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
∣3❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
```

You can see that indeed, the amplitude of the $|00\rangle$ state changed to $-0.5$, so now its relative phase compared to the other basis states is $-1$.

Now you know how to build a complete quantum oracle for a graph coloring problem! In the next unit, we will finally learn Grover's search algorithm itself.
