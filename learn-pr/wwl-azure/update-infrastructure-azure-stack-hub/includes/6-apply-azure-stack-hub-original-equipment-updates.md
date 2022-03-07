You can apply original equipment manufacturer (OEM) updates to your Azure Stack Hub hardware components to get driver updates, firmware updates, and security patches. These updates are done while minimizing impact on your users.

## Overview of OEM updates

In addition to Microsoft Azure Stack Hub updates, many OEMs also release regular updates for your Azure Stack Hub hardware, such as driver and firmware updates. These updates are referred to as OEM package updates. To understand whether your OEM releases OEM package updates, check your [OEM's Azure Stack Hub documentation](/azure-stack/operator/azure-stack-update-oem?view=azs-2008).

These OEM package updates are uploaded into the **updateadminaccount** storage account and applied via the Azure Stack Hub administrator portal.

Ask your OEM about their specific notification process to ensure OEM package update notifications reach your organization.

Some hardware vendors may require a hardware vendor virtual machine that handles the internal firmware update process.

## OEM contact information

This section contains OEM contact information and links to OEM Azure Stack Hub reference material.

:::row:::
  :::column:::
    **Hardware Partner**
  :::column-end:::
  :::column:::
    **Region**
  :::column-end:::
  :::column:::
    **URL**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cisco
  :::column-end:::
  :::column:::
    All
  :::column-end:::
  :::column:::
    Cisco Integrated System for Microsoft Azure Stack Hub Operations Guide UCS C-Series Rack-Mount UCS-Managed Server Software
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Dell EMC
  :::column-end:::
  :::column:::
    All
  :::column-end:::
  :::column:::
    Cloud for Microsoft Azure Stack Hub 14G (account and login required) Cloud for Microsoft Azure Stack Hub 13G (account and login required)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Fujitsu
  :::column-end:::
  :::column:::
    JAPAN
  :::column-end:::
  :::column:::
    Fujitsu managed service support desk (account and login required)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    EMEA &amp; US
  :::column-end:::
  :::column:::
    Fujitsu support IT products and systems
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HPE
  :::column-end:::
  :::column:::
    All
  :::column-end:::
  :::column:::
    HPE ProLiant for Microsoft Azure Stack Hub
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Lenovo
  :::column-end:::
  :::column:::
    All
  :::column-end:::
  :::column:::
    ThinkAgile SXM Best Recipes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Wortmann
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    OEM/firmware package terra Azure Stack Hub documentation (including FRU)
  :::column-end:::
:::row-end:::


## Apply OEM updates

Apply the OEM packages with the following steps:

1.  Contact your OEM to:
    
     -  Determine the current version of your OEM package.
     -  Find the best method to download your OEM package.

2.  Before applying an OEM package update, always apply the latest Azure Stack Hub hotfix available on your system's current Azure Stack Hub version.
3.  Prepare your OEM packages.
4.  Apply the updates.

## Configure hardware vendor virtual machine

Some hardware vendors may require a virtual machine to help with the OEM update process. Your hardware vendor is responsible for creating these virtual machines and documenting if you require `ProxyVM` or `HardwareManager` for **-VMType** when running the **Set-OEMExternalVM** cmdlet, and which credential should be used for -Credential. Once the virtual machines are created, configure them with the **Set-OEMExternalVM** from the privileged endpoint.

1.  Access the privileged endpoint.

```
$cred = Get-Credential $session = New-PSSession -ComputerName -ConfigurationName PrivilegedEndpoint -Credential $cred
```

2.  Configure the hardware vendor virtual machine using the **Set-OEMExternalVM** cmdlet. The cmdlet validates the IP address and credentials for **-VMType**`ProxyVM`. For **-VMType**`HardwareManager`, the cmdlet won't validate the input. The **-Credential** parameter provided to **Set-OEMExternalVM** is one that will be clearly documented by the hardware vendor documentation. It is *NOT* the CloudAdmin credential used with the privileged endpoint, or any other existing Azure Stack Hub credential.

```powershell
$VmCred = Get-Credential Invoke-Command -Session $session { Set-OEMExternalVM -VMType
```
