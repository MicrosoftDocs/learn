The term provider applies to the service administrator and to any delegated providers. Azure Stack Hub operators and delegated providers can use the provider usage Application Programming Interface (API) to view the usage of their direct tenants. For example, as shown in the following diagram, P0 can call the provider API to get direct usage information on P1 and P2, and P1 can call for usage information on P3 and P4.

:::image type="content" source="../media/usage-branch-nodes-707bac96.png" alt-text="Diagram showing normalized relational tables.":::


## Application Programming Interface (API) call reference

### Request

The request gets consumption details for the requested subscriptions and for the requested time frame. There's no request body.

This usage Application Programming Interface is a provider Application Programming Interface, so the caller must be assigned an **Owner, Contributor**, or **Reader** role in the provider's subscription.

**Method: GET**

```powershell
https://{armendpoint}/subscriptions/{subId}/providers/Microsoft.Commerce.Admin/subscriberUsageAggregates?reportedStartTime={reportedStartTime}&reportedEndTime={reportedEndTime}&aggregationGranularity={granularity}&subscriberId={sub1.1}&api-version=2015-06-01-preview&continuationToken={token-value}
```

### Arguments

| **Argument**             | **Description**                                                                                                                                                                                                                                                                                      |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `armendpoint`            | Azure Resource Manager endpoint of your Azure Stack Hub environment. The Azure Stack Hub convention is that the name of the Azure Resource Manager endpoint is in the format `https://adminmanagement.{domain-name}`.                                                                                |
| `subId`                  | Subscription ID of the user who makes the call.                                                                                                                                                                                                                                                      |
| `reportedStartTime`      | Start time of the query. The value for `DateTime` should be in Coordinated Universal Time (UTC) and at the beginning of the hour; for example, 13:00. For daily aggregation, set this value to UTC midnight.                                                                                         |
| `reportedEndTime`        | End time of the query. The constraints that apply to `reportedStartTime` also apply to this argument. The value for `reportedEndTime` can't be either in the future, or the current date. If it is, the result is set to "processing not complete."                                                  |
| `aggregationGranularity` | Optional parameter that has two discrete potential values: `daily` and `hourly`. As the values suggest, one returns the data in daily granularity, and the other is an hourly resolution.                                                                                                            |
| `subscriberId`           | Subscription ID. To get filtered data, the subscription ID of a direct tenant of the provider is required. If no subscription ID parameter is specified, the call returns usage data for all the provider's direct tenants.                                                                          |
| `api-version`            | Version of the protocol that's used to make this request. This value is set to `2015-06-01-preview`.                                                                                                                                                                                                 |
| `continuationToken`      | Token retrieved from the last call to the usage API provider. This token is needed when a response is greater than 1,000 lines. It acts as a bookmark for the progress. If the token isn't present, the data is retrieved from the beginning of the day or hour, based on the granularity passed in. |

### Response

```powershell
GET
```

```powershell
/subscriptions/sub1/providers/Microsoft.Commerce.Admin/subscriberUsageAggregates?reportedStartTime=reportedStartTime=2014-05-01T00%3a00%3a00%2b00%3a00&reportedEndTime=2015-06-01T00%3a00%3a00%2b00%3a00&aggregationGranularity=Daily&subscriberId=sub1.1&api-version=1.0
```

| **Argument**     | **Description**                                                                                                                                                                                                                                                                                                                                                                      |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `id`             | Unique ID of the usage aggregate.                                                                                                                                                                                                                                                                                                                                                    |
| `name`           | Name of the usage aggregate.                                                                                                                                                                                                                                                                                                                                                         |
| `type`           | Resource definition.                                                                                                                                                                                                                                                                                                                                                                 |
| `subscriptionId` | Subscription identifier of the Azure Stack Hub user.                                                                                                                                                                                                                                                                                                                                 |
| `usageStartTime` | UTC start time of the usage bucket to which this usage aggregate belongs.                                                                                                                                                                                                                                                                                                            |
| `usageEndTime`   | UTC end time of the usage bucket to which this usage aggregate belongs.                                                                                                                                                                                                                                                                                                              |
| `instanceData`   | Key-value pairs of instance details (in a new format): `resourceUri`: Fully qualified resource ID, which includes the resource groups and the instance name. `location`: Region in which this service was run. `tags`: Resource tags that are specified by the user. `additionalInfo`: More details about the resource that was consumed; for example, the OS version or image type. |
| `quantity`       | Amount of resource consumption that occurred in this time frame.                                                                                                                                                                                                                                                                                                                     |
| `meterId`        | Unique ID for the resource that was consumed (also called`ResourceID`).                                                                                                                                                                                                                                                                                                              |

## Retrieve usage information

### PowerShell

To generate the usage data, you should have resources that are running and actively using the system. For example, an active virtual machine, or a storage account containing data.

Use the following PowerShell cmdlets to view the usage data:

1.  [Install PowerShell for Azure Stack Hub](https://docs.microsoft.com/azure-stack/operator/powershell-install-az-module?&amp;preserve-view=true).
2.  Configure the Azure Stack Hub user or the Azure Stack Hub operator PowerShell environment.
3.  To retrieve the usage data, call the **Get-AzsSubscriberUsage** PowerShell cmdlet:

```powershell
Get-AzsSubscriberUsage -ReportedStartTime
```
