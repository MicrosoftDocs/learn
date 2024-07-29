A combination of availability within and across regions might be driven by these factors:

- A requirement of RPO = 0 within an Azure region.
- The organization isn't willing or able to have global operations affected by a major natural catastrophe that affects a larger region.
- Regulations that demand distances between primary and secondary sites that are clearly beyond what Azure availability zones can provide.

In these cases, you can set up what SAP calls an SAP HANA multi-tier system replication configuration by using HANA system replication.

:::image border="false" type="content" source="../media/three-vms-over-two-regions-895877f6.png" alt-text="Diagram showing three virtual machines over two regions.":::

SAP introduced multi-target system replication with HANA 2.0 SPS3. Multi-target system replication brings some advantages in update scenarios. For example, the DR site (Region 2) isn't impacted when the secondary HA site is down for maintenance or updates.

:::image border="false" type="content" source="../media/three-vms-over-two-regions-multi-target-791185ed.png" alt-text="Diagram showing three virtual machines over two regions, multi-target.":::

If the organization has requirements for high availability readiness in the second (DR) Azure region, then the architecture would look as follows:

:::image border="false" type="content" source="../media/three-vms-over-two-regions-multi-target-ha-bf40d221.png" alt-text="Diagram showing four virtual machines over two regions multi-target, high availability.":::

Using `logreplay` as operation mode, this configuration provides an RPO = 0, with low RTO, within the primary region. The configuration also provides decent RPO if a move to the second region is involved. The RTO times in the second region are dependent on whether data is preloaded. Many customers use the virtual machine in the secondary region to run a test system. In that use case, the data can't be preloaded.

> [!IMPORTANT]
> The operation modes between the different tiers need to be homogeneous. You can't use logreplay as operation mode between tier 1 and tier 2 and delta\_datashipping to supply tier 3. You can only choose the one or the other operation mode that needs to be consistent for all tiers. Since delta\_datashipping isn't suitable to give you an RPO = 0, the only reasonable operation mode for such a multi-tier configuration remains logreplay.
