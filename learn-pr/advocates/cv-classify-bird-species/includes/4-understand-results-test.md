Now that our model has been created, let's take a look at how it's performing and test the model.

## Understanding the model performance

There are three indicators Custom Vision provides to help understand how the model is performing. Beware that these are indicators not fact or accuracy. It's telling you how it did on the data you provided to give you an idea of how it will perform on unseen data.

The three indicators provided for the entire model and for each class are:

| Indicator              | Description                                                                                                                   |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Precision              | Precision means if a tag is predicted by your model, how likely is that to be right?                                          |
| Recall                 | This number will tell you: out of the tags that should be predicted correctly, what percentage did your model correctly find? |
| AP (Average precision) | A measure of the model performance, summaries the precision and recall at different threshold.                                |

Now that we understand some of the different indicators, we can use to understand how the model is performing. Let's talk about some of the "rookie mistakes" that can happen when starting to build machine learning models.

## Common rookie mistakes

### Unbalanced data

You may notice there is a warning about unbalanced data that says: "Unbalanced data detected. The distribution of images per tag should be uniform to ensure model performance." What this means is that we don't have an even number of samples for each class of bird species. There are different ways to solve unbalanced data, one is "SMOTE", which is duplicating training examples from our existing training pool. In our model, we are fine to leave as is but this can cause issues and should be noted.

### Overfitting

If you don't have enough data or not diverse enough data your model can become overfitted. Meaning it knows the dataset provided well and over fitted to the patterns in that data. It will perform well on the training data but poorly on new unseen data. This is why we always test our models with new data!

### Testing with training data

As mentioned in the overfitting example, if you test with the same data you trained with, it's going to look like it is performing well but when you deploy the model to production it will most likely do poorly.

### Bad data

Another common mistake is training with bad data. There are ways that your data can actually hurt your model and accuracy. Data that is noisy can cause issues because there is too much information that is not useful and is causing model confusion. More data is only better if the data is good data. This could mean throwing out bad data or features to improve your model accuracy.

## Test the model

Our model is performing well enough according to the metrics provided. Let's test our model and see how it performs on unseen data.

### Test in the Portal UI

1. Select **Quick Test** in the upper-right corner.
1. Search for an image of a bird that matches one of the species you trained it to recognize. Grab the URL for the image and paste it into the **Image URL** box to test accuracy. The prediction will appear on the right side of the window.

In the next step, we will deploy the model. After the model is deployed, we can do more testing with the endpoint we create.
