You've investigated the metrics that your video Storage account sends to Azure Monitor and you know that you want to display some of these metrics in the mobile app that your administrators use to monitor the behvior of your video management system.

The app is a .NET application. Now you need to know how to use the Azure Monitor .NET API to get the metrics and Azure Monitor.

## Overview of the Azure Monitor .NET SDK

The Azure Monitor SDK is a set of .NET classes and interfaces that make it simple to query for metrics in Azure Monitor from any .NET project. You can add this SDK to a project, by using the NuGet package manager, to desktop applications, mobile apps, web apps, and other types of custom project. The SDK enables your code to obtain metrics and their values from Azure. You could, for example, display in a mobile app how some of those metrics vary over time or respond if a metric exceeded some critical value.

> [!NOTE] If you want to view metrics from a Storage account, you must use the SDK version 0.18.0-preview or later.

## Security Requirements

Azure carefully controls access to metrics by authenticating users and authorizing them to access different resources. In unit 3, when you used **curl** to request Storage metrics from Azure Monitor, you used the **az** utility to authenticate as the user you were logged into the Azure portal with. The result of this authentication was an access token, which you passed with your **curl** request the the Azure Monitor REST API.

For an application that uses the an Azure .NET API to call Azure services, you can create a service principal in your Azure Active Directory. This service principal includes credentials that the app can supply to prove its identity before it makes a request.

You must also assign a role to the service principal, which authorizes that app to access a resource. For example, if you assign the **Contributor** role to an app for a resource group, that app can read and write data to all the resources in that group, including Azure Monitor.

## How to create a service principal

To create a service principal in Azure:

1. Use the Azure Active Directory to create a new **Application Registration**.
1. Give the service principal a name and specify a sign-on URL where users go for authentication.
1. Use the type **Web App/API** for the service principal.
1. Create a new key for the app and make a note of it. The app must supply this key as part of its credentials.
1. Make a note of the **Directory ID**. This is a GUID that uniquely identifies the Active Directory that contains the service principal and is also referred to as the **Tenant ID**.
1. Assign the new service principal to a role that has sufficient permissions to access the resources you need. For example, the **Contributor** role on a resource group grants access to all the resources in that group, including any Azure Monitor resources.

You will complete these steps in unit 5.

## How to authenticate the application

When the service principal is ready, you can use it in your code to authenticate with Azure. To do this, your code must:

1. Use the **ApplicationTokenProvider.LoginSilentAsync** method to create a new set of service credentials. When you call this method, provide the tenant ID, application ID, and key that you made a note of when you created the service principal.
1. Create a new **MonitorClient** object by calling the **MonitorClient** constructor with the service credentials you just created. This **MonitorClient** object will be used to submit queries for metrics.
1. Set the **MonitorClient.SubscriptionID** property to identify which Azure subscription to connect to. This is the same Subscription ID that you used in unit 3.

## How to list metric definitions and metrics values

Once you have created the **MonitorClient** class, you can use it to query for Azure Storage metrics in Azure Monitor. The first stage is to find out what metrics are available by listing their definitions.

Do this by calling the **MetricDefinitions.ListAsync** method on your **MonitorClient** object and passing the storage account service's resource ID. This resource ID is the same value as you used in unit 3 to specify the metrics you wanted to list.

>[!NOTE] The resource ID that you specify in step two must be that of the service within the Storage account. There are different resource IDs for the blob service, the tables service, the queues service, and the files service within the same Storage account.

Once you know the name of a metric that interests you, obtain its values by calling the **Metrics.ListAsync** method and passing the metric's name and the time period of interest. This will return all of the values of that metric within that period. You can loop through this collection of values and display them to the user or take other action.