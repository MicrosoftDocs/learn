If you've used Microsoft Analysis Services, you might be familiar with XMLA endpoint. While using an API might feel intimidating to some, it's straightforward to use. In short, the XMLA endpoint is another way for you to connect to Power BI workspaces and semantic models from external applications - just an API with a URL to the workspace or semantic model.

## XMLA endpoint settings

By default, endpoint connectivity is **read-only** for the semantic models workload. This setting allows data visualization tools access to the following semantic model details:

- Model data
- Metadata
- Events
- Schema

Some data visualization tools include Microsoft Excel, Power BI Report Builder, Tabular Editor, or ALM Toolkit. You can get the workspace connection URL in workspace settings.

**Read-write** connectivity can be enabled to provide more operations, including:

- Management
- Governance
- Advanced semantic modeling
- Debugging
- Monitoring

With read-write enabled, semantic models have more parity with Azure Analysis Services and SQL Server Analysis Services enterprise grade tabular modeling tools and processes. In order to use XMLA endpoint for read-write operations, the semantic model must reside in a Premium or Fabric workspace.

Some common uses of the XMLA endpoint in Power BI are:

- Refreshing individual components of a data model.
- Systematically exporting data from the data model.
- Automating the use of the Best Practice Analyzer.

> [!NOTE]
> For full functionality and limitations, reference the [Semantic model connectivity with the XMLA endpoint](/power-bi/enterprise/service-premium-connect-tools) article.
