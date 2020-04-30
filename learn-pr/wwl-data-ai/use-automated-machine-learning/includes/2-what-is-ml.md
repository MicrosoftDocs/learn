Machine learning uses mathematics and statistics to predict unknown values. For example, suppose *Adventure Works Cycles* is a business that rents cycles in a city. The business could use historic data to train a model that predicts daily rental demand in order to make sure sufficient staff and cycles are available.

> [!div class="centered"]
> ![Adventure Works cycle rental location, on a cloudy day in January](../media/adventureworks.png)

To do this, Adventure Works could create a machine learning model that takes information about a specific day (the day of week, the expected weather conditions, and so on) as an input, and produces the predicted number of rentals as an output.

Mathematically, you can think of machine learning as a way of defining a function (let's call it ***f***) that operates on one or more *features* of something (which we'll call ***x***) to calculate a predicted *label* (***y***) - like this:

> [!div class="centered"]
> ***y = f(x)***

In this bicycle rental example, the details about a given day (day of the week, weather, and so on) are the *features* (***x***), the number of rentals for that day is the *label* (***y***), and the function (***f***) that calculates the number of rentals based on the information about the day is the machine learning model.

The specific operation that the ***f*** function performs on *x* to calculate *y* depends on a number of factors, including the type of model you're trying to create and the specific algorithm used to train the model.

## Types of machine learning

Machine learning models can be categorized into two broad types - *supervised* machine learning models, and *unsupervised* machine learning models.

### Supervised machine learning

Supervised machine learning techniques involve training a model by using a dataset that includes features as well as already-known label values. The training process *fits* the features to the known labels to define a general function that can be applied to new features for which the labels are unknown, and predict them.

There are two general kinds of supervised machine learning model:

- **Regression**: Regression models use the features to calculate a numeric value for the predicted label, such as a price, size, or any other numeric measurement. Specialized variants of regression incorporate time-series features to forecast future trends, such as stock price values or sales.
- **Classification**: Classification models use the features to predict a label that indicates the category, or *class*, to which an item belongs. Classification scenarios include *binary classification*, in which the model predicts one of two values (often *true* or *false* - for example, predicting whether a person is diabetic or not), and *multiclass classification* in which the model predicts the probabilities of an item belonging to each possible class (for example, the probabilities that a person has type 1 diabetes, type 2 diabetes, or is not diabetic).

In the Adventure Works bicycle rental example, you're looking for a function that performs some kind of calculation based on the various seasonal and weather features on a given day to determine the number of rentals that day. Since you're trying to train a model that predicts a numeric valued label (the number of bicycle rentals) using historic data that includes both features and past known values for the label, this is an example of *regression*.

### Unsupervised machine learning

Unsupervised machine learning models also predict a label based on features, but this time there are no known label values in the training dataset - the function just identifies similarities between items based on their features.

The most common kind of unsupervised machine learning model is a **Clustering** model, which attempts to separate items into a specified number of groups, or *clusters*, based on similarity of features.
