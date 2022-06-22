To collect log data, you need to connect your data sources with Microsoft Sentinel Connectors. The Data Connectors page displays a growing list of connectors provided by Microsoft Sentinel.

:::image type="content" source="../media/connector-page.png#lightbox" alt-text="Screen shot of Microsoft Sentinel Connector page.](../media/connector-page.png) ":::

After you select the Open connector page, the detailed connector page is split and has a left half and a right half.

:::image type="content" source="../media/connector-page2.png#lightbox" alt-text="Screen shot of Microsoft Sentinel Detailed Connector Page.](../media/connector-page2.png) ":::

The left half provides information about the connector, the connector's status, and the last time a log was received if connected.  On the bottom section of the left side is the Data Types.  The Data Types will list the table(s) that the connector will write to.

The right half has two tabs: Instructions and Next steps.  The Instructions tab can vary based on the connector.  In general, there will be Prerequisites and Configuration.  Follow the Configuration to connect to the data source.  The Next steps tab provides a quick reference to workbooks, query samples, and analytical templates.  Data Connectors can only be disconnected/deactivated, not deleted.

> [!NOTE]
> The connector does not install Workbooks and Analytics Templates.  Workbooks and Analytic Templates for out of the box connectors are already available in the Sentinel environment. 

