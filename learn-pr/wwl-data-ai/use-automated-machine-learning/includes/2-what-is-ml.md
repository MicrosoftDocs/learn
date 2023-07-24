Machine learning is a technique that uses mathematics and statistics to create a model that can predict unknown values. 

![Illustration of Adventure Works cycle rental company on a cloudy summer day.](../media/adventure-works.png)

For example, suppose *Adventure Works Cycles* is a business that rents cycles in a city. The business could use historic data to train a model that predicts daily rental demand in order to make sure sufficient staff and cycles are available.

To do this, Adventure Works could create a machine learning model that takes information about a specific day (the day of week, the anticipated weather conditions, and so on) as an input, and predicts the expected number of rentals as an output.

Mathematically, you can think of machine learning as a way of defining a function (let's call it ***f***) that operates on one or more *features* of something (which we'll call ***x***) to calculate a predicted *label* (***y***) - like this:

> ***f(x) = y***

In this bicycle rental example, the details about a given day (day of the week, weather, and so on) are the *features* (***x***), the number of rentals for that day is the *label* (***y***), and the function (***f***) that calculates the number of rentals based on the information about the day is encapsulated in a machine learning model.

The specific operation that the ***f*** function performs on *x* to calculate *y* depends on a number of factors, including the type of model you're trying to create and the specific algorithm used to train the model. Additionally in most cases, the data used to train the machine learning model requires some pre-processing before model training can be performed.

## Types of machine learning 

There are two general approaches to machine learning, supervised and unsupervised machine learning. In both approaches, you train a model to make predictions. 
    
The **supervised machine learning** approach requires you to start with a dataset *with* known label values. Two types of supervised machine learning tasks include regression and classification. 
- **Regression**: used to predict a continuous value; like a price, a sales total, or some other measure.
- **Classification**: used to determine a class label; an example of a binary class label is whether a patient has diabetes or not; an example of multi-class labels is classifying text as positive, negative, or neutral. 

The **unsupervised machine learning** approach starts with a dataset *without* known label values. One type of unsupervised machine learning task is clustering. 
- **Clustering**: used to determine labels by grouping similar information into label groups; like grouping measurements from birds into species. 

The following video discusses the various kinds of machine learning model you can create, and the process generally followed to train and use them.

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4xAok]

