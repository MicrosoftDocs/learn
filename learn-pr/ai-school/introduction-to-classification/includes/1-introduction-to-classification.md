Models that sort examples into categories are called __classification algorithms__. The graph below shows a logistic regression, an example of a classification algorithm, where the values are classified into two categories - satisfied customers and dissatisfied customers.

![3.1 LogisticRegression-01](../media/3.1_LogisticRegression-01.png)

If you have done some data science before you might be used to seeing logistic regression with only one feature, with the label on the y axis.

![3.1 LogisticRegression-02](../media/3.1_LogisticRegression-02.png)  
  
Email spam filters are another example of a classification algorithm (spam or not spam).

Classification differs from the regression algorithms we have covered so far – where we try to predict a number rather than a category. If we wanted to predict the speed a bird can fly or the price of a house, that would be a regression problem. Here we're going to predict if a customer is satisfied or dissatisfied. This is a classification problem.

### Classification predicts labels

In AI, when we predict an example’s category, we __label__ the example with a category. Labels don’t have to be binary - a label might be a breed of a dog or the species of a tree.  
  
#### How we predict labels
  
To build a classification model we need to use examples that are already labeled.  The model learns from these labelled examples, and will be able to predict labels for new unlabelled examples.

So if we want to predict the breed of dogs, we would create a data set and label the examples ourselves with the features of dogs (height, weight, fur color, ear shape, etc).  If we label enough features in a big enough data set of dogs, we can create an AI model that can guess the breed of any new dog we meet.

There are lots of different classification algorithms we can use. We’ll use a simple, but powerful, classification algorithm next - __logistic regression__.

:::tutorial-optional-section {tutorial-optional-section=Optional:&nbsp;What&nbsp;if&nbsp;we&nbsp;don't&nbsp;have&nbsp;labels?}
In this course we will primarily cover supervised learning – teaching AI models to map an input set to an output set, based on a data set we provide. However, you may have heard about unsupervised learning – AI models making predictions without an output set in the data set.
 
Unsupervised AI models can make some predictions without an output set, but the predictions are very limited in comparison to supervised AI models. Some applications include clustering, anomaly detection, and general adversarial networks (GANs). We cover supervised learning in the final module of this course.
:::

## Summary

Well done! In this step, we covered:

* __Classification models__ sort examples into different categories.
* __Logisitic regression__ a classification algorithm that can use one or many features to predict a category.

Stay with us! Don't worry if you feel a bit lost right now - next up we'll walk you through logistic regression.