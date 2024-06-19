After configuring your proximity placement group, you can prepare for the deployment of your SAP HANA volumes to Azure NetApp Files.

## Requirements for using application volume groups

When you use application volume group to deploy your HANA volumes, you need:

* A capacity pool with manual QoS
* A virtual network and delegated subnet
* At least one VM in the availability set must be started.
    Without a running VM, the PPG can't be used to find the optimal Azure NetApp files hardware, causing provisioning to fail.

## Delegate a subnet

Application volume group for SAP HANA creates multiple storage endpoints. Different resource types in the SAP HANA deployment consume different storage endpoints. For example, a data and log volumes are deployed on their own storage endpoints.

When you deploy volumes using application volume group, a minimum of three storage endpoints with three IP addresses are created. These minimums are based on deploying a single-host system. It's recommended you use a /24 subnet for the Azure NetApp Files delegated subnet to allow for future growth.

## Deploy volumes for SAP HANA

After configuring the subnet and capacity pool, you've done most of the planning and architecture work to use application volume group.

Azure NetApp Files application volume group guides you through the steps to deploy your SAP HANA volumes. Deploying volumes for a single host SAP HANA system is a one-step process. Deploying multiple hosts or a system that uses data replication requires more steps, but can be done with the same ease.

For more information, see [Deploy the first SAP HANA host using application volume group for SAP HANA](/azure/azure-netapp-files/application-volume-group-deploy-first-host).
