In this module, you will implement Grover's search algorithm end-to-end - from the oracle definition for the vertex coloring problem to the logic of dealing with the randomized nature of the algorithm.

> [!NOTE]
> The overall code is necessarily rather long, since it includes not only the generic Grover's algorithm implementation but also the problem-specific oracle implementation. 
>
> We will focus this unit on discussing the most important elements of the code, and point you to the materials that will allow you to dig deeper into various topics touched upon in this unit in the summary section.

## Generic quantum search implementation

Here is the Q# code that implements the core of Grover's algorithm we've learned in the previous unit.

:::code language="qsharp" source="code/6-program-1.qs":::

Let's take a moment to highlight an important property of this code (the full code analysis is outside of scope of this module): this code is generic - it can be used to solve *any* search problem!  

We pass the quantum oracle - the only operation that relies on the knowledge of the problem instance we want to solve - as a parameter to the search code.

> [!NOTE]
> Q# allows to manipulate operations and functions as values, defining variables that store callables and passing them as arguments to other operations.
> The callable arguments can then be called in the code, same as other operations, as we see in step 1 in the loop body.
> 
> This feature allows to write concise high-level algorithm code and reuse it for multiple applications.

The code also takes the number of iterations to perform as a parameter. Again, this allows to keep the logic of choosing the number of iterations (either based on our problem knowledge or randomly) outside of the generic algorithm implementation.

Finally, the problem-specific logic of measuring the result and interpreting it is also kept outside. 
Instead, the operation takes a qubit register as one of the inputs, and the code that calls it can measure the state of that register afterwards.

> [!NOTE]
> This code doesn't define an `@EntryPoint`, since running it on its own wouldn't do anything interesting. 
> In the next section we'll see how to prepare all the parameters it will use and pass them to this code.

## Let's solve the graph coloring problem!

Now we are ready to put together everything we've learned so far and to solve the graph coloring problem we've introduced in the second unit!

Here is the full code.

:::code language="qsharp" source="code/6-program-2.qs":::

You will recognize the first three operations as the oracle implementation from unit 4, and the fourth one - as the generic search algorithm implementation we've seen earlier in this unit.

This leaves us only the last operation, which defines the problem we're solving, creates all the necessary parameters, calls the generic search implementation, and interprets the results.

* Note the definition of variables `markingOracle` and `phaseOracle` - the two variants of implementing our problem as a quantum operation. 
  Both of them use _partial application_ - fixing several parameters of an operation to produce another operation that takes fewer parameters. 
  Thus, `MarkValidVertexColoring` takes three parameters (the list of the graph edges, the input register, and the target qubit), but `markingOracle` is an operation that takes only two, the input register and the target qubit, and the list of graph edges is fixed to the `edges` variable.

* As we've seen in the previous unit, the optimal number of iterations depends both on the search space size and the number of solutions to the problem. 
  The first one is easy to define - any bit string of `2 * nVertices` bits can be interpreted as a potential coloring of `nVertices` vertices, so there are $2^{2 nVertices} = 1024$ candidates.
  The number of solutions is generally trickier to estimate, but in our case the graph structure is easy to analyze. 
  Vertices 0 - 3 make up a full graph, so they have to be assigned distinct colors in any order - since we have a total of four colors available, there are $4!$ ways to do this. 
  Vertex 4 is connected only to vertex 3, so it can take any color except the color of vertex 3, which gives us three options for each coloring of the other vertices. 
  The total number of solutions is $4! \cdot 3 = 72$.

  > How many iterations do we end up doing? $\frac{\pi}{4} \sqrt{\frac{N}{M}} = 2.96 \approx 3$.

* The `repeat ... until` loop handles the possibility of getting incorrect answer on the first run of the algorithm. 
  The body of the loop runs the algorithm once, measures the qubit register to get the result and checks whether it is a solution to the problem; if it is, the variable `correct` is updated to reflect that and the measurement results are converted to a bit array, otherwise the algorithm is executed again.

If you run the algorithm, you'll get an output like this:

```output
The resulting graph coloring:
Vertex 0 - color 0
Vertex 1 - color 2
Vertex 2 - color 1
Vertex 3 - color 3
Vertex 4 - color 2
```

## Watching the amplitudes

Now let's take a look at the behavior of the amplitudes of the basis states at the key points during the algorithm execution.

---
TODO:
1. Amplitudes diagram with amplitudes of various states changing during the phases of the algorithm (animated)
---

Congratulations! You've implemented your first quantum search algorithm and used it to solve a small problem.

In the next unit, we will take a look at what kinds of real-world problems are or are not a good fit for using Grover's search to solve them.