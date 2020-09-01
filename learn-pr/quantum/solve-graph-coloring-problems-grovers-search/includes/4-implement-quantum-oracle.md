In this unit we will see how to implement a quantum oracle for our example graph coloring problem from unit 2.

## Implementing quantum oracles



### Representing the graph

We need two parameters to represent a graph: the number of vertices and the list of edges. 

In Q#, we will store the number of vertices `nVertices` as an integer, and the list of edges `edges` as an array of tuples. Each tuple in the array describes one edge of the graph as a pair of indices of vertices connected by this edge; we will use zero-based indices, i.e., the index value can be betwee 0 and `nVertices` - 1.

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

### Step 1. Check whether the colors of two vertices are the same

### Step 2. Check whether the vertex coloring is valid

### Step 3. Convert state encoding into phase encoding

### Step 4. Putting it all together

Notes from outline:

Do an exercise to implement a quantum oracle for a simple graph coloring problem.

Resources: GraphColoring kata (and other oracle implementation resources).

---
