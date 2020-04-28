# Simulated and quantum annealing 

We will explain the general idea of simulated annealing and quantum annealing, as the solvers in Azure Quantum use variations of these techniques. 

## Simulated annealing
For optimization problems in search spaces that are too large to solve by exhaustive search and objective functions that are rugged but structured, one of the most successful and commonly used heuristics is simulated annealing.

- **Heuristic**: A technique for finding an approximate solution, when finding the exact solution may take too long.
- **Walker**: We can imagine a person or a particle in our solution space, and each step taken creates a path, or walk, through the optimization landscape.

### How does it work?
Simulated annealing is like gradient descent in that the algorithm simulates a walker that preferentially moves downhill. 
But unlike in gradient descent, the walker can take uphill moves with some non-zero probability. 
This creates the possibility for the walker to escape from local minima and then descend into deeper neighboring minima, as illustrated below.

![A plot which shows a walker taking an uphill move in order to find a lower point](../media/plot_sa2.png)

You'll notice this uphill move is described as a "thermal jump" in the illustration. 
That's because simulated annealing is an algorithm from physics that mimics the behaviour of materials as they are slowly cooled.
The walker is like an atom in a metal, for instance, that are driven by thermal motion to reconfigure themselves. 
These changes are random, however moves to lower-energy configurations are more likely than moves to higher-energy configurations.
Hence, we say it follows a biased random walk. 

### Defining a cost function: Part One
Let's take a look at how we define the cost function of our simulated annealing problem. 
Firstly, we have a number of variables. We can name these variables *x*, and if we have *i* variables, then we can index them individually as follows:

![Variable definition](../media/variable.png)

These variables can take specific values, and in the case of a binary optimization problem they can only take two. 
In particular, if your problem is considering these variables as spins, as in the Ising model, then the values of the variables can be either +1 or -1. 
In other cases, these can simply be 1 or 0, as in the QUBO or PUBO model which we will explain shortly.

Let us consider some variables. Each of these variables has an associated weight, which determines their influence on the overall cost function.
We can write these weights as *w*, and again, if we have *i* variables, then the associated weight for those individual variables can be indexed like so:

![Term definition](../media/term.png)

And so, we can write our cost function as the sum of these weights and variables.

![Cost function definition](../media/cost.png)

### Defining a cost function: Part Two
Currently our cost function only considers individual variables. 
You can think of these as independent contributions to the cost function. 
But often, in real-life scenarios, variables may depend on one another.
So how do we describe this?
Mathematically, we write this as the product of two variables.
Their contribution can be written as their weight, multiplied by each of the variables with indices *i* and *j*:

![Cost function definition](../media/qubo_term.png)

We can combine this with the previous cost function to describe a problem where variables can contribute individually, and based on another variable:

![Cost function definition](../media/qubo_cost.png)

### Defining a cost function: Part Three

However, we don't have to stop there. We can extend this to considering how three variables might depend on one another, using a third index *k*:

![Cost function definition](../media/pubo_term.png)

Combining this again, we have a problem of the form:

![Cost function definition](../media/pubo_cost.png)

- **k-local**: In mathematics, the expressions we have just defined are called "polynomials". 
In the first case, with independent variables, we would say that this polynomial had degree 1.
For a polynomial with degree *k*, we would describe this as a *k*-local problem.
- **QUBO**: In the second case, we introduced the idea of having two variables depend on one another. 
Mathematically, this amounts to introducing quadratic terms. 
Alternatively, we might say it was a 2-local problem.
In Azure Quantum, you might see these problems described as "quadratic unconstrained binary optimization problems", or QUBOs.
- **PUBO**: In the final case, we described a polynomial with maximum degree 3. 
However, we could continue to extend this cost function so that it considered problems of a greater degree. 
In Azure Quantum, we use the term "polynomial unconstrained binary optimization", or PUBO, to describe problems with a maximum degree *k*. 

### Accepting a move

Now that we have defined the structure of our problems, let's look into more detail at how we describe the acceptance of moves.
This translates to considering, "with what probability should I accept a new assignment to these variables"?
Since the moves are driven by thermal motion, it depends on the temperature.
It also depends on the cost (or energy) of the current and proposed configurations, and finally, a constant called the Boltzmann constant.

Mathematically, the probability can be written as follows:

![A mathematical formula](../media/sa.png)

Simulated annealing algorithms mimic this thermal process not only conceptually but in quantitative detail. 
Over the course of the algorithm the temperature is gradually lowered, which means that moves to higher-energy configurations become less and less likely.
This ensures that the search space is explored widely at the beginning, and at the end only small changes are made that fine-tune the solution.

## Quantum annealing
[Quantum annealing](https://en.wikipedia.org/wiki/Quantum_annealing) is a quantum algorithm which is similar in spirit to simulated annealing but differs in a few details. 
For instance, in simulated annealing we explored the solution space by making thermal jumps, from one solution to the next.
In quantum annealing, we instead make use of a quantum effect called "quantum tunnelling", which allows us to travel through these energy barriers. 

![Tunneling](../media/tunneling.png)

We frame our problem by giving assigments to qubits, which are our variables, and the energy of a given assignment to the qubits is the value of the objective function.
Initially we begin with the quantum state in a broad [superposition](https://en.wikipedia.org/wiki/Quantum_superposition) over many possible assignments to the qubits.
Instead of varying the temperature, as we did in simulated annealing, we vary a parameter called the "quantum field strength".

What this parameter defines is the radius of neighboring states that we could move to, as time goes on, this radius becomes smaller and smaller, as we hone in on a solution.
By the end of the anneal, the system has settled into one particular configuration of low energy which can then be measured, thus yielding a (not necessarily optimal) solution to the desired optimization problem.
The most mathematically clean formulation of quantum annealing is called adiabatic quantum optimization, and is what quantum inspired methods attempt to emulate.