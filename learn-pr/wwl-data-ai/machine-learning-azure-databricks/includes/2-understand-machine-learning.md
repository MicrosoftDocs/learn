
Machine learning is a programming technique used to create predictive models. Unlike typical programming, in which code is used to describe specific steps to produce an outcome; machine learning relies on the use of an *algorithm* to iteratively explore the relationship between the *features* of a data entity and the *label* the resulting model should predict. Machine learning algorithms are based on probability theory and statistics, and rely on large volumes of data with which to train the model.

At a simplistic level, a machine learning model is a *function* that takes the *features* of an observed entity (its characteristics) and performs a calculation on them to return a predicted *label*. It's common to refer in general to the features as **x** and the predicted label as **y**; so in effect, a machine learning model is the function ***f*** in the expression `y = f(x)`.

The specific operation that the function performs on the features in order to calculate a value for the label is determined by the algorithm used to train the model.

## Types of machine learning

Broadly speaking, there are two common kinds of machine learning:

- *Supervised* machine learning in which the model is trained using data that includes known label values (so an algorithm uses the existing data to establish a relationship between **x** and **y**, resulting in a function that can be applied to **x** to calculate **y**).
- *Unsupervised* machine learning in which the model is trained using only feature (**x**) values, and groups (or *clusters*) observations with similar features.

### Supervised machine learning

This module focuses on supervised machine learning as that's the most common scenario. Within the broad definition of supervised machine learning, there are two common kinds of machine learning algorithm:

- ***Regression*** algorithms in which the label is a numeric value, such as a price, temperature, amount, or other value that can be measured. Regression algorithms produce models in which the function (***f***) operates on the features (**x**) to calculate  the numeric value of the label (**y**).

    For example, a regression algorithm could be used to train a model that predicts the expected number of ice creams sold by a kiosk in a park on a given day based on features like the month of the year, the day of the week, the temperature, the humidity, and so on.

- ***Classification*** algorithms in which the label is a discrete category (or *class*). Classification algorithms produce models in which the function (***f***) operates on the features (**x**) to calculate a *probability* value for each possible class, and returns the label (**y**) for the class with the highest probability.

    For example, a classification algorithm could be used to train a model that predicts whether or not a patient has diabetes based on features like blood-insulin level, weight, height, age and so on. A classification model that identifies one of two possible classes (such as true or false) is an example of *binary* classification. Algorithms that predict probability for more than two classes (for example, differentiating between patients without diabetes, type 1 diabetes, or type 2 diabetes) are used for *multiclass* classification.

### Unsupervised machine learning

The most common form of unsupervised learning is ***clustering***, in which the features of data cases are considered as a vector of points in multidimensional space. The goal of a clustering algorithm is to define clusters that group the points so that cases with similar features are close together, but the clusters are clearly separated from one another.

Clustering is useful when you need to define different categories of data but you don't have pre-defined categories to which existing data observations are already assigned. For example, you might want to segment customers based on similarities in their profiles. Clustering can also be used as an initial step in building a classification solution - essentially, you use clustering to determine the appropriate classes for your data.
