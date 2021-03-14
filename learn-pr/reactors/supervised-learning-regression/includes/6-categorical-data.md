<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

Our dataset has two categorical features (also known as *factors* in the statistical world): `region` and `group`. There are multiple ways of handling data like this in linear regression. Here, we'll handle it by building sub-models for it.

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

> [!div class="alert is-tip"]
> Output

:::image type="content" source="..\media\ppgdp-lifeexpf-purban-3d-groups.svg" alt-text="Scatter plot output":::

***

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

> [!div class="alert is-tip"]
> Output

:::image type="content" source="..\media\ppgdp-lifeexpf-purban-3d-groups-countries.svg" alt-text="Scatter plot output":::

***

> [!NOTE]
> The blue plane models the `africa` group, the orange one models `oecd`, and green is for `other`.

The opacity of the various planes can make it hard to see the details. If you rotate the graph, you should be able to see that while the `other` and `oecd` models behave similarly, the `africa` sub-model exhibits different behavior. It responds more dramatically to increases in per-capita GDP and urbanization for increasing women's lifespans.

### Try it yourself

Changing the color map for 3D plots like these can sometimes make details clearer. Locate the `cmap` parameter in the `plot_surface()` function and change it to `cmap='viridis'`.

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

  > [!div class="alert is-tip"]
  > Output

  :::image type="content" source="..\media\ppgdp-lifeexpf-purban-3d-groups-countries-viridis.svg" alt-text="Scatter plot output":::

  ***

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
africa r-squared score: 0.2536511261888206
oecd r-squared score: 0.4692983761591224
other r-squared score: 0.4732136593010081
```

These models are not great. But we'll see if they're improved by using polynomial regression later on.

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
africa slopes:   [5.19791503 0.11838104]
africa intercept: 38.80226271517247
oecd slopes:   [ 5.30911202 -0.00875818]
oecd intercept: 59.22301183635976
other slopes:   [6.8727781 0.0135027]
other intercept: 48.83819321831638
```

What do these plots based on group tell us? The slopes for `log_ppgdp` are similar between the `africa` and `oecd` groups, but the slope is different for the `other` group. This suggests that there might be some interaction between `group` and `log_ppgdp` in explaining `lifeExpF`. 

The `pctUrban` slope for the `oecd` group has a different sign than for `africa` or `other`, which might indicate another interaction. But we're on shaky statistical ground here, because we've done no testing to see if these differences in slope are statistically significant. (For `pctUrban`, the differences - and the numbers - are small.)

What do we mean by interactions between groups? Recall that we generalized a linear model with two features as:

$$
y=β_0+β_1 x_1+β_2 x_2
$$

But what if $x_1$ and $x_2$ interact? What if different values of $x_1$, for example, change the influence of $x_2$ on $y$? We need to include that in the model like so:

$$
y=β_0+β_1 x_1+β_2 x_2+β_3x_1x_2
$$

Our model involves three predictors (`log_ppgdp`, `pctUrban`, and `group`) and has this form:

$$
y=β_0+β_1 x_1+β_2 x_2+β_3 u_2+β_4 u_3+β_5x_1x_2+β_6 x_1 u_2+β_7 x_1 u_3+β_8 x_2 u_2+β_9 x_2 u_3+β_{10} x_1x_2u_2+β_{11}x_1x_2 u_3
$$

Think of this as another aspect of the curse of dimensionality. As we add features (especially categorical ones), the number of potential interactions between features that we have to account for increases even faster.

> [!NOTE]
> Statisticians often use the variable *u* for categorical features. We've used that convention here. Also note that we included only $u_2$ and $u_3$ in the generalized equation for the model, even though we have three groups in the categorical feature group. This is not a mistake. It's because one group from the categorical feature is included in the intercept.

> [!div class="alert is-tip"]
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

> [!div class="alert is-tip"]
> Output

:::image type="content" source="../media/ppgdp-lifeexpf-purban-3d-groups-model-polynomial.svg" alt-text="Scatter plot output":::

***

The differences in shapes for these surfaces suggest interaction between `log_ppgdp`, `pctUrban`, and `group`. Although these plots can be insightful, the nature of 3D visualization can make them hard to see. Another way to present the data is by breaking each model into its own subplot.

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

> [!div class="alert is-tip"]
> Output

:::image type="content" source="../media/ppgdp-lifeexpf-purban-3d-groups-model-polynomial-subplots.svg" alt-text="Scatter plot output":::

***

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
africa r-squared score: 0.2895032771510876
oecd r-squared score: 0.7168351852552235
other r-squared score: 0.5062427591759765
```

The scores are not uniformly good. Adding polynomial regression improved the model for the `oecd` group, but worsened it for `africa` and `other`. Let's see if increasing the degrees of the polynomials helps.

### Try it yourself

Try re-running the $R^2$ scoring code cell by using different polynomial degrees in the `PolynomialFeatures()` function until you get better-fitting models.

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
  africa r-squared score: 0.628701057999079
  oecd r-squared score: 0.870960361112914
  other r-squared score: 0.6948518942709203
  ```

</details>

<br /><br />

***

### Try it yourself

Now that you have a better polynomial degree to use in the models, re-run the code to plot the models and see what they look like.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Exercise solution:

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

  :::image type="content" source="../media/ppgdp-lifeexpf-purban-3d-groups-model-polynomial-subplots-degree.svg" alt-text="Scatter plot output":::

</details>

<br /><br />

***

The differences in the shapes of these surfaces suggest interactions between `log_ppgdp`, `pctUrban`, and `group`. But we would have to do more tests to establish what the specifics of those interactions are.

> [!div class="alert is-tip"]
>
> ### Question
>
> What do these plots tell you about the dangers of extrapolating too much from a model? Is overfitting a possible concern with these tightly fit models?

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Linear regression can be a flexible tool for modeling the relationships between features in our data, particularly with polynomial regression. This flexibility comes with dangers, like the hazard of overfitting our models to our data. 

With multiple regression, we can produce richer models that include more relationships. But interpretation becomes murkier with each additional feature, particularly when the models include categorical features.
