What do our new vectors mean? What is driving our data? To see these results, we will create pandas Series for each of the components, index them by feature, and then sort them in descreasing order (so that a higher number represents a feature that is positively correlated with that vector and negative numbers represent low correlation).

```python
vects = fit.components_[:5]
```

```python
c1 = pd.Series(vects[0], index=nutr_df.columns)
c1.sort_values(ascending=False)
```

Our first component is primarily driven by the amounts of protein, selenium and zinc, while the amounts of vitamin C and sugar have a lessened impact.

```python
c2 = pd.Series(vects[1], index=nutr_df.columns)
c2.sort_values(ascending=False)
```

Our second component is primarily driven by the amounts of fiber, manganese and folate.

By using PCA we've been able to distill our data down into fewer, more meaningful dimensions and gain insights we might miss otherwise.