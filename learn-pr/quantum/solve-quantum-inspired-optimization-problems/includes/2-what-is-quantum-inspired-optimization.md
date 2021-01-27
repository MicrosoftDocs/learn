There are many types of quantum-inspired algorithms. Put simply, they are classical algorithms inspired by quantum algorithms, where the essential quantum phenomenon that would provide the speed-up can be classically emulated.

Quantum-inspired optimization is a method based on emulating quantum tunneling as used in the adiabatic quantum optimization algorithm, explained later. A number of techniques have been developed to simulate this type of physics, and one such approach uses a concept from quantum physics known as [the adiabatic theorem](https://en.wikipedia.org/wiki/Adiabatic_theorem/?azure-portal=true). When you apply that theorem to solve a problem, you:

- First prepare a system and initialize it to its lowest energy state. For a simple system, one that we completely understand, this is easy to do.
- Next, slowly transform that system into a more complex one that describes the problem you are trying to solve. The adiabatic theorem states that, as long as this transformation happens slowly enough, the system has time to adapt and will stay in that lowest energy configuration. When we're done with our transformations, we've solved our problem.

A good analogy of this is to imagine you have a glass of water. If you move that glass slowly across a table, the contents won't spill because the system has time to adapt to its new configuration. If you were to move the glass quickly however, the system has been forced to change too quickly, and we have water everywhere.

While this module focuses on quantum-inspired optimization, it's important to remember that quantum-inspired isn't limited to optimization. Similarly, there are quantum optimization algorithms that might not have a quantum-inspired counterpart.

## Where can quantum-inspired optimization (QIO) be applied?

[Optimization problems](https://en.wikipedia.org/wiki/Optimization_problem/?azure-portal=true) are found in every industry, such as manufacturing, finance, and transportation. In fact, industries such as logistics are dedicated entirely to solving optimization problems. To solve these problems, we search through feasible solutions. The best solution is the one with the lowest cost. Adiabatic quantum algorithms are well suited to solving many optimization problems.

Today, we can emulate adiabatic quantum algorithms by using quantum-inspired techniques on classical hardware. These techniques can perform better than state-of-the-art classical optimization techniques:

- In healthcare, QIO algorithms have been applied to optimize [the pulse sequences that are used in an MRI scanner](https://news.microsoft.com/innovation-stories/quantum-computing-mri-cancer-treatment/?azure-portal=true). With improved sequences, scans can be provided up to three times faster than previous ones.
- In materials design, OTI Lumionics has used QIO algorithms via Azure Quantum to achieve [more accurate simulations for computational chemistry]((https://cloudblogs.microsoft.com/quantum/2020/01/21/oti-lumionics-accelerating-materials-design-microsoft-azure-quantum/?azure-portal=true)).

Since QIO methods are heuristics, they're not guaranteed to find the optimal solution. Also, they don't always outperform other optimization techniques. In reality, it depends on the problem, and discovering what makes QIO perform better than other methods in some situations and not others is still an active area of research. However, as in the cases above, we have found that applying QIO to real-world problems can offer new insights and solutions across [a range of industries]((https://cloudblogs.microsoft.com/quantum/2020/08/04/jij-toyota-azure-quantum-reducing-carbon-emissions/?azure-portal=true)). 

In the next unit, we'll discuss the problem types that are well suited to be solved with QIO methods.
