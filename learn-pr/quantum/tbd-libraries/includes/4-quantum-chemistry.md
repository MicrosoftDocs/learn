OUTLINE:
Overview of fermionic Hamiltonians with interactions, presenting the general eqs *briefly* but always immediately turning to the equation as it looks for molecular hydrogen.
 

- but indistinguishable fermions and those operators not representable in the qubits and interactions of a quantum computer
- --> Jordan Wigner representation

- all of these processes (making the relevant atomic orbitals, importing the molecular data, and transforming it to a representation amenable to quantum computers/Q#) are efficiently handled classically 

- note that we stick to the command-line application here, so will put the input JW form direct in the Q# operation, but normal work flow will be via host program which includes functionality to import any size molecular data file, transform to JW, and input this to the Q# op (details linked to in conclusion)

- beginning of Q# code incl JWEncodingData

------------------------------------------------------

## ACTUAL PAGE START

Although of the quantum chemistry library's functionality is built around using Q# with a host program (e.g. importing large molecular structure files and transforming them into a form for input to a Q# operation), we will continue to use Q# from the command-line in this module.
As such, we will demonstrate a small example of such an application, where the molecular structure is small and straightforward to implement by hand, noting where the host program would take care of things.

A common problem in quantum chemistry is determining the ground state energy of a molecular system. 
From the simplest to the most complex molecules, they are all built of atoms whose spatial arrangement, nuclear masses and charges, and electronic orbitals interact to produce the net properties of the molecule.
One such property, crucial to understanding how it will interact with other molecules, is the resulting electronic of structure of the molecule itself. 

However, because electrons are quantum particles, specifically *fermions*, the amount of time it takes to classically simulate the electronic structure of a molecule will scale exponentially with the number of electrons in the system. 
That is where the potential of *quantum* simulation comes in: by mapping those electrons and their interactions to the qubits of a quantum computer, that same behavior can be simulated efficiently.

In the next few units, we will show how the quantum chemistry library provides the tools to do just that with Q#.

## From molecular structure to molecular properties 

Regardless of whether your simulation will ultimately be classical or quantum, the obvious starting point of many problems in computational chemistry is the structures of the molecules involved. 
Among other things, these "structures" consist of the species of atoms comprising the molecule, their spatial layout, and the properties of the net electronic orbitals which result from the hybridization of each individual atom's electronic orbitals (which can be efficiently computed classically).
All of this provides the information needed to end up at a molecule's *Hamiltonian*, which is a full description of the energies of interactions between particles in the molecule.

### The Coulomb Hamiltonian

Considering the makeup of a molecule, what exactly are these energies and interactions? 

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
The first three terms are what lead to the formation of quantized electronic orbitals in the context of individual atoms, and the same is true when moving to their interaction within a molecule where hybridized and interacting orbitals arise.


### The second quantized Hamiltonian

- briefly mention how the normal hamiltonian in terms of atomic orbitals (spatial and spin components), and how this translates to the second quantized formalism: the primary representation of molecular systems

- present second quantized form in general up to two-particle interactions

## Casting molecular Hamiltonian to a quantum computer

Need to:
- import/access the Hamiltonian of a particular molecule
- transform that second quantized (fermionic) Hamiltonian to a near-equivalent one where the electrons and their interactions are represented by qubits of a quantum computer

All of this is easily handled classically, and the tools necessary are also included in the QDK.

### Molecular data files
- the Hamiltonians of large and complex molecules (those for which quantum simulation will lend real advantage over classical) can contain thousands or millions of terms
- fortunately, have access to molecular structure databases, which contain files for countless molecules, as well as classical tools for creating the files for any molecule by specifying the constituent atoms and their properties like spatial layout (mention NWChem and EMSL)
- the QDK contains host program tools which allow you to import such a file, and then transform it to a representation that can be input to the Q# operation which will then run on a quantum computer. 

### Jordan-Wigner representation
- still a crucial difference between indistinguishable electrons (fermions) of a molecule and the qubits of a quantum computer; need to map them to qubits and qubit interactions
- multiple ways of doing so, but the Jordan Wigner transformation is a well-studied and straightforward one which we will use in our example 

## Molecular Hydrogen
- simplest possible molecule with only two electrons
- future module will go through the normal workflow which uses a host program to import the data file, transform it to a qubit representation, and calling the Q# operation with that representation as input.
- for now though, we will remain with the command-line application, and therefore input the JW representation directly in a Q# wrapper operation

- **Goal**: estimate the energy of the ground-state of the two electrons

### Jordan-Wigner Hamiltonian terms
- explicit form of second quantized hamiltonian, with illustration of the integral forms of the $h$ terms
- explicit form of JW representation of Hamiltonian


In Q# file of your project which has the quantum chemistry library added:

- open respective namespaces

```qsharp
    open Microsoft.Quantum.Chemistry.JordanWigner; 
    open Microsoft.Quantum.Chemistry;

    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Simulation;
    open Microsoft.Quantum.Characterization;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
```

- create wrapper operation with the JW terms we used above:


```qsharp
    @EntryPoint()
    operation WrapGetEnergyTrotterization() : (Double, Double) {

        let emptyHTermArr = new HTerm[0];
        let JWOptTerms = JWOptimizedHTerms(([HTerm(([0], [0.17120128499999998])),
                                            HTerm(([1], [0.17120128499999998])),
                                            HTerm(([2], [-0.222796536])),
                                            HTerm(([3], [-0.222796536]))], 
                                            [HTerm(([0,1], [0.1686232915])),
                                            HTerm(([0,2], [0.12054614575])),
                                            HTerm(([0,3], [0.16586802525])),
                                            HTerm(([1,2], [0.16586802525])),
                                            HTerm(([1,3], [0.12054614575])),
                                            HTerm(([2,3], [0.1743495025]))], 
                                            emptyHTermArr, 
                                            [HTerm(([0,1,2,3], [0., -0.0453218795, 0., 0.0453218795]))]));

		/// input "guess" of ground state 
        let JWInputState = JordanWignerInputState(((1., 0.), [0,1]));

		/// full encoding to be input to Q# operation
        let JWEncodingData = JordanWignerEncodingData((4, JWOptTerms, (2, [JWInputState]), -0.09883444600000002 ));
```

All of this would be handled by the classical tools in the host program, which would provide `JWEncodingData` as the input to the Q# operation.

The energy-estimation algorithm will be described more on the next page, but to finish the wrapper operation we add the call to it alongside some algorithm parameters:

```qsharp

        let nBitsPrec = 7;
        let trotterStep = 0.4;
        let trotterOrd = 1;

        return GetEnergyByTrotterization(JWEncodingData, nBitsPrec, trotterStep, trotterOrd);
    }
```





