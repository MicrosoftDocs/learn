Now that you have trained your AI, you can do a quick test to see how accurate it is so far. Select the **Quick Test** button in the upper-right corner of the Azure Custom Vision portal.

:::image type="content" source="../media/model-quick-test.png" alt-text="Screenshot that shows the Quick Test button in the Custom Vision portal.":::

Choose an image that you *didn't* use to train the AI, and remember that it has to be 4 MB or smaller.

The test will perform immediately. When it does, you should see something like this image:

:::image type="content" source="../media/bungee-test.png" alt-text="Screenshot that shows Bungee test results.":::

Notice that the AI decided that Bungee might have been in two places in the image, but the bounding box that had her full face had more of a probability of her being there.

## Challenge the AI

This was a pretty easy test. The images we used to train the AI were only of Bungee and her entire body, with no other objects in the images. When it's an image of mostly Bungee's face, it's likely that the AI will find Bungee. But what happens if we add a more complicated image from the film?

:::image type="content" source="../media/bungee-test-fail.png" alt-text="Screenshot that shows testing the AI on Bungee in a more complicated image.":::

We can see that the AI didn't find Bungee *at all* in this image. Admittedly, it's a little difficult even for me to see her hiding next to Jack Rabbit. No worries though! We can iterate!

## Train with more images

Now is the time to train with more images. Add more images that include the object you're looking for, but also include some images that don't have the object at all. Better yet, find images where there is an object that looks similar to your object but isn't it. For example, we can train with more images of Bungee from the film and also create a **Not Bungee** tag and tag other characters that aren't Bungee.

:::image type="content" source="../media/not-bungee.png" alt-text="Screenshot that shows the tagging for objects in images that are not Bungee.":::

Remember, you have to have at least 15 images per tag to train the AI.

Select the **Training** button in the upper right of the Custom Vision portal, and select **Quick Training** again.

## Retest your AI

Now you can test the AI again using images that you haven't used yet in your training set.

:::image type="content" source="../media/bungee-iteration-2.png" alt-text="Screenshot that shows the results from testing the second iteration of A I training.":::

With this second iteration, we have a more confident prediction that one of the objects in the image is Bungee at 62.2%. The AI isn't very confident at objects that aren't Bungee, since we grouped all other characters in the **Not Bungee** category instead of creating one for each of the other characters.

## Continue iterating

Now that you have the basics down, you can continue iterating on your AI model. Make sure you are keeping track of which images you are using to train your AI versus testing your AI so that you don't accidentally get too excited when the model predicts with 95% accuracy!