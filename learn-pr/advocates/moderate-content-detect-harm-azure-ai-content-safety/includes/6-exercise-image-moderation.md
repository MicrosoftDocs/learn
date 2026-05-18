Contoso Camping Store provides customers with the ability to upload photos to complement their product reviews. Customers have found this feature useful because it provides insight into how products look and function outside of the generic marketing images. We can use the Azure AI Content Safety **Analyze Image API** to detect whether customer images contain harmful content and then use the detection results to guide the application's response.

> [!NOTE]
> The image moderation API supports common image formats such as JPEG, PNG, GIF, BMP, TIFF, and WEBP. Images must be between **50 x 50** and **7200 x 7200** pixels and no larger than **4 MB**.
> For animated image formats such as GIF, the service analyzes the first frame.
>
> The notebook builds the image path with `os.path.join("<sample_data>", "<image.jpg>")`. Use `../data/Image Moderation` when the notebook runs from the **Azure AI Content Safety Workshop** folder. If you run the notebook from the repository root and get a file-not-found error, use `data/Image Moderation` instead.

## Safe content

Let’s first test an image of a family camping.

1. In the notebook, go to the `SAFE IMAGE` cell.
1. Replace `<sample_data>` with the `../data/Image Moderation` folder, or `data/Image Moderation` if your notebook kernel is running from the repository root.
1. Replace `<image.jpg>` with `family-builds-campfire.jpg`.
1. Run the cell.

You should see a **0** severity across all categories for this sample.

## Violent content

We should also anticipate customers potentially posting harmful image content. To ensure that we account for such a scenario, let’s test the detection of harmful image content.

> [!NOTE]
> The image used for testing contains a graphic depiction of a bear attack.

1. In the notebook, go to the `VIOLENT IMAGE` cell.
1. Replace `<sample_data>` with the `../data/Image Moderation` folder, or `data/Image Moderation` if your notebook kernel is running from the repository root.
1. Replace `<image.jpg>` with `bear-attack-blood.jpg`.
1. Run the cell.

You should see **Violence** rise to a high severity. The image moderation model returns the trimmed severity scale of **0**, **2**, **4**, and **6**, so high-risk results appear as **6**. Model results can change as the service is updated; focus on the flagged category and relative severity rather than treating the exact sample score as a contract.

For the current REST request format and service limits, see [Quickstart: Analyze image content](/azure/ai-services/content-safety/quickstart-image).
