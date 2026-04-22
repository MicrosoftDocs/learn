In this module, you used the Azure AI Content Safety interface in Azure AI Foundry to test moderation and safety controls for generative AI. The same **Try it out** experience can also generate starter code that reflects the settings you chose, which makes it easier to transfer validated guardrail settings into Contoso Camping Store's platform.

As you adjust the threshold levels for the filters, the exported code updates to reflect your current settings. As an example, you can access the code sample for the text moderation tool. In the **Moderate text content** panel, the **View code** button provides starter code for the respective feature. View the code to see how the current thresholds are represented:

1. On the **Try it out** page, select **Moderate text content**.
1. In the **Test** section, select **\</> View code**.

    :::image type="content" source="../media/view-code.png" alt-text="Screenshot of the button for viewing code on the page for moderating text content.":::
1. In the **Language** dropdown list, select **Python** and review the code.
1. As you adjust the threshold levels for the categories, the exported sample updates the threshold mapping for each category. In the Python sample, each category maps to the minimum numeric severity that should trigger rejection (for example, `4` means reject content with severity `4` (**Medium**) or higher, which also includes severity `6` (**High**)). Those values affect your application's decision logic; they don't change how the service classifies content. Adjust the threshold levels for the categories and view the sample code to see how the values change.

    :::image type="content" source="../media/sample-code-thresholds.png" alt-text="Screenshot of the dictionary for rejection thresholds within the sample code for text moderation."  lightbox="../media/sample-code-thresholds.png":::

> [!NOTE]
> If you disable a category, the exported sample uses a sentinel value so your app doesn't treat that category as blocking. In the current Python sample, that value is `-1`.

> [!IMPORTANT]
> Treat the generated code as a starting point, not a finished production integration. Move secrets out of source code, use Microsoft Entra ID or managed identity when possible, and store any required keys securely. For more information, see [Authenticate requests to Azure AI services](/azure/ai-services/authentication) and [Security for Azure AI Content Safety](/azure/ai-services/content-safety/overview#security).

If you choose to start configuring filters and testing the model's detection capabilities within Azure AI Foundry, use the exported sample code for each Azure AI Content Safety feature as your baseline and then adapt it to your app's authentication, logging, and deployment standards. The Python sample uses the **`azure-ai-contentsafety`** SDK; the equivalent .NET, Java, and JavaScript packages are listed in the [Content Safety client library quickstarts](/azure/ai-services/content-safety/quickstart-text). For production hardening guidance, see [Plan and manage costs](/azure/ai-services/content-safety/how-to/plan-manage-costs) and [Mitigate false results in Azure AI Content Safety](/azure/ai-services/content-safety/how-to/improve-performance).
