In quantum computing, resource estimation is the ability to understand the resources that are required for a given algorithm, that is the number of qubits, number of quantum gates, or processing time. The resources will change in different computational scenarios, depending on the type of error correction scheme and other parameters. 


## Why is resource estimation important in the development of quantum computing?

Quantum computers promise *quantum advantage* to solve some scientifically and commercially valuable problems outperforming any classical computer. Accomplishing this quantum advantage requires a large-scale, fault-tolerant quantum computer. That is, a quantum computer capable of allowing a large number of qubits in superposition, and with a physical error rate below a certain threshold, such that through the application of quantum error correction (QEC) schemes, protects quantum information from errors due to decoherence and quantum noise.

Quantum operations at the physical level are noisy, and so the long computations required for practical quantum advantage necessarily require error correction to achieve fault tolerance. Quantum error correction is both time and space intensive. It requires increased execution time for an algorithm-level, or logical-level, operation and an extra number of physical qubits to store and compute information at the logical level.

Understanding the impact of architecture design choices and quantum error correction schemes for specific applications is an important open challenge. Many questions arise. For example, how large does a quantum computer need to be to achieve practical quantum advantage? How long does the computation take? Are some qubit technologies better suited than others for solving such problems? What are the best architecture choices across the hardware and software stacks to enable scaled quantum computation?

Estimating the running time, number of qubits and other resources needed by realistic models of quantum computers is the first necessary step to reducing these resource requirements. Resource estimation allows us to understand the differences between qubit technologies, so we can prepare and refine our quantum solutions to run on future scaled quantum machines.

## Resource estimation for practical quantum applications

To achieve practical quantum advantage, quantum computers require an underlying qubit technology that at scale is:

- **Controllable**: Quantum error correction requires reliable control of more than a million well-connected qubits, with parallel operations that fail in under one part in a thousand.
- **Fast**: To achieve a practical runtime of one month or less, while targeting around one million physical qubits, operations need to be performed in under a microsecond.
- **Small**: Scaling to a million and more qubits constrains the size of the qubit to tens of microns in diameter.

In the next part, you'll learn about the Azure Quantum tool for estimating the resources of a quantum algorithm.
