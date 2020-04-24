## Handle `null` values

Because this is a real-world dataset, it is a safe bet that it contains `null` values. We could first check to see whether this is true. However, later on in this module, we will have to transform our data using a function that cannot use NaN values, so we might as well drop rows that contain those values.






### Try it yourself

Drop rows from the DataFrame that contain NaN values.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

If you need help remembering which method to use, see the [pandas documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.dropna.html?azure-portal=true).

```python
df.dropna()
```

The output is:



NDB_No	FoodGroup	Shrt_Desc	Water_(g)	Energ_Kcal	Protein_(g)	Lipid_Tot_(g)	Ash_(g)	Carbohydrt_(g)	Fiber_TD_(g)	...	Vit_K_(Âµg)	FA_Sat_(g)	FA_Mono_(g)	FA_Poly_(g)	Cholestrl_(mg)	GmWt_1	GmWt_Desc1	GmWt_2	GmWt_Desc2	Refuse_Pct
0	1001	Dairy and Egg Products	BUTTER,WITH SALT	15.87	717.0	0.85	81.11	2.11	0.06	0.0	...	7.0	51.368	21.021	3.043	215.0	5.00	1 pat, (1" sq, 1/3" high)	14.2	1 tbsp	0.0
1	1002	Dairy and Egg Products	BUTTER,WHIPPED,W/ SALT	16.72	718.0	0.49	78.30	1.62	2.87	0.0	...	4.6	45.390	19.874	3.331	225.0	3.80	1 pat, (1" sq, 1/3" high)	9.4	1 tbsp	0.0
2	1003	Dairy and Egg Products	BUTTER OIL,ANHYDROUS	0.24	876.0	0.28	99.48	0.00	0.00	0.0	...	8.6	61.924	28.732	3.694	256.0	12.80	1 tbsp	205.0	1 cup	0.0
3	1004	Dairy and Egg Products	CHEESE,BLUE	42.41	353.0	21.40	28.74	5.11	2.34	0.0	...	2.4	18.669	7.778	0.800	75.0	28.35	1 oz	17.0	1 cubic inch	0.0
4	1005	Dairy and Egg Products	CHEESE,BRICK	41.11	371.0	23.24	29.68	3.18	2.79	0.0	...	2.5	18.764	8.598	0.784	94.0	132.00	1 cup, diced	113.0	1 cup, shredded	0.0
...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...	...
8603	44061	Sweets	PUDDINGS,CHOC FLAVOR,LO CAL,INST,DRY MIX	4.20	356.0	5.30	2.40	9.90	78.20	6.1	...	0.4	0.984	1.154	0.131	0.0	9.90	1 serving	40.0	1 package, 1.4 oz box, 4 servings	0.0
8606	44158	Sweets	PIE FILLINGS,BLUEBERRY,CND	54.66	181.0	0.41	0.20	0.35	44.38	2.6	...	3.9	0.000	0.000	0.000	0.0	151.00	1 serving	262.0	1 cup	0.0
8607	44203	Beverages	BEVERAGES,COCKTAIL MIX,NON-ALCOHOLIC,CONCD,FRZ	28.24	287.0	0.08	0.01	0.07	71.60	0.0	...	0.0	0.003	0.001	0.009	0.0	36.00	1 fl oz	71.0	1 serving, 2 fl oz	0.0
8608	44258	Sweets	PUDDINGS,CHOC FLAVOR,LO CAL,REG,DRY MIX	6.80	365.0	10.08	3.00	5.70	74.42	10.1	...	0.5	1.578	1.150	0.130	0.0	9.90	1 serving	40.0	1 package	0.0
8610	44260	Sweets	PUDDINGS,ALL FLAVORS XCPT CHOC,LO CAL,INST,DRY...	6.84	350.0	0.81	0.90	6.80	84.66	0.8	...	1.7	0.099	0.116	0.433	0.0	8.00	1 serving	32.0	1 package, 4 servings	0.0
2190 rows × 54 columns

</details>

<br /><br />

***


Now let’s see how many rows we have left.

```python
df.shape
```

The output TBD--doesn't match:

```Output
(8989, 54)
```

Dropping those rows eliminated 76 percent of our data (from 8989 entries to 2190). An imperfect state of affairs, but we still have enough for our purposes in this section.

> [!div class="alert is-tip"]
> ### Key takeaway
>
> Another solution to removing `null` values is to impute values for them, but this can be tricky. Should we handle missing values as equal to 0? What about a fatty food with `NaN` for `Lipid_Tot_(g)`? We could try taking the averages of values surrounding a `NaN`, but what about foods that are right next to rows containing foods from radically different food groups? It is possible to make justifiable imputations for missing values, but it can be important to involve subject-matter experts (SMEs) in that process.

## Split off descriptive columns

Our descriptive columns (such as FoodGroup and Shrt_Desc) pose challenges for us when it comes time to perform PCA because they are categorical rather than numerical features, so we will split our DataFrame in to one containing the descriptive information and one containing the nutritional information.

```python
desc_df = df.iloc[:, [0, 1, 2]+[i for i in range(50,54)]]
desc_df.set_index('NDB_No', inplace=True)
desc_df.head()
```

Here's the output:

```Output
	FoodGroup	Shrt_Desc	GmWt_Desc1	GmWt_2	GmWt_Desc2	Refuse_Pct
NDB_No						
1001	Dairy and Egg Products	BUTTER,WITH SALT	1 pat, (1" sq, 1/3" high)	14.2	1 tbsp	0.0
1002	Dairy and Egg Products	BUTTER,WHIPPED,W/ SALT	1 pat, (1" sq, 1/3" high)	9.4	1 tbsp	0.0
1003	Dairy and Egg Products	BUTTER OIL,ANHYDROUS	1 tbsp	205.0	1 cup	0.0
1004	Dairy and Egg Products	CHEESE,BLUE	1 oz	17.0	1 cubic inch	0.0
1005	Dairy and Egg Products	CHEESE,BRICK	1 cup, diced	113.0	1 cup, shredded	0.0
```

### Try it yourself

Why was it necessary to structure the `iloc` method call the way we did in the code cell above? What did it accomplish? Why was it necessary set the `desc_df` index to `NDB_No`?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

Use one of the attributes of the <code>DataFrame</code>.

TBD output


</details>

<br /><br />

***

Next, run this input:

```python
nutr_df = df.iloc[:, :-5] # Remove the last five columns
nutr_df.head()
```

Here's the output:

```Output

NDB_No	FoodGroup	Shrt_Desc	Water_(g)	Energ_Kcal	Protein_(g)	Lipid_Tot_(g)	Ash_(g)	Carbohydrt_(g)	Fiber_TD_(g)	...	Lycopene_(Âµg)	Lut+Zea_ (Âµg)	Vit_E_(mg)	Vit_D_Âµg	Vit_D_IU	Vit_K_(Âµg)	FA_Sat_(g)	FA_Mono_(g)	FA_Poly_(g)	Cholestrl_(mg)
0	1001	Dairy and Egg Products	BUTTER,WITH SALT	15.87	717.0	0.85	81.11	2.11	0.06	0.0	...	0.0	0.0	2.32	0.0	0.0	7.0	51.368	21.021	3.043	215.0
1	1002	Dairy and Egg Products	BUTTER,WHIPPED,W/ SALT	16.72	718.0	0.49	78.30	1.62	2.87	0.0	...	0.0	13.0	1.37	0.0	0.0	4.6	45.390	19.874	3.331	225.0
2	1003	Dairy and Egg Products	BUTTER OIL,ANHYDROUS	0.24	876.0	0.28	99.48	0.00	0.00	0.0	...	0.0	0.0	2.80	0.0	0.0	8.6	61.924	28.732	3.694	256.0
3	1004	Dairy and Egg Products	CHEESE,BLUE	42.41	353.0	21.40	28.74	5.11	2.34	0.0	...	0.0	0.0	0.25	0.5	21.0	2.4	18.669	7.778	0.800	75.0
4	1005	Dairy and Egg Products	CHEESE,BRICK	41.11	371.0	23.24	29.68	3.18	2.79	0.0	...	0.0	0.0	0.26	0.5	22.0	2.5	18.764	8.598	0.784	94.0
5 rows × 49 columns
```

### Try it yourself

What did the `iloc` syntax do in the preceding code cell?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Use one of the attributes of the DataFrame.

  TBD output

</details>

<br /><br />

***

Next, run this in a cell:

```python
nutr_df = nutr_df.drop(['FoodGroup', 'Shrt_Desc'], axis=1)
```

This is the output:

```Output
TBD
```

### Try it yourself

Now set the index of `nutr_df` to use `NDB_No`.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  The correct code for students to use here is `nutr_df.set_index('NDB_No', inplace=True)`.

</details>

<br /><br />

***


Now let’s take a look at `nutr_df`.

```python
nutr_df.head()
```

TBD output
