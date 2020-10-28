<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

We can generalize a line equation in the form favored by statisticians:

$$
y = β_0 + β_1x + \epsilon
$$

In the equation, $\epsilon$ is an unobserved random error that we generally fold into $β_0$. Nothing says that we can have only one $x$ term, though. We can define a linear model for our data in this form:

$$
y = β_0 + β_1x + β_2x^2 + \epsilon
$$

This relationship is still linear because none of our $\beta$s ever multiply or divide each other. In fact, we can generalize linear models to this form:

$$
y = β_0 + β_1x + β_2x^2 + β_3x^3 + \cdots + β_nx^n + \epsilon
$$

The linearity of our models depends on the linearity of $β_n$, not $x_n$. We'll use this fact to use linear regression to model data that does not follow a straight line. Let's apply this to our model of `log_ppgdp` and `lifeExpF`.

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

> [!div class="alert is-tip"]
> Output

:::image type="content" source="..\media\ppgdp-lifeexpf-scatter-model-polynomial.svg" alt-text="Scatter plot output":::

***

Adding the polynomial term gives us a much more intuitive fit of the data. The `degree=2` parameter that we supply to the `PolynomialFeatures` function dictates that our model takes this form:

$$
y = β_0 + β_1x + β_2x^2
$$

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
Model slope:     [ 0.         32.14216588 -2.82047664]
Model intercept: -6.46143145541599
```

> [!NOTE]
> The preceding code cell is intentionally redundant. The last two lines of code in it would suffice to print the fitted model's slope and intercept coefficients. However, inline graphing in Jupyter notebooks can be finicky. We give the entire code snippet necessary to fit the model so that a student who can't run the visualization can continue with portions of the section that deal with the same model.

We can state our polynomial model as:

$$
{\rm lifeExpF} = -6.5 + 32.1 \times {\rm log\_ppgdp} - 2.8 \times {\rm log\_ppgdp}^2
$$

Using the polynomial model improves predictive power, but it comes at the cost of interpretability. What is the intuitive relationship between `lifeExpF` and `log_ppgdp` now?

> [!NOTE]
> Fitting the polynomial-regression model has a lot of steps. Performing these transformations (transforming the features for polynomial regression and fitting the regression model) manually can quickly become tedious and error prone. To streamline this type of processing, scikit-learn provides the `Pipeline` object, which you can use to encapsulate several transformations into one step. Let's run this model again by using `make_pipeline()` in scikit-learn.

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

> [!div class="alert is-tip"]
> Output

:::image type="content" source="..\media\ppgdp-lifeexpf-scatter-model-polynomial-pipeline.svg" alt-text="Scatter plot output":::

***

That was much simpler to code! But how much did going through the work of the polynomial regression help our model?

```python
poly_model = make_pipeline(PolynomialFeatures(2),
                           LinearRegression())
poly_model.fit(df['log_ppgdp'][:, np.newaxis], df['lifeExpF'])

predictions = poly_model.predict(df['log_ppgdp'][:, np.newaxis])
r2_score(df['lifeExpF'], predictions)
```

The output is:

```Output
0.6140796187140456
```

Our improved, polynomial model now accounts for 61.4 percent of the variance in `lifeExpF`. It's clearly an improvement, but a modest one.

### Try it yourself

Go to the code cell in which we fitted the polynomial model by using `make_pipeline()`. Try different values (>2) in `PolynomialFeatures` to see what using higher-degree polynomials does for our model.

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
  
  :::image type="content" source="..\media\ppgdp-lifeexpf-scatter-model-polynomial-multiple-degrees.svg" alt-text="Scatter plot output":::

</details>

<br /><br />

***

Let's see what the $R^2$ scores are for the different-degree polynomial models.

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
Degree 3 r-squared score: 0.6141421612388429
Degree 4 r-squared score: 0.6160520910424707
Degree 5 r-squared score: 0.6208416438555966
```

Each additional polynomial degree improves the fit of our model (as demonstrated by the incremental improvements to the r-squared scores). But adding more degrees to the polynomial regressions opens us to the risk of [overfitting](https://en.wikipedia.org/wiki/Overfitting?azure-portal=true). That's a process by which our models come to fit the training data too closely and become less useful in predicting more generalized data.

Higher-degree polynomials also bring back the [curse of dimensionality](https://en.wikipedia.org/wiki/Curse_of_dimensionality?azure-portal=true). Simple linear models need only $N + 1$ sample points to fit, where $N$ is the number of dimensions (2 points in one dimension, 3 points in two dimensions, 4 points in three dimensions, and so on). However, each additional polynomial degree increases the number of sample points required for a given dimensionality much faster. If certain data points are difficult or expensive to come by, you might run out of data in order to fit a high-degree polynomial model.
