Azure Arc-enabled SQL Managed Instance (MI) provides nearly the same features, functionality, and user experience as Azure SQL MI, except it runs on your chosen hardware, on your version-supported Kubernetes cluster inside your data center or multi-cloud environment.

Working with Arc-enabled SQL MI is broken down into three categories:

- Configuring the Arc-enabled SQL MI
- Managing the Arc-enabled SQL MI
- Working with databases deployed to the Arc-enabled SQL MI

## Configure Azure Arc-enabled SQL Managed Instance

Once the Arc-enabled SQL MI has been deployed, there are several configuration options that you can adjust:

- **SQL Agent** - by default, this is not enabled when deploying.
- **Cores** - both the requested number and limit of Cores provisioned to the deployed SQL MI.
- **Memory** - both the requested amount and maximum amount of memory allocated to the deployed SQL MI.
- **License Types** - This is important for billing purposes. The default value is LicenseIncluded. The configurable values are:
    - BasePrice
    - LicenseIncluded
    - DisasterRecovery
- **Readable Secondaries** - This is the number of replicas to be made readable and applies only to Business Critical tiered deployments. 
- **Replicas** - This is the number of replicas you wish to deploy to the Kubernetes cluster. Only Business Critical tiered deployments support multiple replicas. Supported values are:
    - General Purpose: 1
    - Business Critical: 1,2,3
- **Time Zone** - This allows you to set the time zone for the Arc-enabled SQL MI to your time zone.
- **Trace Flags** - This allows you to list specific trace flags you require enabled in your environment. By default, no trace flags are configured.

## Managing Azure Arc-enabled SQL Managed Instance

Arc-enabled SQL MI, depending on which connectivity mode you have selected, dictates what tools you can use to manage your data services environment:

- **Directly connected Mode** allows managing with the following tools:
    - Azure Portal
    - Azure Data Studio
    - az CLI with arcdata extension
    - kubernetes CLI
- **Indirectly connected Mode** allows managing with the following tools:
    - Azure Data Studio
    - az CLI with arcdata extension
    - kubernetes CLI

<!--Arc-enabled SQL MI, requires usage details for billing purposes. In Directly connected mode, these details are uploaded to your subscription automatically. In Indirectly connected mode, usage details must be manually exported and uploaded to your subscription.

Optionally, you can automatically upload metrics and logs to your subscription in the Directly connected mode or manually on an as-required basis in Indirectly connected mode.
-->
Exporting and importing the usage details, metrics, and logs are all undertaken using the following az arc data CLI commands:

- [az arcdata dc export](https://docs.microsoft.com/azure/azure-arc/data/reference/reference-az-arcdata-dc#az-arcdata-dc-export)
- [az arcdata dc upload](https://docs.microsoft.com/azure/azure-arc/data/reference/reference-az-arcdata-dc#az-arcdata-dc-upload)

## Azure Arc-enabled SQL Managed Instance Maintenance

Azure Arc-enabled SQL MI provides the ability to have an evergreen environment the same as is available with an Azure SQL MI. To achieve this, the maintenance windows need to be configured for the data controller, which defines the time periods for when upgrades occur.

When configuring a maintenance window for your data controller, the following options apply:

- Only one maintenance window per data controller.
- Duration window can be between 2-8 hours.
- The re-occurring frequency of the maintenance window can be either:
    - Weekly
    - Monthly
- Start date and time
- Time zone

To reduce the administrative overhead, all deployed Arc-enabled SQL MIs can be automatically upgraded when the Arc data controller is upgraded. To enable this behavior, you must set the `desired-version` property of the Arc-enabled SQL MI to auto.

## Upgrade Images

The frequency, availability, and automation of upgraded images that get applied to your Arc-enabled data services environments will depend on the connectivity mode chosen for your Arc data controller.

For directly connected Arc data controllers, upgrade images are available from the Microsoft Container Registry (MCR) to be applied to your environment automatically based on your configured maintenance window and the desired-version property for each of your deployed Arc-enabled SQL MIs.

For indirectly connected Arc data controllers, where there is no direct access to the MCR the upgraded images from the MCR need to be exported and imported into your private container registry. Once you import the images, you can apply them per your configured maintenance window and the desired-version property for each of your deployed Arc-enabled SQL MIs.

## Upgrade Downtime

The downtime experienced during upgrades will be dependent on the tier level of the Arc-enabled SQL MI. 

## General Purpose Upgrade Process

During an Arc-enabled SQL MI General Purpose upgrade, the containers in the pod will be upgraded and re-provisioned. As only a single pod is provisioned and utilized in this tier, you will experience a short amount of downtime while the new pod is created.

## Business Critical Upgrade Process

During an Arc-enabled SQL MI Business Critical upgrade, you will experience minimal downtime. The upgrade process takes care of applying the upgrades and patches as follows:
- Applying upgrades/patches on the secondary replica 1
- Applying upgrades/patches on the secondary replica 2
- Perform a failover from the primary replica to secondary replica 1
- Apply upgrades/patches on the remaining secondary replica 

Once upgrade process has been started, the upgrade requires no additional work from you.

## Working with Azure Arc-enabled SQL Managed Instance

Arc-enabled SQL MI, just like Azure SQL MI, is a versionless instance of SQL Server hosting your SQL Server Databases. Connecting to and working with your databases located on an Arc-enabled SQL MI, you can use your tool of choice:

- Azure Data Studio.
- SQL Server Management Studio.
- Custom applications.