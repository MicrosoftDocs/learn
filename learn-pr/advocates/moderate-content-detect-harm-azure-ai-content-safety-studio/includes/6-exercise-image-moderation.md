Contoso Camping Store gives customers the ability to upload photos to complement their product reviews. Customers find this feature useful, because it provides insight into how products look and function outside the generic marketing images.

You can apply an AI model to detect whether the images that customers post are harmful. You can then use the detection results to implement the necessary precautions.

## Safe content

First, test an image of a family camping:

1. On the **Content Safety** page, select **Moderate image content**.
1. Select **Browse for a file** and upload the **family-builds-campfire.JPG** file. The file is within the **data/Image Moderation** folder.
1. Set all **Threshold level** values to **Medium**.

    :::image type="content" source="../media/image-moderation.png" alt-text="Screenshot of the image preview and filter configuration for image moderation."  lightbox="../media/image-moderation.png":::

1. Select **Run test**.

As expected, this image content is **Allowed**. The severity level is **Safe** across all categories.

:::image type="content" source="../media/image-moderation-allow-results.png" alt-text="Screenshot of image moderation results. The content is allowed. The severity level across all categories is Safe. The threshold across all categories is Medium. The judgment across all categories is Allowed."  lightbox="../media/image-moderation-allow-results.png":::

## Violent content

You should anticipate that customers can potentially post harmful image content. To ensure that you account for such a scenario, test the detection of harmful image content.

> [!NOTE]
> The image that you use for testing contains a graphic depiction of a bear attack. The image is blurred by default in the image preview. However, you're welcome to use the **Blur image** toggle to change this setting.

1. Select **Browse for a file** and upload the **bear-attack-blood.JPG** file.
1. Set all **Threshold level** values to **Medium**.
1. Select **Run test**.

The content is **Blocked**. The **Violence** filter rejected it and shows a severity level of **High**.

:::image type="content" source="../media/image-moderation-blocked-content.png" alt-text="Screenshot of image moderation results. The content is blocked. The severity level for the Violence category is High. The judgment for the Violence category is Blocked."  lightbox="../media/image-moderation-blocked-content.png":::

## Run a bulk test

So far, you've tested image content for singular, isolated images. However, you can test a bulk dataset of image content all at once and receive metrics based on the model's performance.

You have a bulk dataset of images from customers. The dataset also includes sample harmful images to test the model's ability to detect harmful content. Each record in the dataset includes a label to indicate whether the content is harmful.

Do another test round, but this time with the dataset:

1. Switch to the **Run a bulk test** tab.
1. Select **Browse for a file** and upload the **bulk-image-moderation-dataset.zip** file.
1. In the **Dataset preview** section, browse through the records and their corresponding labels. A label of **0** indicates that the content is acceptable (not harmful). A label of **1** indicates that the content is unacceptable (harmful).

    :::image type="content" source="../media/bulk-image-moderation.png" alt-text="Screenshot of the dataset preview for bulk image moderation. It shows a list of image records and their corresponding labels on one side and the section for configuring filters on the other side.":::

1. Set all **Threshold level** values to **Medium**.
1. Select **Run test**.

Examine the results.

:::image type="content" source="../media/bulk-image-moderation-results.png" alt-text="Screenshot of results for bulk image moderation."  lightbox="../media/bulk-image-moderation-results.png":::

Is there room for improvement? If so, adjust the **Threshold** levels until the **Precision**, **Recall**, and **F1 score** metrics are closer to **1**.
