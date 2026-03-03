Scalable analytics can be complex, fragmented, and expensive. Microsoft Fabric simplifies analytics solutions by providing a single, easy-to-use product that integrates various tools and services into one platform.

Fabric is a unified _software-as-a-service_ (SaaS) platform where all data is stored in a single open format in OneLake. All analytics engines in the platform can access OneLake, ensuring scalability, cost-effectiveness, and accessibility from anywhere with an internet connection.

## OneLake

**OneLake** is Fabric's centralized data storage architecture that enables collaboration by eliminating the need to move or copy data between systems. OneLake unifies your data across regions and clouds into a single logical lake without moving or duplicating data.

OneLake is built on **Azure Data Lake Storage Gen2** (ADLS Gen2) and supports various formats, including Delta, Parquet, CSV, and JSON. All compute engines in Fabric automatically store their data in OneLake, making it directly accessible without the need for movement or duplication. For tabular data, the analytical engines in Fabric write data in delta-parquet format and all engines interact with the format seamlessly.

:::image type="content" border="true" source="../media/onelake-architecture.png" alt-text="Diagram of Fabric compute engines such as Data Engineering, Data Warehouse, Data Factory, Power BI, and Real-Time Intelligence all accessing the same OneLake data storage.":::

**Shortcuts** are references to files or storage locations within OneLake or external data sources, such as Azure Data Lake Storage, Amazon S3, or Dataverse. Shortcuts allow you to access existing data without copying it, ensuring data consistency and enabling Fabric to stay in sync with the source.

Because all Fabric workloads store data in OneLake using an open format, AI capabilities like Copilot and data agents can access the same governed data as your reports and dashboards without separate data preparation pipelines. The work you do to ingest, prepare, and govern data in Fabric is what makes that data available for AI workloads.

## Workspaces

In Microsoft Fabric, workspaces serve as logical containers that help you organize and manage your data, reports, and other assets. They provide a clear separation of resources, making it easier to control access and maintain security.

Each workspace has its own set of permissions, ensuring that only authorized users can view or modify its contents. This structure supports team collaboration while maintaining strict access control for both business and IT users.

Workspaces allow you to manage compute resources and integrate with Git for version control. You can optimize performance and cost by configuring compute settings, while Git integration helps track changes, collaborate on code, and maintain a history of your work.

## Administration and governance

Fabric's OneLake is centrally governed and open for collaboration. Data is secured and governed in one place, which allows users to easily find and access the data they need. Fabric administration is centralized in the **Admin portal**.

In the admin portal you can manage groups and permissions, configure data sources and gateways, and monitor usage and performance. You can also access the Fabric admin APIs and SDKs in the admin portal, which can automate common tasks and integrate Fabric with other systems.

The **OneLake catalog** helps you analyze, monitor, and maintain data governance. It provides guidance on sensitivity labels, item metadata, and data refresh status, offering insights into the governance status and actions for improvement.

> [!NOTE]
> Review the [Microsoft Fabric administration](/fabric/admin) documentation for more information.
