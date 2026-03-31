
In this unit, you explore some of the most promising applications of quantum computing.

## What problems can quantum computers solve?

A quantum computer isn't a supercomputer that can do everything faster or that can solve every possible problem. A quantum computer expands the set of problems that we can solve efficiently, but there are still problems that are too complex even for a quantum computer to solve.

The following diagram shows the different sets of computational problems according to their complexity. The class of problems that a quantum computer can solve more efficiently than a classical computer are called bounded-error quantum polynomials (BQP) problems. BQP problems are solvable by a quantum computer in polynomial time. Examples of BQP problems include the factoring problem and the search problem.

:::image type="content" source="../media/diagram-complexity.png" alt-text="Diagram of the complexity of the problems, showing the different sets of problems by their complexity.":::

There's a lot of active research into the kinds of problems that a quantum computer can solve faster than a classical computer, and how much faster. Quantum computers do exceptionally well with problems where we need to calculate a large number of possible combinations.

## Quantum simulation

Quantum mechanics is like the underlying operating system of our universe, and describes how the fundamental building blocks of nature behave. Chemical reactions, cellular processes, and material behavior are all quantum mechanical in nature, and often involve interactions between a huge number of quantum particles. Quantum computers have promise to simulate intrinsically quantum mechanical systems, such as molecules, because qubits can be used to represent the natural quantum states in these systems. Examples of quantum systems that we can model include photosynthesis, superconductivity, and complex molecular formations.

## Resource estimation

The Microsoft Quantum resource estimator helps you prepare for the future of quantum computing by providing a way to estimate the resources required to run your quantum programs on scaled quantum computers. Resource estimation helps you answer questions such as, what hardware resources do I need? How many physical and logical qubits do I need, and what type of qubit? How long does my program take to run? How do the required resources compare among different qubit technologies?

With resource estimation, you can refine your quantum algorithms and build solutions that take advantage of scaled quantum computers when they become available.

## Quantum speedups

Many quantum algorithms have been developed that solve certain problems much faster than classical algorithms. Two well-known examples are Grover's algorithm and Shor's algorithm. Grover's algorithm yields a polynomial speedup, and Shor's algorithm an exponential speedup, over their classical counterparts.

A quantum computer that's running Shor's algorithm could break classical cryptographic schemes such as the Rivest–Shamir–Adleman (RSA) scheme, which is widely used in e-commerce for secure data transmission. This scheme relies on the difficulty that classical computers have with factoring large integers into products of large prime numbers.

Grover's algorithm speeds up the solution to unstructured data searches, running the search in fewer steps than classical algorithms can. Indeed, any problem that allows you to check whether a given value is a valid solution (a yes-or-no problem) can be formulated in terms of the search problem.
