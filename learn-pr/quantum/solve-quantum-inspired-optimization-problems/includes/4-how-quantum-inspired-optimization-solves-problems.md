Here, we discuss two common methods for finding the global minimum of a cost function: *simulated annealing* and *quantum annealing*. Simulated annealing is based on ideas from thermal physics; quantum annealing is a quantum algorithm.

## Simulated annealing

For optimization problems in search spaces that are too large to solve by exhaustive search and with cost functions that are rugged, one of the most successful and commonly used heuristics is simulated annealing. A *heuristic* is a technique for finding an approximate solution. Heuristics are useful in situations where finding an exact solution can take too long. You can think of the technique as a random walk through the solution space, where each person or particle creates a path through the optimization landscape.

### How does simulated annealing work?

Simulated annealing is similar to gradient descent. The algorithm simulates a walker that, ideally, always moves downhill. But, unlike gradient descent, the walker can also take uphill moves with some non-zero probability. This creates the possibility for the walker to escape from local minima and then descend into deeper neighboring minima.

![A plot which shows a walker taking an uphill move in order to find a lower point](../media/plot-sa2.png)

In this graph, notice that this uphill move is described as a *thermal jump*. That's because simulated annealing is an algorithm from physics that mimics the behavior of materials as they are slowly cooled. The walker is like an atom in a metal that's driven by temperature to reconfigure itself. These changes are random but moves to lower-energy configurations are more likely than moves to higher-energy configurations. That is why we say the walker follows a biased random walk.

Simulated annealing isn't a QIO method, since it uses only thermal effects. However it's a technique that's commonly used for solving combinatorial problems like the ones we use QIO methods on. Problems can be formulated in the same way.

## Quantum annealing

Quantum annealing is a quantum algorithm that is similar in spirit to simulated annealing but differs in a few ways. In simulated annealing, we explored the solution space by making thermal jumps, from one solution to the next. In quantum annealing, we instead make use of a quantum effect called _quantum tunneling_, which allows us to travel through these energy barriers.

![Tunneling](../media/tunneling.png)

In this graph, you can see the difference between a thermal jump (where thermal fluctuations help a walker overcome an energy barrier) and quantum tunneling (where quantum effects allow a walker to pass through the energy barrier).

### How does quantum annealing work?

In quantum annealing, we frame our problem by giving assignments to qubits, which are our variables. The energy of a given assignment to the qubits is the value of the cost function.

Initially we begin with the quantum state in a broad superposition over many possible assignments to the qubits. Instead of varying the temperature, as we did in simulated annealing, we vary a parameter called the *quantum field strength*.

This parameter defines the radius of neighboring states we can move to. As time goes on and we get closer to a solution, this radius becomes smaller and smaller. By the end of the annealing process, the system has settled into one particular low-energy configuration that can then be measured, which gives us the solution to the optimization problem. The most mathematically clean formulation of quantum annealing is called *adiabatic quantum optimization*, and this is what quantum-inspired methods attempt to emulate.

Azure Quantum offers a range of solvers that are standard implementations of simulated annealing and quantum-inspired optimization solvers.