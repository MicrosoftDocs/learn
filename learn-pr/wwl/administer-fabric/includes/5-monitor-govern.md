The platform is live and users are active. Alex's job shifts from setup to ongoing health management. In this unit, you explore the tools that help Alex answer the question every admin eventually faces: "What's happening in my Fabric environment?" You learn how to monitor job failures, track usage trends, manage capacity consumption, audit user activities, and apply governance controls to keep the platform healthy and trusted.

## Monitor job activity with the monitoring hub

The **monitoring hub** is a centralized view of Fabric job execution health across the tenant. Any Fabric user can open it by selecting **Monitor** in the navigation pane, but they only see activities for items they have permission to view. As Fabric admin, Alex sees everything.

The monitoring hub shows the current run status of every Fabric job: running, succeeded, or failed. It also maintains a 30-day history of activity, giving Alex the context she needs to spot patterns. When something fails, she sees the timing, error details, and item location: everything she needs for faster troubleshooting.

Alex filters the hub by status, item type, start time, the user who submitted the job, and location (workspace). The hub also includes a schedule failures view (currently in preview), where she can view and manage failure notifications for scheduled items in one place.

The Finance team reports that their daily report refresh is failing. Alex opens the monitoring hub, filters by Status = Failed and Location = Finance workspace, and finds two failed Dataflow Gen2 refreshes. She sees the error details and contacts the Finance data lead with the specific information. The monitoring hub answers "what failed and when." It's a reactive, operational tool for spotting and diagnosing problems.

:::image type="content" source="../media/fabric-monitoring-hub.png" alt-text="Screenshot of the Fabric monitoring hub showing a list of jobs with Status, Item type, Start time, and Location columns.":::

## Track platform-wide usage

Beyond operational failures, Alex needs to understand how the platform is being used across Contoso. The **admin monitoring workspace** is a dedicated workspace in Fabric that tenant admins can access by default. It contains the **Feature Usage and Adoption** report and its underlying semantic model.

The report shows which Fabric features users are using across the organization, including lakehouses, notebooks, pipelines, and semantic models. Alex sees usage trends over time, identifies which users and departments are most active, and spots consumption patterns that reveal underused capacity or low adoption.

A month after go-live, she uses the Feature Usage and Adoption report to see that only IT and Finance are actively using Fabric. Marketing has low usage despite having licenses. She shares this insight with the Marketing lead to understand if there's a training gap or adoption barrier.

The admin monitoring workspace is a strategic tool for understanding adoption patterns, distinct from the monitoring hub, which shows individual job status for diagnosing failures.

## Manage capacity health

Now that Alex can spot operational problems and track usage patterns, she turns to the health of her F64 capacity. Consumption in Fabric is measured in **capacity units (CUs)**. The **Microsoft Fabric Capacity Metrics app** lets Alex visualize CU consumption across her capacity.

Alex watches for CU consumption trending toward the F64 limit. When consumption exceeds the capacity, Fabric throttles background jobs to protect the platform. She also tracks which workloads consume the most capacity, helping her decide when to scale up (increase the F SKU size to get more compute) versus scale out (move some workspaces to a separate capacity to distribute load).

At quarter-end, Finance runs heavy financial closing reports that push the F64 toward its limit. She sees this pattern in the Capacity Metrics app and proactively scales the capacity up to F128 for the week, then scales it back down afterward.

For non-production capacities, Alex can **pause** the capacity to save costs when it's not in use, which is useful for dev/test capacities overnight or over weekends. Pausing a capacity makes all content on that capacity unavailable, so Alex only pauses non-production capacities and communicates planned downtime to users first.

The following image shows the Capacity Metrics app Compute tab, where Alex monitors CU consumption over time and identifies which workspaces and item types use the most capacity.

:::image type="content" source="../media/fabric-capacity-metrics-app.png" alt-text="Screenshot of the Microsoft Fabric Capacity Metrics app Compute tab, showing CU consumption over time as a bar chart with a usage spike, and a breakdown of CU consumption by workspace and item type.":::

## Track user activities with audit logs

With capacity health under control, Alex turns to compliance. **Audit logs** record user activities across the Fabric tenant. Alex uses audit logs in the admin portal to track what operations users performed, when, and from where.

Audit logs capture who viewed or exported a report, who shared content externally, who modified workspace permissions, and who deleted a Fabric item. This gives Alex the evidence she needs to answer security and compliance questions.

Risk compliance asks Alex to confirm that no one exported sensitive Risk domain data to Excel last month. She searches the audit logs in the admin portal, filtering by activity type (Export to Excel) and user. She confirms no exports occurred from the Risk domain workspaces and provides the compliance team with the log evidence.

## Apply governance controls

With data assets growing across five departments, Alex needs to help users find trustworthy content. Two key tools support this: **endorsement** and the **OneLake catalog Govern tab**.

Endorsement marks Fabric items as trusted. Workspace members with Contributor or Admin role can mark their own quality items as **Promoted**. These items appear with a Promoted badge in the Fabric portal. **Certified** items go further: they require a formal review by an authorized certifier and appear with a Certified badge. Alex controls who can certify items via the **Certification** tenant setting in the admin portal.

Finance's data lead certifies the five core Finance semantic models as authoritative data sources. Now, when Marketing needs Finance data for a campaign analysis, they filter the OneLake catalog by Finance domain and see which semantic models are certified. They know those are safe to use.

As Fabric admin, Alex opens the **OneLake catalog Govern tab** to see a governance snapshot of the entire tenant. Key insights include sensitivity label coverage (what percentage of items have sensitivity labels applied), endorsement coverage (how many items are promoted or certified versus unendorsed), and recommended actions that show where to focus governance improvement efforts.

The Govern tab shows Alex that Finance workspaces have only 30% sensitivity label coverage. She delegates this as an action item to the Finance domain admin, who works with the data team to label the remaining items.
