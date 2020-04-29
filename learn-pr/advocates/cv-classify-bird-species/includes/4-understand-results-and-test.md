Now that our model has been created lets take a look at how it is performing and test the model.

## Understanding the Model Performance

There are three indicators Custom Vision provides to help understand how the model is performing. Beware that you shouldn't considered these as fact or accuracy. Its telling you how it did on the data you provided to give you an idea of how it will preform on unseen data.

The three indicators provided for the entire model and for each class are:

| Indicator              | Description                                                                                                                    |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| Precision              | Precision means if a tag is predicted by your model, how likely is that to be right?                                           |
| Recall                 | This number will tell you: out of the tags which should be predicted correctly, what percentage did your model correctly find? |
| AP (Average precision) | A measure of the model performance, summaries the precision and recall at different threshold.                                 |

## Common Rookie Mistakes

### 1. Unbalanced Data

You may notice there is a warning about unbalanced data that says: "Unbalanced data detected. The distribution of images per tag should be uniform to ensure model performance." What this means is that we don't have an even number of samples for each class of bird species. There are different ways to solve unbalanced data, onw is "SMOTE" which is duplicating training examples from our existing training pool. In this model we are fine to leave as is but this can cause issues and should be noted.

### 2. Overfitting

If you don't have enough data or not diverse enough data your model can become overfitted. Meaning it knows the dataset provided really well and over fitted to the patterns in that data. It will perform well on the training data but poorly on new unseen data. This is why we always test our models with new data!

### 3. Testing with the same data you trained with

As mentioned in the overfitting example, if you test with the same data you trained with, its going to look like it is performign really well but when you deploy it to production it will most likely do poorly and you will be a sad dev.

### 4. Bad Data

Another common mistake is training with bad data. There are many ways that your data can actually hurt your model and accuracy. Data that is noisy can cause issues because there is too much information that is not useful and is causing model confusion. More data is only better if the data is actually good data. Throwing out bad data will greatly improve your accuracy.

## Test the model

Now that we have went over how to understand our restuls and common rookie mistakes. Lets test our model and see how it performs on unseen data.

- Select "Quick Test" from the upper right corner
- Search for an image of a bird that matches one of the species you trained it to recognize. Grab the URL for the image and paste it into the `Image URL` box to test accuracy.
- The predication will appear on the right side of the window
