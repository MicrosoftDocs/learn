<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

Let's make a prediction. Let's feed everything into a linear model. We'll include the:

- Average area income.
- Average area house age.
- Average area number of rooms.
- Average area number of bedrooms.
- Area population.

Then we'll see how well knowing those factors can help us predict the price of a home.

We'll make our first five columns the $X$ (our predictors). We'll make the **Price** column the $Y$ (our response):

```python
X = df.iloc[:,:5]
y = df['Price']
```

We could use all of our data to create our model. But all that gets us is a model that's good at predicting itself. Not only would that leave us with no objective way to measure how good the model is, but it would also likely lead to a model that was less accurate when used on new data. Such a model is termed _overfitted_.

To avoid an overfitted model, data scientists divide their datasets for machine learning into _training_ data and _test_ data. Training data is the data used to fit the model. Test data is used to evaluate how accurate the model is. Fortunately, scikit-learn provides the `train_test_split` function that we can use to easily divide up our data between training and test sets. In this case, we'll use 70 percent of our data for training and reserve 30 percent of it for testing.

You'll also supply a fourth parameter to the function, which is random_state. The parameter `train_test_split` randomly divides up our data between test and training. This number provides an explicit seed for the random-number generator so that you'll get the same result each time you run this code snippet.

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

```Output
LinearRegression(copy_X=True, fit_intercept=True, n_jobs=1, normalize=False)
```

