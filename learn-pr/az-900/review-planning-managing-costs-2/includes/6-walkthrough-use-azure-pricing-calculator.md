With an understanding of Azure cost factors, Tailwind Traders wants to take a workload scenario and estimate how much it would cost them in Azure, each month.

## Explore the Azure Pricing Calculator

> [!Note]
> This exercise only requires browser access to the internet to complete.
1. Launch the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/). There you'll find several tabs:

- **Products.** This tab is where you'll do most of your activity. It has all of the Azure products and services listed and is where you'll add or remove services to put together your estimate.
- **Example Scenarios** This tab has several examples of the resources involved in common cloud-based solution architectures. You can add all the components of the entire scenario to estimate the cost, and you can edit their configurations. This is a great place to find suggested architectures for things like modern data warehouse and real-time analytics solutions. 
- **Saved Estimates.** Here are all of your previously saved estimates. 
- **FAQ.** Frequently asked questions about using the Pricing Calculator.

## Estimate a solution
The IT Manager at Tailwind Traders is faced with the decision about whether to replace some ageing on-premises hardware or move the application solution to Azure. They need to know how much the ongoing monthly cost of the solution in Azure would be.

This system will run on two Azure VMs and will connect to an Azure SQL Database instance. You also want to have a layer 7 load balancer in place (provided by an Azure Application Gateway), for increased application performance. The following illustration shows an application gateway connected to two virtual machines that are connected to a single Azure SQL Database instance.

![Illustration of described sample architecture: Application Gateway feeding to two virtual machines that take data from a single Azure SQL database.](../media/2-estimate-costs-architecture.png)

> [!Tip]
> Make sure you have a clean calculator with nothing listed in the estimate. If you have anything present in your estimate, click the trash can icon on each item to reset the estimate.

1. In the **Products** tab of the Azure Pricing Calculator, add the following services to the estimate by clicking on them:

    Use the **West US** region for all resources.

<div style="background:yellow;">
TODO: Convert resource details from the paragraphs below into a table like the TCO calc exercise.
</div>

**Virtual Machines** in the **Compute** category

1. TO BE EDITED Set the value for each of these settings:

    | Settings | Value |
    | -- | -- |
    | Name | *Servers: Windows VMs* |
    | Workload | **Windows/Linux Server** |
    | Environment | **Virtual Machines** |
    | Operating system | **Windows** |  
    | VMs | **50** |
    | Virtualization | **Hyper-V** |
    | Core(s) | **8**|
    | RAM (GB) | **16** |
    | Optimize by | **CPU** |
    | Windows Server 2008/2008 R2 | **Off** |
    | | |

This project is an ASP.NET application, so we'll need to use a **Windows** operating system VM. This application doesn't require a massive amount of computing power, so select the **D2 v3** instance size. We'll need two virtual machines, and they will run all the time (730 hours/month). We're going to use **Standard SSD** storage for these VMs and will require just one disk per VM of size **E10**, for a total of two disks. Keep the storage transactions set to the default of 100.


**Azure SQL Database** in the **Databases** category
For the database, we're going to provision a **Single Database** type using the **vCore** model. We want a **General Purpose, Gen 5** database with **8 vCores**. We'll need **32 GB** of storage.

**Application Gateway** in the **Networking** category
For Application Gateway, we're going to use the **Web Application Firewall** tier, so we have some protection for our environment. And we're going to go with just **2** instances and **Medium** size, as our load isn't going to be high. We expect to process **1 TB** of data per month. We don't expect to process any data in the North America, Europe (Zone 1).

1. Looking through your estimate, you should see a summary cost for each service you've added and a full total for the entire estimate. You can try playing with some of the options to see the estimate go up or down.



## Share and save your estimate
We now have an estimate for our solution. We can save this estimate, so we can come back to it later and adjust it if necessary. We can also export it to Excel for further analysis or share the estimate via a URL.

To export the estimate, select **Export** at the bottom of the estimate. Exporting will download your estimate in Excel (**.xlsx**) format and will include all the services you added to your estimate.

We can either share the Excel spreadsheet, or we can click on the Share button in the calculator. Sharing will give you a URL that you can use to share this estimate. Anyone with this link will be able to access it, making it easy to share with your team.

If you are logged in with your Azure account, you can save the estimate, so you can come back to it later. Go ahead and click the **Save** button. If you are signed in, you should see a notification that your estimate was saved. If you aren't signed in, you'll see a message to sign in to save your estimate. After you've saved the estimate, scroll back up to the top of the page and select the **Saved Estimates** tab. You will see your estimate there. You can then select it to pull it back up, or delete it if you no longer need it.

We have arrived at a cost estimate for a set of Azure services without spending any money. We didn't create anything, and we have a fully sharable estimate that we can do further analysis or modifications on in the future. You can use this estimate not only to create estimates for systems where you know the specific services you plan to use but also to compare how different services might impact your overall costs. An example is Microsoft SQL Server on a VM instead of an Azure SQL Database.

