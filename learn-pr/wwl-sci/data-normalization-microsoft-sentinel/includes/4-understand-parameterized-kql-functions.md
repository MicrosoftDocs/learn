When calling KQL functions, you can provide a set of parameters.  This is an important concept for building ASIM parsers as it allows you to filter the function results with dynamic values before returning results.



First, navigate to Logs in the Microsoft Sentinel workspace.

The following sample function returns all events in the Azure Activity log since a particular date and that match a particular category.

Start with the following query using hardcoded values. This verifies that the query works as expected.

```KQL
AzureActivity
| where CategoryValue == "Administrative"
| where TimeGenerated > todatetime("2021/04/05 5:40:01.032 PM")
```

Next, replace the hardcoded values with parameter names and then save the function by selecting Save and then Save as function.

```KQL
AzureActivity
| where CategoryValue == CategoryParam
| where TimeGenerated > DateParam
```

Enter Function name as AzureActivityByCategory
Then create two parameters:

| Type | Name| Default value|
| :--- | :--- | :--- |
|string|CategoryParam|"Administrative"|
|datetime|DateParam||



Your screen should look like the image below:


:::image type="content" source="../media/example-function-properties.png#lightbox" alt-text="Screenshot of K Q L Function properties.":::

Create a new query. Then enter:

```KQL
AzureActivityByCategory("Administrative", todatetime("2021/04/05 5:40:01.032 PM")) 
```


:::image type="content" source="../media/example-use-function.png#lightbox" alt-text="Screenshot of the K Q L calling Function.":::



















