
Our dataset has two categorical features (also known as *factors* in the statistical world): `region` and `group`. There are multiple ways of handling data like this in linear regression; here, we will handle it by building sub-models for it.

To begin moving in that analytical direction, let's start by color coding our 3D scatterplot points by `group`.

```python
groups = df.groupby('group')

fig = plt.figure(figsize=(6,6))
ax = fig.add_subplot(111, projection='3d')
for name, group in groups:
    ax.scatter(group['log_ppgdp'],
               group['pctUrban'],
               group['lifeExpF'], label=name)
ax.legend()

ax.set_xlabel('GDP per capita (log)')
ax.set_ylabel('Percent urbanized')
ax.set_zlabel('Life expectancy (years)')

ax.legend()

plt.show();
```

The output is:

```Output
TBD
```

Unsurprisingly, OECD-member countries cluster at the high end of the income scale and, sadly, African countries lag at the poorer end. Countries from the `other` group include countries ranging from poor ones in Southeast Asia to oil-rich Middle Eastern countries, and thus countries from that group are scattered across the income spectrum.

Now that we have the data points detailed in color, let's fit three separate, simple linear models for each group of countries.

```python
model = LinearRegression(fit_intercept=True)

fig = plt.figure(figsize=(6,6))
ax = fig.add_subplot(111, projection='3d')

groups = df.groupby('group')
cmaps = ['Blues_r', 'Oranges_r', 'Greens_r']

for name, group in groups:

    X = group[['log_ppgdp', 'pctUrban']]
    y = group['lifeExpF']

    model.fit(X, y)

    x1_plot = np.linspace(group['log_ppgdp'].min(), group['log_ppgdp'].max(), 1000)
    x2_plot = np.linspace(group['pctUrban'].min(), group['pctUrban'].max(), 1000)
    X1_plot, X2_plot = np.meshgrid(x1_plot, x2_plot)
    y_plot = model.predict(np.c_[X1_plot.ravel(), X2_plot.ravel()])

    ax.scatter(group['log_ppgdp'], group['pctUrban'], group['lifeExpF'], label=name)
    cmap_index = sorted(df['group'].unique().tolist()).index(name)
    cmap = cmaps[cmap_index]
    ax.plot_surface(X1_plot, X2_plot, y_plot.reshape(X1_plot.shape), cmap=cmap);

ax.set_xlabel('GDP per capita (log)')
ax.set_ylabel('Percent urbanized')
ax.set_zlabel('Life expectancy (years)')

plt.show();
```

The output is:

```Output
TBD
```

> [!NOTE]
> The blue plane models the `africa` group, the orange one `oecd`, and `other` is green.

The opacity of the various planes can make it hard to pick out the details, but if you rotate the graph, you should be able to see that while the `other` and `oecd` models behave similarly, the `africa` sub-model exhibits different behavior and responds more dramatically to increases in per-capita GDP and urbanization for increasing women's lifespans.

### Try it yourself

Changing color map for 3D plots like these can sometime help make different details clearer. Locate the `cmap` parameter in the `plot_surface()` function and change it to `cmap='viridis'`.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Exercise solution:

  ```python
  model = LinearRegression(fit_intercept=True)
  
  fig = plt.figure(figsize=(6,6))
  ax = fig.add_subplot(111, projection='3d')
  
  groups = df.groupby('group')
  cmaps = ['Blues', 'Oranges', 'Greens']
  
  for name, group in groups:
  
      X = group[['log_ppgdp', 'pctUrban']]
      y = group['lifeExpF']
  
      model.fit(X, y)
  
      x1_plot = np.linspace(group['log_ppgdp'].min(), group['log_ppgdp'].max(), 1000)
      x2_plot = np.linspace(group['pctUrban'].min(), group['pctUrban'].max(), 1000)
      X1_plot, X2_plot = np.meshgrid(x1_plot, x2_plot)
      y_plot = model.predict(np.c_[X1_plot.ravel(), X2_plot.ravel()])
  
      ax.scatter(group['log_ppgdp'], group['pctUrban'], group['lifeExpF'], label=name)
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

</details>

<br /><br />

***

How good are these models?

```python
groups = df.groupby('group')

for name, group in groups:

    X = group[['log_ppgdp', 'pctUrban']]
    y = group['lifeExpF']

    model.fit(X, y)
    predictions = model.predict(X)

    print(name, "r-squared score:",
          r2_score(group['lifeExpF'],
                   predictions))
```

The output is:

```Output
TBD
```

These models are not great. But we will see if they are improved by using polynomial regression later on.

```python
model = LinearRegression(fit_intercept=True)

groups = df.groupby('group')

for name, group in groups:

    X = group[['log_ppgdp', 'pctUrban']]
    y = group['lifeExpF']

    model.fit(X, y)

    print(name, "slopes:  ", model.coef_)
    print(name, "intercept:", model.intercept_)
```

The output is:

```Output
TBD
```

What do these plots based on group tell us? The slopes for `log_ppgdp` are similar between the `africa` and `oecd` groups, but the slope is different for the `other` group. This suggests that there might be some interaction between `group` and `log_ppgdp` in explaining `lifeExpF`. The `pctUrban` slope for the `oecd` group has a different sign than for `africa` or `other`, which might indicate another interaction, but we are on shaky statistical ground here because we have done no testing to see if these differences in slope are statistically significant (for `pctUrban`, the differences---and the numbers---are small).

What do we mean by interactions between groups? Recall that we generalized a linear model with two features as:

$$
y=β_0+β_1 x_1+β_2 x_2
$$

However, if $x_1$ and $x_2$ interact---if different values of $x_1$, for example, change the influence of $x_2$ on $y$ --- we need to include that in the model like so:

$$
y=β_0+β_1 x_1+β_2 x_2+β_3x_1x_2
$$

Our model involves three predictors (`log_ppgdp`, `pctUrban`, and `group`) and has this form:

$$
y=β_0+β_1 x_1+β_2 x_2+β_3 u_2+β_4 u_3+β_5x_1x_2+β_6 x_1 u_2+β_7 x_1 u_3+β_8 x_2 u_2+β_9 x_2 u_3+β_{10} x_1x_2u_2+β_{11}x_1x_2 u_3
$$

Think of this as another aspect of the curse of dimensionality: as we add features (especially categorical ones), the number of potential interactions between features that we have to account for increases even faster.

> [!NOTE]
> Statisticians often use the variable u for categorical features, a convention that we have used here. Also note that we only included $u_2$ and $u_3$ in the generalized equation for the model, even though we have three groups in the categorical feature group. This is not a mistake; it is because one group from the categorical feature gets included in the intercept.

> [!div class="alert is-tip"]
>
> ### Question
>
> Do you see where these numbers come from? What do you think the intercepts indicate for each of these groups?

Let's now see what happens when we plot polynomial models for each of these groups.

```python
poly_model = make_pipeline(PolynomialFeatures(2),
                           LinearRegression())

fig = plt.figure(figsize=(6,6))
ax = fig.add_subplot(111, projection='3d')

groups = df.groupby('group')
cmaps = ['Blues_r', 'Oranges_r', 'Greens_r']

for name, group in groups:

    X = group[['log_ppgdp', 'pctUrban']]
    y = group['lifeExpF']

    poly_model.fit(X, y)

    x1_plot = np.linspace(group['log_ppgdp'].min(), group['log_ppgdp'].max(), 1000)
    x2_plot = np.linspace(group['pctUrban'].min(), group['pctUrban'].max(), 1000)
    X1_plot, X2_plot = np.meshgrid(x1_plot, x2_plot)
    y_plot = poly_model.predict(np.c_[X1_plot.ravel(), X2_plot.ravel()])

    ax.scatter(group['log_ppgdp'], group['pctUrban'], group['lifeExpF'], label=name)
    cmap_index = sorted(df['group'].unique().tolist()).index(name)
    cmap = cmaps[cmap_index]
    ax.plot_surface(X1_plot, X2_plot, y_plot.reshape(X1_plot.shape), cmap=cmap);

ax.set_xlabel('GDP per capita (log)')
ax.set_ylabel('Percent urbanized')
ax.set_zlabel('Life expectancy (years)')

plt.show();
```

The output is:

```Output
TBD
```

The differences in shapes for these surfaces suggest interaction between `log_ppgdp`, `pctUrban`, and `group`. However, insightful as these plots can be, the nature of 3D visualization can make them hard to see. Another way to present the data is by breaking each model into its own subplot.

```python
poly_model = make_pipeline(PolynomialFeatures(2),
                           LinearRegression())

fig = plt.figure(figsize=(18, 6))

groups = df.groupby('group')
cmaps = ['Blues_r', 'Oranges_r', 'Greens_r']
colors = ['blue', 'orange', 'green']

for name, group in groups:

    X = group[['log_ppgdp', 'pctUrban']]
    y = group['lifeExpF']

    poly_model.fit(X, y)

    x1_plot = np.linspace(group['log_ppgdp'].min(), group['log_ppgdp'].max(), 1000)
    x2_plot = np.linspace(group['pctUrban'].min(), group['pctUrban'].max(), 1000)
    X1_plot, X2_plot = np.meshgrid(x1_plot, x2_plot)
    y_plot = poly_model.predict(np.c_[X1_plot.ravel(), X2_plot.ravel()])

    index = sorted(df['group'].unique().tolist()).index(name)
    ax = fig.add_subplot(1, 3, index + 1, projection='3d')
    color = colors[index]
    ax.scatter(group['log_ppgdp'], group['pctUrban'], group['lifeExpF'],
               label=name, c=color)
    cmap = cmaps[index]
    ax.plot_surface(X1_plot, X2_plot, y_plot.reshape(X1_plot.shape), cmap=cmap);

    ax.set_title(name)
    ax.set_xlabel('GDP per capita (log)')
    ax.set_ylabel('Percent urbanized')
    ax.set_zlabel('Life expectancy (years)')

plt.show();
```

The output is:

```Output
TBD
```

How useful are these models for prediction? Let's look at the $R^2$ scores.

```python
poly_model = make_pipeline(PolynomialFeatures(2),
                           LinearRegression())
groups = df.groupby('group')

for name, group in groups:

    X = group[['log_ppgdp', 'pctUrban']]
    y = group['lifeExpF']

    poly_model.fit(X, y)
    predictions = poly_model.predict(X)

    print(name, "r-squared score:",
          r2_score(group['lifeExpF'],
                   predictions))
```

The output is:

```Output
TBD
```

Not uniformly good. Adding polynomial regression improved the model for the `oecd` group, but worsened it for `africa` and `other`. Let's see if increasing the degrees of the polynomials helps.

### Try it yourself

Try re-running the $R^2$ scoring code cell above using different polynomial degrees in the `PolynomialFeatures()` function until you get better-fitting models.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Possible solution:

  ```python
  poly_model = make_pipeline(PolynomialFeatures(5),
                             LinearRegression())
  groups = df.groupby('group')
  
  for name, group in groups:
  
      X = group[['log_ppgdp', 'pctUrban']]
      y = group['lifeExpF']
  
      poly_model.fit(X, y)
      predictions = poly_model.predict(X)
  
      print(name, "r-squared score:",
            r2_score(group['lifeExpF'],
                     predictions))
  ```

  The output is:

  ```Output
  TBD
  ```
</details>

<br /><br />

***

### Try it yourself

Now that you have a better polynomial degree to use in the models, re-run the code to plot them to see what they look like.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  poly_model = make_pipeline(PolynomialFeatures(5),
                             LinearRegression())

  fig = plt.figure(figsize=(18, 6))
  
  groups = df.groupby('group')
  cmaps = ['Blues_r', 'Oranges_r', 'Greens_r']
  colors = ['blue', 'orange', 'green']
  
  for name, group in groups:
  
      X = group[['log_ppgdp', 'pctUrban']]
      y = group['lifeExpF']
  
      poly_model.fit(X, y)
  
      x1_plot = np.linspace(group['log_ppgdp'].min(), group['log_ppgdp'].max(), 1000)
      x2_plot = np.linspace(group['pctUrban'].min(), group['pctUrban'].max(), 1000)
      X1_plot, X2_plot = np.meshgrid(x1_plot, x2_plot)
      y_plot = poly_model.predict(np.c_[X1_plot.ravel(), X2_plot.ravel()])
  
      index = sorted(df['group'].unique().tolist()).index(name)
      ax = fig.add_subplot(1, 3, index + 1, projection='3d')
      color = colors[index]
      ax.scatter(group['log_ppgdp'], group['pctUrban'], group['lifeExpF'],
                 label=name, c=color)
      cmap = cmaps[index]
      ax.plot_surface(X1_plot, X2_plot, y_plot.reshape(X1_plot.shape), cmap=cmap);
  
      ax.set_title(name)
      ax.set_xlabel('GDP per capita (log)')
      ax.set_ylabel('Percent urbanized')
      ax.set_zlabel('Life expectancy (years)')
  
  plt.show();
  ```

  The output is:

  ```Output
  TBD
  ```

</details>

<br /><br />

***

The differences in the shapes of these surfaces suggest interactions between `log_ppgdp`, `pctUrban`, and `group`, but we would have to do additional tests to establish what the specifics of those interactions are.

> [!div class="alert is-tip"]
>
> ### Question
>
> What do these plots tell you about the dangers of extrapolating too much from a model? Is overfitting a possible concern with these tightly fit models?

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Linear regression can be a flexible tool for modeling the relationships between features in our data, particularly with polynomial regression. However, this flexibility comes with dangers, particularly the hazard of overfitting our models to our data. With multiple regression, we can produce richer models that include more relationships, but interpretation becomes murkier with each additional feature, particularly when categorical features are included.
