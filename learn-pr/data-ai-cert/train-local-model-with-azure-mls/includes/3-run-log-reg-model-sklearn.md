A logistic regression algorithm is a regression model that is used when the response variable is categorical. For our purpose, you import the commonly-used Scikit-learn package to implement the algorithm.

Use the code below to run the logistic regression model and print the accuracy of the model.  This may take a few minutes to run.

```python
from sklearn.linear_model import LogisticRegression

#load model
clf = LogisticRegression()
#fit model
clf.fit(X_train, y_train)

#evaluate model using test set
y_hat = clf.predict(X_test)
#print the accuracy
print(np.average(y_hat == y_test))

print('Code executed')
```
