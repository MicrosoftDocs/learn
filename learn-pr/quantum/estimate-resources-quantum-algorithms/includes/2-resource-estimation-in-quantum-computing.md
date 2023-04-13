In quantum computing, resource estimation is the ability to understand the resources that are required for a given algorithm. The resources will be the number of qubits, the number of quantum gates, or processing time. Required resources vary for different computational scenarios based on the type of error correction scheme and other parameters. 

## Why is resource estimation important?

Quantum computers have the potential of *quantum advantage* to solve some scientifically and commercially valuable problems. They can outperform any classical computer. To achieve quantum advantage, you must have a large-scale, fault-tolerant quantum computer. That is, a quantum computer that's capable of allowing a large number of qubits in superposition, and with a physical error rate below a certain threshold. Through the application of QEC schemes, quantum information is protected from errors that are caused by decoherence and quantum noise.

Quantum operations at the physical level are noisy. The long computations that are required for practical quantum advantage require error correction to achieve fault tolerance. QEC is both time intensive and space intensive. It requires increased execution time for an algorithm-level or logical-level operation and an extra number of physical qubits to store and compute information at the logical level.

Understanding the impact of architecture design choices and QEC schemes for specific applications is an important challenge. You have to answer several questions. For example, how large does a quantum computer need to be to achieve practical quantum advantage? How long does the computation take? Are some qubit technologies better suited than others to solve the problem you want to solve? What are the best architecture choices in the hardware and software stacks to support scaled quantum computation?

Estimating the running time, the number of qubits, and other resources that will be used in realistic models of quantum computers is the first step to reducing these resource requirements. Resource estimation allows you to understand the differences between qubit technologies so that you can prepare and refine your quantum solutions to run on scaled quantum machines in the future.

## Resource estimation for practical quantum applications

To achieve practical quantum advantage, quantum computers require an underlying qubit technology that at scale is:

- **Controllable**: QEC requires reliable control of more than 1 million well-connected qubits, with parallel operations that fail in under one part in a thousand.
- **Fast**: To achieve a practical runtime of one month or less, while targeting around 1 million physical qubits, operations need to be performed in under a microsecond.
- **Small**: Scaling to 1 million and more qubits constrains the size of the qubit to tens of microns in diameter.

Next, learn about the Azure Quantum tool that you can use to estimate the resources of a quantum algorithm.
