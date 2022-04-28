One thing that makes cloud services different from traditional on-premises virtual desktop infrastructures (VDIs) is how they handle security responsibilities.

When you use Azure Virtual Desktop, it’s important to understand that while some components come already secured for your environment, you'll need to configure other areas yourself to fit your organization’s security needs.

Listed below are the security needs you're responsible for in your Azure Virtual Desktop deployment:

:::row:::
  :::column:::
    **Security need**
  :::column-end:::
  :::column:::
    **Is the customer responsible for this?**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Identity
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    User devices (mobile and PC)
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    App security
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Session host OS
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Deployment configuration
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Network controls
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Virtualization control plane
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Physical hosts
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Physical network
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Physical datacenter
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::


The security needs the customer isn't responsible for are handled by Microsoft.

Microsoft recommends enabling Microsoft Defender for Cloud for subscriptions, virtual machines, key vaults, and storage accounts.

With Microsoft Defender for Cloud Standard, you can:

 -  Manage vulnerabilities.
 -  Assess compliance with common frameworks like Payment Card Industry (PCI).
 -  Strengthen the overall security of your environment.
