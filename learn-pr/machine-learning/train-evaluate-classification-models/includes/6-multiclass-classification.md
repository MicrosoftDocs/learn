It's also possible to create *multiclass* classification models, in which there are more than two possible classes. For example, the health clinic might expand the diabetes model to classify patients as:

* Non-diabetic
* Type-1 diabetic
* Type-2 diabetic

The individual class probability values would still add up to a total of 1 as the patient is definitely in only one of the three classes, and the most probable class would be predicted by the model.

## Using Multiclass classification models

Multiclass classification can be thought of as a combination of multiple binary classifiers. There are two ways in which you approach the problem:

* **One vs Rest (OVR)**, in which a classifier is created for each possible class value, with a positive outcome for cases where the prediction is this class, and negative predictions for cases where the prediction is any other class. For example, a classification problem with four possible shape classes (square, circle, triangle, hexagon) would require four classifiers that predict:
  * square or not
  * circle or not
  * triangle or not
  * hexagon or not
* **One vs One (OVO)**, in which a classifier for each possible pair of classes is created. The classification problem with four shape classes would require the following binary classifiers:
  * square or circle
  * square or triangle
  * square or hexagon
  * circle or triangle
  * circle or hexagon
  * triangle or hexagon

In both approaches, the overall model must take into account all of these predictions to determine which single category the item belongs to.

Fortunately, in most machine learning frameworks, including Scikit-Learn, implementing a multiclass classification model isn't significantly more complex than binary classification - and in most cases, the estimators used for binary classification implicitly support multiclass classification by abstracting an OVR algorithm, an OVO algorithm, or by allowing a choice of either.
