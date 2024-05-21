Despite leveraging the UI interface of Content Safety Studio to test the moderation and safety solutions for generative AI, each of the tests you’ve run throughout this workshop has code available which could be applied directly to the code for Contoso Camping Store’s platform. The provided code sample is both documented with helpful comments and includes placeholders for key variables such as your **subscription key** and your **endpoint**.

As you adjust the threshold levels for the filters, the corresponding code updates to reflect your current settings. As an example, let’s access the code sample for the Text Moderation tool. Within the **Moderate text content** screen, there’s a **View code** button which provides you with the code for the respective feature. View the code to get an idea of how the code is structured.

1. In Content Safety Studio, select **Moderate text content**.
1. Within the **Test** section, locate and click **\</> View code**.
1. Select your preferred language from the **Language** drop down and view the code.

As you adjust the threshold levels for the categories, the **reject_thresholds** dictionary within the sample code changes the value for the corresponding category. Adjust the threshold levels for the categories and view the sample code to see how the values change for each category.

> [!NOTE]
> If you were to disable a category, the sample code would modify its corresponding value to -1.

If you choose to get started configuring filters and testing the model’s detection capabilities within the Content Safety Studio, be sure to leverage the sample code provided for each Azure AI Content Safety feature!