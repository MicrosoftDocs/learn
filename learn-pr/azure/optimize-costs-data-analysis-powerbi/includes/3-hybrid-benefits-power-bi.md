Azure Hybrid Benefit (AHB) helps to reduce the licensing cost of your Azure VMs that run Windows Server. When you have the benefit but aren't actively using it, you should fully use it to save money. For more information about the program, check out [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/).

If you're already using your benefit, then use the Windows Server AHB Usage report to identify the servers that have AHB enabled. When you're not using your benefit, the report shows you where you can use it. In either case, the report helps maximize your benefit usage by showing recommendations that help save you money. Because of the complicated nature of the benefit, the report can give you confidence to fully use your Windows Server licensing benefit without unintentionally exceeding it.

In the Microsoft Cost Management Power BI App, navigate to the **Windows Server AHB Usage** page.

The report shows the number of virtual machines that have Azure Hybrid Benefit enabled over time. It also shows a count of cores/vCPUs currently used by the virtual machines.

:::image type="content" source="../media/3-windows-server-usage-report.png" alt-text="Screenshot showing the Windows Server AHB usage report." lightbox="../media/3-windows-server-usage-report.png" :::

The report also identifies Windows VMs where Hybrid Benefit is currently **enabled** but there are *fewer than* 8 vCPUs. They're shown under **AHB enabled SKUs with less than 8 vCPU (last day)**. In other words, the VMs shown in this area aren't fully using the benefit.

There might be situations where you intend to use fewer than 8 vCPUs. However, licenses for VMs in this area are likely good candidates to get replaced by VMs under **SKUs with 8+ vCPUs where AHB not enabled (last day)**. That's because the larger VMs where AHB isn't enabled are much more expensive than smaller ones. In other words, VMs shown in this area *aren't using any benefits at all*. Apply the benefit to your most expensive virtual machines, like those in this area, to maximize your potential savings.

:::image type="content" source="../media/3-benefits-usage.png" alt-text="Screenshot showing a section where VMs are underused and not enabled." lightbox="../media/3-benefits-usage.png" :::
