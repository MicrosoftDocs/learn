Azure Stack Hub is a collection of both Windows components and on-premises Azure services interacting with each other. All these components and services generate their own set of logs. Since Microsoft Support uses these logs to identify and fix your issues, we offer diagnostic log collection. Diagnostic log collection helps you quickly collect and share diagnostic logs with Microsoft Support.

You have to register Azure Stack Hub to use diagnostic log collection. If you haven't registered Azure Stack Hub, use the privileged endpoint (PEP) to share logs.

You have multiple ways to send diagnostic logs to Microsoft Support. Depending on your connectivity to Azure, your options include:

 -  [Send logs proactively (recommended)](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/diagnostic-log-collection.md).
 -  [Send logs now](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/diagnostic-log-collection.md).
 -  [Save logs locally](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/diagnostic-log-collection.md)

The flowchart below shows which option to use for sending diagnostic logs in each case. If Azure Stack Hub can connect to Azure, Microsoft recommends enabling **Proactive log collection**, which will automatically upload diagnostic logs to a Microsoft-controlled storage blob in Azure when a critical alert gets raised. You can alternatively collect logs on-demand by using **Send logs now**. If Azure Stack Hub is disconnected from Azure, you can **Save logs locally**.

:::image type="content" source="../media/diagnostic-log-collection-image-1-43c3122d.png" alt-text="Flowchart shows how to send logs now to Microsoft.":::


## Proactive log collection

Proactive log collection automatically collects and sends diagnostic logs from Azure Stack Hub to Microsoft before you open a support case. These logs are only collected when a system health alert is raised and are only accessed by Microsoft Support in the context of a support case.

Beginning with Azure Stack Hub version 2008, proactive log collection uses an improved algorithm that captures logs even during error conditions that aren't visible to an operator. Capture makes sure that the right diagnostic info is collected at the right time without needing any operator interaction. Microsoft support can begin troubleshooting and resolve problems sooner in some cases. Initial algorithm improvements focus on patch and update operations.

Azure Stack Hub collects logs for alerts and other hidden failure events, which aren't visible to you.

Azure Stack Hub proactively collects logs for:

 -  Update failed.
 -  Update needs attention.

When an event triggers these alerts, Azure Stack Hub proactively sends the logs to Microsoft.

In addition, Azure Stack Hub sends logs to Microsoft triggered by other failure events. These events are not visible to you.

Enabling proactive log collections is recommended as more operations are optimized and the benefits increase.

Proactive log collection can be disabled and re-enabled anytime. Follow these steps to set up proactive log collection.

1.  Sign in to the Azure Stack Hub administrator portal.
2.  Open **Help + support Overview**.
3.  If the banner appears, select **Enable proactive log collection**. Or you can select **Settings** and set **Proactive log collection** to **Enable**, then select **Save**.

> [!NOTE]
> If log location settings are configured for a local file share, make sure lifecycle management policies will prevent share storage from reaching its size quota. Azure Stack Hub does not monitor local file share or enforce any retention policies.

### How the data is handled.

You agree to periodic automatic log collections by Microsoft based only on Azure Stack Hub system health alerts. You also acknowledge and consent to the upload and retention of those logs in an Azure storage account managed and controlled by Microsoft.

The data will be used only troubleshooting system health alerts and won't be used for marketing, advertising, or any other commercial purposes without your consent. The data can be retained for up to 90 days and any data Microsoft collects will be handled following our [standard privacy practices](https://privacy.microsoft.com/).

Any data previously collected with your consent won't be affected by the revocation of your permission.

Logs collected using **Proactive log collection** are uploaded to an Azure storage account managed and controlled by Microsoft. These logs may be accessed by Microsoft in the context of a support case and to improve the health of Azure Stack Hub.

### Proactive diagnostic log collection alerts

If enabled, proactive log collection uploads logs when one of the following events is raised.

For example, **Update failed** is an alert that triggers proactive diagnostic log collection. If it's enabled, diagnostic logs are proactively captured during an update failure to help Microsoft Support troubleshoot the problem. The diagnostic logs are only collected when the alert for **Update failed** is raised.
