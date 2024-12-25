[Azure Quantum](https://azure.microsoft.com/products/quantum/) is the cloud quantum computing service of Azure. It offers a wide range of quantum hardware, software, and solutions in a single cloud service.

With Azure Quantum and the Azure Quantum Development Kit (QDK), you're able to program your quantum algorithms, then apply those quantum solutions within the existing Azure platform.

## Quantum programming with the Azure Quantum Development Kit

Quantum programming is a distinct art from classical programming that requires different tools to understand and express quantum algorithmic thinking. The Azure Quantum Development Kit (QDK) is a **free**, open-source software development kit that you can use to write quantum programs.

The QDK includes Q#, a high-level **quantum programming language**. Q# is designed to address the challenges of quantum information processing.

There are many reasons for wanting to build a quantum programming language, but the short answer would be: because we want to write algorithms, not circuits.

As a quantum programming language, Q# fulfills the following requirements:

- **Abstract qubits:** Quantum algorithms use qubits that aren't tied to specific hardware or layout. The compiler and runtime handle the mapping from program qubits to physical qubits.
- **Quantum and classical computation:** The ability to perform classical and quantum computations is essential in a *universal* quantum computer.
- **Laws of physics:** Quantum algorithms follow the rules of quantum physics. For example, they can't copy or access the qubit state directly.

> [!TIP]
> If you want to know more about Q#, check out the module [Create your first Q# program](/training/modules/qsharp-create-first-quantum-development-kit).

With the QDK, you can:

- **Write your code faster:** Syntax highlighting and intelligent code completion with IntelliSense, and write entire blocks of code assisted with Copilot.
- **Plot quantum circuit diagrams:** Visualize your quantum circuits with the built-in circuit diagram viewer.
- **Run your code on quantum hardware:** You can run your quantum programs on real quantum hardware, such as IonQ, PASQAL, Quantinuum, and Rigetti.
- **Run the Azure Quantum Resource Estimator:** Estimate the resources required to run your quantum program on a quantum computer.

## Resource estimation with Azure Quantum

In quantum computing, resource estimation is the ability to understand the resources required to run your algorithm, such as the number of qubits, the number of quantum gates, processing time, etc. When you understand the number of qubits required for a quantum solution and the differences between qubit technologies, you can prepare and refine your quantum solutions to run on future scaled quantum machines.

Azure Quantum provides a **free** tool for estimating the resources of your quantum program. The Azure Quantum Resource Estimator allows you to assess architectural decisions, compare qubit technologies, and determine the resources needed to execute a given quantum algorithm. 

If you want to know more, check out the module [Estimate physical resources for quantum algorithms by using the Azure Quantum Resource Estimator](/training/modules/estimate-resources-quantum-algorithms).

## Quantum hardware providers in Azure Quantum

In Azure Quantum, you can find various quantum hardware providers to help you get ready for the future of scaled quantum machines. Unlike other solutions, you're not siloed to a single hardware technology, and you benefit from a full stack approach protecting your long-term investments.

- **IonQ:** Dynamically reconfigurable trapped-ion quantum computers for up to 11 fully connected qubits. IonQ lets you run a two-qubit gate between any pair.
- **PASQAL**: Neutral atom-based quantum processors operating at room temperature, with long coherence times and impressive qubit connectivity.
- **Quantinuum:** Trapped-ion systems with high-fidelity, fully connected qubits, low error rates, qubit reuse, and the ability to perform mid-circuit measurements.
- **Rigetti:** Gate-based superconducting processors based on tunable qubits. Their latest Aspen-M family processor is based on proprietary scalable multi-chip technology, enabling low latency and parallel execution.

## Free Azure Quantum Credits

If it's your first time using Azure Quantum, you automatically get free **USD500** Azure Quantum Credits for use with each participating quantum hardware provider. That's right, you have USD500 to spend at each of the quantum providers.

Azure Quantum Credits consumption is based on a resource-usage model defined by each quantum provider and cost of use is deducted from your credits.

> [!NOTE]
> Note that Azure credits and Azure Quantum credits are different grants and shouldn't be confused. When you create a [free trial Azure account](https://azure.microsoft.com/free/), you get USD200 free Azure Credits to use on Azure services. Azure credits aren't eligible to use on quantum hardware providers.

## If I'm not a quantum expert, can I still use Azure Quantum?

Sure! Azure Quantum makes quantum computing accessible to everyone, whether you're a quantum developer, researcher, or enthusiast.

Azure Quantum incorporates AI to assist you. You can use [Copilot in Azure Quantum](https://quantum.microsoft.com/experience/quantum-coding), a quantum-focused chatbot that helps you write code and better understand quantum concepts.

If you want to learn by doing, try the [Quantum Katas,](https://quantum.microsoft.com/experience/quantum-katas) a series of self-paced tutorials that teach you elements of quantum computing and Q# programming. You can also explore [the Q# quantum samples](https://github.com/microsoft/Quantum/tree/main/samples/azure-quantum).

You can also learn from experts and enthusiasts through blogs, articles and videos. And you can try out some Q# code samples in the online code editor.

All these tools are **free of charge**.

:::image type="content" source="../media/learn-with-azure-quantum.png" alt-text="Art diagram showing that Azure Quantum offers tutorials, samples, AI.":::


