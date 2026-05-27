Every data source that connects to Microsoft Sentinel lands its events in a Log Analytics table. Built-in connectors write to well-known tables like `SecurityEvent`, `CommonSecurityLog`, and `AzureActivity` - tables with fixed schemas that the Microsoft Sentinel analytics rules and workbooks already know how to query. But Contoso's proprietary trading risk management system generates security-relevant events in a custom JSON format that doesn't match any built-in table. Without a custom table, those events have nowhere to land.

## Identify when a custom table is needed

A custom log table is the right choice when your data source meets any of these conditions:

- The data format doesn't match any existing built-in table schema.
- You want to store data from an application that sends logs via the Logs Ingestion API rather than a standard connector.
- The data is high-volume and noncritical, making it a candidate for the Auxiliary table plan at a lower ingestion cost.
- You need to define a custom schema to make the data queryable in a structured way.

Before creating a custom table, verify there isn't an existing connector that handles your data source—many purpose-built connectors in the Content Hub write to `_CL` tables with parsers and workbooks already included.

When you do need a custom table, you have two table plan options. The **Analytics plan** supports full interactive KQL queries with standard retention—use this for security-relevant data that analysts will actively query. The **Auxiliary plan** offers lower ingestion cost with limited query capability and short retention—use this for high-volume compliance or usage data that you ingest for archival but rarely query directly.

## Create and define a custom table schema

To create a custom table in the Microsoft Defender portal:

1. Navigate to **Microsoft Sentinel** > **Configuration** > **Tables**.
2. Select **+ New custom table**.
3. Enter a table name. Microsoft Sentinel automatically appends the `_CL` suffix to custom log tables. For Contoso's trading system, enter `TradingSystemEvents` - the table appears as `TradingSystemEvents_CL` in all queries and schema views.
4. Select the table plan: **Analytics** for a table that analysts query in investigations, or **Auxiliary** for high-volume, low-query data.
5. Define the schema by adding columns. For each column, specify a name and data type. Common data types include `string` for identifiers and messages, `datetime` for timestamps, `int` for numeric codes, and `dynamic` for nested JSON objects. Add at minimum a `TimeGenerated` column of type `datetime` - this column is required by all Log Analytics tables and drives time-range filtering in queries.

   For the Contoso trading risk system, the schema includes:

   | Column name | Type | Description |
   |---|---|---|
   | `TimeGenerated` | datetime | Event timestamp (UTC) |
   | `TradeId` | string | Unique trade identifier |
   | `RiskScore` | int | Calculated risk score (0–100) |
   | `AlertType` | string | Risk alert category |
   | `UserId` | string | Trader who initiated the action |
   | `SourceSystem` | string | Originating platform identifier |

6. Select **Create**.

## Configure a data collection rule for ingestion

Creating the table establishes the schema and target. Sending data to it requires a **Data Collection Rule (DCR)** and a **Data Collection Endpoint (DCE)**. The DCE provides the network endpoint that applications call, and the DCR defines the transformation and routing from the source data stream to the target table.

To configure ingestion:

1. In the Azure portal, navigate to **Monitor** > **Data Collection Endpoints** and create a new endpoint in the same region as your workspace. Note the **Logs Ingestion URI** shown on the endpoint's Overview page—your source application uses this URI to POST events.

2. Navigate to **Monitor** > **Data Collection Rules** and select **Create**. On the **Basics** tab, enter a rule name and select the same subscription and resource group as your workspace.

3. On the **Data sources** tab, select **+ Add data source**. Set the **Data source type** to **Custom logs (JSON format)**. Under **Destination**, select your Log Analytics workspace and the `TradingSystemEvents_CL` table.

4. If your source data format differs from the target table schema, add a **Transformation** using KQL. For example, to rename an incoming field `risk_score` to the table column `RiskScore`:

   ```kql
   source | extend RiskScore = toint(risk_score) | project-away risk_score
   ```

5. Select **Review + create**, then **Create**.

To validate ingestion, have your source application send a test event to the DCE's Logs Ingestion URI with the correct authorization header. After one to two minutes, run the following KQL query in the Defender portal to confirm the event arrived:

```kql
TradingSystemEvents_CL
| take 10
```

If the query returns results, the table and ingestion pipeline are working. If no results appear after five minutes, verify that the DCR is correctly associated with the DCE and that the application is sending to the correct URI.
