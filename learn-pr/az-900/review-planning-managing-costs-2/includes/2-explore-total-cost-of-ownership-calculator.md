Before Tailwind Traders takes their next steps towards migrating to the cloud, they want to better understand what they spend today in their datacenter. 

Having a firm understanding of where they are today will give them a greater sense of what cloud migration means in terms of cost.

In this part, you'll see how the Total Cost of Ownership (TCO) Calculator can help you compare the cost of running in the datacenter versus running on Azure.

## What's the Total Cost of Ownership Calculator?

The Total Cost of Ownership Calculator is a web tool that helps you estimate the cost savings of operating your solution on Azure over time, instead of in your on-premises datacenter.

<div style="background:yellow;">
TODO: Add graphic or screenshot.
</div>

While the term _total cost of ownership_ is commonly used in finance, it can be hard to truly see all of the hidden costs related to operating a technology capability on-premises, in addition to the cost of software licenses and hardware.

With the TCO Calculator, you enter the details of your on-premises workloads and then review the suggested industry average cost (which you can adjust) for related operational costs, such as electricity, network maintenance, and IT labor. You're then presented with a side-by-side report, enabling you to compare those costs with the same workloads running on Azure.

> [!NOTE]
> You don't need an Azure subscription to work with the TCO Calculator.

The TCO Calculator breaks down into these three steps:

![TODO](../media/total-cost-ownership-steps.png)

Let's break down each step.

### Step 1: Define your workloads

First, you enter the specifications of your on-premises infrastructure into the TCO calculator, according to these four categories:

* **Servers**

    This includes operating systems, virtualization methods, CPU cores, memory.
* **Databases**

    This includes database types, server hardware specifications, and the corresponding Azure service you would like to use, including the expected maximum concurrent user logins.
* **Storage**

    This includes storage type and capacity, including any backup or archive storage.
* **Networking**

    This includes the amount of network bandwidth you currently consume in your on-premises environment.

### Step 2: Adjust assumptions

Next, you specify whether your current on-premises licenses are enrolled for Software Assurance (which can save you money by reusing them on Azure), and whether you need to replicate your storage to another Azure region for greater redundancy.

Then, you can see the key operating cost assumptions across several different areas, which varies between customers. These costs have been certified by Nucleus Research, an independent research company. For example, these include electricity price per kilowatt hour (KWh), hourly pay rate for IT administration, and network maintenance cost as a percentage of network hardware and software costs.

To improve the accuracy of the TCO Calculator results, you adjust the values so that they match the costs of your current on-premises infrastructure.

### Step 3: View report

Choose a time frame between 1 and 5 years; the TCO Calculator generates a report that's based on the information you've entered.

![Two pie charts comparing total cost of ownership in the datacenter versus on Azure. For the datacenter, total cost of ownership is $777,258. The same workload on Azure is estimated at $107,569.](../media/tco-report-piecharts.png)

For each category (compute, datacenter, networking, storage, and IT labor),  you can also view a side-by-side comparison of the cost breakdown of operating those workloads on-premises versus operating them on Azure.
  
![A diagram showing the side-by-side cost breakdown across compute, datacenter, networking, and storage categories.](../media/tco-report-detailed-cost.png)

You can download, share, or save this report to review later in more detail.

In the next part, you'll use the TCO Calculator to help the Tailwind Traders team understand their total costs.
