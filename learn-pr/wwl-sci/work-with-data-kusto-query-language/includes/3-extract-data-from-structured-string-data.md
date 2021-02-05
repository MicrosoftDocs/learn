Strings fields may also contain structured data like JSON or Key-Value pairs.  KQL provides easy access to these values for further analysis.

## Dynamic Fields

Within a Log Analytics table, there a field types defined as Dynamic.  Dynamic fields contain a key-value pair such as:

```
{"eventCategory":"Autoscale","eventName":"GetOperationStatusResult","operationId":"xxxxxxxx-6a53-4aed-bab4-575642a10226","eventProperties":"{\"OldInstancesCount\":6,\"NewInstancesCount\":5}","eventDataId":" xxxxxxxx -efe3-43c2-8c86-cd84f70039d3","eventSubmissionTimestamp":"2020-11-30T04:06:17.0503722Z","resource":"ch-appfevmss-pri","resourceGroup":"CH-RETAILRG-PRI","resourceProviderValue":"MICROSOFT.COMPUTE","subscriptionId":" xxxxxxxx -7fde-4caf-8629-41dc15e3b352","activityStatusValue":"Succeeded"}
```

To access the strings within a Dynamic field, use the dot notation.  The Properties_d field from the AzureActivity table is of type dynamic. In this example, you could access the eventCategory with the Properties_d.eventCategory field name.

```kusto
AzureActivity
| project Properties_d.eventCategory

```

The following example shows the use of Dynamic fields with the SigninLogs table.

```kusto
// Example query for SigninLogs showing how to break out packed fields.

SigninLogs 
| where TimeGenerated >= ago(1d)
| extend OS = DeviceDetail.operatingSystem, Browser = DeviceDetail.browser
| extend ConditionalAccessPol0Name = tostring(ConditionalAccessPolicies[0].displayName), ConditionalAccessPol0Result = tostring(ConditionalAccessPolicies[0].result)
| extend ConditionalAccessPol1Name = tostring(ConditionalAccessPolicies[1].displayName), ConditionalAccessPol1Result = tostring(ConditionalAccessPolicies[1].result)
| extend ConditionalAccessPol2Name = tostring(ConditionalAccessPolicies[2].displayName), ConditionalAccessPol2Result = tostring(ConditionalAccessPolicies[2].result)
| extend StatusCode = tostring(Status.errorCode), StatusDetails = tostring(Status.additionalDetails)
| extend State = tostring(LocationDetails.state), City = tostring(LocationDetails.city)
| extend Date = startofday(TimeGenerated), Hour = datetime_part("Hour", TimeGenerated)
| summarize count() by Date, Identity, UserDisplayName, UserPrincipalName, IPAddress, ResultType, ResultDescription, StatusCode, StatusDetails, ConditionalAccessPol0Name, ConditionalAccessPol0Result, ConditionalAccessPol1Name, ConditionalAccessPol1Result, ConditionalAccessPol2Name, ConditionalAccessPol2Result, Location, State, City
| sort by Date

```

## JSON

KQL provides functions to manipulate JSON stored in string fields. Many logs submit data in JSON format, which requires you to know how to transform JSON data to queryable fields.

The following is a list of JSON related functions.

| **Function**| **Description**|
| :--- | :--- |
| parse_json()

or

todynamic()| Interprets a string as a JSON value and returns the value as dynamic.

Use either of these to refer to a field:

- JsonField.Key

- JsonField["Key"]|
| mv_expand()| is applied on a dynamic-typed array or property bag column so that each value in the collection gets a separate row. All the other columns in an expanded row are duplicated.

mv_expand is the easiest way to process JSON arrays.|
| mv_apply()| Applies a subquery to each record and returns the union of the results of all subqueries.

Apply a query to each value in an array.|

Run each query separately to see the results.

```kusto
SecurityAlert
| extend ExtendedProperties = todynamic(ExtendedProperties) 
| extend ActionTaken = ExtendedProperties.ActionTaken
| extend AttackerIP = ExtendedProperties["Attacker IP"]

SecurityAlert
| mv-expand entity = todynamic(Entities)

SecurityAlert
| mv-apply entity = todynamic(Entities) on 
( where entity.Type == "account" | extend account = strcat (entity.NTDomain, "\\", entity.Name))

```

