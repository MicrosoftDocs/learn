Before you can explore the end-to-end capabilities of Microsoft Fabric, it must be enabled for your organization. You might need to work with your IT department to enable Fabric for your organization, including one of the following roles:

- _Fabric admin (formerly Power BI admin)_: Manages Fabric settings and configurations.
- _Power Platform admin_: Oversees Power Platform services, including Fabric.
- _Microsoft 365 admin_: Manages organization-wide Microsoft services, including Fabric.

## Enable Microsoft Fabric

Admins can enable Fabric in the **Admin portal > Tenant settings** in the Power BI service. Fabric can be enabled for the entire organization or for specific Microsoft 365 or Microsoft Entra security groups. Admins can also delegate this ability to other users at the capacity level.

:::image type="content" border="true" source="../media/enable-fabric.png" alt-text="Screenshot of the Fabric admin portal where you can enable Fabric items.":::

> [!NOTE]
> If your organization isn't using Fabric or Power BI today, you can sign up for a [free Fabric trial](/fabric/get-started/fabric-trial) to explore its features.

## Create workspaces

Workspaces are collaborative environments where you can create and manage items like lakehouses, warehouses, and reports. All data is stored in OneLake and accessed through workspaces. Workspaces also support data lineage view, providing a visual view of data flow and dependencies to enhance transparency and decision-making.

In _Workspace settings_, you can configure:

- License type to use Fabric features.
- OneDrive access for the workspace.
- Azure Data Lake Gen2 Storage connection.
- Git integration for version control.
- Spark workload settings for performance optimization.

You can manage workspace access through four roles: _admin_, _contributor_, _member_, and _viewer_. These roles apply to all items in a workspace and should be reserved for collaboration. For more granular access control, use item-level permissions based on business needs.

> [!NOTE]
> Learn more about workspaces in the [Fabric documentation](/fabric/get-started/workspaces).

## Discover data with OneLake catalog

The OneLake catalog in Microsoft Fabric helps users easily find and access various data sources within their organization. Users explore and connect to data sources, ensuring they have the right data for their needs. Users only see items shared with them. Here are some considerations when using OneLake Hub:

- Narrow results by workspaces or domains (if implemented).
- Explore default categories to quickly locate relevant data.
- Filter by keyword or item type.

:::image type="content" source="../media/onelake-catalog.png" alt-text="Screenshot of the OneLake catalog." lightbox="../media/onelake-data-hub.png":::

## Create items with Fabric workloads

After you create your Fabric enabled workspace, you can start creating items in Fabric. Each workload in Fabric offers different item types for storing, processing, and analyzing data. Fabric workloads include:

- **Data Engineering**: Create lakehouses and operationalize workflows to build, transform, and share your data estate.
- **Data Factory**: Ingest, transform, and orchestrate data.
- **Data Science**: Detect trends, identify outliers, and predict values using machine learning.
- **Data Warehouse**: Combine multiple sources in a traditional warehouse for analytics.
- **Databases**: Create and manage databases with tools to insert, query, and extract data.
- **Industry Solutions**: Use out-of-the-box industry data solutions.
- **Real-Time Intelligence**: Process, monitor, and analyze streaming data.
- **Power BI**: Create reports and dashboards to make data-driven decisions.

Fabric integrates capabilities from existing Microsoft tools like Power BI, Azure Synapse Analytics, and Azure Data Factory into a unified platform. Fabric also supports a data mesh architecture, allowing decentralized data ownership while maintaining centralized governance. This eliminates the need for direct Azure resource access, simplifying data workflows.
