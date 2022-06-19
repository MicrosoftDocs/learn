In this exercise, you use the Pricing calculator to estimate the cost of running a basic web application on Azure.

With an understanding of the more important cost factors associated with running on Azure, Tailwind Traders wants to take a typical workload and estimate how much it would cost each month to run it on Azure.

The IT Manager at Tailwind Traders is faced with the decision about whether to replace some aging on-premises hardware or move the application to Azure. The company needs to know how much the ongoing monthly cost of the solution in Azure would be.

Let's start by defining which Azure services you need.

> [!NOTE]
> The Pricing calculator is for information purposes only. The prices are only an estimate, and you won't be charged for any services you select.

## Define your requirements

Before you run the Pricing calculator, you first need a sense of what Azure services you need.

You meet with the application development team to discuss their migration project.

In their datacenter, the team has an ASP.NET web application that runs on Windows. The web application provides information about product inventory and pricing. They have two virtual machines that are connected through a central load balancer. The web application connects to a SQL Server database that holds inventory and pricing information.

The team decides to:

 -  Use Azure Virtual Machines instances, similar to the virtual machines they use in the datacenter.
 -  Use Azure Application Gateway for load balancing.
 -  Use Azure SQL Database to hold inventory and pricing information.

Here's a diagram that shows the basic configuration:

:::image type="content" source="../media/5-estimate-costs-architecture-5a86c148.png" alt-text="Illustration of described sample architecture, Application Gateway feeding to two virtual machines that take data from a single Azure SQL database.":::


In practice, you would define your requirements in greater detail. But here are some basic facts and requirements that came up during the meeting:

 -  The application is used by Tailwind Traders employees at their retail stores. It's not accessible to customers.
 -  This application doesn't require a massive amount of computing power.
 -  The virtual machines and the database run all the time (730 hours per month).
 -  The network processes about 1 TB of data per month.
 -  The database doesn't need to be configured for high-performance workloads and requires no more than 32 GB of storage.

## Explore the Pricing calculator

Let's start with a quick tour of the Pricing calculator.

1.  Go to the [Pricing calculator](https://azure.microsoft.com/pricing/calculator/?azure-portal=true).
2.  Notice the following tabs:<br>:::image type="content" source="../media/5-pricing-calculator-tabs-a4508d2f.png" alt-text="A screenshot showing the four tabs that appear on the pricing calculator, Products, Example Scenarios, Saved Estimates, and FAQ.":::
    
     -  **Products** This is where you choose the Azure services that you want to include in your estimate. You'll likely spend most of your time here.
     -  **Example Scenarios** Here you'll find several *reference architectures*, or common cloud-based solutions that you can use as a starting point.
     -  **Saved Estimates** Here you'll find your previously saved estimates.
     -  **FAQ** Here you'll discover answers to frequently asked questions about the Pricing calculator.

## Estimate your solution

Here you add each Azure service that you need to the calculator. Then you configure each service to fit your needs.

> [!TIP]
> Make sure you have a clean calculator with nothing listed in the estimate. You can reset the estimate by selecting the trash can icon next to each item.

### Add services to the estimate

1.  On the **Products** tab, select the service from each of these categories:
    
    :::row:::
      :::column:::
        **Category**
      :::column-end:::
      :::column:::
        **Service**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Compute
      :::column-end:::
      :::column:::
        **Virtual Machines**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Databases
      :::column-end:::
      :::column:::
        **Azure SQL Database**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Networking
      :::column-end:::
      :::column:::
        **Application Gateway**
      :::column-end:::
    :::row-end:::
    
2.  Scroll to the bottom of the page. You see that each service is listed with its default configuration.<br>:::image type="content" source="../media/5-pricing-calculator-estimate-0ef158b4.png" alt-text="A screenshot of the Pricing calculator showing the configuration options for virtual machines.":::
    

### Configure services to match your requirements

1.  Under **Virtual Machines**, set these values:
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        **West US**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Operating system
      :::column-end:::
      :::column:::
        **Windows**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Type
      :::column-end:::
      :::column:::
        **(OS Only)**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Tier
      :::column-end:::
      :::column:::
        **Standard**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Instance
      :::column-end:::
      :::column:::
        **D2 v3**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Virtual machines
      :::column-end:::
      :::column:::
        **2** x **730 Hours**
      :::column-end:::
    :::row-end:::
    
    
    Leave the remaining settings at their current values.
2.  Under **Azure SQL Database**, set these values:
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        **West US**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Type
      :::column-end:::
      :::column:::
        **Single Database**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Backup storage tier
      :::column-end:::
      :::column:::
        **RA-GRS**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Purchase model
      :::column-end:::
      :::column:::
        **vCore**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Service tier
      :::column-end:::
      :::column:::
        **General Purpose**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Compute tier
      :::column-end:::
      :::column:::
        **Provisioned**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Generation
      :::column-end:::
      :::column:::
        **Gen 5**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Instance
      :::column-end:::
      :::column:::
        **8 vCore**
      :::column-end:::
    :::row-end:::
    
    
    Leave the remaining settings at their current values.
3.  Under **Application Gateway**, set these values:
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        **West US**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Tier
      :::column-end:::
      :::column:::
        **Web Application Firewall**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Size
      :::column-end:::
      :::column:::
        **Medium**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Gateway hours
      :::column-end:::
      :::column:::
        **2** x **730 Hours**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Data processed
      :::column-end:::
      :::column:::
        **1 TB**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Outbound data transfer
      :::column-end:::
      :::column:::
        **5 GB**
      :::column-end:::
    :::row-end:::
    
    
    Leave the remaining settings at their current values.

## Review, share, and save your estimate

At the bottom of the page, you see the total estimated cost of running the solution. You can change the currency type if you want.

:::image type="content" source="../media/5-pricing-calculator-estimated-cost-4e587838.png" alt-text="A screenshot of the Pricing calculator showing a total estimated cost of 1,902.64.":::


At this point, you have a few options:

 -  Select **Export** to save your estimate as an Excel document.
 -  Select **Save** or **Save as** to save your estimate to the **Saved Estimates** tab for later.
 -  Select **Share** to generate a URL so you can share the estimate with your team.

You now have a cost estimate that you can share with your team. You can make adjustments as you discover any changes to your requirements.

Experiment with some of the options you worked with here, or create a purchase plan for a workload you want to run on Azure.
