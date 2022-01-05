There are several common provisioning issues that you should be aware of when you create an HDInsight cluster. Some errors are transient and may succeed if you retry the creation after 15 minutes. 

## Azure Policy and Firewall configuration

The most common provisioning issue is Azure Policy restrictions that prevent the creation of a cluster. In general, the following policies can impact cluster creation:

- Policies preventing creation of an IP address & load balancers within the subscription.
- Policies preventing creation of storage account.

Furthermore, firewall configurations of either your network or Azure services such as Azure Blob storage may deny communication with HDInsight management IP addresses.

All clusters must allow traffic from the IP addresses in the table below:

|Source IP address| Destination| Direction|
|-|-|
|168.61.49.99| *:443| Inbound|
|23.99.5.239| *:443| Inbound|
|168.61.48.131| *:443| Inbound|
|138.91.141.162| *:443| Inbound|

## Storage account permission

If you are using Azure Data Lake Storage Gen2, and receive the error “AmbariClusterCreationFailedErrorCode, Internal server error occurred while processing the request. Please retry the request or contact support.”, open the Azure portal, go to your Storage account, and under Access Control (IAM), ensure that the Storage Blob Data Contributor or the Storage Blob Data Owner role has Assigned access to the User assigned managed identity for the subscription.

## Storage account name restrictions

Storage account names cannot be more than 24 characters and cannot contain a special character. These restrictions also apply to the default container name in the storage account. You will be notified of this should HDInsight provision a storage though the portal. This error typically occurs if you are using an existing storage account.

## Conflict (HTTP Status Code: 409)

If you receive HTTP status code 409, you deleted a cluster and are attempting to recreate it with the same name before the operation completed. Just wait 30-60 minutes before recreating a cluster with the same name.

## Other issues

On rare occasions, you may face the following issues:

- Resources locks - Ensure that there are no locks on your virtual network and resource group.
- Unsupported component versions - Ensure that you are using a supported version of Azure HDInsight and any Apache Hadoop components in your solution.
- Azure outage - Check Azure status for any potential outages or service issue
