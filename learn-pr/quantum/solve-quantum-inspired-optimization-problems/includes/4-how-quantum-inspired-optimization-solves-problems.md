Before we get down to business, let's discuss two common methods for finding the global minimum of a cost function: *simulated annealing* and *quantum annealing*. [Simulated annealing](https://wikipedia.org/wiki/Simulated_annealing?azure-portal=true) is based on ideas from thermal physics, whereas [quantum annealing](https://wikipedia.org/wiki/Quantum_annealing?azure-portal=true) is a quantum algorithm.

## Simulated annealing

For optimization problems in search spaces that are too large to solve by exhaustive search and with cost functions that are rugged, one of the most successful and commonly used heuristics is simulated annealing. *Heuristics* is a technique for finding an approximate solution. Heuristics is useful in situations where finding an exact solution can take too long. You can think of the technique as a random walk through the solution space, where each walker creates a path through the optimization landscape.

### How does simulated annealing work?

Simulated annealing is similar to gradient descent. The algorithm simulates a walker that, ideally, always moves downhill. But, unlike gradient descent, the walker can also take uphill moves with some non-zero probability. This creates the possibility for the walker to escape from local minima and then descend into deeper neighboring minima.

![A plot that shows a walker taking an uphill move in order to find a lower point.](../media/plot-simulated-annealing-2.png)

In this graph, notice that this uphill move is described as a *thermal jump*. That's because simulated annealing is an algorithm from physics that mimics the behavior of materials as they are slowly cooled. The walker is like an atom in a metal that's driven by temperature to reconfigure itself. These changes are random, but moves to lower-energy configurations are more likely than moves to higher-energy configurations. That is why we say the walker follows a biased random walk.

Simulated annealing isn't a QIO method, because it uses only thermal effects. However, it's a technique that's commonly used for solving combinatorial problems such as the ones we use QIO methods on, and the problems can be formulated in the same way.

## Quantum annealing

Quantum annealing is a quantum algorithm that's similar in spirit to simulated annealing, but it differs in a few ways. In simulated annealing, we explored the solution space by making thermal jumps from one solution to the next. In quantum annealing, we instead make use of a quantum effect called *quantum tunneling*, which allows us to travel through these energy barriers.

![A graph that compares a thermal jump over an energy barrier to quantum tunneling through an energy barrier.](../media/tunneling.png)

In this graph, you can see the difference between a thermal jump, where thermal fluctuations help a walker overcome an energy barrier, and quantum tunneling, where quantum effects allow a walker to pass through the energy barrier.

### How can quantum annealing be used to solve optimization problems?

In quantum annealing, we frame our problem by giving assignments to our variables, the energy of which is the value of the cost function.

Initially, we begin with the quantum state in a broad superposition over many possible assignments to the variables. Instead of varying the temperature, as we did in simulated annealing, we vary a parameter called the *quantum field strength*.

This parameter defines the radius of neighboring states we can move to. As time goes on and we get closer to a solution, this radius becomes smaller and smaller. By the end of the annealing process, the system has settled into one particular low-energy configuration that can then be measured, which gives us the solution to the optimization problem. The most mathematically clean formulation of quantum annealing is called *adiabatic quantum optimization*, and this is what quantum-inspired methods attempt to emulate.

## Azure Quantum optimization techniques

In Azure Quantum, we make available a range of physics-inspired and quantum-inspired techniques to solve discrete and combinatorial optimization problems:

* **Simulated annealing**: A classical stochastic [simulation method](https://doi.org/10.1126/science.220.4598.671?azure-portal=true) that mimics the slow cooling of a material (annealing) to remove imperfections. A temperature is reduced according to a schedule. Thermal hops assist in escaping from local minima in the search space.
* **Parallel tempering**:  A related [classical optimization approach](https://doi.org/10.1143/JPSJ.65.1604?azure-portal=true), where copies of a system are kept at different temperatures, automating the repeated heating and cooling in tempering approaches. It can be used to accelerate both classical and (simulated) quantum annealing, as well as many other heuristics.
* **Quantum Monte Carlo**: A quantum-inspired optimization that mimics the quantum annealing method using [quantum Monte-Carlo](https://journals.aps.org/prb/abstract/10.1103/PhysRevB.96.134305?azure-portal=true) simulations. Analogous to the temperature in simulated annealing, the quantum tunneling strength is reduced over time. Quantum tunneling effects assist in escaping from local minima in the search space.

Note that this is just a small subset of available techniques, and we continue to develop and add [new solvers to the service](https://doi.org/10.1103/PhysRevA.94.022337?azure-portal=true).
