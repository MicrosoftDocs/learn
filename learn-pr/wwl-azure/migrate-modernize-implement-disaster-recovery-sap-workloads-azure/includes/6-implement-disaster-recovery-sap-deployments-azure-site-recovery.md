Replicate virtual machines:

To start replicating Azure VMs to the Azure region serving as the disaster recovery site, follow the guidance in [Tutorial: Set up disaster recovery for Azure VMs](/azure/site-recovery/azure-to-azure-walkthrough-enable-replication).

- For guidance on protecting Active Directory and DNS, refer to [Set up disaster recovery for Active Directory and DNS](/azure/site-recovery/site-recovery-active-directory).
- For guidance on protecting database tier running on SQL server, refer to [Set up disaster recovery for SQL Server](/azure/site-recovery/site-recovery-sql).

## Configure networking

If you use a static IP address, you can specify the IP address that you want the virtual machine to take as part of its Azure Site Recovery protection settings.

## Create a recovery plan

A recovery plan supports the sequencing of various tiers in a multi-tier application during a failover. Sequencing helps maintain application consistency. When you create a recovery plan for a multi-tier web application, complete the steps described in [Create and customize recovery plans](/azure/site-recovery/site-recovery-create-recovery-plans).

### Add virtual machines to failover groups

Create a recovery plan by adding the application server, web dispatcher, and SAP Central services VMs.

### Add scripts to the recovery plan

For your applications to function correctly, you might need to perform some operations on the Azure VMs after the failover or during a test failover. You can automate some post-failover operations. For example, you can update the DNS entry and change bindings and connections by adding corresponding scripts to the recovery plan. You can deploy the most commonly used Azure Site Recovery scripts into an Automation account.

For example, you should add a pre-action script to a facilitate failover SQL Availability group. Similarly, you should add a post-action script to attach a load balancer on the failed over Azure VMs.

## Run a test failover

1. In the Azure portal, select your Recovery Services vault.
2. Select the recovery plan that you created for SAP applications.
3. Select **Test Failover**.
4. To start the test failover process, select the recovery point and the Azure virtual network.
5. When the secondary environment is up, perform validations.
6. When validations are complete, to clean the failover environment, select **Cleanup test failover**.

## Run a failover

1. In the Azure portal, select your Recovery Services vault.
2. Select the recovery plan that you created for SAP applications.
3. Select **Failover**.
4. To start the failover process, select the recovery point.
