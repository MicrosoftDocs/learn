Currently, we are using a randomly selected 20% of the faces in the dataset to test the model and quantify its accuracy. Unfortunately, you can (and almost always will) get different results depending on which 20% of the dataset you select. For a more reliable measure of accuracy, you can cross-validate the model by training it several times, each time using different subsets of the original dataset for training and testing, and averaging the scores from each run. (This is precisely what GridSearchCV does when evaluating the effect of different parameter combinations.) scikit's cross_validate function makes this easy. Let's finish up by using it to measure the accuracy of our model. We'll divide the original dataset into five folds and train the model five times, each time using a different fold for testing and the remaining folds for training.

In [15]:
from sklearn.model_selection import cross_validate

scores = cross_validate(model, faces.data, faces.target, cv=5)
print(scores['test_score'].mean())
0.8850918369413338
Is the cross-validated score higher or lower than the score returned by the model's score method? Regardless, the CV score is probably a more accurate indicator of how well the model will respond to faces it hasn't seen before. And to a data scientist, accuracy is everything.