<div style="background:yellow;">
TODO: I didn't touch this page, but from our conversation, let's see if we want to lead with TCO.

After this unit, we might move to the TCO exercise where you help TWT understand their current cloud spend (and see what Azure thinks the savings will be.)

After that, move to 2-purchase-azure-products-services and discuss pricing structure. Then do the pricing exercise.

After that, move to 9-explore-minimizing-costs and then 10-define-azure-cost-management (I haven't looked closely, but perhaps we can combine them.)

After that, move to the knowledge check unit and then the summary
</div>

The [Total Cost of Ownership Calculator](https://azure.microsoft.com/pricing/tco?azure-portal=true) is a tool that you use to estimate cost savings you can realize by migrating to Azure. To use the TCO calculator, complete the three steps that the following sections explain.

![Image showing the numbers 1, 2 and 3 to represent the three steps required to use the TCO calculator.](../media/total-cost-ownership-steps.png)

**Step 1: Define your workloads**

Enter details about your on-premises infrastructure into the TCO calculator according to four groups:

+ **Servers**. Enter details of your current on-premises server infrastructure.
+ **Databases**. Enter details of your on-premises database infrastructure in the **Source** section. In the **Destination** section, select the corresponding Azure service you would like to use.
+ **Storage**. Enter the details of your on-premises storage infrastructure.
+ **Networking**. Enter the amount of network bandwidth you currently consume in your on-premises environment.

**Step 2: Adjust assumptions**

Adjust the values of key assumptions that the TCO calculator makes, which might vary between customers. To improve the accuracy of the TCO calculator, you should adjust the values so they match the costs of your current on-premises infrastructure. The assumption values you can adjust include storage costs, IT labor costs, hardware costs, software costs, electricity costs, virtualization costs, datacenter costs, networking costs, and database costs.

**Step 3: View the report**

![Depicts two TCO pie charts. One for total on-premises cost of $30,702,495 and one for Azure cost of $595,618.](../media/total-cost-ownership-report.png)


The TCO calculator generates a detailed report based on the details you enter and the adjustments you make.  The report allows you to compare the costs of your on-premises infrastructure with the costs using Azure products and services to host your infrastructure in the cloud.


