A *logistic regression algorithm* is a regression model that is used when the response variable is categorical. For our purpose, you import the commonly used scikit-learn package to implement the algorithm.

Use the following code to run the logistic regression model and to print the model's accuracy. This may take a few minutes to finish executing. 

```python
from sklearn.linear_model import LogisticRegression

#load the model
clf = LogisticRegression()
#fit the model
clf.fit(X_train, y_train)

#evaluate the model by using a test set
y_hat = clf.predict(X_test)
#print the accuracy
print(np.average(y_hat == y_test))

print('Done')
```