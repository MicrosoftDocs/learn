<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

Let's make a prediction. Let's feed everything into a linear model (average area income, average area house age, average area number of rooms, average area number of bedrooms, and area population) and see how well knowing those factors can help us predict the price of a home.

To do this, we will make our first five columns the $X$ (our predictors), and the **Price** column the $Y$ (our response):

```python
X = df.iloc[:,:5]
y = df['Price']
```

Now, we could use all of our data to create our model. However, all that would get us is a model that is good at predicting itself. Not only would that leave us with no objective way to measure how good the model is, it would also likely lead to a model that was less accurate when used on new data. Such a model is termed _overfitted_.

To avoid this, data scientists divide their datasets for ML into _training_ data (the data used to fit the model) and _test_ data (data used to evaluate how accurate the model is). Fortunately, scikit-learn provides a function that enables us to easily divide up our data between training and test sets: `train_test_split`. In this case, we will use 70 percent of our data for training and reserve 30 percent of it for testing. (Note that you will also supply a fourth parameter to the function: random_state; `train_test_split` randomly divides up our data between test and training, so this number provides an explicit seed for the random-number generator so that you will get the same result each time you run this code snippet.)

```python
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.3,random_state=54)
```

All that's left now is to import our linear regression algorithm and fit our model based on our training data:

```python
from sklearn.linear_model import LinearRegression
reg = LinearRegression()

reg.fit(X_train,y_train)
```

The output is:

```output
LinearRegression(copy_X=True, fit_intercept=True, n_jobs=1, normalize=False)
```
