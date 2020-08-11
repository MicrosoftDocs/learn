## Molecules and Hamiltonians

The simplest and most complex molecules are all built of atoms whose spatial arrangement, nuclear masses and charges, and electronic orbitals interact to produce the net properties of the molecule.
One such property, crucial to understanding how it will interact with other molecules, is the resulting electronic of structure of the molecule itself. 

Regardless of whether your simulation will ultimately be classical or quantum, the obvious starting point of many problems in computational chemistry is the structures of the molecules involved. 
Among other things, these "structures" consist of the species of atoms comprising the molecule, their spatial layout, and the properties of the net electronic orbitals which result from the hybridization of each individual atom's electronic orbitals (which can be efficiently computed classically).
All of this provides the information needed to end up at a molecule's *Hamiltonian*, which is a full description of the energies of interactions between particles in the molecule.

The behavior of any system is governed by its Hamiltonian, $H$, which is often represented as a matrix, and comprises all of the components and interactions in the system.
Specifically, the Hamiltonian dictates how a state evolves in time---its *dynamics*.
So, if the system begins in state $\ket{\psi(0)}$, the state at any future time $t$ is given by $\ket{\psi(t)} = e^{i H t} \ket{\psi(0)}$. 

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

Molecular data files are understandably a staple in computational chemistry, and the quantum chemistry library provides tools for loading these files as instances of quantum simulation problems.
The computational chemistry software NWChem(LINK), widely used to generate such data files, can now export directly in the Broombridge(LINK) format schema used with Q#, but the quantum chemistry library also provides tools(link to chem lib install `qdk-chem`) to convert to Broombridge from other formats. 

(TO DO: exposition on the need to transform to JW encoding)


## Example application: energy levels
A common problem in quantum chemistry is determining the energy levels of a molecular system.
Fortunately, the widely used quantum algorithm for *phase estimation* provides a method to effeciently do just that.

The quantized states a molecular system are *eigenstates* of the system's Hamiltonian, meaning that they are both static and have a fixed energy level (the corresponding *eigenvalue*). 
That is, if the system is in an eigenstate $\ket{\psi_n}$, then the state itself does not change in time, but only acquires a numerical phase factor which depends on the corresponding energy level, $E_n$. 
Mathematically, 
$$e^{i H t} \ket{\psi_n} = e^{i E_n t} \ket{\psi_n}.$$

This situation aligns perfectly to the phase estimation algorithm, which, when provided a unitary $U$ with eigenstate $\ket{\psi}$, returns the phase $\phi$ such that 
$$U \ket{\psi} = e^{i \phi} \ket{\psi}.$$

So, given a molecule's ground state $\ket{\psi_0}$ and using $e^{i H t}$ as $U$, we can immediately extract the ground state energy $E_0$ from the algorithm's output via $\phi = E_0 t$.

### Ground state estimation with Q#
With all of the heavy lifting taken care of by existing functions/operations in the Q# standard and quantum chemistry libraries, the workflow to perform the task above could look like the following:
1. Create Q# project, add the quantum chemistry library to it
2. Get molecular data file
3. Create Q# program which
    - accepts properly encoded Hamiltonian from host program
    - runs phase estimation algorithm
    - returns energy level estimate
3. Create host program to
    - import molecular data file
    - encode Hamiltonian to Q#-amenable form
    - call Q# operation and receive returned energy estimate
    - save, plot, or process that returned value to your heart's content

## Explore further

- To get started using the quantum chemistry library with your Q# projects, see [Using additional Q# libraries](https://docs.microsoft.com/en-us/quantum/user-guide/libraries/additional-libraries?view=qsharp-preview&tabs=tabid-csproj)
- Learn how to use additional tools from the library at [Chemistry library installation](https://docs.microsoft.com/en-us/quantum/user-guide/libraries/chemistry/installation?view=qsharp-preview), and explore the entire documentation section for more.
- SAMPLES
- ??


