Azure Stack Hub includes the infrastructure needed to track usage as it occurs and forwards it to Azure. In Azure, Azure Commerce processes the usage data and charges usage to the appropriate Azure subscriptions. This process works in the same way as usage tracking in the global Azure cloud.

Some concepts are consistent between global Azure and Azure Stack Hub. Azure Stack Hub has local subscriptions, which fulfill a similar role to an Azure subscription. Local subscriptions are only valid locally. Local subscriptions are mapped to Azure subscriptions when usage is forwarded to Azure.

Azure Stack Hub has local usage meters. Local usage is mapped to the meters used in Azure commerce. However, the meter IDs are different. There are more meters available locally than the one Microsoft uses for billing.

There are some differences between how services are priced in Azure Stack Hub and Azure. For example, in Azure Stack Hub, the charge for virtual machines is only based on vcore/hours, with the same rate for all virtual machine series, unlike Azure. The reason is that in global Azure the different prices reflect different hardware. In Azure Stack Hub, the customer provides the hardware, so there's no reason to charge different rates for different virtual machine classes.

You can find out about the Azure Stack Hub meters used in Commerce and their prices in Partner Center. The process is the same as it is for Azure services:

1.  In Partner Center, go to the **Dashboard** menu, then select **Sell**, then select **Pricing and offers**.
2.  Under **Usage-based services**, select **Current**.
3.  Open the **Azure in Global CSP price list** spreadsheet.
4.  Filter on **Region = Azure Stack Hub**.

## Terms used for billing and usage

The following terms and concepts are used for usage and billing in Azure Stack Hub:

:::row:::
  :::column:::
    **Term**
  :::column-end:::
  :::column:::
    **Definition**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Direct CSP partner
  :::column-end:::
  :::column:::
    A direct CSP partner receives an invoice directly from Microsoft for Azure and Azure Stack Hub usage, and bills customers directly.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Indirect CSP
  :::column-end:::
  :::column:::
    Indirect resellers work with an indirect provider (also known as a distributor). The resellers recruit end customers; the indirect provider holds the billing relationship with Microsoft, manages customer billing, and provides other services like product support.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    End customer
  :::column-end:::
  :::column:::
    End customers are the businesses and government agencies that own the apps and other workloads that run on Azure Stack Hub.
  :::column-end:::
:::row-end:::
