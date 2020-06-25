![Conceptual illustration showing compute as the center of our solar system](../media/7-heading.png)

Azure provides multiple services to perform cloud compute, but choosing the right service depends on your business needs. Remember that there are some overlaps in capabilities. For example, you could use either Azure containers or Azure Functions as part of a serverless architecture. But ultimately, making the right decision depends on both the service capability and the abilities of your development team.

## Learn more

For more information on the compute services available on Azure, visit some of the pages below.

- [Overview of Azure compute options](https://docs.microsoft.com/azure/architecture/guide/technology-choices/compute-overview?azure-portal=true)
- [Typical scenarios for running Azure VMs](https://docs.microsoft.com/azure/virtual-machines/windows/overview?toc=%2Fazure%2Fvirtual-machines%2Fwindows%2Ftoc.json?azure-portal=true)

## Clean up

Let's clean up the resources that we created. Since we deployed everything in a single resource group, cleaning up is easy.

1. Go ahead and pull up the [Azure portal](https://portal.azure.com/?azure-portal=true) in a web browser if you haven't already. In the search box in the top navigation bar, search for **msftlearn-core-infrastructure-rg** and click on the resource group.

1. In the **Overview** pane, click **Delete resource group**. Enter the **msftlearn-core-infrastructure-rg** resource group name to confirm, and click **Delete**.