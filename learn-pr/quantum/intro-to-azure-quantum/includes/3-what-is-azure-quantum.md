[Azure Quantum](https://azure.microsoft.com/products/quantum/) is the cloud quantum computing service of Azure. It offers a wide range of quantum hardware, software, and solutions in a single cloud service.

With Azure Quantum and the Azure Quantum Development Kit (QDK), you're able to program your quantum algorithms, then apply those quantum solutions within the existing Azure platform.

## The Azure Quantum Development Kit

Quantum programming is a distinct art from classical programming that requires different tools to understand and express quantum algorithmic thinking. The Azure Quantum Development Kit (QDK) is a **free**, open-source software development kit that you can use to write quantum programs.

The QDK includes Q#, a high-level **quantum programming language**. Q# is designed to address the challenges of quantum information processing. The Q# language is integrated in a software stack that enables a quantum algorithm to be compiled down to the primitive operations of a quantum computer.

> [!NOTE]
> You can install the [Azure Quantum Development Kit](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode) extension for Visual Studio Code to get started with Q# programming.

With the QDK, you can:

- **Debug your code:** It offers a quantum computing debugger that can step through classical and quantum code. This debugger paired with its sparse in-memory simulator, provides fast simulation of up to thousands of logical qubits.
- **Write your code faster:** Syntax highlighting and intelligent code completion with IntelliSense, and write entire blocks of code assisted with Copilot.
- **Run your code on quantum hardware:** You can run your quantum programs on real quantum hardware, such as IonQ, PASQAL, Quantinuum, and Rigetti.
- **Plot the quantum circuit diagram:** Visualize your quantum circuits with the built-in circuit diagram viewer.
- **Run the Azure Quantum Resource Estimator:** Estimate the resources required to run your quantum program on a quantum computer.

## Hybrid quantum computing

Hybrid quantum computing is the mix of classical and quantum computing, both working together to solve a problem. With Azure Quantum, you can start coding for quantum computers by mixing up classical and quantum instructions. This means quantum programs can do more than just circuits. They can use classical programming methods to measure mid-circuit, optimize and reuse qubits, and adapt in real-time to the Quantum Processing Unit (QPU).

Azure Quantum also lets you batch multiple circuits into one job, which means you don’t have to wait between job submissions, and you can run multiple jobs quicker. You can also manage your jobs easier by grouping jobs into sessions. Plus, jobs in sessions get priority over nonsession jobs.

## Resource estimation

In quantum computing, resource estimation is the ability to understand the resources required to run your algorithm, such as the number of qubits, the number of quantum gates, processing time, etc. When you understand the number of qubits required for a quantum solution and the differences between qubit technologies, you can prepare and refine your quantum solutions to run on future scaled quantum machines.

Azure Quantum provides a **free** tool for estimating the resources of your quantum program. The Azure Quantum Resource Estimator allows you to assess architectural decisions, compare qubit technologies, and determine the resources needed to execute a given quantum algorithm. 

If you want to know more, check out the module [Estimate physical resources for quantum algorithms by using the Azure Quantum Resource Estimator](/training/modules/estimate-resources-quantum-algorithms).

## Quantum hardware

In Azure Quantum, you can find various quantum hardware providers to help you get ready for the future of scaled quantum machines. Unlike other solutions, you're not siloed to a single hardware technology, and you benefit from a full stack approach protecting your long-term investments.

- **IonQ:** Dynamically reconfigurable trapped-ion quantum computers for up to 11 fully connected qubits. IonQ lets you run a two-qubit gate between any pair.
- **PASQAL**: Neutral atom-based quantum processors operating at room temperature, with long coherence times and impressive qubit connectivity.
- **Quantinuum:** Trapped-ion systems with high-fidelity, fully connected qubits, low error rates, qubit reuse, and the ability to perform mid-circuit measurements.
- **Rigetti:** Gate-based superconducting processors based on tunable qubits. Their latest Aspen-M family processor is based on proprietary scalable multi-chip technology, enabling low latency and parallel execution.

### Free Azure Quantum Credits

If it's your first time using Azure Quantum, you automatically get free **$500 (USD)** Azure Quantum Credits for use with each participating quantum hardware provider. That's right, you have $500 (USD) to spend at each of the quantum providers. The Azure Quantum Credits facilitate your exploration of the different quantum providers and help you test your first quantum programs.

Azure Quantum Credits consumption is based on a resource-usage model defined by each quantum provider and cost of use is deducted from your credits.

> [!NOTE]
> Note that Azure credits and Azure Quantum credits are different grants and shouldn't be confused. When you create a [free trial Azure account](https://azure.microsoft.com/free/), you get $200 (USD) free Azure Credits to use on Azure services. Azure credits aren't eligible to use on quantum hardware providers.

## If I'm not a quantum expert, can I still use Azure Quantum?

Microsoft is committed to making quantum computing accessible to everyone, whether you're a quantum developer, researcher, or enthusiast.

Azure Quantum incorporates **artificial intelligence** to assist you. You can play with Copilot in Azure Quantum, a quantum-focused chatbot that helps you write code and better understand quantum concepts.

If you want to learn by doing, try the *Quantum Katas*, a series of self-paced tutorials that teach you elements of quantum computing and Q# programming. You can also explore [the Q# quantum samples](https://github.com/microsoft/Quantum/tree/main/samples/azure-quantum).

You can also learn from experts and enthusiasts through blogs, articles and videos. And you can try out some Q# code samples in the online code editor.

:::image type="content" source="../media/learn-with-azure-quantum.png" alt-text="Art diagram showing that Azure Quantum offers tutorials, samples, AI.":::

All these tools are **free of charge**.
