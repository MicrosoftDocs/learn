




Simulation of physical systems has long been a driving force in the push toward quantum computing.
This is because quantum dynamics are widely believed to be intractable to simulate on classical computers, meaning that the complexity of simulating the system scales exponentially with the size of the quantum system in question. 
Simulating problems in chemistry and material science remains perhaps the most evocative applications of quantum computing, and would allow us to probe processes and systems that were previously beyond our ability to measure or simulate. 
Besides molecular problems in quantum chemistry, which our discussion below focuses on, this ability (and the Q# quantum chemistry library) will also allow us to simulate correlated electronic materials such as high-temperature superconductors.

> [!VIDEO https://www.youtube.com/embed/Hxz0tH8jDfQ]

## Molecules and Hamiltonians

Regardless of whether your simulation will ultimately be classical or quantum, the obvious starting point of many problems in computational chemistry is the structures of the molecules involved. 
Among other things, these "structures" consist of the species of atoms comprising the molecule, their spatial layout, and the properties of the net electronic orbitals which result from the hybridization of each individual atom's electronic orbitals (which can be efficiently computed classically).
All of this provides the information needed to end up at a molecule's *Hamiltonian*, which is a full description of the energies of interactions between particles in the molecule.

The behavior of any system is governed by its Hamiltonian.
Often represented as a matrix, $H$, the Hamiltonian dictates the *dynamics* of a state---that is, how it evolves in time. 
So, if the system begins in state $\ket{\psi(0)}$, the state at any future time $t$ is given by $\ket{\psi(t)} = e^{- i H t} \ket{\psi(0)}$. 

### Hamiltonians of electronic systems

Considering the makeup of a molecule (or a solid-state system), what exactly are these energies and interactions which make up the Hamiltonian? 

The components of a molecule are the positively charged nuclei and negatively charged electrons, and therefore Coulomb attraction/repulsion plays a role. 
Of course, these particles do not stand still, so we must also consider the kinetic energy that each has.

At the deepest level, we must consider the energies resulting from:
- the kinetic energies of the electrons,
- the repulsion between each electron,
- the attraction between each electron and each nucleus of the molecule,
- the kinetic energies of the nuclei, and
- the repulsion between nuclei. 

Because the nuclei are far heavier than the electrons (the mass of each proton is about 1836 times that of an electron), the Born-Oppenheimer approximation is commonly used to simplify the Hamiltonian.
This assumes that the nuclei are at rest, and therefore the last two terms in the list above simplify to a constant energy offset (with the kinetic energies zero, and the energy of their repulsion set).

Hence the molecular problem becomes primarily a problem regarding the electronic structure. 
The first three terms are what lead to the formation of quantized electronic orbitals in the context of individual atoms, and the same is true when moving to their interaction within a molecule or solid where hybridized and interacting orbitals arise.


## How can quantum help?

Because electrons are quantum particles, specifically *fermions*, the amount of time it takes to classically simulate the electronic structure of a molecule will scale exponentially with the number of electrons in the system. 
For a system with $n$ quantum particles, $2^n$ terms are required to represent the full state wavefunction, $\psi$, and the corresponding Hamiltonian ends up with a $2^n \times 2^n$ matrix representation.
Hence classical computing becomes infeasible even at moderate system sizes $n$. 

This is where the potential of *quantum* simulation comes in: by mapping those electrons and their interactions to the qubits of a quantum computer, that same behavior can be simulated efficiently.
Rather than the exponentially scaling space/runtime required to mathematically represent and classically simulate quantum particles and their interactions, quantum simulation simply embeds those properties in *other* quantum particles, and therefore allows the behavior to be simulated directly and efficiently.

Suppose we wanted to simulate the evolution of an $n$-particle system for an amount of time $T$. 
We know that the system itself in nature would perform the "simulation" in time $T$ using precisely those $n$ particles.
This therefore represents the *ideal* case for quantum simulation: requiring the same time and number of particles. 
Understandably this is unattainable in practice, but quantum algorithms have already been developed which, up to polylogarithmic factors, attain this linear scaling in both $n$ and $T$. 

## The quantum chemistry library: a practical tool

Despite the limitations of direct classical simulation, quantum chemistry has grown into a robust and diverse field of study over the past decades.
Quantum computation/simulation will enable researchers to explore countless previously inaccessible paths, but in order to do so it must be amenable to the problems and practices already used in the field.
Besides the quantum algorithms themselves, which reside in Q# and will ultimately be the instructions to the quantum hardware, the quantum chemistry library also provides classical tools which allow this quantum potential to be seamlessly integrated into existing computational chemistry practices.

As such, most applications of the quantum chemistry library are ideally suited for integration with a host program, which, among other things, allows support for file input/output.

### Molecular data files

Because the Hamiltonians of large and complex molecules can contain thousands or millions of terms, molecular data files are understandably a staple in computational chemistry.

The quantum chemistry library is designed to work well with computational chemistry packages, most notably the [NWChem](https://nwchemgit.github.io/) computational chemistry platform.
NWChem can export data files directly in the [Broombridge](https://docs.microsoft.com/quantum/user-guide/libraries/chemistry/schema/broombridge?view=qsharp-preview) format schema used with Q#, and also has a web-based front-end to piece together your own molecules at [EMSL Arrows Builder](https://arrows.emsl.pnnl.gov/api/qsharp_chem).

The library provides host program tools for loading these files as instances of quantum simulation problems.

### Mapping Hamiltonians to quantum computers

Although electrons are themselves quantum particles, they are very different from the qubits comprising a quantum computer.
For example, the fermionic nature of electrons implies that they must be treated as *indistinguishable*, which distinct qubits most certainly are not. 
Nevertheless, the properties of the electrons can be approximately embedded in the quantum computer by mapping them to specific states and interactions between qubits. 
There exist numerous approaches to this mathematical mapping, such as the [Jordan-Wigner representation](https://docs.microsoft.com/quantum/user-guide/libraries/chemistry/concepts/jordan-wigner?view=qsharp-preview), each with their own advantages and disadvantages.

Fortunately, these mappings are easily computed classically, and therefore the quantum chemistry library includes host program tools which perform this automatically. 
With the Hamiltonian in a representation suitable for quantum simulation, the host program can then directly pass this encoding as an argument when calling the Q# operation to run the simulation.


## Example application: molecular energy levels
A common problem in quantum chemistry is determining the energy levels of a molecular system.
Fortunately, the widely used quantum algorithm for *phase estimation* provides a method to effeciently do just that.

The quantized states a molecular system are *eigenstates* of the system's Hamiltonian, meaning that they are both static and have a fixed energy level (the corresponding *eigenvalue*). 
That is, if the system is in an eigenstate $\ket{\psi_n}$, then the state itself does not change in time, but only acquires a numerical phase factor which depends on the corresponding energy level, $E_n$. 
Mathematically, 
$$e^{-i H t} \ket{\psi_n} = e^{-i E_n t} \ket{\psi_n}.$$

This situation aligns perfectly to the phase estimation algorithm, which, when provided a unitary $U$ with eigenstate $\ket{\psi}$, returns the phase $\phi$ such that 
$$U \ket{\psi} = e^{i \phi} \ket{\psi}.$$

So, given a molecule's ground state $\ket{\psi_0}$ and using $e^{-i H t}$ as $U$, we can immediately extract the ground state energy $E_0$ from the algorithm's output via $\phi = E_0 t$.

### Ground state estimation with Q#

With all of the heavy lifting taken care of by existing functions/operations in the Q# standard and quantum chemistry libraries, the workflow to perform the task above could look like the following:

1. Create Q# project, add the quantum chemistry library to it
1. Get molecular data file
1. Create Q# program which
    - accepts properly encoded Hamiltonian from host program.
    - runs phase estimation algorithm.
    - returns energy level estimate.
1. Create host program to
    - import molecular data file.
    - encode Hamiltonian to Q#-amenable form.
    - call Q# operation and receive returned energy estimate.
    - save, plot, or process that returned value to your heart's content.

## Explore further

- To get started using the quantum chemistry library with your Q# projects, see [Using additional Q# libraries](https://docs.microsoft.com/quantum/user-guide/libraries/additional-libraries?view=qsharp-preview&tabs=tabid-csproj)
- Learn how to use additional tools from the library at [Chemistry library installation](https://docs.microsoft.com/quantum/user-guide/libraries/chemistry/installation?view=qsharp-preview), and explore the entire documentation section for more.
