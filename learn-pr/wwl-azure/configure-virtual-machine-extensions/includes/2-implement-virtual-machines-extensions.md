Creating and maintaining virtual machines can be burdensome. Many of the maintenance tasks are repetitive and time-consuming. Fortunately, there are several ways to automate the tasks of creating, maintaining, and removing virtual machines. One way is to use a virtual machine **extension**.

Azure virtual machine extensions are small applications that provide post-deployment configuration and automation tasks for Azure Virtual Machines. Consider a scenario where a virtual machine requires software installation or anti-virus protection, or when a machine needs to run a configuration script. You can use virtual machine extensions to complete these tasks. Extensions are all about managing your virtual machines.

### Things to know about virtual machine extensions

Examine the following characteristics of virtual machine extensions.

- You can manage virtual machine extensions with the Azure CLI, PowerShell, Azure Resource Manager (ARM) templates, and the Azure portal.

- Virtual machine extensions can be bundled with a new virtual machine deployment or run against any existing system. 

- There are different virtual machine extensions for Windows and Linux machines. You can choose from a large set of first and third-party virtual machine extensions.

   :::image type="content" source="../media/virtual-machine-extensions-facf0a08.png" alt-text="Screenshot of Windows extensions in the Azure portal showing the Custom Script Extension and PowerShell Desired State Configuration extension.":::

### Things to consider when using virtual machine extensions

Let's review some example scenarios for working with virtual machine extensions. Think about how can you implement virtual machines extensions to support your organization.

- **Consider deployment**. Virtual machine extension small applications can be a subset of a larger deployment for your virtual machines.

- **Consider provisioning**. You can use virtual machine extensions as configuration applications to assist with provisioning your virtual machines.

- **Consider post-deployment**. Virtual machine extensions can be run against any supported extension operated systems after deployment.