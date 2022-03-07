In this part, you start by performing a few basic setup tasks. In Visual Studio Code, you connect a terminal session to the Azure subscription that's provided by the free Azure sandbox environment. Doing so enables you to authenticate commands to Azure.

Then, you run a basic ARM template that provisions a Linux virtual machine (VM). After the deployment completes, you verify that the VM is running and connectable.

Although working with VMs is a common task, you discover that a VM resource requires networking and storage components that must exist before the VM can be created. You see how the `dependsOn` construct enables you to set the order in which resources are provisioned.

::: zone pivot="powershell"

[!include[](./powershell/3-exercise-dependencies.md)]

::: zone-end

::: zone pivot="cli"

[!include[](./azcli/3-exercise-dependencies.md)]

::: zone-end