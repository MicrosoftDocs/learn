To collect log data, you need to connect your data sources with Microsoft Sentinel Data Connectors. The Data Connectors are included with Content Hub Solutions provided by Microsoft Sentinel.

:::image type="content" source="../media/02-azure-activity-content-hub-solution.png#lightbox" alt-text="Screen shot of Microsoft Sentinel Content Hub page."(../media/02-azure-activity-content-hub-solution.png) ":::

After you install a Content Hub Solution, installed Data Connectors are displayed in Microsoft Sentinel under the `Configuration | Data connectors` menu section. When you select the Open connector page, the detailed connector page is split and has a left half and a right half.

:::image type="content" source="../media/02-azure-activity-data-connector-page.png#lightbox" alt-text="Screen shot of Microsoft Sentinel Detailed Connector Page."(../media/02-azure-activity-data-connector-page.png) ":::

The left half provides information about the connector, the connector's status, and the last time a log was received if connected.  On the bottom section of the left side is the Data Types. The `Data Types` lists the table(s) that the connector writes to.

The right half has an Instructions tab. The Instructions tab can vary based on the connector. In general, there are Prerequisites and Configuration. Follow the Configuration to connect to the data source. The Next steps tab provides a quick reference to workbooks, query samples, and analytical templates. Data Connectors can only be disconnected/deactivated, not deleted.

> [!NOTE]
> Content Hub solutions may also install Workbooks, Analytics rules and Hunting queries. Workbooks and Analytic rule templates for out of the box connectors are already available in the Sentinel environment.
