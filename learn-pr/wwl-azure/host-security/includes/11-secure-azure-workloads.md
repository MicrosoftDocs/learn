The Azure Security Benchmark includes a collection of high-impact security recommendations you can use to help secure the services you use in Azure: **Security controls**: These recommendations are generally applicable across your Azure tenant and Azure services. Each recommendation identifies a list of stakeholders that are typically involved in planning, approval, or implementation of the benchmark. **Service baselines**: These apply the controls to individual Azure services to provide recommendations on that service’s security configuration.

Microsoft's cybersecurity group in conjunction with the Center for Internet Security (CIS) has developed best practices to help establish security baselines for the Azure platform. A security baseline is:

 -  A set of basic security objectives which must be met by any given service or system.
 -  Establishes what you need to do and not how to do it.

The [CIS Microsoft Azure Foundations Security Benchmark](/azure/governance/blueprints/samples/cis-azure-1-3-0) guide provides prescriptive guidance for establishing a secure baseline configuration for Azure. This guide was tested against the listed Azure services as of March 2018. The scope of this benchmark is to establish the foundational level of security for anyone adopting Azure.

## Create a platform security baseline

A variety of security standards can help cloud service customers to achieve workload security when using cloud services. The following are recommended technology groupings to help create secure cloud-enabled workloads. These recommendations should not be considered an exhaustive list of all possible security configurations and architectures but just as a starting point.

:::image type="content" source="../media/az500-host-hardened-905c68e4.png" alt-text="A diagram of the workflow for securing Azure workloads with CIS benchmark.":::


CIS has two implementation levels, and several categories of recommendations.

**Level 1** \- Recommended minimum security settings

 -  These should be configured on all systems.
 -  These should cause little or no interruption of services nor reduced functionality.

**Level 2** \- Recommendations for highly secure environments

 -  These might result in reduced functionality.

The following table provides the categories and number of recommendations made for each.

:::row:::
  :::column:::
    **Technology group**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **\# of recommendations**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Identity &amp; Access Management (IAM)**
  :::column-end:::
  :::column:::
    Recommendations related to IAM policies
  :::column-end:::
  :::column:::
    23
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Microsoft Defender for Cloud**
  :::column-end:::
  :::column:::
    Recommendations related to the configuration and use of Microsoft Defender for Cloud
  :::column-end:::
  :::column:::
    19
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Storage accounts**
  :::column-end:::
  :::column:::
    Recommendations for setting storage account policies
  :::column-end:::
  :::column:::
    7
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Azure SQL Database**
  :::column-end:::
  :::column:::
    Recommendations for helping secure Azure SQL databases
  :::column-end:::
  :::column:::
    8
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Logging and monitoring**
  :::column-end:::
  :::column:::
    Recommendations for setting logging and monitoring policies for your Azure subscriptions
  :::column-end:::
  :::column:::
    13
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Networking**
  :::column-end:::
  :::column:::
    Recommendations for helping to securely configure Azure networking settings and policies
  :::column-end:::
  :::column:::
    5
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **VMs**
  :::column-end:::
  :::column:::
    Recommendations for setting security policies for Azure compute services - specifically VMs
  :::column-end:::
  :::column:::
    6
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Other**
  :::column-end:::
  :::column:::
    Recommendations regarding general security and operational controls, including those related to Azure Key Vault and resource locks
  :::column-end:::
  :::column:::
    3
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Total recommended**
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    84
  :::column-end:::
:::row-end:::
