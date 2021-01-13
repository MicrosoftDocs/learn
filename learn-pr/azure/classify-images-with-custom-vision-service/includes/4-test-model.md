Now that we've trained our model, it's time to test it. We'll give the model new images and see how well it classifies it.

1. Select **Quick Test** at the top of the page.

    :::image type="content" source="../media/4-portal-click-quick-test.png" alt-text="Screenshot of the top bar of the Artworks project with the Quick Test button highlighted." loc-scope="other"::: <!-- no-loc -->

1. Select **Browse local files**, and then browse to the "Quick Tests" folder in the module resources folder you download previously. Select **PicassoTest_01.jpg**, and select **Open**.

    :::image type="content" source="../media/4-portal-select-test-01.png" alt-text="Screenshot of the QuickTests folder with a Picasso test image selected and Open button highlighted." loc-scope="other":::

1. Examine the results of the test in the "Quick Test" dialog. What is the probability that the painting is a Picasso? What is the probability that it's a Rembrandt or Pollock?

    :::image type="content" source="../media/4-quick-test-result.png" alt-text="Screenshot of the QuickTest dialog box showing the selected image." loc-scope="other":::

1. Close the "Quick Test" dialog. Then, select **Predictions** at the top of the page.

    :::image type="content" source="../media/4-portal-select-predictions.png" alt-text="Screenshot of the top bar of the Artworks project with the Predictions tab highlighted." loc-scope="other":::

1. Select the test image that you uploaded to show a detail of it. Then tag the image as a "Picasso" by selecting **Picasso** from the dropdown, and select **Save and close**.

    By tagging test images this way, you can refine the model without uploading additional training images.

    :::image type="content" source="../media/4-tag-test-image.png" alt-text="Screenshot showing the image selected for predictions with Picasso tag and Save and Close button highlighted." loc-scope="other":::

1. Run another quick test, this time using the file named **FlowersTest.jpg** in the "Quick Test" folder. Confirm that this image is assigned a low probability of being a Picasso, a Rembrandt, or a Pollock.

The model is trained and ready to go and appears to be skilled at identifying paintings by certain artists. Let's call the prediction endpoint over HTTP and see what happens.