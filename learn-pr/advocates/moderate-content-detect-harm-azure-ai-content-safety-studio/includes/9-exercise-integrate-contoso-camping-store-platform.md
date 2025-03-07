In this workshop, you used the interface of Azure AI Content Safety to test the moderation and safety solutions for generative AI. However, each test that you ran in this workshop also has code available. You can apply this code directly to the code for Contoso Camping Store's platform. The provided code sample is documented with helpful information to explain the code logic.

As you adjust the threshold levels for the filters, the corresponding code is updated to reflect your current settings. As an example, you can access the code sample for the text moderation tool. On the **Moderate text content** page, the **View code** button provides the code for the respective feature. View the code to get an idea of how it's structured:

1. On the **Content Safety** page, select **Moderate text content**.
1. In the **Test** section, select **\</> View code**.

    :::image type="content" source="../media/view-code.png" alt-text="Screenshot of the button for viewing code on the page for moderating text content.":::
1. In the **Language** dropdown list, select **Python** and view the code.
1. As you adjust the threshold levels for the categories, the **reject_thresholds** dictionary within the sample code changes the value for the corresponding category. Adjust the threshold levels for the categories and view the sample code to see how the values change.

    :::image type="content" source="../media/sample-code-thresholds.png" alt-text="Screenshot of the dictionary for rejection thresholds within the sample code for text moderation."  lightbox="../media/sample-code-thresholds.png":::

> [!NOTE]
> If you disable a category, the sample code modifies its corresponding value to `-1`.

If you choose to start configuring filters and testing the model's detection capabilities within Azure AI Foundry, be sure to use the sample code that's provided for each Azure AI Content Safety feature.
