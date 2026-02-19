Azure Quantum is available through three different interfaces: the Microsoft Quantum website, the Microsoft Quantum Development Kit (QDK) extension for Visual Studio Code (VS Code), and the Azure portal.

You can use all three options to explore quantum computing and quantum programming. But what are the differences between them? Which one is the best tool for your needs? This unit helps you answer these questions.

## What is the Microsoft Quantum website?

The [Microsoft Quantum website](https://quantum.microsoft.com/) allows you to learn and explore quantum computing and quantum programming. You can discover the latest quantum breakthroughs, and create and run quantum programs with the help of Copilot.

- **Copilot in Microsoft Quantum** - AI meets the world of quantum. With a built-in code window and Q# compiler, Copilot in Microsoft Quantum can run your Q# code and also generate new code from your prompts, and engage in conversations about quantum computing.
- **Quantum Katas** - Hands-on tutorials that teach quantum computing concepts and the Q# programming language from scratch.
- **Code samples** - The Microsoft Quantum code library is a rich set of samples that use Q#, Python, and Qiskit code to demonstrate quantum scenarios.
- **Videos** - Browse the video library for interviews with leading quantum computing researchers and innovators.
- **Microsoft Quantum blogs** - Stay up to date with the latest quantum computing research and innovations.

> [!TIP]
> With the Microsoft Quantum website, you can submit quantum computing programs to the Quantinuum H-Series Emulator without an Azure subscription.

If you're a quantum enthusiast and want to learn by doing, then the Microsoft Quantum website is for you.

:::image type="content" source="../media/copilot.png" alt-text="Screenshot of Copilot in Microsoft Quantum showing a sample and the answer from Copilot to a question for generating new code.":::

### Is the Microsoft Quantum website the right tool for me?

Use the following table to help you decide whether you want to use the Microsoft Quantum website for your quantum computing development journey.

| Use it if you want to: | You need: | You can't: |
| --- | --- | --- |
| <ul><li>Learn quantum programming using the tutorials in Quantum Katas</li><li>Read about quantum computing concepts</li><li>Run Q# programs online and simulate them in Quantinuum's H-Series Emulator</li><li>Ask Copilot to explain quantum computing concepts or prompt it to generate a Q# program</li><li>Open your quantum program in VS Code for the Web</li></ul> | <ul><li>No installation required</li><li>No Azure subscription required</li><ul> | <ul><li>Save your programs and results</li><li>Select a quantum computing provider</li><li>Run Python code</li><li>Manage your quantum jobs</li><li>Debug your programs</li></ul>|

## What is the QDK extension?

The QDK extension is a software development kit for quantum computing in VS Code, which is a free code editor from Microsoft.

> [!NOTE]
> The QDK extension is available both in VS Code and [VS Code for the web](https://vscode.dev/quantum).

With the QDK extension, you can create Q# programs, load pre-installed Q# samples, and take advantage of features such as improved error messaging, Q# syntax highlighting, and integrated debugging in a local development environment. The QDK also supports OpenQASM and Python development in Jupyter notebooks.

The QDK provides other features, such as the Microsoft Quantum resource estimator. The resource estimator is a tool that allows you to estimate the resource requirements to run your quantum programs on real quantum hardware, such as the number of qubits, the number of operations, and the runtime.

You don't need to have an Azure account to use the QDK in VS Code, but if you already have an Azure account set up, then you can connect directly to your Azure Quantum workspaces from VS Code. This allows you to run your Q# programs on the quantum computers and simulators of the providers that you selected for your workspace.

:::image type="content" source="../media/quantum-development-kit-extension.png" alt-text="Screenshot of the QDK extension in VS Code.":::

### Is the QDK in VS Code the right tool for me?

Use this table as a quick reference to the features of the QDK in VS Code. Typically, you'll use different Azure Quantum options together, such as writing Q# code in VS Code with the QDK extension, while you manage your quantum workspace in the Azure portal.

| Use it if you want to: | You need: | You can't: |
| --- | --- | --- |
| <ul><li>Use VS Code</li><li>Run Q# samples</li><li>Select your quantum computing providers</li><li>Run Q# and Qiskit programs</li><li>Debug your Q# programs</li><li>Visualize quantum circuit diagrams</li><li>Create and run Jupyter notebooks</li><li>Have compiler error messages</li><li>Use the resource estimator</li><li>Save your programs and results</li></ul> | <ul><li>Install [VS Code](https://code.visualstudio.com/) (Only for local development)</li><li>Install the [Microsoft QDK for VS Code extension](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode) </li><li>An Azure subscription and a quantum workspace (Only if you want to run programs on real hardware)</li></ul> | <ul><li>Manage your subscriptions and workspaces</li><li>Manage your quantum jobs</li></ul> |

## What is the Azure portal?

The [Azure portal](https://portal.azure.com) is the main interface of the Microsoft Azure cloud computing platform. Azure provides a wealth of cloud-based services like remote storage, database hosting, and centralized account management.

In the Azure portal, you can create a quantum workspace. A quantum workspace is a container for your quantum programs and quantum jobs. In a quantum workspace, you can select the quantum computing providers that you want to use. You can also select the Azure Quantum storage account that you want to store your job data in.

The Azure portal allows you to manage your subscriptions and workspaces. You can grant a group of users, like your team members or students, access to your Azure Quantum workspace. You can also manage your quantum jobs, credits consumption, and quotas.

:::image type="content" source="../media/azure-portal-landing-page.png" alt-text="Screenshot of the landing page of Azure portal.":::

### Is the Azure portal the right tool for me?

Use this table as a quick reference for the features in the Azure portal.

| Use it if you want to: | You need: | You can't: |
| --- | --- | --- |
| <ul><li>Create a quantum workspace</li><li>Manage your subscriptions and workspaces</li><li>Copy the Access Keys of your workspace</li><li>Manage your quantum jobs</li><li>Select your quantum computing providers</li><li>Save your programs and results</li></ul> | <ul><li>An Azure subscription</li><li>A quantum workspace</li><li>No installation required</li></ul> | <ul><li>Ask Copilot about quantum concepts</li><li>Run your quantum programs in an Azure notebook</li><li>Debug your programs |
