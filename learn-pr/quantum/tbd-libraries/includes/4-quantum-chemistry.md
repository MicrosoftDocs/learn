Although of the quantum chemistry library's functionality is built around using Q# with a host program (e.g. importing large molecular structure files and transforming them into a form for input to a Q# operation), we will continue to use Q# from the command-line in this module.
As such, we will demonstrate a small example of such an application, where the molecular structure is small and straightforward to implement by hand, noting where the host program would take care of things.

-----------------------------------
Overview of fermionic Hamiltonians with interactions, presenting the general eqs *briefly* but always immediately turning to the equation as it looks for molecular hydrogen. 

- atomic orbitals: spatial and spin components
- how this translates to the second quantized formalism: the primary representation of molecular systems 
- (mention the molecular structure databases and tools like NWChem and EMSL, but save links and more details for end)
- but indistinguishable fermions and those operators not representable in the qubits and interactions of a quantum computer
- --> Jordan Wigner representation

- all of these processes (making the relevant atomic orbitals, importing the molecular data, and transforming it to a representation amenable to quantum computers/Q#) are efficiently handled classically 

- note that we stick to the command-line application here, so will put the input JW form direct in the Q# operation, but normal work flow will be via host program which includes functionality to import any size molecular data file, transform to JW, and input this to the Q# op (details linked to in conclusion)

- beginning of Q# code incl JWEncodingData