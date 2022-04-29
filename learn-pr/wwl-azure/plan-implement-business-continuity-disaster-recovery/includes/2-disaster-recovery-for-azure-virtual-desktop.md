To strengthen your organization’s Azure Virtual Desktop availability and to keep data safe, you should implement a business continuity and disaster recovery (BCDR) strategy. A good BCDR strategy keeps your apps and workloads up and running during planned and unplanned service or Azure outages. The graphic below shows the **recovery point objective (RPO)** as the loss of data and the **recovery time objective (RTO)** as the time to recover from a disaster. :::image type="content" source="../media/recovery-point-objective-loss-recovery-time-81559491.png" alt-text="RPO loss and RTO time to recover.":::


The Azure Virtual Desktop service offers BCDR to preserve customer metadata during outages. When an outage occurs in an Azure region, the service infrastructure components will failover to a secondary location and continue functioning as expected.

To make sure your users can still connect during an Azure region outage, you may need to replicate personal VMs to a different Azure region (the secondary location). During outages, the primary region fails over to the replicated VMs in the secondary location. Users can continue to access apps from the secondary location without interruption. In addition to VM replication, you’ll need to ensure user identities are accessible at the secondary location. Accessible identities can be achieved by using profile containers. You may also use multiple Pooled host pools with automated provisioning across regions as an alternative to VM replication.

> [!IMPORTANT]
> Make sure business applications that rely on data in the primary Azure region can fail over with the rest of the data.

To ensure your users are connected during an outage, you should consider the five components shown in the table below.

:::row:::
  :::column:::
    **1**
  :::column-end:::
  :::column:::
    Virtual network
  :::column-end:::
  :::column:::
    Consider your network connectivity during an outage.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **2**
  :::column-end:::
  :::column:::
    Virtual machines
  :::column-end:::
  :::column:::
    Replicate the VMs in a secondary location or deploy multiple non-persistent host pools across Azure regions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **3**
  :::column-end:::
  :::column:::
    User and app data
  :::column-end:::
  :::column:::
    Using FSLogix profile containers, set up data replication in the secondary location. Data replication is also required for those using MSIX app attach.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **4**
  :::column-end:::
  :::column:::
    User identities
  :::column-end:::
  :::column:::
    Ensure user identities you set up in the primary location are available in the secondary location.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **5**
  :::column-end:::
  :::column:::
    Application dependencies
  :::column-end:::
  :::column:::
    Ensure any line-of-business applications relying on data in your primary location are failed over to the secondary location.
  :::column-end:::
:::row-end:::
