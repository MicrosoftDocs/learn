Your deployment methodology for Azure SQL Managed Instance somewhat depends on the connectivity mode you selected when installing Azure Arc SQL data controller. For your company, you chose the indirectly connected mode because the US government contract-related data must be fully isolated from the internet. For on-premises SQL Server databases hosted in overseas datacenters, you opted for the directly connected mode to benefit from features such as the Azure portal-based management, cloud-resident backup, built-in update mechanism through integration with Microsoft Container Registry in addition to automatic metric, log, and usage data collection.

## Prepare to deploy an Azure Arc-enabled SQL Managed Instance

Ensure that you satisfy all of the prerequisites for deployment of an Azure Arc-enabled SQL Managed Instance, including provisioning the suitable size and type of compute and storage resources. To avoid resource constraints issues, consider addressing these prerequisites early in the design stage, before you deploy a data controller. Sizing decisions are closely related to the choice of the service tier and resiliency requirements. They also depend on other factors, such as the number of databases you intend to provision and their utilization levels.

In general, as part of the preparation for the deployment of a managed instance, complete the following tasks:

- Install the client tools required to carry out the deployment method you choose as listed at [Install client tools for deploying and managing Azure Arc-enabled data services](/azure/azure-arc/data/install-client-tools).
- Verify access to the Kubernetes cluster that hosts the Azure Arc data controller.
- Decide which service tier to provision. As you decide, consider high availability and disaster recovery requirements.
- Identify the licensing model for the planned deployment. It's possible to lower the licensing costs by applying the Azure Hybrid Benefit (AHB) for SQL Server discount. AHB is part of the Software Assurance program that allows its customers to use existing SQL Server licenses to reduce pricing of cloud and hybrid resources.
- Determine resource requirements:
  - **vCores**:
    - vCore request, which designates the number of vCores assigned to the Azure Arc-enabled SQL Managed Instance.
    - vCore limit, which designates the maximum number of vCores available to the Azure Arc-enabled SQL Managed Instance. This number can't exceed the supported limits of the service tier you decided to implement. The General Purpose service tier supports up to 24 vCores, while the Business Critical service tier doesn't impose any vCore limits.
  - **Memory**:
    - Memory request, which designates the amount of memory allocated to the Azure Arc-enabled SQL Managed Instance.
    - Memory limit, which designates the maximum amount of memory allocated to the Azure Arc-enabled SQL Managed Instance. This number can't exceed the supported limits of the service tier you decide to implement. The General Purpose service tier supports up to 128 GB of memory, while the Business Critical service tier doesn't impose any memory limits.
  - **Storage**:
    - Data storage class and volume size of database data files.
    - Database Log storage class and volume size used by database transaction log files.
    - Log storage class and volume size used by service log files.
    - Backup storage class and volume size used by automated backups. This class must be ReadWriteMany (RWX) capable.
- Deploy the Azure Arc data controller.

## Deployment method options

When the installation of data controllers completes, you need to decide which deployment method to use for the managed instances. You can choose from several available options, which provide sufficient flexibility to match your preferred operational model.

- In the directly connected connectivity mode, you can use:
  - The Azure portal.
  - Azure PowerShell or Azure CLI (locally installed or running from a Cloud Shell session).
  - Azure Data Studio graphical interface.
  - Azure Data Studio terminal window.
- In the indirectly connected connectivity mode, you can use:
  - Azure PowerShell or Azure CLI (locally installed).
  - Azure Data Studio graphical interface.
  - Azure Data Studio terminal window.

You'll review the deployment process of an Azure Arc-enabled SQL Managed Instance that use some of these options in the next exercise unit of this module.
