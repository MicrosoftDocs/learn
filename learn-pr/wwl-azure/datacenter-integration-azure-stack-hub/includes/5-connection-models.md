If you decide to purchase an integrated system, your original equipment manufacturer (OEM) hardware vendor will help guide you through the planning process in more detail. The OEM hardware vendor also performs the actual deployment.

## Choose an Azure Stack Hub deployment connection model

You can choose to deploy Azure Stack Hub either connected to the internet (and to Azure) or disconnected. Deploy connected to Azure to get the most benefit from Azure Stack Hub, including hybrid scenarios between Azure Stack Hub and Azure. This choice defines which options are available for your identity store (Microsoft Entra ID or Active Directory Federation Services) and billing model (pay as you use-based billing or capacity-based billing) as summarized in the following diagram and table:

:::image type="content" source="../media/azure-stack-sub-integrated-systems-connection-models-image-24-90824009.png" alt-text="Azure Stack Hub deployment and billing scenarios.":::


Choosing Active Directory Federation Services (AD FS) or Microsoft Entra ID is a one-time decision that you must make at deployment time. You can't make changes later without redeploying the entire system.

:::row:::
  :::column:::
    **Options**
  :::column-end:::
  :::column:::
    **Connected to Azure**
  :::column-end:::
  :::column:::
    **Disconnected from Azure**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Microsoft Entra ID
  :::column-end:::
  :::column:::
    **Yes**
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    AD FS
  :::column-end:::
  :::column:::
    **Yes**
  :::column-end:::
  :::column:::
    **Yes**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Consumption-based billing
  :::column-end:::
  :::column:::
    **Yes**
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Capacity-based billing
  :::column-end:::
  :::column:::
    **Yes**
  :::column-end:::
  :::column:::
    **Yes**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Licensing
  :::column-end:::
  :::column:::
    Enterprise Agreement or Cloud Solution Provider
  :::column-end:::
  :::column:::
    Enterprise Agreement
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Patch and update
  :::column-end:::
  :::column:::
    Update package can be downloaded directly from the Internet to Azure Stack Hub.
  :::column-end:::
  :::column:::
    Required Also requires removable media and a separate connected device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Registration
  :::column-end:::
  :::column:::
    Automated
  :::column-end:::
  :::column:::
    Required Also requires removable media and a separate connected device.
  :::column-end:::
:::row-end:::


After you've decided on the Azure connection model to be used for your Azure Stack Hub deployment, other connection-dependent decisions must be made for the identity store and billing method.
