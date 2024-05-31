Azure Quantum is available through three different interfaces: the Azure Quantum website, the Azure Quantum Development Kit (QDK) extension for Visual Studio Code, and the Azure Quantum portal.

You can use any of them to explore quantum computing and quantum programming. But what are the differences between them? Which one is the right tool for your needs? This unit will help you answer these questions.

## What is the Azure Quantum website?

The [Azure Quantum website](https://quantum.microsoft.com/) allows you to learn and explore quantum computing and quantum programming. You can discover the latest quantum breakthroughs and create and run quantum programs with the help of Copilot.

- **Copilot in Azure Quantum** - AI meets the world of quantum. With a built-in code window and Q# compiler, Copilot in Azure Quantum can not only run your code, but also generate Q# code from your prompts and engage in conversations about quantum computing.
- **Quantum Elements** - One of the most important applications of quantum computing will be in the field of chemistry. Quantum Elements uses Copilot in Azure Quantum to design, code, and render molecular models.
- **Quantum Katas** - Hands-on tutorials that teach quantum computing concepts and the Q# programming language.
- **Code samples** - The Azure Quantum code library is a rich set of samples using Q#, Python, and Qiskit code to demonstrate quantum scenarios.
- **Quantum concepts** - From the basics of quantum theory to advanced techniques of quantum computing, the Concepts library is a crash course to bring you up to speed on quantum computing. 
- **Videos** - Browse the video library for interviews with leading quantum computing researchers and innovators.
- **Azure Quantum blogs** - Stay up to date with the latest quantum computing research and innovations.

> [!TIP]
> With the Azure Quantum website, you can submit quantum computing programs to the **Quantinuum H-Series Emulator** without an Azure subscription.

If you are a quantum enthusiast and want to learn by doing, the Azure Quantum website is for you.

:::image type="content" source="../media/copilot.png" alt-text="Screenshot of Copilot in Azure Quantum showing a sample and the answer of Copilot to a question for generating new code.":::

### Is the Azure Quantum website the right tool for me?

The following table might help you decide if you want to use the Azure Quantum website for your quantum computing development journey.

| Use it if you want to: | You need: | You can't: |
| --- | --- | --- |
| <ul><li>Learn quantum programming using the tutorials in Quantum Katas</li><li>Read about quantum computing concepts</li><li>Run Q# programs online and simulate them in Quantinuum H-Series Emulator</li><li> Ask Copilot to explain quantum computing concepts or prompt it to generate a Q# program </li><li> Open your quantum program in VS Code for the Web</li></ul> | <ul><li>No installation required</li><li>No Azure subscription required</li><ul> | <ul><li> Save your programs and results</li><li> Select a quantum computing provider </li><li>Run Python code </li><li>Manage your quantum jobs</li><li>Debug your programs</li></ul>|


## What is the Azure Quantum Development Kit (QDK) extension?

The Azure QDK extension is a software development kit for quantum computing. It is an extension for Visual Studio Code, a free, open-source code editor from Microsoft.

> [!NOTE]
> The QDK extension is available both in Visual Studio Code and [VS Code for the Web](https://vscode.dev/quantum).

With the QDK extension, you can create Q# programs, load pre-installed Q# samples, and take advantage of features such as improved error messaging, Q# syntax highlighting, and integrated debugging in a local development environment. 

You can also estimate the resources of your Q# programs using the Azure Quantum Resource Estimator. The Resource Estimator is a tool that allows you to estimate the number of qubits and the number of operations required to run your Q# programs on quantum computers.

You don't need an Azure account to use the QDK in Visual Studio Code, but if you already have an Azure account set up, you can connect directly to your Azure Quantum workspaces from VS Code. This allows you to run your Q# programs on the quantum computers and simulators of the providers you selected for your workspace.

> [!TIP]
> If you have an Azure Quantum workspace, you can enjoy a free USD500 per target in Azure Quantum Credits when you submit your Q# programs to Azure Quantum from VS Code.

:::image type="content" source="../media/quantum-development-kit-extension.png" alt-text="Screenshot of the QDK extension in Visual Studio Code.":::

### Is the QDK in VS Code the right tool for me?

You can use this table as a quick reference to the features of the QDK in VS Code. Typically, you'll use different Azure Quantum options together, such as writing Q# in VS Code with the QDK while managing your quantum workspace in the Azure Quantum portal.

| Use it if you want to: | You need: | You can't: |
| --- | --- | --- |
| <ul><li>Use Visual Studio Code</li><li> Run Q# samples</li><li>Select your quantum computing providers</li><li>Run Q# and Qiskit programs</li><li> Debug your Q# programs</li><li> Visualize quantum circuit diagrams </li><li>  Create and run Jupyter Notebooks  </li><li> Have compiler error messages</li><li> Use the Resource Estimator </li><li>  Save your programs and results</li></ul> | <ul><li>Install [Visual Studio Code](https://code.visualstudio.com/) (*Only for local development*) </li><li> Install the [Azure QDK for VS Code extension](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode) </li><li> An Azure subscription and a quantum workspace (*Only if you want to run programs on real hardware*) </li></ul>| <ul><li>Ask Copilot</li><li> Manage your subscriptions and workspaces</li><li> Manage your quantum jobs</li></ul> |

## What is the Azure Quantum portal?

The [Azure portal](https://portal.azure.com) is the main interface of the Microsoft Azure cloud computing platform. Azure provides a wealth of cloud-based services like remote storage, database hosting, and centralized account management.

In the Azure Quantum portal, you can create a quantum workspace. A quantum workspace is a container for your quantum programs and quantum jobs. In a quantum workspace, you can select the quantum computing providers you want to use. You can also select the Azure Quantum storage account where your quantum jobs will be stored.

> [!TIP]
> When you create an Azure Quantum workspace for the first time, you get **USD500 free in Azure Quantum Credits** for use in each of the quantum computing providers. That's right, you can spend USD500 in each of them to run your quantum programs.

The Azure portal allows you to manage your subscriptions and workspaces. You can grant a group of users, like your team members or students, access to your Azure Quantum workspace. You can also manage your quantum jobs, credits consumption, and quotas.

The Azure Quantum portal also allows you to run your quantum programs in an Azure Quantum notebook. An Azure notebook is a web-based environment for running Jupyter notebooks.

:::image type="content" source="../media/azure-portal-landing-page.png" alt-text="Screenshot of the landing page of Azure portal.":::

### Is the Azure Quantum portal the right tool for me?

Use this table as a quick reference to the features in the Azure Quantum portal.

| Use it if you want to: | You need: | You can't: |
| --- | --- | --- |
| <ul><li> Create a quantum workspace </li><li>Manage your subscriptions and workspaces</li><li> Copy the Access Keys of your workspace </li><li> Manage your quantum jobs</li><li>Select your quantum computing providers</li><li>Run your Q# and Qiskit programs in an Azure notebook </li><li> Save your programs and results</li></ul> | <ul><li>An Azure subscription</li><li>A quantum workspace</li><li> No installation required</li></ul>| <ul><li>Ask Copilot</li><li>Debug your programs  |

