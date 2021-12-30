This unit provides an overview of the Azure Monitor service in Azure Stack Hub. It discusses the operation of Azure Monitor and additional information on how to use Azure Monitor on Azure Stack Hub.

Azure Monitor is a platform service that provides a single source for monitoring Azure resources. Azure Monitor lets you visualize, query, route, archive, and take other actions on metrics and logs coming from resources in Azure. You can work with this data by using the Azure Stack Hub administrator portal, Monitor PowerShell Cmdlets, Cross-Platform CLI, or Azure Monitor REST APIs.

## Prerequisites for Azure Monitor on Azure Stack Hub

Register the **Microsoft.insights** resource provider on your subscription's offer resource providers settings. You can verify that the resource provider is available in your offer associated with your subscription:

1.  Open the Azure Stack Hub user portal.
2.  Select the subscription you want to register.
3.  Select **Resource providers** under **Settings**.
4.  Find **Microsoft.Insights** in the list and verify that the status is **Registered**.
