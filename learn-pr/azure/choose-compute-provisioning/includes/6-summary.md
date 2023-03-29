Your organization needed to move several applications to Azure virtual machines. They also want to be able to scale out their compute resources to many virtual machines. Their manual process was time consuming and error prone. They wanted to automate the scale-out process to improve operational abilities. They were unsure of what tools were available on Azure to provision compute resources and where each tool would fit into the overall provisioning process.

In this module, we looked at native Azure solutions, such as the virtual machine extensions (custom script and Desired State Configuration extensions) and their purposes. We also looked at non-native Azure solutions for provisioning and configuration. We learned how they can help us to automate manual processes and post-deployment tasks. We identified the tools available for automation. We learned how to decide between provisioning tools for specific scenarios. Each tool has its own advantages and disadvantages, and some tools can and should be used together. We used an Azure Resource Manager template together with a Desired State Configuration to deploy a web server.

Without the provisioning tools, we wouldn't be able to automate provisioning. We wouldn't be able to easily configure an environment and deploy it with minimal effort. We also wouldn't be able to provision a web server and automatically enforce a state on it.

With the help of the provisioning tools on Azure, we can improve the provisioning of compute resources for the organization. As a result, the organization can become more productive because repetitive tasks and mistakes are minimized. The organization also can become more cost-effective because it can more accurately provision resources.

## Learn more

- [Understand the structure and syntax of Azure Resource Manager templates](/azure/azure-resource-manager/resource-group-authoring-templates)
- [Introduction to the Azure Desired State Configuration extension handler](/azure/virtual-machines/extensions/dsc-overview)
- [Chef software on Azure documentation](/azure/chef/)
- [Terraform on Azure documentation](/azure/terraform/)