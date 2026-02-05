[Azure Quantum](https://azure.microsoft.com/products/quantum/) is the cloud quantum computing service of Azure. The service offers a wide range of quantum hardware, software, and solutions in a single cloud service.

With Azure Quantum and the Microsoft Quantum Development Kit (QDK), you can program your quantum algorithms and then apply your quantum solutions within the existing Azure platform.

## Quantum programming with the QDK

Quantum programming is a distinct art from classical programming because of the peculiar nature of qubits. Quantum algorithms require tools and ways of thinking that differ from classical algorithms. The QDK is a free open-source software development kit that's built specifically to write and run quantum programs.

The QDK includes Q#, a high-level quantum programming language. The Q# language is designed to address the challenges of quantum information processing and is a holistic tool to write entire quantum algorithms, not just quantum circuits.

As a quantum programming language, Q# provides the following benefits for quantum algorithm design and implementation:

- Abstract qubits that aren't tied to any specific hardware technology or design. The Q# compiler and runtime handle the mapping of abstract qubits to physical qubits.
- The ability to perform both classical and quantum computations.
- Adherence to the rules of quantum mechanics. For example, you can't directly access or copy the state of a qubit.

> [!TIP]
> If you want to know more about Q#, check out the module [Create your first Q# program](/training/modules/qsharp-create-first-quantum-development-kit).

Here's just some of the benefits that come with the QDK:

- Write code faster with features like syntax highlighting and code completion with IntelliSense, and write entire blocks of code with Copilot assistance.
- Debug your code with the built-in debugger and unit test functionality.
- Choose between different quantum programming languages and packages, such as Q#, OpenQASM, Qiskit, and Cirq.
- Visualize circuit diagrams with the built-in circuit diagram viewer, and build quantum circuits graphically with the Circuit Editor.
- Connect to Azure Quantum and run your quantum programs on real quantum hardware or hardware simulators, from providers such as IonQ, PASQAL, Quantinuum, and Rigetti.
- Estimate the resources that your quantum program requires to run on a real quantum computer with the Microsoft Quantum resource estimator.

## Resource estimation in Azure Quantum

In quantum computing, resource estimation is the ability to understand the resources required to run your algorithm, such as the number of qubits, the number of quantum gates, and total processing time. When you understand the number of qubits required for a quantum solution and the differences between qubit technologies, you can prepare and refine your quantum solutions to run on future scaled quantum machines.

Azure Quantum provides a free tool to estimate the resources of your quantum program. The Microsoft Quantum resource estimator allows you to assess architectural decisions, compare qubit technologies, and compare the resources needed to run a given quantum algorithm on different platforms.

If you want to know more, check out the module [Estimate physical resource requirements for quantum algorithms with the Microsoft Quantum resource estimator](/training/modules/estimate-resources-quantum-algorithms).

## Quantum hardware providers in Azure Quantum

Azure Quantum offers various quantum hardware providers to help you get ready for the future of scaled quantum machines. With Azure Quantum, you aren't siloed to a single hardware technology, and you benefit from a full stack approach to protect your long-term investments.

Azure Quantum supports the following quantum hardware providers:

| **Provider**   | **Description** |
|----------------|-----------------|
| **IonQ**       | Dynamically reconfigurable trapped-ion quantum computers for up to 32 fully connected qubits. IonQ lets you run a two-qubit gate between any pair. |
| **PASQAL**     | Neutral atom-based quantum processors that operate at room temperature, with long coherence times and impressive qubit connectivity. |
| **Quantinuum** | Trapped-ion systems with high-fidelity, fully connected qubits, low error rates, qubit reuse, and the ability to perform mid-circuit measurements. |
| **Rigetti**    | Gate-based superconducting processors based on tunable qubits. Their latest Ankaa-3 family processor is based on proprietary scalable multi-chip technology, which offers low latency and parallel execution. |

## If I'm not a quantum expert, can I still use Azure Quantum?

Absolutely! Azure Quantum makes quantum computing accessible to everyone, whether you're a quantum developer, researcher, or just curious.

Azure Quantum incorporates AI to assist you. You can use [Copilot in Microsoft Quantum](https://quantum.microsoft.com/experience/quantum-coding), a quantum-focused AI agent that helps you to write code and understand quantum concepts.

If you want to learn by doing, try the [Quantum Katas](https://quantum.microsoft.com/experience/quantum-katas), a series of self-paced tutorials that teach you elements of quantum computing and Q# programming. You can also explore [the Q# quantum samples](https://github.com/microsoft/qdk/tree/main/samples).

You can also learn from experts and enthusiasts through blogs, articles, and videos. And you can try out some Q# code samples in the online code editor.

All these tools are free of charge.

:::image type="content" source="../media/learn-with-azure-quantum.png" alt-text="Art diagram showing that Azure Quantum offers tutorials, samples, AI.":::
