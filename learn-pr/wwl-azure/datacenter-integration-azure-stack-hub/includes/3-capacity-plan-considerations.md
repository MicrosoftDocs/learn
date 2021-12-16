When you evaluate an Azure Stack Hub solution, you make hardware configuration choices that have an effect on the overall capacity of the Azure Stack Hub solution.

Options include choosing CPU, memory density, storage configuration, and overall solution scale (for example, number of servers). Unlike a traditional virtualization solution, the simple arithmetic of these components to determine usable capacity doesn't apply, because:

 -  Azure Stack Hub is architected to host the infrastructure or management components within the solution itself.
 -  Some of the solution's capacity is reserved in support of resiliency by updating the software to minimize disruption of tenant workloads.

The [Azure Stack Hub capacity planner spreadsheet](https://docs.microsoft.com/azure-stack/operator/azure-stack-capacity-planner?&amp;preserve-view=true) helps you make informed decisions for planning capacity in two ways.

 -  Selecting a hardware offering and attempting to fit a combination of resources.
 -  Defining the workload that Azure Stack Hub is intended to run to view the available hardware SKUs that can support it.

The spreadsheet is intended as a guide to help in making decisions relate to Azure Stack Hub planning and configuration.

:::image type="content" source="../media/azure-stack-capacity-planner-9c1e75b4.png" alt-text="The Azure Stack Hub capacity planner spreadsheet helps you make informed decisions.":::


The spreadsheet isn't intended to serve as a substitute for your own investigation and analysis. Microsoft makes no representations or warranties, express or implied, with respect to the information provided within the spreadsheet.
