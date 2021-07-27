Creating and maintaining virtual machines can be a lot of work, and much of it is repetitive, requiring the same steps each time. Fortunately, there are several ways to automate the tasks of creating, maintaining, and removing virtual machines. One way is to use a virtual machine **extension**.

Azure virtual machine extensions are small applications that provide post-deployment configuration and automation tasks on Azure VMs. For example, if a virtual machine requires software installation, anti-virus protection, or a configuration script inside, a VM extension can be used. Extensions are all about managing your virtual machines.

Azure VM extensions can be:

 -  Managed with Azure CLI, PowerShell, Azure Resource Manager templates, and the Azure portal.
 -  Bundled with a new VM deployment or run against any existing system. For example, they can be part of a larger deployment, configuring applications on VM provision, or run against any supported extension operated systems post deployment.

There are different extensions for Windows and Linux machines and a large choice of first and third-party extensions.

:::image type="content" source="../media/virtual-machine-extensions-facf0a08.png" alt-text="Screenshot of the Windows extensions page. The Custom Script Extension and PowerShell Desired State Configuration extensions are highlighted.":::
