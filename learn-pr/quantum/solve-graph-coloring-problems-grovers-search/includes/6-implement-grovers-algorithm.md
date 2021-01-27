In this module, you will finally implement Grover's search algorithm end-to-end - from the oracle definition for the graph coloring problem to the logic of dealing with the randomized nature of the algorithm. 

> [!NOTE]
> Out of necessity, the overall code in this example is rather long, as it includes not only the generic Grover's algorithm implementation but also the problem-specific oracle implementation. 
>
> This unit focuses on the most important elements of the code - the full code analysis is outside of scope of this module. However, the summary section of this module has links to materials to allow you to dig deeper into the various concepts discussed here. 

## Generic quantum search implementation

Here is the Q# code that implements the core of Grover's algorithm.

:::code language="qsharp" source="code/6-program-1.qs":::

Let's take a moment to highlight an important property of this code: this code is generic - it can be used to solve *any* search problem!  

We pass the quantum oracle - the only operation that relies on the knowledge of the problem instance we want to solve - as a parameter to the search code.

> [!NOTE]
> Q# allows us to manipulate operations and functions as values, defining variables that store callables and passing them as arguments to other operations.
> The callable arguments can then be called in the code just like other operations, as we see in step 1 in the loop body.
> 
> This feature allows us to write concise, high-level algorithm code and reuse it for multiple applications.

The code also takes the number of iterations to perform as a parameter. Again, this allows us to keep the logic of choosing the number of iterations (either based on our problem knowledge or randomly) outside of the generic algorithm implementation.

Finally, the problem-specific logic of measuring the result and interpreting it is also kept outside the implementation. 
Instead, the operation takes a qubit array as one of the inputs, and the code that calls it can measure the state of those qubits afterward.

> [!NOTE]
> At this point, the code doesn't define an `@EntryPoint`, since running it on its own wouldn't do anything interesting. 
> In the next section, we'll see how to prepare all the necessary parameters and pass them to the code.

## Let's solve the graph coloring problem!


Now you are ready to put together everything you've learned so far and solve the problem of preparing a route to deliver specific supplies to different space stations.
Recall that this problem is an instance of the graph coloring problem we introduced in the second unit, where a color stands for a type of supply. It can be fuel, food, water, 
construction materials, clothing, etc. We strongly recommend that you start solving a smaller version of the problem and consider only 4 types of supplies. 

Here is the full code.

:::code language="qsharp" source="code/6-program-2.qs":::

You should recognize the first three operations as the oracle implementation from unit 4, and the fourth operation as the generic search algorithm we implemented earlier in this unit.

This leaves us only the last operation, which defines the problem we're solving, creates all the necessary parameters, calls the generic search implementation, and interprets the results.

* Note the definition of variables `markingOracle` and `phaseOracle` - the two variants of implementing our problem as a quantum operation. 
  Both variables use _partial application_, that is, fixing several parameters of an operation to produce another operation that takes fewer parameters. 
  Thus, `MarkValidVertexColoring` operation takes three parameters (the list of the graph edges, the input register, and the target qubit), while the `markingOracle` operation takes only two parameters (the input register and the target qubit), with the list of graph edges fixed to the `edges` variable.

* As we've seen in the previous unit, the optimal number of iterations depends on both the search space size and the number of solutions. 

  The first one is easy to define - any bit string of `2 * nVertices` bits can be interpreted as a potential coloring of `nVertices` vertices, so there are $2^{2\textrm{nVertices}} = 1024$ candidates.

  The number of solutions is generally trickier to estimate, but in our example, the graph structure is easy to analyze. 
  Vertices 0 - 3 make up a full graph, so they have to be assigned distinct colors in any order - since we have a total of four colors available, there are $4!$ ways to do this. 
  Vertex 4 is connected only to vertex 3, so it can take any color except the color of vertex 3, which gives us three options for each coloring of the other vertices. 
  The total number of solutions is $4! \cdot 3 = 72$.

  Taking this into account, we'll end up running $\frac{\pi}{4} \sqrt{\frac{N}{M}} = 2.96 \approx 3$ iterations.

* The `repeat ... until` loop handles the possibility of getting an incorrect answer on the first run of the algorithm. 
  The body of the loop runs the algorithm once, measures the qubit register to get the result, and then checks whether it is a solution to the problem. If it is, the variable `correct` is updated to reflect that and the measurement results are converted to a bit array. Otherwise, the algorithm is run again.

If you run the algorithm, you'll see output like this:

```output
The resulting graph coloring:
Vertex 0 - color 0
Vertex 1 - color 2
Vertex 2 - color 1
Vertex 3 - color 3
Vertex 4 - color 2
```
If you deliver 4 types of supplies to our stations, you have to send a spaceship to a route based on the results you got here. 

## Watching the amplitudes

Now let's take a look at the behavior of the amplitudes of the basis states at the key points during the algorithm execution.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4JQ8E]

Congratulations! You've implemented your first quantum search algorithm and used it to solve a small problem.

In the next unit, you consider other examples and you take a look at what kinds of real-world problems are, or are not, a good fit for using Grover's algorithm to solve them.

