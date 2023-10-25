
Azure Quantum is available through three different interfaces: the Azure Quantum website, the Azure Quantum portal, and the Quantum Development Kit (QDK) extension.

You can use any of them to explore quantum computing and quantum programming. But what are the differences between them? Which one is the right tool for you? This unit will help you answer these questions.

## What is the Azure Quantum website?

The [Azure Quantum website](https://quantum.microsoft.com/) allows you to learn and explore quantum computing and quantum programming. You can discover the latest quantum breakthroughs, and create and run quantum programs with the help of the Copilot.

- **Copilot in Azure Quantum** - AI meets the world of quantum. With a built-in code window and Q# compiler, the Copilot in Azure Quantum can not only run your code, but also generate Q# code from your prompts, and engage in conversations about quantum computing.
- **Quantum Elements** - One of the most important applications of quantum computing will be in the field of chemistry. Currently in private preview, Quantum Elements uses the Copilot in Azure Quantum to design, code, and render molecular models.
- **Quantum Katas** - Hands-on tutorials that teach quantum computing concepts and the Q# programming language.
- **Code samples** - The Azure Quantum code library is a rich set of samples using Q#, Python, and Qiskit code to demonstrate quantum scenarios.
- **Quantum concepts** - From the basics of quantum theory to advanced techniques of quantum computing, the Concepts library is a crash course to bring you up to speed on quantum computing. 
- **Videos** - Browse the video library for interviews with leading quantum computing researchers and innovators.
- **Azure Quantum blogs** - Stay up to date with the latest quantum computing research and innovations.

If you are a quantum enthusiast and want to learn by doing, the Azure Quantum website is for you.

:::image type="content" source="../media/copilot.png" alt-text="Screenshot of the Copilot in Azure Quantum showing a sample and the answer of Copilot to a question for generating new code.":::

### Is the Azure Quantum website the right tool for me?

The following table might help you decide if you want to use the Azure Quantum website for your quantum computing development.

| Use it if you want to: | You need: | You can't: |
| --- | --- | --- |
| <ul><li>Learn quantum programming using the tutorials in Quantum Katas</li><li>Read about quantum computing concepts</li><li>Run Q# programs online</li><li> Ask Copilot to explain quantum computing concepts or Q# code</li><li>Prompt the Copilot to generate a Q# program</li></ul> | <ul><li>No installation required</li><li>No Azure subscription required</li><ul> | <ul><li> Save your programs and results</li><li>Run Qiskit code </li><li>Manage your quantum jobs</li><li>Debug your programs</li></ul>|

## What is the Azure Quantum portal?

The [Azure portal](https://portal.azure.com) is the main interface of the Microsoft Azure cloud computing platform. Azure provides a wealth of cloud-based services like remote storage, database hosting, and centralized account management.

In the Azure Quantum portal, you can create a quantum workspace. A quantum workspace is a container for your quantum programs and quantum jobs. In a quantum workspace you can select the quantum computing providers you want to use. You can also select the Azure Quantum storage account where your quantum jobs will be stored.

When you create an Azure Quantum workspace for the first time, you get **free $500 USD in Azure Quantum Credits** for use in each of the quantum computing providers. That's right, you can spend $500 USD in each of them to run your quantum programs.

The Azure Quantum portal also allows you to run your quantum programs in an Azure notebook. An Azure notebook is a web-based environment for running Jupyter notebooks.

The Azure portal allows you to manage your subscriptions and workspaces. You can grant a group of users, like your team members or students, access to your Azure Quantum workspace. You can also manage your quantum jobs, credits consumption, and quotas.

:::image type="content" source="../media/azure-portal-landing-page.png" alt-text="Screenshot of the landing page of Azure portal.":::

### Is the Azure Quantum portal the right tool for me?

The following table might help you decide if you want to use Azure Quantum portal for your quantum computing development.

| Use it if you want to: | You need: | You can't: |
| --- | --- | --- |
| <ul><li>Manage your subscriptions and workspaces</li><li>Manage your quantum jobs</li><li>Select your quantum computing providers</li><li>Run your Q# and Qiskit programs in an Azure notebook</li><li> Run quantum programming samples </li><li> Save your programs and results</li></ul> | <ul><li>An Azure subscription</li><li>A quantum workspace</li><li> No installation required</li></ul>| <ul><li>Ask Copilot</li><li>Debug your programs  |

## What is the Quantum Development Kit (QDK) extension?

The Quantum Development Kit (QDK) extension is a sofwtare development kit for quantum computing. It is a plugin for Visual Studio Code, a free, open source code editor from Microsoft.

With the QDK extension, you can create, debug, and run Q# programs in a local development environment. You can also use the QDK extension to connect to your Azure Quantum workspace. This allows you to run your Q# programs on the quantum computers and simulators of the providers you selected for your workspace.

:::image type="content" source="../media/qdk-extension.png" alt-text="Screenshot of the QDK extension in Visual Studio Code.":::


### Is the QDK the right tool for me?

The following table might help you decide if you want to use the QDK for your quantum computing development.

| Use it if you want to: | You need: | You can't: |
| --- | --- | --- |
| <ul><li>Use a local development environment with Visual Studio Code</li><li>Select your quantum computing providers</li><li>Run Q# and Qiskit programs</li><li> Debug your Q# programs</li><li>Have compiler error messages</li><li> Use a Python host program</li><li>  Save your programs and results</li></ul> | <ul><li>An Azure subscription</li><li>A quantum workspace</li><li> Install [Visual Studio Code](https://code.visualstudio.com/) </li><li> Install the [Microsoft QDK for VS Code extension](https://marketplace.visualstudio.com/items?itemName=quantum.qsharp-lang-vscode)</li></ul>| <ul><li>Ask Copilot</li><li> Manage your subscriptions and workspaces</li><li> Manage your quantum jobs</li></ul> |
