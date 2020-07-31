Great work! You successfully configured Azure Pipelines to run a basic Ansible configuration on two virtual machines.

You started by creating an inventory file, a configuration file, and a playbook locally. You uploaded these files to Azure Cloud Shell and to your control machine.

In practice, you typically won't need to copy so many files. Here, you started by running Ansible from Cloud Shell to get a sense for how the process works. You then ran Ansible on your control machine through Visual Studio Code to see how the Ansible extension for Visual Studio Code helps make the process easier. In practice, you'd choose the technique that best fits your preferred workflow.

## Learn more

If you're interested in Ansible, here are some resources where you can learn more:

* [ansible.com](https://www.ansible.com/?azure-portal=true)
* [Ansible on Azure](https://docs.microsoft.com/azure/ansible/?azure-portal=true)
* [Microsoft Azure Guide](https://docs.ansible.com/ansible/latest/scenario_guides/guide_azure.html?azure-portal=true)
* [Ansible playbooks for Azure](https://github.com/Azure-Samples/ansible-playbooks?azure-portal=true)
* [How to build your inventory](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html?azure-portal=true)
* [Visual Studio Code extension for Ansible](https://marketplace.visualstudio.com/items?itemName=vscoss.vscode-ansible&azure-portal=true)

In this module, you saw a few tools that you can use to automate your configuration. Here are additional resources where you can learn more about each option:

* [Azure Automation](https://docs.microsoft.com/azure/automation/automation-intro?azure-portal=true)
* [Azure virtual machine extensions](https://docs.microsoft.com/azure/virtual-machines/extensions/overview?azure-portal=true)
* Chef:
  * [chef.io](https://www.chef.io/?azure-portal=true)
  * [Learn Chef](https://learn.chef.io/?azure-portal=true)
  * [Chef Software on Azure](https://docs.microsoft.com/azure/chef/?azure-portal=true)
* Cloud-init:
  * [cloudinit.readthedocs.io](https://cloudinit.readthedocs.io/?azure-portal=true)
  * [Cloud-init support for virtual machines in Azure](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init?azure-portal=true)
* [PowerShell DSC](https://docs.microsoft.com/powershell/scripting/dsc/overview/overview?view=powershell-6?azure-portal=true)
* [Puppet](https://puppet.com/?azure-portal=true)