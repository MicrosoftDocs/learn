Contoso's Microsoft Sentinel workspace is currently running on the Log Analytics default retention of 30 days for all tables. That means events older than a month are gone—no recovery, no query, no audit trail. PCI-DSS requires one year of in-scope system log retention. SOX requires seven years of financial control audit records. The gap between 30 days and seven years isn't a configuration oversight; it's a compliance liability. Closing it requires understanding how Microsoft Sentinel's data tiers work and applying them deliberately to the right tables.

## Compare Microsoft Sentinel data retention tiers

Microsoft Sentinel offers three storage tiers for Log Analytics tables. Each balances queryability, cost, and retention duration differently.

**Analytics tier** is the standard tier for all tables. Data in this tier is fully interactive—you can run any KQL query against it at any time. Interactive retention in the Analytics tier can be set from 30 days up to two years. The cost is higher per gigabyte than the other tiers, which makes it the right choice for tables you actively query during investigations and threat hunting.

**Basic tier** is designed for high-volume, low-value logs—think verbose diagnostic data or network flow records that you ingest for completeness but rarely query. Basic tier tables have eight days of interactive retention at a lower ingestion cost. The tradeoff is limited query capability: you can run queries, but only against a limited time window. Use the Basic tier for tables that serve compliance ingestion requirements but don't feed your daily detection and investigation workflows.

**Archive tier** extends the total retention period for any Analytics or Basic table beyond the interactive window, up to 12 years. Data in the Archive tier is stored at low cost, but it isn't directly queryable with KQL. To investigate archived data, you run a **restore job** that brings a copy of the archived data back into an interactive temporary table (with `_RST` suffix) for a defined time window. For smaller data sets, a **search job** provides full-text lookup against archived data without a full restore.

The distinction between *interactive retention* and *total retention* is important. Interactive retention is how long the data stays in the queryable Analytics or Basic tier. Total retention is how long the data exists at all—the sum of the interactive period plus the Archive period.

## Design a retention strategy for compliance requirements

Before touching any settings, map your compliance requirements to specific tables. Contoso's requirements break down as follows:

| Compliance requirement | Retention period | Applicable tables |
|---|---|---|
| PCI-DSS - in-scope system logs | One year interactive | `SecurityEvent`, `CommonSecurityLog`, `AzureActivity`, `TradingSystemEvents_CL` |
| SOX - financial control audit records | Seven years total | `OfficeActivity`, `CopilotActivity`, `AzureActivity`, `SigninLogs` |
| General security operations | 90 days interactive | All other Microsoft Sentinel tables |

For tables in multiple categories, apply the stricter requirement. `AzureActivity` appears in both lists—set it to one year interactive and seven years total to satisfy both.

For cost optimization, apply this rule: if your team doesn't query a table during active investigations, it's a candidate for the Basic tier or a short interactive period with Archive extension. For Contoso, the trading system's `TradingSystemEvents_CL` table is queried regularly in investigations, so it stays on the Analytics tier.

## Configure per-table retention in the Defender portal

Retention settings are managed per-table from the **Tables** page in the Microsoft Defender portal. To configure a table:

1. Navigate to **Microsoft Sentinel** > **Configuration** > **Tables**.
2. Find the table you want to configure—for example, `SecurityEvent`. Select the table row to open the details panel.
3. Select **Manage table**.
4. Under **Analytics tier**, set the **Interactive retention** value. For PCI-DSS compliance on `SecurityEvent`, enter `365` days.
5. Under **Total retention**, enter the total period. For the SOX-applicable tables, enter `2555` days (seven years).
6. Select **Save**.

:::image type="content" source="../media/manage-table-retention.png" alt-text="Screenshot of the Manage table settings dialog in the Microsoft Defender portal showing Analytics tier retention and total retention configuration for the SecurityEvent table.":::

Repeat this process for each table in your compliance scope. Changes take effect immediately and apply to new data going forward. Existing data that's already past the previous retention period can't be recovered—which is why establishing these settings at deployment time, rather than after the fact, is critical.

> [!NOTE]
> The workspace-level default retention setting (configurable in the Log Analytics workspace settings) applies to any table that doesn't have a per-table override. Set the workspace default to your most common retention requirement—for example, 90 days—and then apply per-table overrides only for tables that need longer or shorter periods. This approach minimizes per-table configuration without sacrificing compliance coverage for the tables that need it most.
