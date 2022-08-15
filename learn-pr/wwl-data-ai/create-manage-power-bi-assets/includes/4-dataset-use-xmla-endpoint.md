If you've used Microsoft Analysis Services, you may be familiar with XMLA endpoint. However, it sounds intimidating to many others even though it's straightforward. In short, the XMLA endpoint is another way for you to connect to Power BI workspaces and datasets from external applications - just an API with a URL to the workspace or dataset.

## XMLA endpoint settings

By default, endpoint connectivity is *read-only* for **datasets workload**. This setting allows data visualization tools access to the following dataset details:

* Model data
* Metadata
* Events
* Schema

Some data visualization tools include Microsoft Excel, Power BI Report Builder, Tabular Editor, or ALM Toolkit. You can get the workspace connection URL in workspace settings. Go to **Settings** > **Premium** > **Workspace Connection**, select **Copy**.

*Read-write* connectivity can be enabled to provide more operations, including:

* Management
* Governance
* Advanced semantic modeling
* Debugging
* Monitoring

With read-write enabled, datasets have more parity with Azure Analysis Services and SQL Server Analysis Services enterprise grade tabular modeling tools and processes.

> [!IMPORTANT]
> In order to use XMLA endpoint for read-write operations, the dataset must reside in a Premium or Premium Per User (PPU) workspace.

Some common uses of the XMLA endpoint in Power BI are:

- Refreshing individual components of a data model.
- Systematically exporting data from the data model.
- Automating the use of the Best Practice Analyzer.

## Enable read-write connectivity

To set XMLA endpoint connectivity setting for all workspaces and datasets assigned to a **Premium capacity**:

* Navigate to Settings > **Admin portal**.
* In the Admin portal, select **Capacity settings** > **Power BI Premium** > *capacity name*.
* Expand Workloads. In the **XMLA Endpoint** setting, select **Read Write**.

To enable read-write for **Premium Per User** workspaces:

* Select Settings > **Admin portal**.
* In the Admin portal, select **Premium Per User**.
* Expand Dataset workload settings. In the **XMLA Endpoint** setting, select **Read Write**.

> [!NOTE]
> For full functionality and limitations, reference the [Dataset connectivity with the XMLA endpoint](/power-bi/enterprise/service-premium-connect-tools) article.
