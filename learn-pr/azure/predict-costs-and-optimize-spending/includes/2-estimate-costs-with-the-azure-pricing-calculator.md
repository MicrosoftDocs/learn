Imagine that you've been asked to build a system on Azure, and you've been asked for an estimate of what it might cost to run over the next 12 months. You already know that Azure pricing is fully transparent and that you're billed monthly for only the services that you use. How would you get that estimate without deploying and running those services or without manually pricing out each service from the Azure service pricing pages?

## Introducing the Azure pricing calculator

To make estimates easy for customers to create, Microsoft developed the **Azure pricing calculator**. The Azure pricing calculator is a free web-based tool that allows you to input Azure services and modify properties and options of the services. It outputs the costs per service and total cost for the full estimate.

The options that you can configure in the pricing calculator vary between products, but basic configuration options include:

| Option | Description |
|--------|-------------|
| Region | Lists the regions from which you can provision a product. Southeast Asia, central Canada, the western United States, and northern Europe are among the possible regions available for some resources. |
| Tier | Sets the type of tier you wish to allocate to a selected resource, such as Free Tier, Basic Tier, etc. |
| Billing Options | Highlights the billing options available to different types of customers and subscriptions for a chosen product. |
| Support Options | Allows you to pick from included or paid support pricing options for a selected product. |
| Programs and Offers | Allows you to choose from available price offerings according to your customer or subscription type. |
| Azure Dev/Test Pricing | Lists the available development and test prices for a product. Dev/Test pricing applies only when you run resources within an Azure subscription that is based on a Dev/Test offer. |

### Try out the Azure pricing calculator

In another browser window or tab, open the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/?azure-portal=true). On the pricing calculator page, you'll see several tabs:

1. **Products.** This tab is where you'll do most of your activity. This tab has all the Azure services listed and is where you'll add or remove services to put together your estimate.
1. **Example Scenarios** This tab has several examples of infrastructure involved in common cloud-based solutions. You can add all the components of the entire scenario to estimate the cost.
1. **Saved Estimates.** This tab has all of your previously saved estimates. We'll go through this process in a moment.
1. **FAQ.** Just as it says, this tab has answers to some frequently asked questions.

Let's start with the **Products** tab. You'll see the full listing of service categories down the left-hand side. Clicking on any of the categories will display the services in that category. There's also a search box where you can search through all services for the service you're looking for. Clicking on the service will add it to your estimate. You can add just one service, or you can add as many as you need, including multiples of the same service. For example, you can add multiple virtual machines.

After you've added the services, you'll want to price them. Scrolling down on the Pricing Calculator page will show you customizable details for that service that apply to pricing. For example, on virtual machines, you can select details such as the region, operating system, and instance size. These options all impact the pricing for the VM. You'll see a subtotal for the service. Further down the page, you'll see the full total for all services included in the estimate. Along with the total, you'll see buttons where you can export, save, and share the estimate.

## Estimate a solution

From our original scenario, let's imagine that this system will run on two Azure VMs and will connect to an Azure SQL Database instance. We also want to have a layer 7 load balancer in place to ensure we have enhanced load-balancing capabilities. The following illustration shows an application gateway connected to two virtual machines that are connected to a single Azure SQL Database instance.

![Illustration of described sample architecture: Application Gateway feeding to two virtual machines that take data from a single Azure SQL database.](../media/2-estimate-costs-architecture.png)

We can use the Azure pricing calculator to figure out what the solution will cost and export our estimate to share with the team. To estimate all the potential costs, from the **Example Scenarios** tab, add all the resources involved with a common solution to the problem you are trying to solve. To create an estimate for your custom solution, from the **Products** tab, add individual products.

> [!TIP]
> Make sure you have a clean calculator with nothing listed in the estimate. If you have anything present in your estimate, click the trash can icon on each item to reset the estimate.

In the **Products** tab of the Azure pricing calculator, add the following services to the estimate by clicking them:

* **Virtual Machines** in the **Compute** category
* **Azure SQL Database** in the **Databases** category
* **Application Gateway** in the **Networking** category

We can configure the details of each, on the **Saved Estimates** tab, to get a solid estimate of our costs. Use the **West US** region for all resources.

* **Virtual Machines.** This project is an ASP.NET application, so we'll need to use a **Windows** operating system VM. This application doesn't require a massive amount of computing power, so select the **D2 v3** instance size. We'll need two virtual machines, and they will run all the time (730 hours/month). We're going to use **Standard SSD** storage for these VMs and will require just one disk per VM of size **E10**, for a total of two disks. Keep the storage transactions set to the default of 100.

* **SQL Database.** For the database, we're going to provision a **Single Database** type using the **vCore** model. We want a **General Purpose**, **Gen 5** database with **8 vCores**. We'll need **32 GB** of storage.

* **Application Gateway.** For Application Gateway, we're going to use the **Web Application Firewall** tier, so we have some protection for our environment. And we're going to go with just **2** instances and **Medium** size, as our load isn't going to be high. We expect to process **1 TB** of data per month. We don't expect to process any data in the North America, Europe (Zone 1).

Looking through your estimate, you should see a summary cost for each service you've added and a full total for the entire estimate. You can try playing with some of the options - particularly the _location_ you place these resources in - to see the estimate go up or down.

> [!TIP]
> If you have resources that are not location-sensitive, you can save a lot of money by locating them in less expensive regions. Checking the pricing calculator can help you determine the most cost-effective place to put these services.

## Share and save your estimate

We now have an estimate for our solution. We can save this estimate, so we can come back to it later and adjust it if necessary. We can also export it to Excel for further analysis or share the estimate via a URL.

To export the estimate, select **Export** at the bottom of the estimate. Exporting will download your estimate in Excel (**.xlsx**) format and will include all the services you added to your estimate.

We can either share the Excel spreadsheet, or we can click on the `Share` button in the calculator. Sharing will give you a URL that you can use to share this estimate. Anyone with this link will be able to access it, making it easy to share with your team.

If you are logged in with your Azure account, you can save the estimate, so you can come back to it later. Go ahead and click the **Save** button. If you are signed in, you should see a notification that your estimate was saved. If you aren't signed in, you'll see a message to sign in to save your estimate. After you've saved the estimate, scroll back up to the top of the page and select the **Saved Estimates** tab. You will see your estimate there. You can then select it to pull it back up, or delete it if you no longer need it.

We have arrived at a cost estimate for a set of Azure services without spending any money. We didn't create anything, and we have a fully sharable estimate that we can do further analysis or modifications on in the future. You can use this estimate not only to create estimates for systems where you know the specific services you plan to use but also to compare how different services might impact your overall costs. An example is Microsoft SQL Server on a VM instead of an Azure SQL Database.
