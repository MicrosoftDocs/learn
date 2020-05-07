Now that our model is created, let's take a look at how it's performing and test the model.

## Understanding model performance

Custom Vision provides three indicators or *metrics*  to help you understand how your model is performing. The indicators do *not* indicate how factual or accurate the model is. The indicators tell you how the model performed on the data you provided, to give you an idea of how the model will perform on new data.

The following metrics are provided for the entire model, and for each class:

| Metric | Description |
| ---- | ---- |
| precision | If a tag is predicted by your model, this metric indicates how likely the tag is to be right. |
| recall | Of the tags that should be predicted correctly, this metric indicates the percentage of tags your model found correctly. |
| average precision (AP) | This metric measures model performance by computing the precision and recall at different thresholds. |

Now that we understand some of the different indicators that Custom Vision provides, we can use the indicators to understand how well the model performs. 

## Common mistakes

Let's talk about some of the "rookie mistakes" that can happen when you first start to build machine learning models.

### Unbalanced data

You might see this warning: *Unbalanced data detected. The distribution of images per tag should be uniform to ensure model performance.*

The warning indicates that you don't have an even number of samples for each class of data. There are different ways to solve unbalanced data; one way is by using *Synthetic Minority Over-sampling Technique (SMOTE)*. SMOTE duplicates training examples from our existing training pool. In our model, we don't see this warning, but it's something to watch for in a  machine learning model.

### Overfitting

If you don't have enough data or your data isn't diverse enough, your model can become overfitted. When a model is overfitted, it knows the dataset that is provided well, and it is overfitted to the patterns in that data. The model  performs well on the training data, but it will perform poorly on new data that it hasn't seen before. This is why we always test our models by using new data!

### Testing by using training data

As in overfitting, if you test the model by using the same data that you trained the model with, the model will appear to perform well, but when you deploy the model to production, it most likely will do poorly.

### Bad data

Another common mistake is training by using bad data. There are ways that your data can actually hurt your model and accuracy. For example, data that is "noisy" can cause issues: too much information that isn't useful is provided, and the information causes model confusion. More data is better only if the data is good data. You might need to throw out bad data or features to improve your model accuracy.

## Test the model

According to the metrics that Custom Vision provides, our model is performing well enough. Let's test our model and see how it performs on unseen data.

### Test in the portal UI

To test the model in the Custom Vision portal:

1. Select **Quick Test** in the upper-right corner.
1. Search for an image of a bird that matches one of the species you trained the model to recognize. Grab the URL for the image and paste it in **Image URL** to test the model's accuracy. The prediction is shown in the window.

In the next step, we'll deploy the model. After the model is deployed, we can do more testing with the endpoint we create.
