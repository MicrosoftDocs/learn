Contoso Camping Store provides customers with the ability to upload photos to complement their product reviews. Customers have found this feature useful as it provides insight into how products look and function outside of the generic marketing images. We could leverage an AI model to detect whether the images posted by our customers are harmful and later use the detection results to implement the necessary precautions.

## Safe content

Let’s first test an image of a family camping!

1. In Content Safety Studio, select **Moderate** **image content**.
1. Select **Browse for a file** and upload the `family-builds-campfire.JPG` file.
1. Set all **Threshold levels** to **Medium**.
1. Select **Run test**.

As expected, this image content is **Allowed,** and the **Severity level** is **Safe** across all categories.

## Violent content

We should also anticipate customers potentially posting harmful image content. To ensure that we account for such a scenario, let’s test the detection of harmful image content.

> [!NOTE]
> The image used for testing contains a graphic detection of a bear attack. The image will be blurred by default in the **Image preview**. However, you’re welcome to use the **Blur image** toggle to change this setting.

1. Select **Browse for a file** and upload the `bear-attack-blood.JPG` file.
1. Set all **Threshold levels** to **Medium**.
1. Select **Run test**.

Rightfully so, the content is **Blocked**, and was rejected by the **Violence** filter which has a **Severity** level of **High**.

## Run a bulk test

So far, we’ve tested image content for singular isolated images. However, if we have a bulk dataset of image content, we could test the bulk dataset at once and receive metrics based on the model’s performance.

We have a bulk dataset of images provided by customers. The dataset also includes sample harmful images to test the model’s ability to detect harmful content. Each record in the dataset includes a label to indicate whether the content is harmful. Let’s do another test round but this time with the data set!

1. Switch to the **Run a bulk test** tab.
1. Select **Browse for a file** and upload the `bulk-image-moderation-dataset.zip` file.
1. In the **Dataset preview** section, browse through the **Records** and their corresponding **Label**. A **0** indicates that the content is acceptable (not harmful). A **1** indicates that the content is unacceptable (harmful content).
1. Set all **Threshold levels** to **Medium**.
1. Select **Run test**.

Based on the results, is there room for improvement? If so, adjust the **Threshold** levels until the **Precision**, **Recall**, and **F1 Score** metrics are closer to **1**.