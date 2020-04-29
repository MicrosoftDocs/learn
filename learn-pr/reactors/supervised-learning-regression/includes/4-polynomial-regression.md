
We can generalize the line equation above in the form favored by statisticians:

![$$
y = β_0 + β_1x + \epsilon
$$](https://render.githubusercontent.com/render/math?math=y%20%3D%20%CE%B2_0%20%2B%20%CE%B2_1x%20%2B%20%5Cepsilon&mode=display)

where ![$\epsilon$](https://render.githubusercontent.com/render/math?math=%5Cepsilon&mode=inline) is an unobserved random error that we generally fold into ![$β_0$](https://render.githubusercontent.com/render/math?math=%CE%B2_0&mode=inline). Nothing says that we can have only one ![$x$](https://render.githubusercontent.com/render/math?math=x&mode=inline) term, however. We can define a linear model for our data of the form

![$$
y = β_0 + β_1x + β_2x^2 + \epsilon
$$](https://render.githubusercontent.com/render/math?math=y%20%3D%20%CE%B2_0%20%2B%20%CE%B2_1x%20%2B%20%CE%B2_2x%5E2%20%2B%20%5Cepsilon&mode=display)

This is still a linear relationship because none of our ![$\beta$](https://render.githubusercontent.com/render/math?math=%5Cbeta&mode=inline)s ever multiply or divide each other. In fact, we can generalize linear models to the form

![$$
y = β_0 + β_1x + β_2x^2 + β_3x^3 + \cdots + β_nx^n + \epsilon
$$](https://render.githubusercontent.com/render/math?math=y%20%3D%20%CE%B2_0%20%2B%20%CE%B2_1x%20%2B%20%CE%B2_2x%5E2%20%2B%20%CE%B2_3x%5E3%20%2B%20%5Ccdots%20%2B%20%CE%B2_nx%5En%20%2B%20%5Cepsilon&mode=display)

The linearity of our models depend on the linearity of ![$β_n$](https://render.githubusercontent.com/render/math?math=%CE%B2_n&mode=inline), not ![$x_n$](https://render.githubusercontent.com/render/math?math=x_n&mode=inline). We will use this fact to use linear regression to model data that does not follow a straight line. Let's apply this to our model of `log_ppgdp` and `lifeExpF`.

```python
from sklearn.preprocessing import PolynomialFeatures

poly = PolynomialFeatures(degree=2)

X = df['log_ppgdp'][:, np.newaxis]
y = df['lifeExpF']
x_min = df['log_ppgdp'].min()
x_max = df['log_ppgdp'].max()
x_plot = np.linspace(x_min, x_max, 1000)
x_fit = poly.fit_transform(x_plot[:, np.newaxis])
X_ = poly.fit_transform(X)

poly_model = LinearRegression(fit_intercept=True)
poly_model.fit(X_, y)

x_fit[:, np.newaxis]
y_fit = poly_model.predict(x_fit)

plt.scatter(df['log_ppgdp'], df['lifeExpF'], alpha=0.3)
plt.plot(x_fit[:,1], y_fit, c='orange');
```

The output is:

```Output
TBD
```

Adding the polynomial term provides us with a much more intuitive fit of the data! The `degree=2` parameter that we supply to the `PolynomialFeatures` function dictates that our model takes the form of

![$$
y = β_0 + β_1x + β_2x^2
$$](https://render.githubusercontent.com/render/math?math=y%20%3D%20%CE%B2_0%20%2B%20%CE%B2_1x%20%2B%20%CE%B2_2x%5E2&mode=display)

Let's see what the coefficients for our model are.

```python
poly = PolynomialFeatures(degree=2)

X = df['log_ppgdp'][:, np.newaxis]
y = df['lifeExpF']
x_min = df['log_ppgdp'].min()
x_max = df['log_ppgdp'].max()
x_plot = np.linspace(x_min, x_max, 1000)
x_fit = poly.fit_transform(x_plot[:, np.newaxis])
X_ = poly.fit_transform(X)

poly_model = LinearRegression(fit_intercept=True)
poly_model.fit(X_, y)

print("Model slope:    ", poly_model.coef_)
print("Model intercept:", poly_model.intercept_)
```

The output is:

```Output
TBD
```

> [!NOTE]
> The code cell above is intentionally redundant. The last two lines of code in it would suffice to print the fitted model's slope and intercept coefficients. However, inline graphing in Jupyter notebooks can be finicky; the entire code snippet necessary to fit the model is given so that a student unable to run the visualization will nonetheless be able to continue on with follow-on portions of the section dealing with the same model.

We can state our polynomial model as

![$$
{\rm lifeExpF} = -6.5 + 32.1 \times {\rm log\_ppgdp} - 2.8 \times {\rm log\_ppgdp}^2
$$](https://render.githubusercontent.com/render/math?math=%7B%5Crm%20lifeExpF%7D%20%3D%20-6.5%20%2B%2032.1%20%5Ctimes%20%7B%5Crm%20log%5C_ppgdp%7D%20-%202.8%20%5Ctimes%20%7B%5Crm%20log%5C_ppgdp%7D%5E2&mode=display)

Using the polynomial model improves predictive power, but it comes at the cost of interpretability. What is the intuitive relationship between `lifeExpF` and `log_ppgdp` now?

> [!NOTE]
> Fitting the polynomial-regression model above has a lot of steps in it, and performing these transformations (transforming the features for polynomial regression and fitting the regression model) manually can quickly become tedious and error prone. To streamline this type of processing, scikit-learn provides the `Pipeline` object, which you can use to encapsulate several transformations into one step. Let's run this model again using scikit-learn `make_pipeline()`.

```python
from sklearn.pipeline import make_pipeline

poly_model = make_pipeline(PolynomialFeatures(2),
                           LinearRegression())

X = df['log_ppgdp'][:, np.newaxis]
y = df['lifeExpF']
poly_model.fit(X, y)
x_min = df['log_ppgdp'].min()
x_max = df['log_ppgdp'].max()
x_plot = np.linspace(x_min, x_max, 1000)
y_plot = poly_model.predict(x_plot[:, np.newaxis])

plt.scatter(df['log_ppgdp'], df['lifeExpF'], alpha=0.3)
plt.plot(x_plot, y_plot, c='orange');
```

The output is:

```Output
TBD
```

That was much simpler to code! But how much did going through the work doing the polynomial regression help our model?

```python

poly_model = make_pipeline(PolynomialFeatures(2),
                           LinearRegression())
poly_model.fit(df['log_ppgdp'][:, np.newaxis], df['lifeExpF'])

predictions = poly_model.predict(df['log_ppgdp'][:, np.newaxis])
r2_score(df['lifeExpF'], predictions)
```

The output is:

```Output
TBD
```

Our improved, polynomial model now accounts for 61.4 percent of the variance in `lifeExpF`. Clearly an improvement, but a modest one.

### Try it yourself

Go to the code cell in which we fitted the polynomial model using `make_pipeline()` and try different values (>2) in `PolynomialFeatures` to see what using higher-degree polynomials does for our model.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Here is a comparison of the outputs for models using three-degree, four-degree, and five-degree polynomials.

```python
colors = ['teal', 'yellowgreen', 'gold']

x_min = df['log_ppgdp'].min()
x_max = df['log_ppgdp'].max()
x_plot = np.linspace(x_min, x_max, 1000)

plt.scatter(df['log_ppgdp'], df['lifeExpF'], alpha=0.3, c='gray')

for count, degree in enumerate([3, 4, 5]):
    model = make_pipeline(PolynomialFeatures(degree),
                         LinearRegression())
    X = df['log_ppgdp'][:, np.newaxis]
    y = df['lifeExpF']
    model.fit(X, y)
    y_plot = model.predict(x_plot[:, np.newaxis])
    plt.plot(x_plot, y_plot, color=colors[count],
             linewidth=2, label="Degree %d" % degree)

plt.legend(loc='lower right')

plt.show();
```

The output is:

```Output
TBD
```

</details>

<br /><br />

***

Let's see what the ![$R^2$](https://render.githubusercontent.com/render/math?math=R%5E2&mode=inline) scores for the different-degree polynomial models are.

```python
for count, degree in enumerate([3, 4, 5]):
    model = make_pipeline(PolynomialFeatures(degree),
                         LinearRegression())
    X = df['log_ppgdp'][:, np.newaxis]
    y = df['lifeExpF']
    model.fit(X, y)
    predictions = model.predict(X)
    print("Degree %d" % degree, "r-squared score:",
          r2_score(df['lifeExpF'], predictions))
```

The output is:

```Output
TBD
```

Each additional polynomial degree improves the fit of our model (as demonstrated by the incremental improvements to the r-squared scores). However, adding more degrees to the polynomial regressions opens us to the risk of [overfitting](https://en.wikipedia.org/wiki/Overfitting), a process by which our models come to fit the training data too closely and are thus less useful in predicting more generalized data.

Higher-degree polynomials also bring back the [curse of dimensionality](https://en.wikipedia.org/wiki/Curse_of_dimensionality). Simple linear models need only ![$N + 1$](https://render.githubusercontent.com/render/math?math=N%20%2B%201&mode=inline) sample points to fit, where ![$N$](https://render.githubusercontent.com/render/math?math=N&mode=inline) is the number of dimensions (2 points in 1 dimension, 3 in 2 dimensions, 4 in three dimensions, and so on). However, each additional polynomial degree increases the number of sample points required for a given dimensionality much faster. Particularly if certain data points are difficult or expensive to come by, you might run out of data in order to fit a high-degree polynomial model.
