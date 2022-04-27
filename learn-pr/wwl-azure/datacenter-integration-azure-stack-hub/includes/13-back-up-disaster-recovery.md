Planning for back up and disaster recovery involves planning for both the underlying Azure Stack Hub infrastructure that hosts IaaS virtual machines and PaaS services, and for tenant apps and data. Plan for these things separately.

### Protect infrastructure components

You can back up Azure Stack Hub infrastructure components to an SMB share that you specify:

 -  You'll need an external SMB file share on an existing Windows-based file server or a third-party device.
 -  Use this same share for the back up of network switches and the hardware lifecycle host. Your OEM hardware vendor will help provide guidance for back up and restore of these external Azure Stack Hub external components. You're responsible for running the back up workflows based on the OEM vendor's recommendation.

If catastrophic data loss occurs, you can use the infrastructure back up to reseed deployment data such as:

 -  Deployment inputs and identifiers
 -  Service accounts
 -  CA root certificate
 -  Federated resources (in disconnected deployments)
 -  Plans, offers, subscriptions, and quotas
 -  Role based access control (RBAC) policy and role assignments
 -  Key Vault secrets

### Protect tenant apps on IaaS virtual machines

Azure Stack Hub doesn't back up tenant apps and data. Plan for back up and disaster recovery protection to a target external to Azure Stack Hub. Tenant protection is a tenant-driven activity. For IaaS virtual machines, tenants can use in-guest technologies to protect file folders, app data, and system state. However, as an enterprise or service provider, you may want to offer a back up and recovery solution in the same datacenter or externally in a cloud.

To back up Linux or Windows IaaS virtual machines, you must use back up products with access to the guest operating system to protect file, folder, operating system state, and app data. You can use Azure Back up, System Center Datacenter Protection Manager, or supported third-party products.

To replicate data to a secondary location and orchestrate application failover if a disaster occurs, you can use Azure Site Recovery or supported third-party products. Also, apps that support native replication, like Microsoft SQL Server, can replicate data to another location where the app is running.
