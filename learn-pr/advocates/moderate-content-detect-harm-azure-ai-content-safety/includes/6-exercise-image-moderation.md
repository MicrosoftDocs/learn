Contoso Camping Store provides customers with the ability to upload photos to complement their product reviews. Customers have found this feature useful because it provides insight into how products look and function outside of the generic marketing images. We could leverage an AI model to detect whether the images posted by our customers are harmful and later use the detection results to implement the necessary precautions.

## Safe content

Let’s first test an image of a family camping.

1. In the notebook, go to the `SAFE IMAGE` cell.
1. Replace `<sample_data>` with the `../data/Image Moderation` folder.
1. Replace `<image.jpg>` with `family-builds-campfire.jpg`.
1. Run the cell.

As expected, the **Severity level** is **0** across all categories.

## Violent content

We should also anticipate customers potentially posting harmful image content. To ensure that we account for such a scenario, let’s test the detection of harmful image content.

> [!NOTE]
> The image used for testing contains a graphic detection of a bear attack.

1. In the notebook, go to the `VIOLENT IMAGE` CELL.
1. Replace `<sample_data>` with the `../data/Image Moderation` folder.
1. Replace `<image.jpg>` with `bear-attack-blood.jpg`.
1. Run the cell.

Rightfully, the **Severity level** is **6**.
