Since the primary purpose of Azure Arc data controller is support for data services, it is important to optimize its operations and take full advantage of the functionality it provides. Following the initial deployment, there are several tasks that you should incorporate into your standard operating procedures. These tasks include verifying data controller status, managing its upgrades, enumerating its endpoints, enabling auto-upload of metrics and logs in the directly connected mode, and configuring the maintenance window. Configuring the maintenance window is of particular importance because it needs to align with the internal change control and business service level agreements (SLAs) within your company.

## Verify the data controller status

The status of Azure Arc data controller is readily available on its page within the Azure portal. Alternatively, you can review the output of the **az arcdata dc status show** Azure CLI command. This command accepts the name of a Kubernetes namespace or an Azure resource group, which allows you to target specific data controllers based on different criteria.

## Manage data controller upgrades

As a component of Azure Arc data services, the data controller is subject to automatic upgrades. To review versions of its Docker images available in Microsoft Container Registry, you can use the **az arcdata dc list-upgrades** command, with the value of the *--k8s-namespace* parameter identifying its namespace on the target Kubernetes cluster. To trigger an upgrade to a specific version, run the az arcdata dc upgrade with the *--desired-version* parameter. If the *--desired-version* parameter is not set, the command will install the latest version. An equivalent command is available for Azure Arc-enabled SQL Managed Instance.

## Enumerate endpoints

If you want to review the endpoints of a data controller including log search and metrics dashboards, run the **az arcdata dc endpoint list** command and review its output. 

## Enable auto-upload of metrics and logs

If you change your mind following the deployment of the data controller and you decide to either enable or disable auto-upload of metrics and logs in the directly connected mode, consider using the **az arcdata dc update** command with the *--auto-upload-metrics* parameter set to either true or false. 

## Configure a maintenance window

The **arcdata dc update**ommand also allows you to configure the maintenance window of the data controller and the associated data services. The window you specify defines a time period during which the data controller and data services upgrades are allowed. To ensure that the Arc-enabled SQL Managed Instances on that data controller are upgraded, set the value of their **desiredVersion** property to auto.

As part of the maintenance window configuration, set its duration between two and eight hours, specify recurrence, and assign the start date and time. After the maintenance window starts, it will run for the period of time set in the duration. The instances attached to the data controller will begin upgrades in parallel. At the end of the set duration, any upgrades that are in progress will continue to completion. Any instances that did not begin upgrading in the window will begin upgrading in the following recurrence.
