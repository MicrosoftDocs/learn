Azure Arc-enabled SQL Managed Instance minimizes considerably the administrative overhead associated with managing on-premises SQL Server instances. However, there are several configuration, management, and maintenance tasks that typically follow the initial deployment.

## Azure Arc-enabled SQL Managed Instance management tasks

The tasks that you need to perform following deployment may fall into categories like:

- Accommodate any post-installation adjustments necessitated by changing requirements
- Apply standard operating procedures
- Apply changes required by use of the indirectly connected mode

For example, you might find out that you underestimated the demand for data services residing in your overseas data centers and you need to allocate to them more vCore or memory resources. You might also decide to automate upgrades to the managed instance hosting the US government contracts data. In general, the most common management tasks include:

- Enable SQL Agent
- Modify instance size (vCores and memory)
- Set the licensing type
- Implement readable secondaries
- Set up replicas
- Adjust the time zone
- Enable trace flags
- Export and uploading usage details
- Set up a maintenance window
- Upgrade images

### Enable SQL agent

SQL Server agent is one of the more prominent features that distinguishes both Azure SQL Managed Instance and Azure Arc-enabled SQL Managed Instance from Azure SQL Database. The SQL Server agent is disabled by default following a managed instance deployment. However, you can easily enable it by running the `az sql mi-arc update` command with the `--agent-enabled true` parameter.

### Modify instance size (vCores and memory)

Depending on the changes in compute utilization levels, you might want to increase or decrease the numbers that determine the number of vCores and the amount of memory allocated to your managed instance. You can update these values by running the `az sql m-arc update` command and assigning the desired values to the `--cores-limit`, `--cores-request`, `--memory-limit`, and `--memory-request` parameters. To validate that the changes took effect, use the `az sql mi-arc` show command.

### Set the license type

Azure Arc-enabled SQL Managed Instance offers three pricing options:

- BasePrice: This option takes into account the SQL Server AHB discount.
- LicenseIncluded:  This option excludes the SQL Server AHB discount.
- DisasterRecovery:  This option applies to instances used exclusively for disaster recovery. 

To set the appropriate licensing option, use the `--license-type` parameter of the `az sql m-arc update` command. The default value is `LicenseIncluded`. 

### Implement readable secondaries

When deploying Azure Arc-enabled SQL Managed Instance in the Business Critical service tier with two or more replicas, by default, one secondary replica is automatically configured as readableSecondary. If this is not your intention, you can either remove that secondary or add extra ones by running the `az sql mi-arc update` command with the `--readable-secondaries` parameter. Set its value to the total number of secondaries you want to configure.

### Set up replicas

With the Business Critical service tier, you can optimize the level of resiliency by deploying an Azure Arc-enabled SQL Managed Instance in a multi-replica mode, with up to three replicas. To change the number of replicas post-deployment, use the `az sql mi-arc update` command with the `--replicas` parameter set to a value between `1` and `3`.

> [!NOTE]
> If you intend to reduce the number of replicas to one, make sure that you check the number of `--readable--secondaries` first and, set it to `0` if needed.

### Adjust the time zone

Coordinated Universal Time (UTC) is the recommended time zone for the data tier of new cloud and hybrid solutions because it eliminates ambiguity. However, Azure Arc-enabled SQL Managed Instance, similar to its cloud counterpart, supports selecting any time zone to accommodate the needs of existing applications that store date and time values and call date and time functions with an implicit context of a specific time zone. However, while you can configure the time zone of Azure SQL Managed Instance only during instance creation, with Azure Arc-enabled SQL Managed Instance, you can set the intended time zone post-deployment by running the `az sql mi-arc update` command with the `--time-zone` parameter.

### Enable trace flags

You typically use SQL Server trace flags in troubleshooting scenarios. As with other configuration settings previously described in this unit, to enable specific trace flags, use the `az sql mi-arc update` command with the `--trace-flags` parameter, followed by a comma-separated list of flags enclosed in double quotes. 

### Export and upload usage details

When operating in the indirectly connected mode, you need to periodically export usage data from the data controller and upload it to Azure. This is a two-step process involving the `az arcdata dc export` and `az arc data upload` commands, respectively. The first command creates a JSON formatted file that contains resource and data records describing the instance configuration and usage details. The purpose of the second command is to upload the file generated by the first one. Command line support facilitates automation. The process is automatic by default in the directly connected mode. 

You need to upload the current usage data at least once in every 30 days, although we highly recommended performing this task daily. Failing to upload usage data for more than 30 days results in a degradation of the managed instance functionality, including the inability to provision new resources.

### Set up a maintenance window

Azure Arc-enabled SQL Managed Instance provides the ability to automatically maintain an evergreen environment, matching the one available with an Azure SQL Managed Instance. To take advantage of this ability, you need to configure the data controller with a maintenance window during which upgrades take place. 

When you configure a maintenance window for a data controller, take into account the following considerations:

- There is one maintenance window per data controller.
- Duration window can be between two to eight hours.
- The recurring frequency of the maintenance window can be either weekly or monthly.

To set a maintenance window, use the `az arcdata dc update` command with the `--maintenance-start`, `--maintenance-duration`, `--maintenance-recurrence`, and `--maintenance-time-zone` switches.

### Upgrade images

To reduce the administrative overhead, you can enable automatic upgrade of Azure Arc-enabled SQL Managed Instances whenever their data controller is upgraded. To enable this capability, you must set the `desired-version` property of the Azure Arc-enabled SQL Managed Instance to auto. The frequency, availability, and the level of automation of image upgrades depend on the connectivity mode of the data controller hosting the managed instances.

- In the directly connected mode, a data controller pulls images directly from Microsoft Container Registry (MCR) and installs them automatically according to the maintenance window you configured and the `desired-version` property of each locally provisioned managed instance. 
- In the indirectly connected mode, you need to import MCR images into a private container registry accessible from the data controller. After you import the images, they are installed automatically according to the maintenance window you configured and the `desired-version` property of each locally provisioned managed instance, similar to the directly connected mode. Alternatively, you can initiate the upgrade manually.

The downtime experienced during upgrades depends on the tier level of the Azure Arc-enabled SQL Managed Instance. When upgrading a managed instance, its pod containers are upgraded and reprovisioned. Because this tier utilizes only a single pod, the upgrade will involve a short amount of downtime while a new pod is created. In case of Business Critical upgrades, you can reduce downtime to a minimum by utilizing the following sequence of events:

1. Apply an upgrade on the secondary replica 1.
2. Apply an upgrade on the secondary replica 2.
3. Perform a failover from the primary replica to secondary replica 1.
4. Apply an upgrade on the remaining secondary replica.

Once the upgrade process starts, it continues in an unattended manner until it completes.
