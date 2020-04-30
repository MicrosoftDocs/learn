What do our new vectors mean? What is driving our data? To see these results, we will create pandas Series for each of the components, index them by feature, and then sort them in descreasing order (so that a higher number represents a feature that is positively correlated with that vector and negative numbers represent low correlation).

First, run this code in a cell:

```python
vects = fit.components_[:5]
```

This is the output:

```Output
TBD
```

Next, run this code in a cell:

```python
c1 = pd.Series(vects[0], index=nutr_df.columns)
c1.sort_values(ascending=False)
```

This is the output:

```Output
TBD
```

Our first component is primarily driven by the amounts of protein, selenium, and zinc, although the amounts of vitamin C and sugar have a lessened impact.

Then, run this code in a cell:

```python
c2 = pd.Series(vects[1], index=nutr_df.columns)
c2.sort_values(ascending=False)
```

Here's the output:

```Output
TBD
```

Our second component is primarily driven by the amounts of fiber, manganese and folate.

By using PCA, we've been able to distill our data down into fewer, more meaningful dimensions and gain insights we might miss otherwise.