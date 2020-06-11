<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

Let's plot out the data to see the relationship between per-capita GDP and female life expectancy.

```python
plt.scatter(df['ppgdp'], df['lifeExpF'], alpha=0.3);
```

The output is:

> [!div class="alert is-tip"]
> Output

:::image type="content" source="..\media\ppgdp-lifeexpf-scatter.svg" alt-text="Scatter plot output":::

***

> [!NOTE]
> We supplied the `alpha` parameter in the matplotlib `scatter` function. It makes the points semi-transparent so that we can where data points bunch up. 
>
> Also note the semicolon at the end of the preceding code snippet. It silences the matplotlib memory-path output for cleaner inline graphing (without additional output above the graph, such as `<matplotlib.collections.PathCollection at 0x7f2c54737f28>`).

Let's now plot a line and see what we get.

```python
model = LinearRegression(fit_intercept=True)

X = df['ppgdp'][:, np.newaxis]
y = df['lifeExpF']

model.fit(X, y)

x_plot = np.linspace(0, 100000, 1000)
y_plot = model.predict(x_plot[:, np.newaxis])

plt.scatter(df['ppgdp'], df['lifeExpF'], alpha=0.3)
plt.plot(x_plot, y_plot, c='orange');
```

The output is:

> [!div class="alert is-tip"]
> Output

:::image type="content" source="..\media\ppgdp-lifeexpf-scatter-model-fit.svg" alt-text="Scatter plot model fit output":::

***

> [!NOTE]
> In the preceding code cell, we didn't fit the model by using `model.fit(df['ppgdp'], df['lifeExpF'])`. We had to use `df['ppgdp'][:, np.newaxis]` for our predictors rather than just `df['ppgdp']`. The addition of `[:, np.newaxis]` changes `df['ppgdp']` from a pandas `Series` to an array in matrix format. (If you're unsure what that looks like, create a new code cell below this cell by using **Insert > Insert Cell Below**. Run `df['ppgdp']` and then `df['ppgdp'][:, np.newaxis]` to see the difference.

Just how poor is this initial model? Let's calculate the $R^2$ score for it to see. The $R^2$ score (also called the [coefficient of determination](https://en.wikipedia.org/wiki/Coefficient_of_determination?azure-portal=true)) represents the proportion of the variance in our response that is predictable from the predictors. So 0 is the worst (a model explains none of the variance) and 1 is the best (a model explains all of it).

```python
from sklearn.metrics import r2_score

model = LinearRegression(fit_intercept=True)

model.fit(df['ppgdp'][:, np.newaxis], df['lifeExpF'])

predictions = model.predict(df['ppgdp'][:, np.newaxis])
r2_score(df['lifeExpF'], predictions)
```

The output is:

```Output
0.30135661006266223
```

This first model accounts for only 30 percent of the variability in `lifeExpF` and is not a good representation of the relationship between economic activity and female life expectancy.

These results are not good because there is no linear relationship between per-capita GDP and female life expectancy. Instead, the relationship has an elbow-like curve. When countries are very poor, the data suggests that even modest increases to GDP per capita can dramatically increase female life expectancy, but only up to a point. After countries hit about USD 10,000 per capita, additional gains correlated to increases in wealth are much smaller. This suggests a logarithmic relationship between these factors: female life expectancy being not related to GDP, but to its logarithm.

Let's create a new column that contains the logarithm of per-capita GDP by country. Note that because we're dealing with powers of 10 in the GDP column, we'll use the base-10 logarithm rather than the natural logarithm to make interpretation easier.

```python
df['log_ppgdp'] = np.log10(df['ppgdp'])
df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | region | group | fertility | ppgdp | lifeExpF | pctUrban | log_ppgdp |
> | --- | --- | --- | --- | --- | --- | --- | --- |
> | 0 | Asia | other | 5.968 | 499.0 | 49.49 | 23 | 2.698101 |
> | 1 | Europe | other | 1.525 | 3677.2 | 80.40 | 53 | 3.565517 |
> | 2 | Africa | africa | 2.142 | 4473.0 | 75.00 | 67 | 3.650599 |
> | 3 | Africa | africa | 5.135 | 4321.9 | 53.17 | 59 | 3.635675 |
> | 4 | Caribbean | other | 2.000 | 13750.1 | 81.10 | 100 | 4.138306 |

Let's now plot our new `log_ppgdp` column against `lifeExpF` to see if there is a more linear relationship.

```python
model = LinearRegression(fit_intercept=True)

X = df['log_ppgdp'][:, np.newaxis]
y = df['lifeExpF']

model.fit(X, y)

x_min = df['log_ppgdp'].min()
x_max = df['log_ppgdp'].max()
x_plot = np.linspace(x_min, x_max, 1000)
y_plot = model.predict(x_plot[:, np.newaxis])

plt.scatter(df['log_ppgdp'], df['lifeExpF'], alpha=0.3)
plt.plot(x_plot, y_plot, c='orange');
```

The output is:

> [!div class="alert is-tip"]
> Output

:::image type="content" source="..\media\ppgdp-lifeexpf-scatter-model-linear-regression.svg" alt-text="Scatter plot model linear regression output":::

***

This is much better, but it's still far from perfect. The shape of the data seems to have a curve, and we'll examine how to deal with that shortly. Let's first interpret the model we have right here to see what it tells us. How much better is it than the first model? Let's look at the $R^2$ score.

```python
model.fit(df['log_ppgdp'][:, np.newaxis], df['lifeExpF'])

predictions = model.predict(df['log_ppgdp'][:, np.newaxis])
r2_score(df['lifeExpF'], predictions)
```

The output is:

```Output
0.5963834900027573
```

Using `log_ppgdp` rather than `ppgdp` roughly doubles the amount of variance in `lifeExpF` that we can account for with this model (to 60 percent). But what does our model actually mean?

```python
print("Model slope:    ", model.coef_[0])
print("Model intercept:", model.intercept_)
```

The output is:

```Output
Model slope:     11.556295659454959
Model intercept: 29.814802497051275
```

In algebra, lines are generally defined by an equation of this form:

$$y = ax + b
$$

In the equation, $a$ is the *slope* and $b$ is the *intercept*. That same terminology applies in linear regression. The slope refers to our model's predicted change in units of female life expectancy (years) for each unit of the base-10 logarithm of per-capita GDP. In other words, our model predicts that, on average, women's life expectancies increase by 11.6 years every time per-capita GDP increases tenfold.

The intercept is a little more abstract because it's not directly tied to any data point. It shows the value of the $y$-axis at the point where our line crossed that axis (where $x=0$). If we were still modeling `ppgdp` versus `lifeExpF`, we might interpret the intercept as representing women's baseline life expectancy in a hypothetical country with a per-capita GDP of USD 0: 29.8 years. However, we're modeling `log_ppgdp` versus `lifeExpF`, and the logarithm of 0 is undefined. 

It can be easiest to accept the intercept in our model as a mathematical abstraction necessary to make other parts of our model work. Our model can be stated as:

$$
{\rm lifeExpF} = 11.6 \times {\rm log\_ppgdp} + 29.8
$$
