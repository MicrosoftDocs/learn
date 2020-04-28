
Let's plot out the data to see the relationship between per-capita GDP and female life expectancy.

```python

```

The output is:

```Output
TBD
```

plt.scatter(df['ppgdp'], df['lifeExpF'], alpha=0.3);

> **Technical note:** The `alpha` parameter we supplied in the matplotlib `scatter` function; it makes the points semi-transparent so that we can where data points bunch up. Also note the semicolon at the end of the code snippet above; it silences the matplotlib memory-path output for cleaner inline graphing (without additional output above the graph, such as `<matplotlib.collections.PathCollection at 0x7f2c54737f28>`).

Let's now plot a line and see what we get.

```python

```

The output is:

```Output
TBD
```

model = LinearRegression(fit_intercept=True)

X = df['ppgdp'][:, np.newaxis]
y = df['lifeExpF']

model.fit(X, y)

x_plot = np.linspace(0, 100000, 1000)
y_plot = model.predict(x_plot[:, np.newaxis])

plt.scatter(df['ppgdp'], df['lifeExpF'], alpha=0.3)
plt.plot(x_plot, y_plot, c='orange');

> **Technical note:** Notice in the code cell above that we did not fit the model using `model.fit(df['ppgdp'], df['lifeExpF'])`. Instead, we had to use `df['ppgdp'][:, np.newaxis]` for our predictors rather than just `df['ppgdp']`. The addition of `[:, np.newaxis]` changes `df['ppgdp']` from a pandas `Series` to an array in matrix format. (If you're unsure what that looks like, create a new code cell below this cell using **Insert > Insert Cell Below** and then run `df['ppgdp']` and then `df['ppgdp'][:, np.newaxis]` in order to see the difference.

Just how poor is this initial model? Let's calculate the ![$R^2$](https://render.githubusercontent.com/render/math?math=R%5E2&mode=inline) score for it to see. The ![$R^2$](https://render.githubusercontent.com/render/math?math=R%5E2&mode=inline) score (also called the [coefficient of determination](https://en.wikipedia.org/wiki/Coefficient_of_determination)) represents the proportion of the variance in our response that is predictable from the predictors -- so 0 is the worst (a model explains none of the variance) and 1 is the best (a model explains all of it).

```python

```

The output is:

```Output
TBD
```

from sklearn.metrics import r2_score

model = LinearRegression(fit_intercept=True)

model.fit(df['ppgdp'][:, np.newaxis], df['lifeExpF'])

predictions = model.predict(df['ppgdp'][:, np.newaxis])
r2_score(df['lifeExpF'], predictions)

This first model accounts for only 30 percent of the variability in `lifeExpF` and is really not a very good representation of the relationship between economic activity and female life expectancy.

These results are not good, which stems from the fact that there is no linear relationship between per-capita GDP and female life expectancy. Instead, the relationship has an elbow-like curve to it. When countries are very poor, the data suggests that even modest increases to GDP per capita can dramatically increase female life expectancy, but only up to a point; once countries hit about USD 10,000 per head, additional gains correlated to increases in wealth are much smaller. This suggests a logarithmic relationship between these factors: female life expectancy being not related to GPD, but to its logarithm.

Let's create a new column that contains the logarithm of per-capita GDP by country. Note that, because we are dealing with powers of 10 in the GDP column, we will use the base-10 logarithm rather than the natural logarithm in order to make interpretation easier.

```python

```

The output is:

```Output
TBD
```

df['log_ppgdp'] = np.log10(df['ppgdp'])
df.head()

Let's now plot our new `log_ppgdp` column against `lifeExpF` to see if there is a more linear relationship.

```python

```

The output is:

```Output
TBD
```

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

This is much better, but it is still far from perfect. The shape of the data seems to have a curve to it and we will examine how to deal with that shortly. However, let's first interpret the model have right here to see what it tells us. How much better is it than the first model? Let's look at the ![$R^2$](https://render.githubusercontent.com/render/math?math=R%5E2&mode=inline) score.

```python

```

The output is:

```Output
TBD
```

model.fit(df['log_ppgdp'][:, np.newaxis], df['lifeExpF'])

predictions = model.predict(df['log_ppgdp'][:, np.newaxis])
r2_score(df['lifeExpF'], predictions)

Using `log_ppgdp` rather than `ppgdp` in the model roughly doubles the amount of variance in `lifeExpF` that we can account for with this model (to 60 percent). But what does our model actually mean?

```python

```

The output is:

```Output
TBD
```

print("Model slope:    ", model.coef_[0])
print("Model intercept:", model.intercept_)

Remember that in high school algebra lines were generally defined by an equation of the form

![$$
y = ax + b
$$](https://render.githubusercontent.com/render/math?math=y%20%3D%20ax%20%2B%20b&mode=display)

where ![$a$](https://render.githubusercontent.com/render/math?math=a&mode=inline) is the *slope* and ![$b$](https://render.githubusercontent.com/render/math?math=b&mode=inline) is the *intercept*. That samer terminology applies in linear regression. The slope refers to our model's predicted change in units of female life expectancy (years) for each unit of the base-10 logarithm of per-capita GDP. In other words, our model predicts that, on average, women's life expectancies increase by 11.6 years every time per-capita GDP increases 10 fold.

The intercept is a little more abstract because it is not directly tied to any data point. It shows the value of the ![$y$](https://render.githubusercontent.com/render/math?math=y&mode=inline)-axis at the point where our line crossed that axis (where ![$x=0$](https://render.githubusercontent.com/render/math?math=x%3D0&mode=inline)). If we were still modeling `ppgdp` versus `lifeExpF`, we might interpret the intercept as representing women's baseline life expectancy in a hypothetical country with a per-capita GDP of USD 0: 29.8 years. However, we are modeling `log_ppgdp` versus `lifeExpF`, and the logarithm of 0 is undefined. Therefore, it can be easiest to accept the intercept in our model as a mathematical abstraction necessary to making other parts of our model work. Our model can be stated as:

![$$
{\rm lifeExpF} = 11.6 \times {\rm log\_ppgdp} + 29.8
$$](https://render.githubusercontent.com/render/math?math=%7B%5Crm%20lifeExpF%7D%20%3D%2011.6%20%5Ctimes%20%7B%5Crm%20log%5C_ppgdp%7D%20%2B%2029.8&mode=display)

TBD

### Try it yourself

TBD

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  The input is:

  ```python
  ```

  The output is:

  The output is:

```Output
  ```

</details>

<br /><br />

***


> [!div class="alert is-tip"]
> ### Takeaway
>
>The performance of our naive Bayes model helps underscore the algorithm's popularity, particularly for spam detection. Even untuned, we got good performance, performance that would only continue to improve in production as users submitted more examples of spam messages.
>

