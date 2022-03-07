Included with the Azure Stack Hub solution, the hardware lifecycle host is a computer outside Azure Stack Hub that runs OEM vendor-provided management tools for hardware. You can use these tools or other solutions that directly integrate with existing monitoring solutions in your datacenter.

The following table summarizes the list of currently available options.

Note the following requirements:

:::row:::
  :::column:::
    **Area**
  :::column-end:::
  :::column:::
    **External Monitoring Solution**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Stack Hub software
  :::column-end:::
  :::column:::
    [Azure Stack Hub Management Pack for Operations Manager](https://azure.microsoft.com/blog/management-pack-for-microsoft-azure-stack-now-available/)
[Nagios plug-in](https://exchange.nagios.org/directory/Plugins/Cloud/Monitoring-AzureStack-Alerts/details)
REST-based API calls
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Physical servers (BMCs via IPMI)
  :::column-end:::
  :::column:::
    OEM hardware - Operations Manager vendor management pack
OEM hardware vendor-provided solution
Hardware vendor Nagios plug-ins.
OEM partner-supported monitoring solution (included)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Network devices (SNMP)
  :::column-end:::
  :::column:::
    Operations Manager network device discovery
OEM hardware vendor-provided solution
Nagios switch plug-in
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Tenant subscription health monitoring
  :::column-end:::
  :::column:::
    [System Center Management Pack for Windows Azure](https://www.microsoft.com/download/details.aspx?id=50013)
  :::column-end:::
:::row-end:::


 -  The solution you use must be agentless. You can't install third-party agents inside Azure Stack Hub components.
 -  If you want to use System Center Operations Manager, Operations Manager 2012 R2 or Operations Manager 2016 is required.
