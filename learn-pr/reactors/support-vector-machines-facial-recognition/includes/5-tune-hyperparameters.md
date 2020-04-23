One way to find the optimum combination of parameters provided to a learning algorithm in scikit-learn is to use GridSearchCV, which trains the model multiple times with all the different combinations of parameters that you specify. Let's use GridSearchCV to find the optimum values for the SVM's C and gamma parameters, which have an important effect on SVM models that use an RBF kernel. C determines how tolerant the model is of misclassified data points during training. The higher the value of C, the more aggressive the model is at finding a classification boundary that minimizes the number of misclassified points. gamma controls the tightness of the fit to the training data. Generally speaking, lower values for C and gamma are preferred because higher values can lead to overfitting. Lower values typically produce a model that generalizes better.

We'll use GridSearchCV to find the C and gamma that work best together. Note that training will take longer now because since we're testing five different C values and seven different gamma values, the model will be trained 35 times. (Good thing we reduced the number of dimensions with PCA!)

```python
from sklearn.model_selection import GridSearchCV

params = {'svc__C': [0.01, 0.1, 1, 10, 100],
          'svc__gamma': [0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1]}

grid = GridSearchCV(model, params, cv=5)
grid.fit(x_train, y_train)
/home/nbuser/anaconda3_501/lib/python3.6/site-packages/sklearn/model_selection/_split.py:2053: FutureWarning: You should specify a value for 'cv' instead of relying on the default value. The default value will change from 3 to 5 in version 0.22.
  warnings.warn(CV_WARNING, FutureWarning)
/home/nbuser/anaconda3_501/lib/python3.6/site-packages/sklearn/model_selection/_search.py:841: DeprecationWarning: The default of the `iid` parameter will change from True to False in version 0.22 and will be removed in 0.24. This will change numeric results when test-set sizes are unequal.
  DeprecationWarning)
```

```output
GridSearchCV(cv='warn', error_score='raise-deprecating',
       estimator=Pipeline(memory=None,
     steps=[('pca', PCA(copy=True, iterated_power='auto', n_components=150, random_state=42,
  svd_solver='randomized', tol=0.0, whiten=True)), ('svc', SVC(C=1.0, cache_size=200, class_weight='balanced', coef0=0.0,
  decision_function_shape='ovr', degree=3, gamma='auto', kernel='rbf',
  max_iter=-1, probability=False, random_state=None, shrinking=True,
  tol=0.001, verbose=False))]),
       fit_params=None, iid='warn', n_jobs=None,
       param_grid={'svc__C': [0.01, 0.1, 1, 10, 100], 'svc__gamma': [0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1]},
       pre_dispatch='2*n_jobs', refit=True, return_train_score='warn',
       scoring=None, verbose=0)
```

Now let's find out what the optimum values for C and gamma are, and replace model with the optimized model.

```python
print(grid.best_params_)
model = grid.best_estimator_
{'svc__C': 1, 'svc__gamma': 0.005}
```

Finally, let's see if the optimized ("hypertuned") model does a better job of recognizing faces than our original model.

```python
model.score(x_test, y_test)
```

```output
0.9385964912280702
```


It appears that we improved the model's accuracy by about 2.5%. Let's print a classification report to get a more detailed assessment of the model's accuracy.

```python
from sklearn.metrics import classification_report

y_predicted = model.predict(x_test)
print(classification_report(y_test, y_predicted, target_names=faces.target_names))
                   precision    recall  f1-score   support

     Colin Powell       0.89      0.98      0.93        50
  Donald Rumsfeld       0.96      0.92      0.94        25
    George W Bush       0.98      0.94      0.96       106
Gerhard Schroeder       0.87      0.91      0.89        22
       Tony Blair       0.92      0.88      0.90        25

        micro avg       0.94      0.94      0.94       228
        macro avg       0.92      0.93      0.92       228
     weighted avg       0.94      0.94      0.94       228
```

For clarity, let's generate a confusion matrix to see how the model really performed during testing.

```python
from sklearn.metrics import confusion_matrix

mat = confusion_matrix(y_test, y_predicted)
sns.heatmap(mat.T, square=True, annot=True, fmt='d', cbar=False, cmap='Blues',
            xticklabels=faces.target_names,
            yticklabels=faces.target_names)
plt.xlabel('Actual label')
plt.ylabel('Predicted label')
```

```output```
Text(89.18, 0.5, 'Predicted label')
```

The model correctly identified Colin Powell 49 times out of 50, Donald Rumsfeld 23 times out of 25, and so on. That's not bad. And it's a great example of Support Vector Machines at work. It would be challenging, perhaps impossible, to do this well using more conventional learning algorithms such as logistic regression.

