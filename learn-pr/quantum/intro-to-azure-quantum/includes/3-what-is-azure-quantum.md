
[Azure Quantum](https://azure.microsoft.com/products/quantum/) is the cloud quantum computing service of Azure, with a diverse set of quantum solutions and technologies. With Azure Quantum, you can access innovative quantum hardware, software, and solutions in a single cloud service.

Azure Quantum provides the best development environment to create quantum algorithms for multiple platforms at once while preserving flexibility to tune the same algorithms for specific systems. You can write your code once and run it with little to no change against multiple targets of the same family, which allows you to focus your programming at the algorithm level.

## What's included on Azure Quantum?

With Azure Quantum and the Quantum Development Kit, you're able to program your quantum algorithms, then apply those quantum solutions within the existing Azure platform.

### Quantum Development Kit

Quantum programming is a distinct art from classical programming requiring very different tools to understand and express quantum algorithmic thinking. The Quantum Development Kit (QDK) is the software development kit required to interface with the Azure Quantum service. With the Quantum Development Kit, you can build programs that run on quantum hardware in Azure Quantum.

The QDK includes Q#, a high-level **quantum programming language**. Q# is designed to address the challenges of quantum information processing; it is integrated in a software stack that enables a quantum algorithm to be compiled down to the primitive operations of a quantum computer.

The Quantum Development Kit is designed to be used by a broad range of developers, from experienced quantum experts to developers who have never written a line of quantum code. It is built in to the Azure Quantum portal, where you can develop programs using the free hosted Jupyter Notebooks. You can also install the QDK locally on your computer to use your own local development environment and work both online and offline with the Azure Quantum service.

### Hybrid quantum computing

*Hybrid quantum computing* refers to the processes and architecture of a classical computer and a quantum computer working together to solve a problem. With Azure Quantum you can start programming quantum computers by mixing classical and quantum instructions together. By integrating quantum and classical computing, quantum programs can move away from just circuits. Programs can now use common programming constructs to perform mid-circuit measurements, optimize and reuse qubits, and adapt in real-time to the QPU. Examples of scenarios that can take advantage of this model are adaptive phase estimation and machine learning.

Other examples of hybrid quantum computing are batching and sessions. In Azure Quantum you can group or batch multiple circuits into one job, which eliminates the wait between job submissions, and allows you to run multiple jobs faster. With sessions, you can logically group several of your jobs, making job management easier for you. Also, jobs grouped in sessions are prioritized over nonsession jobs. Examples of problems that can use this approach are Variational Quantum Eigensolvers (VQE) and Quantum Approximate Optimization Algorithms (QAOA).

### Resource estimation

In quantum computing, resource estimation is the ability to understand the resources, that is, the number of qubits, number of quantum gates, processing time, etc., that will be required to run your algorithm. Understanding the number of qubits required for a quantum solution and the differences between qubit technologies allows innovators to prepare and refine their quantum solutions to run on future scaled quantum machines and ultimately accelerate their quantum impact.

Azure Quantum provides a tool for estimating the resources of your quantum program. The Azure Quantum Resource Estimator allows you to assess architectural decisions, compare qubit technologies, and determine the resources needed to execute a given quantum algorithm. You can choose from predefined fault-tolerant protocols and specify assumptions of the underlying physical qubit model.

The Azure Quantum Resource Estimator computes post-layout physical resource estimation by taking a set of inputs such as qubit architecture, a quantum error correction (QEC) code, an error budget, and other parameters into account.

If you want to know more, check the module [Estimate physical resources for quantum algorithms by using the Azure Quantum Resource Estimator](/training/modules/estimate-resources-quantum-algorithms).

### Quantum hardware

In Azure Quantum, you can find various quantum hardware providers to help you get ready for the future of scaled quantum machines. Unlike other solutions, you're not siloed to a single hardware technology, and you benefit from a full stack approach protecting your long-term investments.

- **IonQ:** IonQ has trapped-ion gate-based quantum computers. They are universal and dynamically reconfigurable in software, providing up to 11 qubits to use in IonQ Harmony QPU and up to 23 qubits to use in IonQ Aria QPU. All qubits are fully connected, meaning you can run a two-qubit gate between any pair. The implementation of quantum gate operations is done by manipulating Ytterbium ions with laser pulses. IonQ also provides a GPU-accelerated quantum simulator supporting up to 29 qubits, using the same set of gates IonQ provides on its quantum hardware.
- **Quantinuum:** Quantinuum has trapped-ion quantum computers with high-fidelity, fully connected qubits, and qubit reuse. Quantum operations are laser-based gates with low error rates, and have the ability to perform mid-circuit measurements. Both the System Model H1 and H2 generations of hardware use a Quantum Charge-Coupled Device (QCCD) architecture. Quantinuum also provides emulation tools, the System Model H1 and H2 Emulators, which contain detailed physical models and noise models of the actual quantum hardware.
- **Rigetti:** Rigetti has superconducting quantum processors, which are universal, gate-model machines based on tunable qubits. Their latest Aspen-M family processor is based on proprietary scalable multi-chip technology. System features and device characteristics include enhanced readout capabilities, a speedup in quantum processing times, fast gate times for multiple entangling gate families, rapid sampling via active register reset, and parametric control.

### Free Azure Quantum Credits

If this is your first time using Azure Quantum, you automatically get free **$500 (USD)** Azure Quantum Credits for use with each participating quantum hardware provider. That's right, you have $500 (USD) to spend at each of the quantum providers. The Azure Quantum Credits facilitate your exploration of the different quantum providers and help you test your first quantum programs.

Azure Quantum Credits consumption is based on a resource-usage model defined by each quantum provider and cost of use is deducted from your credits.

> [!NOTE]
> Note that Azure credits and Azure Quantum credits are different grants and shouldn't be confused. When you create a [free trial Azure account](https://azure.microsoft.com/free/), you get $200 (USD) free Azure Credits to use on Azure services. Azure credits aren't eligible to use on quantum hardware providers.

## Job lifecycle in Azure Quantum

Once you've written your quantum program, you can select a target and submit your program, also called a job.

This diagram shows the basic workflow after you submit your job:

:::image type="content" source="../media/azure-quantum-flow-diagram.png" alt-text="Diagram showing the job lifecycle from the moment you submit your quantum problem, until the provider gets the program and returns the solution.":::

First, Azure Quantum uploads the job to the Azure Storage account that you configured in the workspace. Then, the job is added to the job queue for the provider that you specified in the job. Azure Quantum then downloads your program and translates it for the provider. The provider processes the job and returns the output to Azure Storage, where it is available for download.

## If I'm not a quantum expert, can I still use Azure Quantum?

Sure! Quantum computing is evolving quickly and Microsoft is committed to making quantum computing accessible to everyone. Azure Quantum is designed to guide you in your quantum journey, whether you're a quantum developer, researcher, or enthusiast.

Azure Quantum has incorporated **artificial intelligence** to assist you. You can play with the Copilot in Azure Quantum, a quantum-focused chatbot that helps you write code and better understand concepts.

If you want to learn by doing, Azure Quantum provides the *Quantum Katas*, a series of self-paced tutorials that teach you elements of quantum computing and Q# programming at the same time. You can also check [the Q# quantum samples](https://github.com/microsoft/Quantum/tree/main/samples/azure-quantum).

You can also learn from experts and enthusiasts through blogs, articles and videos. And you can try out some Q# code samples in the online code editor.

:::image type="content" source="../media/learn-with-azure-quantum.png" alt-text="Art diagram showing that Azure Quantum offers tutorials, samples, AI.":::

All these tools are free of charge.
