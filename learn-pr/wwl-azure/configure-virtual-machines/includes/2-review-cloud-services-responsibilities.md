The primary advantage of working with virtual machines is to have more control over installed software and configuration settings. Azure Virtual Machines supports more granular control than other Azure services, such as Azure App Service or Azure Cloud Services.

### Things to know about Azure Virtual Machines

Consider the following characteristics of Azure Virtual Machines.

- Azure Virtual Machines is the basis of the Azure infrastructure as a service (IaaS) model. IaaS is an instant computing infrastructure, provisioned and managed over the internet.

- A virtual machine provides its own operating system, storage, and networking capabilities, and can run a wide range of applications.

- You can implement multiple virtual machines, and configure each machine with different software and settings to support separate operation scenarios, such as development, testing, and deployment.

- You can use virtual machines to quickly scale up and down with demand and pay only for what you use. 

- The responsibilities associated with configuring and maintaining virtual machines is shared between Microsoft and the customer. The following chart shows how the responsibilities are handled across the IaaS (virtual machines), PaaS, SaaS, and on-premises offerings.

   :::image type="content" source="../media/responsibility-layers-4ffbf946.png" alt-text="Diagram of the shared responsibility areas for IaaS, PaaS, SaaS, and on-premises offerings." border="false":::

### Things to consider when using IaaS and virtual machines

Let's look at some scenarios for working with IaaS and virtual machines. Think about how you can implement virtual machines in Azure.

 - **Consider test and development**. Teams can quickly set up and dismantle test and development environments, bringing new applications to market faster. IaaS and virtual machines make it quick and economical to scale up dev-test environments up and down.
 
 - **Consider website hosting**. Running websites by using IaaS and virtual machines can be less expensive than traditional web hosting.
 
 - **Consider storage, backup, and recovery**. Virtual machines let organizations avoid the expense for storage and complexity of storage management. Recovery typically requires a skilled staff to manage data and meet legal and compliance requirements. IaaS is useful for handling unpredictable demand and steadily growing storage needs. You can simplify planning and management of backup and recovery systems.
 
 - **Consider high-performance computing**. Virtual machines enable high-performance computing (HPC) on supercomputers, computer grids, or computer clusters. HPC helps solve complex problems involving millions of variables or calculations. You can support scenarios such as earthquake and protein folding simulations, climate and weather predictions, financial modeling, and evaluating product designs.
 
 - **Consider big data analysis**. Big data is a popular term for massive data sets that contain potentially valuable patterns, trends, and associations. Mining data sets to locate or tease out these hidden patterns requires a huge amount of processing power, which IaaS economically provides.
 
 - **Consider extended datacenters**. Add capacity to your datacenter by adding virtual machines in Azure. Avoid the costs of physically adding hardware or space to your physical location. Connect your physical network to the Azure cloud network seamlessly.