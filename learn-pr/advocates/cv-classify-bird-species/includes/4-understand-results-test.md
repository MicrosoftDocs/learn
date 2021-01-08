With our model created, let's take a look at how it's performing. We'll also test the model.

## Understand model performance

Custom Vision provides three indicators or *metrics*  to help you understand how your model is performing. The indicators *don't* indicate how factual or accurate the model is. The indicators tell you only how the model performed on the data you provided, to give you an idea of how the model will perform on new data.

The following metrics are provided for the entire model and for each class:

| Metric | Description |
| ---- | ---- |
| `precision` | If a tag is predicted by your model, this metric indicates how likely the tag is to be correct. |
| `recall` | Of the tags that should be predicted correctly, this metric indicates the percentage of tags your model found correctly. |
| `average precision` | This metric measures model performance by computing the precision and recall at different thresholds. |

Now that we understand some of the different indicators that Custom Vision provides, we can use the indicators to understand how well the model performs. 

## Common mistakes

Let's talk about some of the "rookie mistakes" that can happen when you first start to build machine learning models.

### Unbalanced data

You might see this warning: *Unbalanced data detected. The distribution of images per tag should be uniform to ensure model performance.*

The warning indicates that you don't have an even number of samples for each class of data. There are different ways to solve unbalanced data; one way is by using *Synthetic Minority Over-sampling Technique (SMOTE)*. SMOTE duplicates training examples from our existing training pool. In our model, we don't see this warning, but it's something to watch for in a  machine learning model.

### Overfit the model

If you don't have enough data or your data isn't diverse enough, your model can become overfitted. When a model is overfitted, it knows the provided dataset well, and it's overfitted to the patterns in that data. The model performs well on the training data, but it performs poorly on new data that it hasn't seen before. For this reason, we always use new data to test a model!

### Test by using training data

As in overfitting, if you test the model by using the same data that you used to train the model, the model appears to perform well. But, when you deploy the model to production, it most likely perform poorly.

### Bad data

Another common mistake is training by using bad data. There are ways that your data can actually hurt your model and accuracy. For example, data that is "noisy" can cause issues: too much information that isn't useful is provided, and the information causes model confusion. More data is better only if the data is good data. You might need to throw out bad data or features to improve your model accuracy.

## Test the model

According to the metrics that Custom Vision provides, our model is performing well enough. Let's test our model and see how it performs on unseen data.

### Test in the Custom Vision portal

To test the model in the Custom Vision portal:

1. In the top menu bar in the Custom Vision portal, select **Quick Test**.
1. In **Quick Test**, select **Browse local files**.
1. In  **Open**, search for a bird image from one of the species that you trained the model to recognize. Select the image, and then select **Open**.

Custom Vision opens the image, and then analyzes the image to test the model's accuracy. The prediction results are shown in the window.

:::image type="content" source="../media/quick-test-prediction-results.png" alt-text="Screenshot that shows the prediction results after testing an image in the Custom Vision project.":::

In the next step, we'll deploy the model. After the model is deployed, we can do more testing with the endpoint we create.
