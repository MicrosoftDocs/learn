You can deploy an Azure Arc-enabled SQL Managed Instance (MI) to a Kubernetes environment, using directly or indirectly connected modes. To deploy an Arc-enabled SQL MI, we have several options available based on how we configured the Arc data controller:

- **Directly connected data controller**
    - Azure Portal GUI
    - Azure Portal Cloud Shell (CLI)
    - Powershell terminal window (CLI)
    - Azure Data Studio GUI
    - Azure Data Studio terminal window (CLI)
- **Indirectly connected data controller**
    - Powershell terminal window (CLI)
    - Azure Data Studio GUI
    - Azure Data Studio terminal window (CLI)

Before undertaking a deployment, ensure you have completed the following pre-requisites:

- [Install client tools](https://docs.microsoft.com/azure/azure-arc/data/install-client-tools).
- Have access to a Kubernetes cluster (v1.21 and above).
- Configured Arc data controller.
- Determine your required service tier.
    - General Purpose (Same as Standard Edition)
    - Business Critical (Same as Enterprise Edition)
- Understand your High Availability & Disaster Recovery requirements.
- Identify your Arc-enabled SQL MI requirements:
    - License types being used.
    - Instance Name.
    - Resource requirements:
        - Cores.
            - CPU vCore request is the number of vCores assigned to the Arc-enabled SQL MI.
            - CPU vCore limit is the maximum number of vCores assigned to the Arc-enabled SQL MI and can't exceed the supported limits of the Tier chosen ([General Purpose (24 vCores) Vs Business Critical (unlimited)](https://docs.microsoft.com/sql/sql-server/editions-and-components-of-sql-server-2019?view=sql-server-ver16#Cross-BoxScaleLimits))
        - Memory.
            - Memory request is the amount of memory allocated to the Arc-enabled SQL MI.
            - Memory limit is the maximum amount of memory allocated to the Arc-enabled SQL MI and can't exceed the supported limits of the Tier chosen ([General Purpose (128 GB) Vs Business Critical (unlimited)](https://docs.microsoft.com/sql/sql-server/editions-and-components-of-sql-server-2019?view=sql-server-ver16#Cross-BoxScaleLimits))
        - Backup storage class. (Location for your Automated backups. Requires to be ReadWriteMany (RWX) supported storage class)
        - Data storage class. (Location for your database data files)
        - Database Log storage class. (Location for your database transaction log files)
        - Log storage class. (Location for your log files)
        - Backup volume sizing.
        - Data volume sizing.
        - Datalog volume sizing.
        - Log volume sizing.
    - Admin account and password.

Before deploying your Arc-enabled SQL MI, ensure that your provisioned data classes on your Kubernetes cluster meet your capacity and performance requirements. Your backup class storage needs to be ReadWriteMany (RWX) capable storage to allow for the automated backups of your databases. Without this backup storage class, you will not be able to deploy a SQL MI successfully.