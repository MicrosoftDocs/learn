After configuring both sites with VMware Site Recovery Manager (SRM), you should proceed with installing the VMware vSphere Replication solution. VMware vSphere Replication is an integrated component of VMware vSphere, and uses a virtual machine (VM) replication appliance at the hypervisor level.

## vSphere Replication appliance components

vSphere Replication is an Azure VMware Solution private cloud add-on that you can use to help protect your VMs from partial or complete site failure. Any changes to the primary site VM are captured by vSphere Replication and applied to the VM offline disk copies (replicas).

The vSphere Replication appliance provides the following components for the protection scenarios:

- A VMware SRM user interface for working with vSphere Replication.
- A plug-in to the vSphere web client and vSphere client that provides a user interface for vSphere Replication health status.
- A VMware standard embedded PostgreSQL database that stores the replication configuration.
- A vSphere Replication management server that manages replications.
- A vSphere Replication server that provides the core of the vSphere Replication infrastructure.

> [!IMPORTANT] 

> Try our VMware Site Recovery Manager click-through demo. This demo shows how an organization can confidently implement disaster recovery for on-premises VMware vSphere virtual machines (VMs) or Azure VMware Solution-based VMs. [Try now](https://regale.cloud/Microsoft/play/3245/vmware-site-recovery-manager-srm#/0/0)

## Install vSphere Replication appliance

Use the following procedure to enable the add-on in Azure VMware Solution:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Search for and select your Azure VMware Solution.
1. From the navigation menu, under **Manage**, select **Add-ons**.
1. Select the **Disaster Recovery** tab, then select **Start**.
1. Under **Feedback**, from the drop-down list, select **VMware Site Recovery Manager (SRM)**.
1. Under **License key**, enter your license key and select **Save**.
1. Under **Setup replication**, from the **Replication using** drop-down menu, select **vSphere Replication**.
1. Configure the number of vSphere servers, then select **Install**.

:::image type="content"  source="../media/4-vsphere-replication-install-add-ons.png" alt-text="Screenshot of the Disaster recovery tab in Azure VMware Solution. The vSphere Replication option is selected under Setup replication."lightbox="../media/4-vsphere-replication-install-add-ons.png":::

After you set up the replication infrastructure, you can select the VMs to be replicated at a different recovery point objective (RPO). You can enable the multiple point-in-time retention policy to store more than one instance of the replicated VM. After recovery, the retained instances are available as snapshots of the recovered VM.

Your sites are now configured and ready for testing and implementing different disaster recovery plans for your VMs.
