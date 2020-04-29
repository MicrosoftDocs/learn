
Ultimately, no matter how complex the model we construct between `log_ppgdp` and `lifeExpF`, we will only be able to explain so much of variability because factors other than per-capita GDP affect female life expectancy. Using more than one predictor in our regression model helps us capture more of this richness of detail.

Let's start by plotting the relationship between log per-capita GDP, urbanization, and female life expectancy in three dimensions.

> [!NOTE]
> We reimport matplotlib to work around a know issue in switching between `%matplotlib inline` and `%matplotlib notebook`. If the scatterplot does not render the first time, run the code cell again. You might also have to click in the figure in order to get it to render.

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

```Output
TBD
```

Go ahead and move this figure around! It's interactive.

Let's fit a simple, multi-dimensional model to examine this relationship.

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

```Output
TBD
```

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
TBD
```

This model explains 59.8 percent of the variance in `lifeExpF`: better than our initial simple linear model (![$R^2=$](https://render.githubusercontent.com/render/math?math=R%5E2%3D&mode=inline) 0.596), but not spectacularly so.

What does this new model mean?

```python
print("Model slopes:    ", model.coef_)
print("Model intercept:", model.intercept_)
```

The output is:

```Output
TBD
```

Our model now has two predictors in it, so it takes the generalized form:

![$$
y = β_0 + β_1x_1 + β_2x_2
$$](https://render.githubusercontent.com/render/math?math=y%20%3D%20%CE%B2_0%20%2B%20%CE%B2_1x_1%20%2B%20%CE%B2_2x_2&mode=display)

Specifically, our model is:

![$$
{\rm lifeExpF} = 30.7 + 11 \times {\rm log\_ppgdp} + 0.023 \times {\rm pctUrban}
$$](https://render.githubusercontent.com/render/math?math=%7B%5Crm%20lifeExpF%7D%20%3D%2030.7%20%2B%2011%20%5Ctimes%20%7B%5Crm%20log%5C_ppgdp%7D%20%2B%200.023%20%5Ctimes%20%7B%5Crm%20pctUrban%7D&mode=display)

Multiple regression is a little trickier to interpret than simple regression, but not enormously so. Our model says that if we were to hold all other factors equal, then increasing the per-capita GDP of a country 10 fold will (on average) add 11 years to women's life expectancy. It also says that if we keep everything else the same, then increasing the urbanization of a country by 1 percent will increase women's life expectancy by 0.023 years. (Remember that we can't think of the intercept as representing a hypothetical baseline country with USD0 GDP and 0 urbanization, because the logarithm of 0 is undefined.) This is another way of showing that adding `pctUrban` to our model provides some additional predictive power to our simple model, but not much. But does it do anything if we add it to a polynomial model?

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

```Output
TBD
```

Let's take a look at the ![$R^2$](https://render.githubusercontent.com/render/math?math=R%5E2&mode=inline) for this model.

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
TBD
```

In the polynomial regression, adding `pctUrban` to our model provides a decent improvement to our model's predictive power (for example, this model's ![$R^2$](https://render.githubusercontent.com/render/math?math=R%5E2&mode=inline) score is higher than those that we got with our two-degree, three-degree, or four-degree models using just `log_ppgdp`).

More than just boosting the ![$R^2$](https://render.githubusercontent.com/render/math?math=R%5E2&mode=inline) score, fitting the multiple polynomial regression provides additional insights from the visualization. If you rotate the visualization above 180 degrees about the ![$z$](https://render.githubusercontent.com/render/math?math=z&mode=inline)-axis, you will notice that while our model predicts increased female life expectancy at high incomes, in poor countries, our model actually shows a *decrease* in female life expectancy in poor countries correlated with increased urbanization.

All of these conclusions come from a model that treats all of the data as coming from a rather monolithic whole. We have other types of data that we can also use in our modeling to try and arrive at different insights.
