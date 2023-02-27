Once you have created your proximity placement group, you can begin to prepare for the deployment of your SAP HANA system to Azure NetApp Files. 

## Requirements for using application volume groups

* You must use a capacity pool with manual QoS.
* When you use application volume group to deploy your HANA volumes, at least one VM in the availability set must be started. Without a running VM, the PPG cannot be used to find the optimal Azure NetApp files hardware, and provisioning will fail.
* You must have created a virtual network and delegated subnet.

## Delegated subnet

Application volume group for SAP HANA will create multiple IP addresses. Different resource types in the SAP HANA deployment consume different IP addresses. For example, a data and log volumes have their own IP addresses. 

When you create the application volume group, it will create a minimum of three storage endpoints with three IP addresses. These minimums are based on deploying a single-host system. It is recommended you use a /24 subnet. The subnet should be size /26 and should have sufficient free IP addresses. If is recommended the subnet have a minimum of 59 IP addresses.  

## Deploying SAP HANA

Once you have configured the subnet and capacity pool, you have done the majority of the planning and architecture work to use application volume groups. 

Azure NetApp Files guides you through the steps to deploy your SAP HANA system. Deploying a single host SAP HANA system is a one step process. Deploying a multi-host or a system that uses data replication will require additional steps, but can be done with the same ease. 

For more information, see [Deploy the first SAP HANA host using application volume group for SAP HANA](/azure/azure-netapp-files/application-volume-group-deploy-first-host).
