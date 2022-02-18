This unit provides instructions for how to set up your development environment so that you can complete the exercises in this learning path.

We provide two ways for setting up your environment:

1. Use [GitHub Codespaces](https://github.com/features/codespaces), this is the preferred way since you will not need to install the toolchain on your PC.

1. Use [Visual Studio](https://visualstudio.microsoft.com/), use this if you either do not have Codespaces access yet for your GitHub account or you prefer to use a local environment on your Windows PC.

## Use GitHub Codespace

1. Open the [GitHub project samples](https://github.com/liydu/azure-rtos-ms-learn-projects) repo in browser.

1. From the repo page, create a new codespace. Wait until the codespace is set up.

1. The VSCode web opens and you can see the projects in the Explorer view under `courses/threadx`. Follow the instructions of the unit to build and run the project.

    ![VSCode Web](../media/vscode-web.png)

> [!TIP]
> If you are using macOS or Linux and do not have the access to Codespaces yet in GitHub. You can use [local devcontainer](https://code.visualstudio.com/docs/remote/containers) with the same repo.

## Use Visual Studio

1. Download and install latest [Visual Studio](https://visualstudio.microsoft.com/) with the **Desktop development with C++** workload. You can use Community version which is free of charge.

1. Download and unzip [Azure_RTOS_6.1_Win32_Samples_2020_10_18.zip](https://github.com/azure-rtos/samples/releases/download/v6.1_rel/Azure_RTOS_6.1_Win32_Samples_2020_10_18.zip).

1. Open `training_projects\azure_rtos_threadx_training.sln` in Visual Studio and follow the instructions of the unit to build and run the project.

    ![Visual Studio](../media/visual-studio-project.png)

## Reference documentation

* [Azure RTOS ThreadX documentation](https://docs.microsoft.com/azure/rtos/threadx)
* [Azure RTOS ThreadX User Guide](https://docs.microsoft.com/azure/rtos/threadx/about-this-guide)
* [Azure RTOS GitHub repositories](https://github.com/azure-rtos)
