::: zone pivot="video"

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=a95428c7-17de-455d-812d-7c4492eb2504]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

In this module, you learned how Microsoft Web IQ gives agents access to current web-based knowledge beyond a model's training data. Retrieving evidence at run time helps agents answer time-sensitive questions without retraining the model.

You explored the Web Search, News, Images, Videos, Browse, and Auto methods. Web Search discovers relevant pages, while Browse retrieves content from a known URL. News and media methods support more specific information needs. Auto provides typed evidence across eligible answer types and is currently a beta REST API for enabled AppIDs.

You learned how to create a Web IQ resource in a paid Azure subscription, connect it in the Web IQ portal to obtain a Web IQ AppID, and test queries in the playground. You also distinguished the AppID from an API key and a Microsoft Entra application client ID, and considered how clients authenticate securely.

Finally, you explored adding Web IQ to a Foundry project and agent through its MCP tool. Clear grounding instructions, appropriate approval settings, and inspection of tool traces help ensure that an agent uses the intended sources. Checking both retrieval quality and the final answer is essential: current web access doesn't remove the need to verify dates, cite evidence, and acknowledge uncertainty.

::: zone-end

For more information, see:

- [Microsoft Web IQ overview](/web-iq/overview?azure-portal=true).
- [Deploy Microsoft Web IQ with the Azure portal](/web-iq/get-started/deploy-azure-portal?azure-portal=true).
- [Use the Microsoft Web IQ MCP server](/web-iq/integrations/mcp?azure-portal=true).
