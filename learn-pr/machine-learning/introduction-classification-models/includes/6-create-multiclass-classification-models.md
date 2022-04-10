It's also possible to create *multiclass* classification models, in which there are more than two possible classes. For example, the health clinic might expand the diabetes model to classify patients as:

- Non-diabetic
- Type-1 diabetic
- Type-2 diabetic

The individual class probability values would still add up to a total of 1, because a patient can fall into only one of the three classes, and the most probable class would be predicted by the model.

## About multiclass classification models

Multiclass classification can be thought of as a combination of multiple binary classifiers. There are two ways in which you can approach the problem:

**One-vs-Rest (OVR)**, in which a classifier is created for each possible class value, with a positive outcome for cases where the prediction is a certain class, and a negative outcome for cases where the prediction is any other class. For example, a classification problem with four possible shape classes (*square*, *circle*, *triangle*, *hexagon*) would require four classifiers that predict:

- Square or not
- Circle or not
- Triangle or not
- Hexagon or not

**One-vs-One (OVO)**, in which a classifier for each possible pair of classes is created. The classification problem with four shape classes would require the following binary classifiers:

- Square or circle
- Square or triangle
- Square or hexagon
- Circle or triangle
- Circle or hexagon
- Triangle or hexagon

In both approaches, the overall model must take into account all these predictions to determine which single category the item belongs to.

Fortunately, in most machine-learning frameworks, including tidymodels, implementing a multiclass classification model is not significantly more complex than implementing a binary classification.
