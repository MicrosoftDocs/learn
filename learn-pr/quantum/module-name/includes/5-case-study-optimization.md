Azure Quantum offers optimization solutions, where some divisions of the space team can run optimization algorithms using classical hardware. For example, the logistics and maintenance divisions will need this optimization service for cargo vessel loading. There are other optimization problems of interest, such as optimizing traveling time between planets, job scheduling prioritization, or finding the equilibrium configuration of certain proteins of a recently discovered form of life.

![Figure Azure Quantum Optimizations Problems](../media/5-azure-quantum-optimization-solutions.png)


Complex optimization problems exist across every industry: vehicle routing, supply chain management, portfolio optimization, power grid management and many others. Optimization algorithms are also at the core of many machine learning methods. Solving these real-world problems results in high-value benefits, such as reduced costs, accelerated processes, or reduced risks. Many real-world optimization problems still remain unsolvable by classical computing despite the remarkable advancement in both algorithms and computing power over the past decades.

Emulating quantum effects on classical computers has led to the development of new types of quantum solutions that run
on classical hardware, also called *quantum-inspired* algorithms. These algorithms allow us to exploit some of the advantages of
quantum computing approaches today on classical hardware, providing a speedup over traditional approaches. Using quantum solutions on classical hardware also prepares us for the future of quantum optimization on actual quantum hardware.

## Application case studies

### Traffic optimization

Traffic congestion results in a significant time and cost burden in many metropolitan areas. Another important use
case for vehicle routing is the efficient evacuation of large urban areas.

One example of applying quantum-inspired optimization is to significantly reduce both traffic congestion and travel time. Ford and Microsoft have worked together on a solution that shows a more than 70% decrease in traffic congestion and a reduction of
average travel time of approximately 8%,  in preliminary studies with up to 5,000 vehicles and compared to the best routes provided by Bing Maps. 

[Traffic optimizations](https://arxiv.org/abs/1708.01625) of approximately 400 vehicles takes 20 seconds on a quantum annealing machine. In the case study, the
quantum-inspired algorithms tackle a comparable problem in only 0.02 seconds on a single CPU core. Larger problems could also be
accelerated using specialized hardware, such as FPGAs available in Azure, by at least two orders of magnitude, which
enables the speed required to address the scale of real-world routing complexity, well beyond simple toy problems. 

### Materials Design
Many of the staples of modern life such as compact electronics, energy efficient transportation, and innovative buildings and construction techniques are owed to advancements in materials science that allow researchers to create materials whose chemical structures maximize certain physical properties such as strength, electrical characteristics, weight, or other features. However, designing materials to maximize these properties requires simulating the complex quantum physics that dictate how the atoms that make up these materials interact with the world around them. For most molecules, this simulation represents a problem that is intractable using traditional computers or methods.

![Quantum Simulation for Material Design](../media/5-quantum-simulation.png)
*Using Azure Quantum and quantum optimization solutions running on classical hardware, Quantum Inspired Optimization (QIO) can enable quantum methods for materials simulations that yield more accurate results.*

In this domain, quantum-inspired optimization can be applied to help achieve near-term advancements in state of the art materials. One example of this comes from OTI Lumionics who have applied optimization solvers in [Azure Quantum to do materials simulations](https://cloudblogs.microsoft.com/quantum/2020/01/21/oti-lumionics-accelerating-materials-design-microsoft-azure-quantum/) that they can apply to their R&D process as they design the next generation of OLED displays. To accomplish this, they leveraged the ability for Azure Quantum's solvers to support the native higher-order problem in a Polynomial Unconstrained Binary Optimization (PUBO) problem - reducing the problem definition from 58,265 variables to just 132. Making use of parameter-free solvers they were also able to save valuable time optimizing parameters.  By using Azure Quantum’s optimization tools in their pipeline, OTI Lumionics successfully performed
a complete active space configuration interaction simulation of an archetype green light
emitting OLED material — Alq3 [Tris (8-hydroxyquinolinato) aluminum].

In addition to solving complex optimization problems, quantum computers may be able to aid in chemistry and materials development far beyond the capacity of present-day supercomputers. Such simulations could lead to breakthroughs in materials science such as batteries with greater capacity and longer life spans, high temperature superconductors, and new catalysts for converting and optimizing alternative fuel sources. In addition, because of the difficulty of simulating the characteristics of complex molecules, the development of new materials with specific properties — like next-gen batteries — poses huge computational challenges as well. With quantum breakthroughs in material science, lower emissions and better efficiencies begin to come into focus. 

### Energy and utility
Simulating aerodynamics is another area that requires heavy computation. On a windmill farm, design the placement of windmill locations is critical, as windmills harness power from the wind but can also disrupt airflow and hinder the farm from utilizing the wind's maximum power. 

Although airflow and turbulence are seemingly classical and macroscopic phenomena, one can get inspiration from quantum mechanical systems, such as an electron behaving like a spinning top, approximating it as a mechanical engine of interacting rotors. 

Microsoft Quantum Network Member Qubit Engineering is creating
rotor models to simulate what turbulence looks like in the air. Azure Quantum has tools to solve these rotor models in order to find
minimum and maximum energy configurations, which helps Qubit Engineering apply quantum theories to calculate the optimum
placement of windmills within a space.

By understanding environmental factors and adding how the
windmills might interact with each other, Qubit Engineering has created
an abstract modeling scoring system to find the optimal placement for
maximum energy production under a variety of circumstances.

### Signal processing
Magnetic Resonance Imaging (MRI) is a key diagnostics tool in healthcare and has played a pivotal role in the treatment of the most harming
diseases for humanity ranging from cancer to heart disease to Alzheimer’s. While much progress has been made in recent decades,
improvements in imaging and scan times have been incremental, with significant improvements limited by computational challenges.

Microsoft Quantum has teamed up with Case Western Reserve University to use bespoke quantum-inspired optimization solutions running on classical hardware to develop new pulse sequences for [MRI scans]( https://news.microsoft.com/innovation-stories/quantum-computing-mri-cancer-treatment/). The discoveries were significant:

When optimizing for speed, the pulse sequences generated are typically shorter, resulting in up to three times faster scans, and delivery of comparable image quality. 

When optimizing for scan precision, these sequences can yield as much as a 30% improvement in resolution, potentially
leading to an earlier diagnosis and treatment.

Faster imaging, as well as imaging with better precision at a fixed scan time, can lead to new diagnostics tools that may help tackle today’s medical challenges while reducing the cost and side effects of the scans.

Read more about applications of quantum-inspired optimizations in the [Quantum Impact case studies.](https://azure.microsoft.com/en-us/resources/whitepapers/search/?term=quantum).

Understanding the power of quantum-inspired optimization, you will work with your crew in module [Solve QIO problems](https://docs.microsoft.com/en-us/learn/modules/solve-quantum-inspired-optimization-problems/) to help the logistics division efficiently load cargo vessels, and in module [Solve the job shop scheduling problem](https://docs.microsoft.com/learn/modules/solve-job-shop-scheduling-optimization-problem?azure-portal=true) with the maintenance division to prioritize different kinds of jobs on the spaceship. 
