Azure Sentinel integrates with TAXII 2.0 and 2.1 data sources to enable monitoring, alerting, and hunting using your threat intelligence. Use this connector to send threat indicators from TAXII servers to Azure Sentinel. Threat indicators can include IP addresses, domains, URLs, and file hashes.

In the Azure portal, navigate to Azure Sentinel > Data connectors and then select the Threat Intelligence - TAXII (Preview) connector.

To view the connector page:

1. Select Data connectors page.

1. Select **Threat intelligence - TAXII**.

1. select the Open connector page on the preview pane.

1. Specify the required and optional information in the text boxes.

    - Friendly name (for server)

    - API root URL

    - Collection ID

    - Username

    - Password

1. Select **Add** to enable the connection.

The list of configure TAXII servers shows the currently connected TAXII servers and the last indicator received time. The ellipse at the end of the configured server provides the option to remove the server configuration.

:::image type="content" source="../media/taxii-connector.png" alt-text="The TAXII Connector page" lightbox="../media/taxii-connector.png":::
