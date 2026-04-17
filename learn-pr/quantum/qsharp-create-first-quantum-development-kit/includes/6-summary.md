Congratulations! You successfully created your first Q# program.

The Microsoft Quantum Development Kit (QDK) provides you with everything you need to start writing your own quantum algorithms.

You covered a lot in this module. Here's some of the key concepts that you learned:

- A Q# program must have an entry point, which is the `Main` operation by default.
- To allocate qubits in Q#, use the `use` keyword and the `Qubit` type. Qubits are always in the $\ket{0}$ state when you allocate them.
- A superposition state is a quantum phenomenon where a qubit is in a combination of both the $\ket{0}$ state and the $\ket{1}$ state. If a qubit is in the $\ket{0}$ state, then you can use the `H` operation to put the qubit into an equal superposition state.
- To measure qubits in the Pauli-Z basis in Q#, use the `M` operation. When you measure a qubit that's in a superposition state, the measurement always produces 0 or 1.
- Q# has programming structures that are common to all modern programming languages, such as `for` loops and `if` statements. Combine typical programming structures with quantum-specific features all in a single Q# program.

## Next steps

The QDK includes a set of built-in Q# samples that you can use to learn more about Q# and quantum computing. To view the samples, open a blank Q# file in Visual Studio Code and type `sample`, then select the sample that you want to view from the list of options. For example, you can find the Q# code that you wrote to generate a random bit when you choose **Random Bits sample**.

## Learn more

- Explore the [Azure Quantum documentation](/quantum/?azure-portal=true).
- Learn quantum computing with the [Quantum Katas](https://quantum.microsoft.com/tools/quantum-katas).
