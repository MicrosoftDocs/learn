<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

No matter how complex the model we construct between `log_ppgdp` and `lifeExpF`, we won't be able to explain all of the variability. The reason is that factors other than per-capita GDP affect female life expectancy. Using more than one predictor in our regression model helps us capture more of this richness of detail.

Let's start by plotting the relationship between log per-capita GDP, urbanization, and female life expectancy in three dimensions.

> [!NOTE]
> We reimport matplotlib to work around a known issue in switching between `%matplotlib inline` and `%matplotlib notebook`. If the scatterplot isn't rendered the first time, run the code cell again. You might also have to click in the figure to have the scatterplot rendered.

```python
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
%matplotlib notebook

fig = plt.figure(figsize=(6,6))
ax = fig.add_subplot(111, projection='3d')
ax.scatter(df['log_ppgdp'], df['pctUrban'], df['lifeExpF'])

ax.set_xlabel('GDP per capita (log)')
ax.set_ylabel('Percent urbanized')
ax.set_zlabel('Life expectancy (years)')

plt.show();
```

The output is:

> [!div class="alert is-tip"]
> Output

:::image type="content" source="..\media\ppgdp-lifeexpf-purban-3d.svg" alt-text="Scatter plot output":::

***

Go ahead and move this figure around! It's interactive.

Let's fit a simple, multidimensional model to examine this relationship.

```python
model = LinearRegression(fit_intercept=True)

X = df[['log_ppgdp', 'pctUrban']]
y = df['lifeExpF']

model.fit(X, y)

x1_plot = np.linspace(df['log_ppgdp'].min(), df['log_ppgdp'].max(), 1000)
x2_plot = np.linspace(df['pctUrban'].min(), df['pctUrban'].max(), 1000)
X1_plot, X2_plot = np.meshgrid(x1_plot, x2_plot)
y_plot = model.predict(np.c_[X1_plot.ravel(), X2_plot.ravel()])

fig = plt.figure(figsize=(6,6))
ax = fig.add_subplot(111, projection='3d')
ax.scatter(df['log_ppgdp'], df['pctUrban'], df['lifeExpF'])
ax.plot_surface(X1_plot, X2_plot, y_plot.reshape(X1_plot.shape), cmap='viridis');

ax.set_xlabel('GDP per capita (log)')
ax.set_ylabel('Percent urbanized')
ax.set_zlabel('Life expectancy (years)')

plt.show();
```

The output is:

> [!div class="alert is-tip"]
> Output

:::image type="content" source="..\media\ppgdp-lifeexpf-purban-3d-model-linear-regression.svg" alt-text="Scatter plot output":::

***

How accurate is our multiple-regression model?

```python
model = LinearRegression(fit_intercept=True)

X = df[['log_ppgdp', 'pctUrban']]
y = df['lifeExpF']

model.fit(X, y)

predictions = model.predict(X)
r2_score(df['lifeExpF'], predictions)
```

The output is:

```Output
0.5976310585601522
```

This model explains 59.8 percent of the variance in `lifeExpF`. That's better than our initial simple linear model ($R^2=$ 0.596), but not spectacular.

What does this new model mean?

```python
print("Model slopes:    ", model.coef_)
print("Model intercept:", model.intercept_)
```

The output is:

```Output
Model slopes:     [10.96001505  0.02300815]
Model intercept: 30.67374430006005
```

Our model now has two predictors in it, so it takes this generalized form:

$$
y = β_0 + β_1x_1 + β_2x_2
$$

Specifically, our model is:

$$
{\rm lifeExpF} = 30.7 + 11 \times {\rm log\_ppgdp} + 0.023 \times {\rm pctUrban}
$$

Multiple regression is a little trickier to interpret than simple regression. Our model says that if we were to hold all other factors equal, then increasing the per-capita GDP of a country tenfold will (on average) add 11 years to women's life expectancy. It also says that if we keep everything else the same, then increasing the urbanization of a country by 1 percent will increase women's life expectancy by 0.023 years. (Remember that we can't think of the intercept as representing a hypothetical baseline country with USD 0 GDP and no urbanization, because the logarithm of 0 is undefined.) 

This is another way of showing that adding `pctUrban` to our model provides some additional predictive power to our simple model, but not much. Does it do anything if we add it to a polynomial model?

```python
poly_model = make_pipeline(PolynomialFeatures(2),
                           LinearRegression())

X = df[['log_ppgdp', 'pctUrban']]
y = df['lifeExpF']

poly_model.fit(X, y)

x1_plot = np.linspace(df['log_ppgdp'].min(), df['log_ppgdp'].max(), 1000)
x2_plot = np.linspace(df['pctUrban'].min(), df['pctUrban'].max(), 1000)
X1_plot, X2_plot = np.meshgrid(x1_plot, x2_plot)
y_plot = poly_model.predict(np.c_[X1_plot.ravel(), X2_plot.ravel()])

fig = plt.figure(figsize=(6,6))
ax = fig.add_subplot(111, projection='3d')
ax.scatter(df['log_ppgdp'], df['pctUrban'], df['lifeExpF'])
ax.plot_surface(X1_plot, X2_plot, y_plot.reshape(X1_plot.shape), cmap='viridis');

ax.set_xlabel('GDP per capita (log)')
ax.set_ylabel('Percent urbanized')
ax.set_zlabel('Life expectancy (years)')

plt.show();
```

The output is:

:::image type="content" source="..\media\ppgdp-lifeexpf-purban-3d-model-polynomial.svg" alt-text="Scatter plot output":::

***

Let's look at the $R^2$ for this model.

```python
poly_model = make_pipeline(PolynomialFeatures(2),
                           LinearRegression())

X = df[['log_ppgdp', 'pctUrban']]
y = df['lifeExpF']

poly_model.fit(X, y)

predictions = poly_model.predict(X)
r2_score(df['lifeExpF'], predictions)
```

The output is:

```Output
0.6171027296858922
```

In the polynomial regression, adding `pctUrban` to our model provides a decent improvement to our model's predictive power. For example, this model's $R^2$ score is higher than the scores that we got with our two-degree, three-degree, or four-degree models using just `log_ppgdp`.

Beyond boosting the $R^2$ score, fitting the multiple polynomial regression provides insights from the visualization. Now rotate the visualization above 180 degrees about the $z$-axis. You'll notice that although our model predicts increased female life expectancy at high incomes, in poor countries, our model shows a *decrease* in female life expectancy correlated with increased urbanization.

All of these conclusions come from a model that treats all of the data as coming from a rather monolithic whole. We can use other types of data in our modeling to try to get different insights.
