Train an SVM model
The next task is to train an SVM model to do image classification using the faces in the dataset. Let's start by splitting the dataset so 80% can be used for training and 20% for testing.

```python
from sklearn.model_selection import train_test_split

x_train, x_test, y_train, y_test = train_test_split(faces.data, faces.target, train_size=0.8, random_state=42)
/home/nbuser/anaconda3_501/lib/python3.6/site-packages/sklearn/model_selection/_split.py:2179: FutureWarning: From version 0.21, test_size will always complement train_size unless both are specified.
  FutureWarning)
```

Now let's create an SVM classifier and train it using the 80% of the dataset reserved for training.

```python
from sklearn.svm import SVC

model = SVC(class_weight='balanced', gamma='auto')
model.fit(x_train, y_train)
Out[5]:
SVC(C=1.0, cache_size=200, class_weight='balanced', coef0=0.0,
  decision_function_shape='ovr', degree=3, gamma='auto', kernel='rbf',
  max_iter=-1, probability=False, random_state=None, shrinking=True,
  tol=0.001, verbose=False)
```

Next, let's use the 20% of the dataset set aside for testing to assess the accuracy of the model.

```python
model.score(x_test, y_test)
```

```python
0.4649122807017544
```

That's not very encouraging. But we're far from done.

SVM can use several types of kernels to fit a mathematical model to a dataset. The default kernel type is one called the radial-basis function, which scikit-learn abbreviates 'rbf'. You can specify the kernel type with the SVC function's kernel parameter. Other common values include 'linear', 'poly', and 'sigmoid'. It could be that another kernel type would fit the data better. But there's something else that might help, too. That "something else" is Principal Component Analysis, also known as PCA.


