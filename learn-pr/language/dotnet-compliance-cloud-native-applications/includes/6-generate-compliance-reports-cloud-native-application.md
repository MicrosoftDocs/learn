Compliance departments need to be able to review code and compliance reports to ensure that the application is compliant with the company's policies. The .NET compliance framework provides a way to generate reports that show the compliance status of the application.

## What is a compliance report?

A compliance report can be generated at compile time. The .NET compliance framework generates a JSON file that contains details on the data classifications and redaction methods used in the application.

```json
{
    "Name": "DataEntities",
    "Types": [
        {
            "Name": "DataEntities.Order",
            "Members": [
                {
                    "Name": "CustomerAddress",
                    "Type": "string",
                    "File": "C:\\Developer\\mslearn-dotnet-cloudnative\\dotnet-compliance\\eShopLite\\DataEntities\\Order.cs",
                    "Line": "25",
                    "Classifications": [
                        {
                            "Name": "EUIIData"
                        }
                    ]
                },
                {
                    "Name": "CustomerName",
                    "Type": "string",
                    "File": "C:\\Developer\\mslearn-dotnet-cloudnative\\dotnet-compliance\\eShopLite\\DataEntities\\Order.cs",
                    "Line": "21",
                    "Classifications": [
                        {
                            "Name": "EUIIData"
                        }
                    ]
                },
    ...
```

The report above is an example from the **:::no-loc text="eShopLite.DataEntities":::** project. It shows that the **:::no-loc text="Order":::** class has two properties that are classified as **:::no-loc text="EUIIData":::**.

```json
{
    "Name": "Store",
    "Types": [
        {
            "Name": "Store.Services.Log",
            "Logging Methods": [
                {
                    "Name": "LogOrders",
                    "Parameters": [
                        {
                            "Name": "logger",
                            "Type": "Microsoft.Extensions.Logging.ILogger",
                            "File": "C:\\Developer\\mslearn-dotnet-cloudnative\\dotnet-compliance\\eShopLite\\Store\\Services\\ProductService.cs",
                            "Line": "103"
                        },
                        {
                            "Name": "order",
                            "Type": "DataEntities.Order",
                            "File": "C:\\Developer\\mslearn-dotnet-cloudnative\\dotnet-compliance\\eShopLite\\Store\\Services\\ProductService.cs",
                            "Line": "103"
                        }
                    ]
                }
            ]
        }
    ]
}
```

The report above is an example from the **:::no-loc text="eShopLite.Store":::** project. It shows that the **:::no-loc text="LogOrders":::** method in the **:::no-loc text="ProductService":::** class takes an **:::no-loc text="Order":::** object as a parameter for logging.

## How to generate a compliance report

There are two steps that you need to take for each project you'd like to generate a report for:

1. Add the `Microsoft.Extensions.AuditReports` NuGet package to each project.
1. Add two entries into the `PropertyGroup` section of the **csproj** project file:

    ```xml
    <GenerateComplianceReport>true</GenerateComplianceReport>
    <ComplianceReportOutputPath>$(MSBuildThisFileDirectory)\path to folder location</ComplianceReportOutputPath>
    ```

    The first switches the compliance report generation on. The second specifies the path to the folder where the report will be generated. The file name is **ComplianceReport.json**.

With these updates, running `dotnet build` in the solution folder generates a compliance report for each project that has the `GenerateComplianceReport` property set to `true`.
