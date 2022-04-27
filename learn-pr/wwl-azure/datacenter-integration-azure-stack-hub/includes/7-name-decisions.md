You'll need to think about how you want to plan your Azure Stack Hub namespace, especially the region, and the external domain name. The external fully qualified domain name (FQDN) of your Azure Stack Hub deployment for public-facing endpoints is the combination of these two names: `<region>.<fqdn>`. For example, `east.cloud.fabrikam.com`. In this example, the Azure Stack Hub portals would be available at the following URLs:

 -  `https://portal.east.cloud.fabrikam.com`
 -  `https://adminportal.east.cloud.fabrikam.com`

> [!IMPORTANT]
> The region name you choose for your Azure Stack Hub deployment must be unique and will appear in the portal addresses.

The following table summarizes these domain-naming decisions.

:::row:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Region name
  :::column-end:::
  :::column:::
    The name of your first Azure Stack Hub region. This name is used as part of the FQDN for the public virtual IP addresses (VIPs) that Azure Stack Hub manages. Typically, the region name would be a physical location identifier such as a datacenter location. The region name must consist of only letters and numbers between 0-9. No special characters (like -, \#, and so on) are allowed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    External domain name
  :::column-end:::
  :::column:::
    The name of the Domain Name System (DNS) zone for endpoints with external-facing VIPs. Used in the FQDN for these public VIPs.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Private (internal) domain name
  :::column-end:::
  :::column:::
    The name of the domain (and internal DNS zone) created on Azure Stack Hub for infrastructure management.
  :::column-end:::
:::row-end:::
