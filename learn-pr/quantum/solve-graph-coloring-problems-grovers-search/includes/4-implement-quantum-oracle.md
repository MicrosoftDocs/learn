In this unit we will see how to implement a quantum oracle for our example graph coloring problem from unit 2.

## Implementing quantum oracles



### Representing the graph

We need two parameters to represent a graph: the number of vertices and the list of edges. 

In Q#, we will store the number of vertices `nVertices` as an integer, and the list of edges `edges` as an array of tuples. Each tuple in the array describes one edge of the graph as a pair of indices of vertices connected by this edge; we will use zero-based indices, i.e., the index value can be between 0 and `nVertices` - 1.

![Figure 1. A graph](../media/2-valid-coloring.png)

The structure of our example graph can be represented as follows:

:::code language="qsharp" source="code/4-1-graph-description.qs" highlight="6":::

### Representing the graph coloring

Graph coloring is described by an array of `nVertices` colors. 
To simplify the representation, we will look for a 4-coloring of the graph - a coloring that uses at most four colors, encoded with integers 0 through 3. 

We need to represent our coloring in a bit string, so we'll use a bit string of length 2 * `nVertices`, with the first pair of bits encoding the color of vertex 0, the second pair - the color of vertex 1, and so on.

Here is how the coloring of the example graph above will be encoded and interpreted:

:::code language="qsharp" source="code/4-2-graph-coloring.qs":::

This code will produce the following output:

```output
Vertex 0 - color 0 (red)
Vertex 1 - color 1 (green)
Vertex 2 - color 2 (blue)
Vertex 3 - color 3 (yellow)
Vertex 4 - color 2 (blue)
```

When we work with graph coloring in a quantum program, we use the same encoding, but with basis states $|0\rangle$ and $|1\rangle$ instead of classical bits `false` and `true`. 
The same coloring would be represented as a 10-qubit state $|0010011101\rangle$.

### Implementing the oracle

A typical approach to implementing a quantum oracle for a given function is as follows:

1. Break down the classical function into small building blocks that are easy to implement.  
  Any Boolean function can be implemented using [primitive logic gates](https://en.wikipedia.org/wiki/Logic_gate); you can either use this level of detail or a higher level that takes advantage of Q# library operations.

2. Replace each classical block with a sequence of quantum gates that implement it using amplitudes encoding.  
  Each of the primitive logic gates can be implemented using one or several quantum gates, possibly with an extra qubit allocated to hold the computation result. For example,  
   * Classical NOT gate is equivalent to the X gate.
   * Classical XOR gate can be implemented using the CNOT gate.
   * Classical AND gate can be realized using [Toffoli gate](https://en.wikipedia.org/wiki/Toffoli_gate) and an extra qubit.

3. If the algorithm calls for phase encoding of the function, transform the operation to use phase encoding instead.  
  This uses a standard trick called "phase kickback".

Let's see how this approach works in the case of vertex coloring problem!

#### Step 1. Check whether the colors of two vertices are the same

The smallest building block for checking whether the given graph coloring is valid is taking a pair of vertices connected by an edge and checking whether their assigned colors are the same or different.

The operation that implements this has to take two 2-qubit registers as inputs, representing the colors of the vertices, and a qubit we'll use to mark the result of the comparison by flipping its state if the colors are the same.
To compare the registers, we compare their corresponding bits to each other; if all pairs of bits are the same, then the registers are the same.
And to compare a pair of bits, we can compute their XOR: if it is 0, the bits are the same, otherwise they are different.

Here is Q# code that implements this check and uses it to compare two registers: the first one in the $|00\rangle$ state and the second one in an equal superposition of all basis states.

:::code language="qsharp" source="code/4-3-color-equality.qs":::

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

We see that in the beginning the state of the system is 

$$|00\rangle_{c0} \otimes \frac12\big(|00\rangle + |10\rangle + |01\rangle + |11\rangle\big)_{c1} \otimes |0\rangle_{target}$$

> Remember that `DumpRegister` indices are encoded in little endian, so the index `1` corresponds to bit string `100`, with the least significant bit stored first.

After we apply the equality check, the state of the register `c0` doesn't change (you can verify this by adding another `DumpRegister` call), but the amplitudes of the combined state of the register `c1` and the `target` qubit change: the amplitude of the $|00\rangle _{c1} \otimes |0\rangle_{target}$ state becomes 0, and the amplitude of the $|00\rangle _{c1} \otimes |1\rangle_{target}$ state becomes 0.25. In fact, these two amplitudes are swapped as the result of applying this check.

Indeed, since the colors encoded in the state $|00\rangle_{c0} \otimes |00\rangle _{c1} \otimes |0\rangle_{target}$ are equal, the state of the `target` qubit for this basis state gets flipped, giving us the resulting state

$$|00\rangle_{c0} \otimes \frac12\big(|00\rangle_{c1} \otimes |1\rangle_{target} + |10\rangle_{c1} \otimes |0\rangle_{target} + |01\rangle_{c1} \otimes |0\rangle_{target} + |11\rangle_{c1}\big)$$

> Note that the `target` qubit becomes entangled with the register `c1`: you can no longer separate their states!
> If the value of the function we're evaluating is the same for all inputs, the target qubit will stay not entangled with the input register, storing this value instead. 
> In our case, some inputs yield $f(x) = 0$ and some yield $f(x) = 1$, so you cannot separate the information about the inputs from the information about the output any longer.

#### Step 2. Check whether the vertex coloring is valid


#### Step 3. Convert state encoding into phase encoding




Notes from outline:

Do an exercise to implement a quantum oracle for a simple graph coloring problem.

Resources: GraphColoring kata (and other oracle implementation resources).

---

Now that we know how to build a quantum oracle for a graph coloring problem, in the next unit we will finally learn Grover's search algorithm itself.
