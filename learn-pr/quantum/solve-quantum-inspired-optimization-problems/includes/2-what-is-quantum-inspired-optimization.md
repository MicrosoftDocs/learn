Quantum-inspired algorithms are, put simply, classical algorithms where the essential quantum phenomena that would provide the speed-up can be classically emulated.

Quantum-inspired optimization (QIO) is a method that's based on emulating quantum tunneling, as used in the adiabatic quantum optimization algorithm, which we'll explain later. A number of techniques have been developed to simulate this type of physics, and one such approach uses a concept from quantum physics known as [the adiabatic theorem](https://wikipedia.org/wiki/Adiabatic_theorem?azure-portal=true). 

When you apply that theorem to solve a problem, you:

1. First, prepare a system and initialize it to its lowest energy state. For a simple system, one that we completely understand, this is easy to do.

1. Next, slowly transform that system into a more complex one that describes the problem you're trying to solve. The adiabatic theorem states that, as long as this transformation happens slowly enough, the system has time to adapt and will stay in that lowest energy configuration. When you're done with your transformations, you've solved your problem.

As an analogy, imagine a glass of water sitting on a table top. If you move the glass slowly across the surface, the contents won't spill because the system has time to adapt to its new configuration. If you move the glass quickly, however, the system is forced to adapt too quickly, and you have water everywhere.

Although this module focuses on QIO, it's important to remember that the quantum-inspired idea isn't limited to optimization. Similarly, some quantum optimization algorithms might not have a quantum-inspired counterpart.

## Where can QIO be applied?

[Optimization problems](https://en.wikipedia.org/wiki/Optimization_problem?azure-portal=true) are found in every industry, such as manufacturing, finance, transportation, and logistics. In fact, the logistics industry is dedicated entirely to solving optimization problems. To solve these problems, we search through feasible solutions. The best solution is the one with the lowest cost. Adiabatic quantum algorithms are well suited to solving many optimization problems.

Today, we can emulate adiabatic quantum algorithms by using quantum-inspired techniques on classical hardware. These techniques can perform better than state-of-the-art classical optimization techniques:

* In healthcare, QIO algorithms have been applied to optimize [the pulse sequences that are used in an MRI scanner](https://news.microsoft.com/innovation-stories/quantum-computing-mri-cancer-treatment/?azure-portal=true). With improved sequences, scans can be provided up to three times faster than in previous sequences.
* In materials design, OTI Lumionics has used QIO algorithms via Azure Quantum to achieve [more accurate simulations for computational chemistry](https://cloudblogs.microsoft.com/quantum/2020/01/21/oti-lumionics-accelerating-materials-design-microsoft-azure-quantum/?azure-portal=true).

Because QIO methods are heuristics, they're not guaranteed to find the optimal solution. Also, the methods don't always outperform other optimization techniques. In reality, it depends on the problem, and discovering what makes QIO perform better than other methods in some situations and not others is still an active area of research. 

However, as in the preceding cases, we've found that applying QIO to real-world problems can offer new insights and solutions across [a range of industries](https://cloudblogs.microsoft.com/quantum/2020/08/04/jij-toyota-azure-quantum-reducing-carbon-emissions/?azure-portal=true).

In the next unit, we'll discuss the problem types that are well suited to be solved with QIO methods.
