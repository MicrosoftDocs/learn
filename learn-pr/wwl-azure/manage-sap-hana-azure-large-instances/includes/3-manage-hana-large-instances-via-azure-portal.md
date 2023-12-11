In the Azure portal, on the page listing HANA Large Instance units, you can choose any of the entries to access the details of the corresponding single HANA Large Instance unit.

You will find there the name of the unit, its operating system, its IP address, and the unit type with the number of CPU threads and memory.

Another important piece of information available in the Azure portal include the ExpressRoute Circuit ID (you might need to provide it when raising a support request) and the IP address of the NFS endpoint providing storage for the unit (you need to reference it when configuring storage snapshots).

The portal also displays information about the power state. The power state indicates whether the hardware unit is powered on or off. It does not represent the state of the operating system. As you restart a HANA Large Instance unit, you will experience a short period of time where the state of the unit changes from **Starting** to **Started**. The **Started** state indicates that the OS is starting up or that the OS has been started up completely. As a result, after a restart of the unit, you might need to wait before you can log in even if the state already changed to Started.

Beyond identifying the basic status of HANA Large Instance units, you can also review their activities. One of the main activities recorded is restarts. The captured data includes the status of the activity, the timestamp of its trigger, the subscription ID of the trigger, and the Microsoft Entra identity that initiated the trigger.

Another type of recorded activity represents changes to metadata associated with individual units (such as adding or deleting a tag). This activity is recorded as **Write HANAInstances** and has no impact on the operational state of the HANA Large Instance unit. By default, the HANA Large Instance units have no tag assigned.

## Restart a HANA Large Instance unit through Azure portal

Restart of the Linux operating system of an HANA Large Instance unit might sometimes not complete successfully. In the past, remediating this issue required opening a service request to have the Microsoft operations team perform a power restart on your behalf. The functionality of a power restart of a HANA Large Instance unit is now available directly from the Azure portal. The restart button appears in the overview section of the HANA Large Instance unit in the Azure portal.

Depending on the amount of memory of the HANA Large Instance unit, a restart and reboot of the hardware and the operating system can take up to one hour.

## Register HANA Large Instance resource provider

Usually, the Azure subscription you are using for HANA Large Instance deployments includes registration of the HANA Large Instance resource provider. However, if you can’t see you deployed HANA Large Instance units, you should register the resource provider in your Azure subscription. You can accomplish this by using Azure CLI and the Azure portal.

### Register through CLI interface

To perform registration, start by signing in to your Azure subscription containing the HANA Large Instance deployment via the Azure CLI. Next, invoke the registration by running the following:

```bash
az provider register --namespace Microsoft.HanaOnAzure

```

### Register through the Azure portal

To register the HANA Large Instance resource provider via the Azure portal, display the blade representing the Azure subscription, which was used to deploy the HANA Large Instance unit(s). On that page, select **Resource providers** and type **HANA** in the search text box. In the list of results, click **re-register** or **register**.
