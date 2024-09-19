Contoso Camping Store provides customers with the ability to speak with an AI-powered customer support agent and post product reviews. We could apply an AI model to detect whether the text input from our customers is harmful and later use the detection results to implement the necessary precautions.

## Safe content

Let’s first test some positive customer feedback.

1. On the **Content Safety** page, select **Moderate text content**.
1. In the **Test** box, enter the following content:

   *I recently used the PowerBurner Camping Stove on my camping trip, and I must say, it was fantastic! It was easy to use, and the heat control was impressive. Great product!*

1. Set all **Threshold levels** to **Medium**.
    :::image type="content" source="../media/text-moderation.png" alt-text="A screenshot of step 2 on the text moderation page. A text box displays with sample text. Next to the text box are the threshold filters."  lightbox="../media/text-moderation.png":::
1. Select **Run test**.

The content is allowed, and the severity level is **Safe** across all categories. This result is to be expected given the positive and unharmful sentiment of the customer’s feedback.

:::image type="content" source="../media/text-moderation-allow-results.png" alt-text="A screenshot of the results for text moderation. The screenshot shows that the content is allowed. The severity level for all categories is safe. The threshold settings for all categories is medium. And the judgment for all categories is allowed."  lightbox="../media/text-moderation-allow-results.png":::

## Harmful content

But what happens if we test a harmful statement? Let’s test with negative customer feedback. While it's OK to dislike a product, we don't want to condone any name calling or degrading statements.

1. In the **Test** box, enter the following content:

   *I recently bought a tent, and I have to say, I'm really disappointed. The tent poles seem flimsy, and the zippers are constantly getting stuck. It's not what I expected from a high-end tent. You all suck and are a sorry excuse for a brand.*

1. Set all **Threshold levels** to **Medium**.
1. Select **Run test**.

    :::image type="content" source="../media/text-moderation-low-hate.png" alt-text="A screenshot of the text moderation results. The content is allowed, however, the severity level for hate is low. The severity level is safe across all other categories."  lightbox="../media/text-moderation-low-hate.png":::

   Although the content is **Allowed**, the **Severity level** for **Hate** is low. To guide our model to block such content, we need to adjust the **Threshold level** for **Hate**. A lower **Threshold level** would block any content that’s a low, medium, or high severity. There’s no room for exceptions!

1. Set the **Threshold level** for **Hate** to **Low**.

    :::image type="content" source="../media/text-moderation-low-threshold-hate.png" alt-text="A screenshot of the configure filters settings for text moderation. The threshold for the hate category is emphasized and set to low."  lightbox="../media/text-moderation-low-threshold-hate.png":::
1. Select **Run test**.

The content is now **Blocked** and was rejected by the filter in the **Hate** category.

:::image type="content" source="../media/text-moderation-blocked-content.png" alt-text="A screenshot of the text moderation results. The content is blocked. The severity level for the hate category is low. The threshold for the hate category is low. The judgment for the hate category is blocked."  lightbox="../media/text-moderation-blocked-content.png":::

## Violent content with misspelling

We can’t anticipate that all text content from our customers is going to be free of spelling errors. Fortunately, the **Moderate text content** tool can detect harmful content even if the content has spelling errors. Let’s test this capability on more customer feedback about an incident with a racoon.

1. In the **Test** box, enter the following content:

   *I recently purchased a campin cooker, but we had an acident. A racon got inside, was shocked, and dyed. Its blod is all over the interior. How do I clean the cooker?*

1. Set all **Threshold levels** to **Medium**.
1. Select **Run test**.

The content is **Blocked**, the **Severity level** for **Violence** is **Medium**. Consider a scenario where the customer is asking this question in a conversation with the AI-powered customer support agent. The customer hopes to receive guidance on how to clean the cooker. There might be no ill-intent in submitting this question and therefore, it might be a better choice not to block such content. As the developer, consider various scenarios where such content might be OK before deciding to adjust the filter and block similar content.

## Run a bulk test

So far, we tested text content for singular isolated text content. However, if we have a bulk dataset of text content, we could test the bulk dataset at once and receive metrics based on the model’s performance.

We have a bulk dataset of statements provided by both customers and the support agent. The dataset also includes fabricated harmful statements to test the model’s ability to detect harmful content. Each record in the dataset includes a label to indicate whether the content is harmful. The data set consists of statements provided by customers and customer support agents. Let’s do another test round but this time with the data set!

1. Switch to the **Run a bulk test** tab.
1. In the **Select a sample or upload your own** section, select **Browse for a file**. Select the `bulk-text-moderation-data.csv` file and upload.
1. In the **Dataset preview** section, browse through the **Records** and their corresponding **Label**. A **0** indicates that the content is acceptable (not harmful). A **1** indicates that the content is unacceptable (harmful content).

    :::image type="content" source="../media/bulk-text-moderation.png" alt-text="A screenshot of the dataset preview for bulk text moderation. A list of records and their corresponding label displays to the left. The section to configure filters displays on the right."  lightbox="../media/bulk-text-moderation.png":::

1. Set all **Threshold levels** to **Medium**.
1. Select **Run test**.

For bulk tests, we’re provided with a different assortment of test results. First, we’re provided with the proportion of **Allowed** vs. **Blocked** content. In addition, we also receive a **Precision**, **Recall**, and **F1 Score** metric.

:::image type="content" source="../media/bulk-text-moderation-results.png" alt-text="A screenshot of the bulk text moderation results."  lightbox="../media/bulk-text-moderation-results.png":::

The **Precision** metric reveals how much of the content the model identified as harmful is actually, harmful. It’s a measurement of how precise/accurate the model is. The maximum value is **1**.

The **Recall** metric reveals how much of the actual harmful content the model correctly identified. It’s a measurement of the model's ability to identify actual harmful content. The maximum value is **1**.

The **F1 Score** metric is a function of **Precision** and **Recall**. The metric is needed when you seek a balance between **Precision** and **Recall**. The maximum value is **1**.

We’re also able to view each record and the **Severity level** across each enabled category. The **Judgment** column consists of the following:

- Allowed
- Blocked
- Allowed with warning
- Blocked with warning

The warnings are an indication that the general judgment from the model is different from the corresponding record label. To resolve such differences, you could adjust the **Threshold levels** within the **Configure filters** section to fine-tune the model.

The final result we’re given is the distribution across categories. This result considers the number of records that were judged to be **Safe** compared to the records for the corresponding category, which were either **Low**, **Medium**, or **High**.

:::image type="content" source="../media/bulk-text-moderation-distribution-results.png" alt-text="A screenshot of the severity distributed by category results."  lightbox="../media/bulk-text-moderation-distribution-results.png":::

Based on the results, is there room for improvement? If so, adjust the **Threshold** levels until the **Precision**, **Recall**, and **F1 Score** metrics are closer to **1**.