Another way of normalizing log data is transforming the data at ingestion time. This provides the benefit of storing the data in a parsed format for use in Microsoft Sentinel.


## Data collection rules in Azure Monitor

Data Collection Rules (DCRs) provide an ETL-like pipeline in Azure Monitor, allowing you to define the way that data coming into Azure Monitor should be handled. Depending on the type of workflow, DCRs may specify where data should be sent and may filter or transform data before storing it in Azure Monitor Logs. Some data collection rules are created by Azure Monitor, while you may create others to customize data collection for your particular requirements. 

## Types of data collection rules
Azure Monitor supports several types of data collection rules. Common types include:

- **Standard DCR**. Used with different workflows that send data to Azure Monitor, including the Azure Monitor agent and custom logs ingestion.

- **Workspace transformation DCR**. Used with a Log Analytics workspace to apply ingestion-time transformations to workflows that don't currently support DCRs directly.

> [!NOTE]
> For the current complete list of DCR types and supported workflows, see [Data collection rules in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/essentials/data-collection-rule-overview).


## Transformations
Transformations in a data collection rule (DCR) allow you to filter or modify incoming data before storing it in a Log Analytics workspace. Data transformations are defined using a Kusto Query Language (KQL) statement that is applied individually to each entry in the data source. It must understand the format of the incoming data and create output in the structure of the target table.

### Transformation structure
The input stream is represented by a virtual table named **source** with columns matching the input data stream definition. Following is a typical example of a transformation. This example includes the following functionality:

- Filters the incoming data with a where statement
- Adds a new column using the extend operator
- Formats the output to match the columns of the target table using the project operator

```KQL
source  
| where severity == "Critical" 
| extend Properties = parse_json(properties)
| project
    TimeGenerated = todatetime(["time"]),
    Category = category,
    StatusDescription = StatusDescription,
    EventName = name,
    EventId = tostring(Properties.EventId)
```