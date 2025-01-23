In quantum computing, resource estimation is the ability to understand the resources that are required for a given algorithm. The resources will be the number of qubits, the number of quantum gates, or processing time. Required resources vary for different computational scenarios based on the type of error correction scheme and other parameters. 




## How long does it take to run a quantum algorithm? 

Quantum computers have the potential of *quantum advantage* to solve some scientifically and commercially valuable problems. For example, one of the top applications for quantum computing is to break encryption. The RSA encryption algorithm is based on the difficulty of factoring large numbers. A quantum computer can factor large numbers exponentially faster than a classical computer. So, the question is, how long does it take to run a quantum algorithm that breaks encryption? Or in other words, how long are my passwords secure?

The time it takes to run a quantum algorithm depends on the number of qubits, the number of quantum gates, and the error correction scheme. The time to run a quantum algorithm can be estimated by using the Azure Quantum Resource Estimator.


To achieve quantum advantage, you must have a large-scale, fault-tolerant quantum compute; that is, a quantum computer that's capable of allowing a large number of qubits in superposition, and with a physical error rate below a certain threshold. 

Understanding the impact of architecture design choices and QEC schemes for specific applications is an important challenge. You have to answer several questions; for example, how large does a quantum computer need to be to achieve practical quantum advantage? How long does the computation take? Are some qubit technologies better suited than others to solve the problem you want to solve? What are the best architecture choices in the hardware and software stacks to support scaled quantum computation?

Estimating the running time, the number of qubits, and other resources to be used in realistic models of quantum computers is the first step to reducing these resource requirements. Resource estimation allows you to understand the differences between qubit technologies so you can prepare and refine your quantum algorithms to run on scaled quantum machines in the future.

Next, let's learn about the Azure Quantum tool you can use to estimate a quantum algorithm's resources.
