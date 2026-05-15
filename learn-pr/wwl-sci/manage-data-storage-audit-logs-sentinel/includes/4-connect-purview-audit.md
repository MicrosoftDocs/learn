Contoso's SOC received a request from the compliance team: investigate whether a SharePoint document containing trading strategy data was accessed by an unauthorized account three months ago. The event isn't in any firewall log or endpoint alert. It happened entirely within Microsoft 365—a platform Microsoft Sentinel doesn't monitor by default unless you configure it to. Microsoft Purview Audit captures exactly this type of user activity across the Microsoft 365 service boundary, and connecting it to Microsoft Sentinel brings those records into the same workspace where analysts are already working incidents.

## Understand what Microsoft Purview Audit captures

Microsoft Purview Audit records user and administrator activity across Microsoft 365 services. The scope is broad: Exchange Online email actions, SharePoint document operations, Teams messages and channel activity, Microsoft Entra sign-in and directory changes, Power BI report access, and Dynamics 365 entity operations. Each event records the operation type, the user who performed it, the target object, the client IP address, and the timestamp.

E5 licensing unlocks **Audit Premium**, which provides longer retention within Purview, faster log availability, and other event types compared to the **Audit Standard** tier available with E3.

Two Microsoft 365 Audit tables are especially relevant to Microsoft Sentinel investigations:

- **`OfficeActivity`**: The primary audit table. Captures Exchange, SharePoint, Teams, Microsoft Entra, and most other Microsoft 365 service activities.
- **`CopilotActivity`**: Captures activity from Microsoft 365 Copilot—including prompts submitted, responses returned, and files accessed in Teams, Word, SharePoint, and other Microsoft 365 applications where Copilot is active. [REVIEW: Confirm `CopilotActivity` is a distinct table in Microsoft Sentinel as of mid-2026 and not a subset of `OfficeActivity`.]

The `CopilotActivity` table represents an important and growing compliance surface. For Contoso, SOX requires audit evidence that access to financial systems and data is controlled and monitored. Microsoft 365 Copilot's ability to reason across SharePoint content and summarize documents means it can access sensitive financial data—and those accesses need to be in your audit trail. Connecting the Purview Audit data connector to Microsoft Sentinel brings both `OfficeActivity` and `CopilotActivity` into scope for KQL-based investigation and incident correlation.

> [!NOTE]
> Purview Audit events are typically available in Microsoft Sentinel within 30 minutes of the activity occurring. For time-critical investigations, be aware of this lag when querying recent events.

## Prepare the prerequisites for integration

Before configuring the connector, verify these prerequisites are met:

1. **Unified audit logging is enabled** in your Microsoft 365 tenant. In the Microsoft Purview portal, navigate to **Audit** and check that the banner says "Recording user and admin activity." If it shows "Start recording," select it to enable. You can also verify via PowerShell in Exchange Online:

   ```powershell
   Get-AdminAuditLogConfig | Select-Object UnifiedAuditLogIngestionEnabled
   ```

   The output should show `True`. If it shows `False`, contact your Microsoft Purview admin to enable it.

2. **Licensing**: The tenant must have at least Microsoft 365 E3 for Audit Standard coverage. For `CopilotActivity` events, verify that Microsoft 365 Copilot licenses are assigned to users whose activity you want to audit.

3. **Permissions**: Three roles are needed across the integration:
   - **Microsoft Sentinel Contributor** (or higher) in Azure—required to configure the data connector in the Defender portal.
   - **Global Administrator** or **Security Administrator** in Microsoft 365—required to authorize the connector to access the tenant's audit logs.
   - **View-Only Audit Logs** in Microsoft 365 (assigned via the Microsoft Purview portal or Exchange admin center)—required for analysts who will query the `OfficeActivity` or `CopilotActivity` tables after ingestion.

## Configure the connector and validate ingestion

To connect Purview Audit to Microsoft Sentinel:

1. In the Microsoft Defender portal, navigate to **Microsoft Sentinel** > **Configuration** > **Data connectors**.
2. Search for the audit connector. [REVIEW: Confirm the exact connector name as of mid-2026—it can be listed as **Microsoft 365**, **Office 365**, or a dedicated **Microsoft Purview Audit** connector depending on the Defender portal version at your organization's tenant.]
3. Select the connector and choose **Open connector page**.
4. On the connector page, review the prerequisites section to confirm all conditions are met. Then select the log categories you want to ingest. At minimum, enable:
   - **Exchange**
   - **SharePoint**
   - **Microsoft Teams**
5. Select **Apply changes** (or **Save**, depending on the portal version). The connector authenticates to your Microsoft 365 tenant using delegated permissions established during the initial Microsoft Sentinel onboarding.

To validate ingestion, wait 30 to 60 minutes after enabling the connector, then run the following query in the Defender portal's **Advanced Hunting** or in **Logs**:

```kql
OfficeActivity
| where TimeGenerated > ago(1h)
| summarize count() by RecordType, Operation
| order by count_ desc
```

If results appear, the connector is ingesting data. To verify `CopilotActivity` ingestion, run:

```kql
CopilotActivity
| where TimeGenerated > ago(24h)
| take 10
```

If no results appear in `CopilotActivity` but `OfficeActivity` is populated, confirm that Microsoft 365 Copilot is licensed and active in the tenant, and that the connector configuration includes the Copilot or AI activity log category if listed as a separate option.
