In quantum computing, resource estimation is the ability to understand the resources that are required to run a given algorithm. The resources are, for example, the number of qubits, the number of quantum gates, and processing time. 

In this unit, you'll learn why the estimation of these resources is important in quantum computing.

## How long does it take to run a quantum algorithm? 

Quantum computers have the potential of *quantum advantage* to solve some scientifically and commercially valuable problems. For example, one of the top applications for quantum computing is to break encryption. The RSA encryption algorithm is based on the difficulty of factoring large numbers. A quantum computer can factor large numbers exponentially faster than a classical computer. So, the question is, how long does it take to run a quantum algorithm that breaks encryption on a real quantum computer? Or in other words, how long are my passwords secure?

The truth is the required resources needed to run a quantum algorithm on a future scaled quantum computer vary for different computational scenarios based on the type of qubits, the error correction scheme, and other architecture design choices. The Azure Quantum Resource Estimator is a tool that helps you estimate the resources needed to run a quantum algorithm. 

The Azure Quantum Resource Estimator is a tool that helps you estimate the resources needed to run a quantum algorithm for a future scaled quantum computer. For example, the Azure Quantum Resource Estimator can estimate the resources needed to break a particular encryption algorithm. The diagram shows the estimated runtime and number of qubits needed to break different encryption algorithms for different qubit types. The diagram shows the following:

- Classical encryption algorithm, which are RSA (blue), Elliptic Curve (green), and Advanced Encryption Standard (red).
- Key strength, which is set to highest.
- Qubit type, which are topological (circle) and superconducting (triangle).
- Qubit error rate, which is set to reasonable.


:::image type="content" source="../media/resource-estimation-crypto.png" alt-text="Diagram showing the number of qubits and runtime required to break different encryption algorithms for different qubit types.":::

The diagram shows that the number of qubits and runtime needed to break the Advanced Encryption Standard (AES) encryption algorithm is significantly higher than the number of qubits and runtime needed to break the Elliptic Curve and RSA algorithms. The diagram also shows that the number of qubits and runtime needed to break any encryption algorithm is higher for  superconducting qubits than for topological qubits. If you want to know more about the diagram, see [Analyze cryptographic protocols with the Resource Estimator](/azure/quantum/resource-estimator-quantum-safe-planning).

With this in mind, the Azure Quantum Resource Estimator helps you to analyze the impact of quantum computing on the security of some classical encryption methods, and prepare for a quantum-safe future. 

## Why is resource estimation important in quantum computing?

Understanding the impact of architecture design choices and quantum error correction schemes for specific applications is an important challenge. You have to answer several questions; for example, how large does a quantum computer need to be to achieve practical quantum advantage? How long does the computation take? Are some qubit technologies better suited than others to solve the problem you want to solve? What are the best architecture choices in the hardware and software stacks to support scaled quantum computation?

The Resource Estimator helps you understand how many qubits are needed to run an application, how long it will take to run, and which qubit technologies are better suited to solving a specific problem. Understanding these requirements will allow you to prepare and refine quantum solutions to run on future, scaled quantum machines.

Next, let's learn about the Azure Quantum Resource Estimator and how to customize it to estimate the resources needed to run a quantum algorithm. 

