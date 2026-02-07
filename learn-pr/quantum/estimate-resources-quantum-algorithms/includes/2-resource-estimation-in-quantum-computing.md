In quantum computing, resource estimation is the ability to understand the resources that are required to run a given algorithm. The resources are, for example, the number of qubits, the number of quantum gates, and processing time.

In this unit, you learn why it's important to estimate these resources before you run an algorithm on a quantum computer.

## How long does it take to run a quantum algorithm?

Quantum computers have the potential of quantum advantage to solve scientifically and commercially valuable problems. For example, one of the top applications for quantum computing is to break encryption. The RSA encryption algorithm is based on how difficult it is to factor a very large number into a product of two large prime numbers. A quantum computer can factor large numbers exponentially faster than a classical computer.

So, the question is, how long does it take to run a quantum algorithm that breaks encryption on a real quantum computer? Or in other words, are my passwords still secure in a world with good quantum computers?

The truth is that the resources you need to run a quantum algorithm on a future scaled quantum computer vary for different computational scenarios. Factors that affect resource requirements include the type of qubit, the error correction scheme, and other architecture design choices.

The Microsoft Quantum resource estimator is a tool that helps you estimate the resources you need to run a quantum algorithm for a future scaled quantum computer. For example, the resource estimator can estimate the resources needed to break a particular encryption algorithm.

The following diagram shows the estimated runtime and number of qubits needed to break different encryption algorithms for different qubit types. Here are the components of the diagram:

- Classical encryption algorithms, which are RSA (blue), Elliptic Curve (green), and Advanced Encryption Standard (red).
- Key strength, which is set to highest.
- Qubit types, which are topological (circle) and superconducting (triangle).
- Qubit error rate, which is set to reasonable.

:::image type="content" source="../media/resource-estimation-crypto.png" alt-text="Diagram showing the number of qubits and runtime required to break different encryption algorithms for different qubit types.":::

The diagram shows that the number of qubits and runtime needed to break the Advanced Encryption Standard (AES) encryption algorithm is significantly higher than for the Elliptic Curve and RSA algorithms. The diagram also shows that the resources needed to break all three encryption algorithms are higher for superconducting qubits than for topological qubits. If you want to know more about the diagram, see [Analyze cryptographic protocols with the resource estimator](/azure/quantum/resource-estimator-quantum-safe-planning).

With this in mind, the resource estimator helps you analyze the impact of quantum computing on the security of some classical encryption methods, and prepare for a quantum-safe future.

## Why is resource estimation important in quantum computing?

It's important to understand the impact of hardware architecture design choices and quantum error correction schemes for specific applications. Resource estimation allows you to answer several questions. For example, how large does a quantum computer need to be to achieve practical quantum advantage? How long does the computation take? Are some qubit technologies better suited than others for the problem that you want to solve? What are the best architecture choices in the hardware and software stacks to support scaled quantum computation?

The resource estimator helps you understand how many qubits are needed to run an application, how long the application will take to run, and which qubit technologies are better suited to solve a specific problem. When you understand these requirements, you're able to prepare and refine quantum solutions to run on future, scaled quantum machines.
