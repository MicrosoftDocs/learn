Azure Center for SAP solutions (ACSS) is an end-to-end solution that enables you to create and run SAP systems as a unified workload on Azure, but there are prerequisites. To successfully deploy SAP on Azure, ACSS requires prerequisites to be completed.

You'll need an Azure [subscription](/azure/cost-management-billing/manage/create-subscription#create-a-subscription) to provision Azure resources with the prerequisites.

## Infrastructure pre-provisioning

The following items are required for a deployment of SAP infrastructure on Azure using ACSS:

- Review the quotas for your Azure subscription. If the quotas are low, you might need to create a support request before creating your infrastructure deployment. Otherwise, you might experience deployment failures or an **Insufficient quota** error.
- Configure Azure role-based access control (RBAC) role assignments for the Microsoft Entra ID user account used to perform the deployment.
- Create a storage account associated with the Azure Center for SAP solutions used for the deployment.
- Create and configure a user-assigned managed identity to be used by Azure Center for SAP solutions for authentication and authorization of its automated deployment.
- Create a network security group (NSG) to be used within subnets of the virtual network that hosts the deployment.
- Create route tables to be used within subnets of the virtual network that hosts the deployment.
- Create and configure the virtual network that hosts the deployment.
- Deploy Azure Firewall into the virtual network that hosts the deployment.
- Deploy Azure Bastion into the virtual network that hosts the deployment.

## Infrastructure access prerequisites

Grant access to:

- Azure Storage accounts
- Azure Resource Manager (ARM)
- Microsoft Entra ID services from the virtual network where the SAP system exists.

Use one of these options:

- Allow outbound internet connectivity for the VMs.
- Use [**Service tags**](/azure/virtual-network/service-tags-overview) to allow connectivity.
- Use a Service tag with regional scope to allow connectivity to resources in the same region as the VMs.
- Allowlist the region-specific IP addresses for Azure Storage, Azure Resource Manager and Microsoft Entra ID.
- Register the **Microsoft.Workloads** Resource Provider in the subscription where you have the SAP system.
- Check that your Azure account has **Azure Center for SAP solutions administrator** and **Managed Identity Operator** or equivalent role access on the subscription or resource groups where you have the SAP system resources.
- A **User-assigned managed identity** which has **Azure Center for SAP solutions service role** access on the Compute resource group and **Reader** role access on the Virtual Network resource group of the SAP system. Azure Center for SAP solutions service uses this identity to discover your SAP system resources and register the system as a VIS resource.
- Make sure ASCS, Application Server and Database virtual machines of the SAP system are in **Running** state.

## SAP system level prerequisites

- `sapcontrol` and `saphostctrl` exe files must exist on ASCS, App server and Database.
  - File path on Linux VMs: `/usr/sap/hostctrl/exe`
  - File path on Windows VMs: `C:\Program Files\SAP\hostctrl\exe\`
- Make sure the **`sapstartsrv`** process is running on all **SAP instances** and for **SAP `hostctrl` agent** on all the VMs in the SAP system.
  - To run, `hostctrl sapstartsrv` use this command for Linux VMs: `hostexecstart -start`
  - To run the instance, `sapstartsrv` use the command: `sapcontrol -nr 'instanceNr' -function StartService S0S`
  - To check status of `hostctrl sapstartsrv` use this command for Windows VMs: `C:\Program Files\SAP\hostctrl\exe\saphostexec –status`
- For successful discovery and registration of the SAP system, ensure there's network connectivity between ASCS, App and DB VMs. `ping` command for App instance hostname must be successful from ASCS VM. `ping` for Database hostname must be successful from App server VM.
- On App server profile, `SAPDBHOST`, `DBTYPE`, `DBID` parameters must have the right values configured for the discovery and registration of Database instance details.

## Further details

- Review the article [Prepare network for infrastructure deployment](/azure/sap/center-sap-solutions/prepare-network) to complete steps necessary for deploying your SAP system on Azure.
- Detailed steps are available in AZ-120 GitHub lab Module 5: Design and implement an infrastructure to support SAP workloads on Azure - [Exercise 1: Implement prerequisites for deploying SAP workloads in Azure by using Azure Center for SAP solutions](https://github.com/MicrosoftLearning/AZ-120-Planning-and-Administering-Microsoft-Azure-for-SAP-Workloads/blob/master/Instructions/AZ-120_Lab05-ACSS_Deployment.md).
