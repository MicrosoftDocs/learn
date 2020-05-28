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

## Typical machine learning tasks

Machine learning is typically performed within the context of a larger *data science* process. The specific details of this process can vary between organizations and individual data scientists, but the process is usually iterative and involves the following tasks:

- **Data Ingestion** - data is collected from various sources and made available to data scientists to work with.
- **Data exploration** - data scientists analyze the data, often using statistical metrics and visualizations to understand relationships between features and labels.
- **Data preprocessing** (sometimes referred to as *featurization*) - data is prepared for modeling using techniques such as:
    - **Feature selection** - features that are considered most likely to help predict the label (or separate the data well when clustering) are identified for use in model training - others are discarded.
    - **Feature engineering** - New features are derived from existing features - for example by splitting a date field into separate day, month, and year features.
    - **Data cleansing** - Missing values, outliers, and errors are mitigated - sometimes by replacing them with default or interpolated values, sometimes by discarding rows from the dataset.
    - **Data normalization** - Numeric features on different scales are often normalized to the same scale so that features with large values don't dominate model training.
    - **Categorical encoding** - features that are *categorical* (in  other words, they represent a category rather than a numeric value) are encoded as numeric indicators.
- **Model training and evaluation** - An appropriate algorithm is applied to a subset of the data to *fit* it to a model (in other words, determine a function that will be applied to the features). Another subset is then used to evaluate the trained model against an appropriate *evaluation metric*, which measures how well the model predicts.
- **Model Deployment** - The trained model is deployed as a service that applications can use to infer predictions from new feature data.
- **Model Management** - The model is documented and stored, and iteratively retrained with new data to improve its predictive performance.

As you can see, machine learning involves a lot of work, much of it time-consuming. In the subsequent units in this module, you'll learn how Azure Machine Learning can help simplify some of the tasks and reduce the time it takes to prepare data, train a model, and deploy a predictive service.
