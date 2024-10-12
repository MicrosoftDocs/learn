In this workshop, you used the UI interface of Azure AI Content Safety to test the moderation and safety solutions for generative AI. However, each of the tests that you ran in this workshop also has code available. You can apply this code directly to the code for Contoso Camping Store's platform. The provided code sample is documented with helpful information to explain the code logic.

As you adjust the threshold levels for the filters, the corresponding code updates to reflect your current settings. As an example, let's access the code sample for the Text Moderation tool. Within the **Moderate text content** screen, there's a **View code** button that provides you with the code for the respective feature. View the code to get an idea of how the code is structured.

1. In Content Safety Studio, select **Moderate text content**.
1. Within the **Test** section, locate and select **\</> View code**.

    :::image type="content" source="../media/view-code.png" alt-text="A screenshot of the moderate text context screen. The view code button is emphasized.":::
1. Select **Python** from the **Language** dropdown list and view the code.
1. As you adjust the threshold levels for the categories, the **reject_thresholds** dictionary within the sample code changes the value for the corresponding category. Adjust the threshold levels for the categories and view the sample code to see how the values change for each category.

    :::image type="content" source="../media/sample-code-thresholds.png" alt-text="A screenshot of the reject thresholds dictionary within the sample code for text moderation."  lightbox="../media/sample-code-thresholds.png":::

> [!NOTE]
> If you disable a category, the sample code modifies its corresponding value to `-1`.

If you choose to get started configuring filters and testing the model's detection capabilities within Azure AI Studio, be sure to use the sample code provided for each Azure AI Content Safety feature!