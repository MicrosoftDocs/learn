In an Azure Cognitive Search solution, you create the index, skillset, and other associated elements of the search solution within an Azure Cognitive Search resource in an Azure subscription. The knowledge store created by your indexing process is hosted in an Azure Storage account.

> [!NOTE]
> While it's possible to use the graphical interface in the Azure portal to create an Azure Cognitive Search index and related objects, a code-based approach is preferred when developing an enterprise solution. Using code to define infrastructure and service configuration makes it easier to apply a repeatable DevOps process in which the solution can be automatically built and deployed to test and staging environments for validation before being released to production.
>
> For this reason, you will use a completely code-based approach to implement the Margie's Travel search solution.

## Prepare a development environment

To create the Margie's Travel search solution, you'll need:

- A Microsoft Azure subscription.
- A local development computer with Visual Studio Code, Docker, and Git.
- A container based on the **MicrosoftDocs/km** Git repository.

The instructions below describe how to prepare your environment for the coding tasks in this module. You can reuse this environment for all of the modules in the [Implement knowledge mining with Azure Cognitive Search](https://docs.microsoft.com/learn/paths/implement-knowledge-mining-azure-cognitive-search/) learning path.

### Get an Azure subscription

If you don't already have an Azure subscription, sign up for a free trial at [https://azure.microsoft.com](https://azure.microsoft.com?azure-portal=true).

### Install development tools

To set up the development environment, you will need a Microsoft Windows 10, Linux, or Apple Mac computer with the latest operating system updates applied. The instructions below guide you to the additional software you need to install.

1. Download and install the [Git client](https://git-scm.com/downloads?azure-portal=true), using the appropriate download for your operating system. You can select the default installation options.
2. If you are using Windows 10, you must enable the Windows Subsystem for Linux (WSL) 2 before installing Docker. To do this:
    1. Open PowerShell as Administrator and run the following commands:

        ```Powershell
        dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
        ```

        ```Powershell
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
        ```

    2. Restart Windows and sign in again.
    3. Download and install the [x64](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi) or [ARM64](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_arm64.msi) version of WSL 2, depending on your hardware architecture.
    4. Reopen PowerShell as Administrator and run the following command:

        ```Powershell
        wsl --set-default-version 2
        ```

    **More Information**: For more details, see the [WSL documentation](https://docs.microsoft.com/windows/wsl/install-win10?azure-portal=true).

3. Download and install [Docker Desktop](https://www.docker.com/get-started?azure-portal=true), using the appropriate download for your operating system. Follow the prompts to install Docker, and sign out and back in if prompted. Then wait for Docker to start.
4. Download and install [Visual Studio Code](https://code.visualstudio.com/Download?azure-portal=true), using the appropriate installer for your operating system. After Visual Studio Code has been installed, start it and install any recommended extensions.
5. In Visual Studio Code, on the **Extensions** tab (CTRL+SHIFT+X), search for and install the **Remote Containers** extension from Microsoft.

> [!NOTE]
> The **Remote Containers** extension enables you to use Visual Studio Code to develop in a different environment from your local operating system. In this module, you'll be working in a Linux-based container image that includes .NET Core, Python, the Azure CLI, Node.js, and the code files required to build an Azure Cognitive Search solution for knowledge mining. The benefit of using a container is that you don't need to install any of these in your local operating system, and you can use a consistent development environment regardless of your own system configuration. To learn more about remote container development, see the [Visual Studio Code documentation](https://code.visualstudio.com/docs/remote/remote-overview?azure-portal=true).

### Clone the *km* repository to a container volume

1. In Visual Studio Code, in the palette (CTRL+SHIFT+P), run **Remote-Containers: Clone Repository in Container Volume** and clone `https://github.com/MicrosoftDocs/km` to new volume (you can use a dedicated volume or a shared one).
2. Wait while the container is created and repository opened (this may take 5 minutes or so).
3. Then wait while C# components are installed.
4. After a few seconds, when prompted to restore unresolved .NET dependencies, do so.

Now you have a development environment that you can use to complete the coding exercises in this module. You can reuse the environment for the other modules in the [Implement knowledge mining with Azure Cognitive Search](https://docs.microsoft.com/learn/paths/implement-knowledge-mining-azure-cognitive-search/) learning path.
