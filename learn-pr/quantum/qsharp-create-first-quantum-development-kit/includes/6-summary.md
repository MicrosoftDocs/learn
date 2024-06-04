Congratulations! Your first Q# program gave you practice performing quantum operations.

The Azure Quantum Development Kit (Modern QDK) provides you with everything you need to start writing and verifying your own quantum algorithms right away.

In this module, we covered a lot. Here are a few key concepts to keep in mind:

* A Q# program must have a namespace and an entrypoint followed by an operation.
* In Q#, you allocate a qubit by using the `use` keyword and the `Qubit()` operation. The qubit is always in the |0〉 state.
* Superposition is a quantum phenomenon where a qubit is in a combination of both zero and one states. If a qubit is in the |0〉 state, you can put it into superposition by using the `H` operation.
* In Q#, you use the `M` operation to measure qubits in the Z-basis. When measured, a qubit goes from being in superposition to one of the classical states.
* You can combine classical code with quantum code. This combination enables you to perform quantum computations and work with the results, all in the same program.

## Learn more

* Explore the [Azure Quantum documentation](/quantum/?azure-portal=true).
* Learn quantum computing with the [Quantum Katas](/azure/quantum/tutorial-qdk-intro-to-katas?azure-portal=true).
