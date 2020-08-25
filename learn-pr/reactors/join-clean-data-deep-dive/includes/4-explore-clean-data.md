By the end of this unit, you should be comfortable performing a simple exploration of your data and performing simple cleaning steps on it to prepare it for later analysis.

Data you'll be working with is typically in formats not necessarily designed for human consumption. Fortunately, pandas DataFrame offers several tools for exploring the data. Let's explore the data that we imported.

```python
df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | ... | Vit_K_(ï¿½g) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | GmWt_1 | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 0 | 1001 | BUTTER,WITH SALT | 15.87 | 717 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | ... | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 | 5.00 | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 |
> | 1 | 1002 | BUTTER,WHIPPED,W/ SALT | 16.72 | 718 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | ... | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 | 3.80 | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 |
> | 2 | 1003 | BUTTER OIL,ANHYDROUS | 0.24 | 876 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | ... | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 | 12.80 | 1 tbsp | 205.0 | 1 cup | 0.0 |
> | 3 | 1004 | CHEESE,BLUE | 42.41 | 353 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | ... | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 | 28.35 | 1 oz | 17.0 | 1 cubic inch | 0.0 |
> | 4 | 1005 | CHEESE,BRICK | 41.11 | 371 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | ... | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 | 132.00 | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 |

5 rows × 53 columns
***

We can get some aggregated information about the DataFrame by using its `info()` method:

```python
df.info()
```

The output is:

```Output
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 8790 entries, 0 to 8789
Data columns (total 53 columns):
NDB_No                8790 non-null int64
Shrt_Desc             8790 non-null object
Water_(g)             8789 non-null float64
Energ_Kcal            8790 non-null int64
Protein_(g)           8790 non-null float64
Lipid_Tot_(g)         8790 non-null float64
Ash_(g)               8465 non-null float64
Carbohydrt_(g)        8790 non-null float64
Fiber_TD_(g)          8196 non-null float64
Sugar_Tot_(g)         6958 non-null float64
Calcium_(mg)          8442 non-null float64
Iron_(mg)             8646 non-null float64
Magnesium_(mg)        8051 non-null float64
Phosphorus_(mg)       8211 non-null float64
Potassium_(mg)        8364 non-null float64
Sodium_(mg)           8707 non-null float64
Zinc_(mg)             8084 non-null float64
Copper_mg)            7533 non-null float64
Manganese_(mg)        6630 non-null float64
Selenium_(ï¿½g)       7090 non-null float64
Vit_C_(mg)            7972 non-null float64
Thiamin_(mg)          8156 non-null float64
Riboflavin_(mg)       8174 non-null float64
Niacin_(mg)           8153 non-null float64
Panto_Acid_mg)        6548 non-null float64
Vit_B6_(mg)           7885 non-null float64
Folate_Tot_(ï¿½g)     7529 non-null float64
Folic_Acid_(ï¿½g)     6751 non-null float64
Food_Folate_(ï¿½g)    7022 non-null float64
Folate_DFE_(ï¿½g)     6733 non-null float64
Choline_Tot_ (mg)     4774 non-null float64
Vit_B12_(ï¿½g)        7597 non-null float64
Vit_A_IU              8079 non-null float64
Vit_A_RAE             7255 non-null float64
Retinol_(ï¿½g)        6984 non-null float64
Alpha_Carot_(ï¿½g)    5532 non-null float64
Beta_Carot_(ï¿½g)     5628 non-null float64
Beta_Crypt_(ï¿½g)     5520 non-null float64
Lycopene_(ï¿½g)       5498 non-null float64
Lut+Zea_ (ï¿½g)       5475 non-null float64
Vit_E_(mg)            5901 non-null float64
Vit_D_ï¿½g            5528 non-null float64
Vit_D_IU              5579 non-null float64
Vit_K_(ï¿½g)          5227 non-null float64
FA_Sat_(g)            8441 non-null float64
FA_Mono_(g)           8124 non-null float64
FA_Poly_(g)           8125 non-null float64
Cholestrl_(mg)        8380 non-null float64
GmWt_1                8490 non-null float64
GmWt_Desc1            8491 non-null object
GmWt_2                4825 non-null float64
GmWt_Desc2            4825 non-null object
Refuse_Pct            8740 non-null float64
dtypes: float64(48), int64(2), object(3)
memory usage: 3.6+ MB
```

Quickly inspecting the columns from `df`, we can see that almost all of the columns have null values. Those missing values are not an issue for us right now, but they will pose a challenge in future sections. We'll deal with them in those sections.

Let's also check to see if this DataFrame has any duplicate values in it. Let's start by exploring the `duplicated` method.

```python
df.duplicated?
```

```python
df.duplicated()
```

The output is:

```Output
0       False
1       False
2       False
3       False
4       False
5       False
6       False
7       False
8       False
9       False
10      False
11      False
12      False
13      False
14      False
15      False
16      False
17      False
18      False
19      False
20      False
21      False
22      False
23      False
24      False
25      False
26      False
27      False
28      False
29      False
        ...  
8760    False
8761    False
8762    False
8763    False
8764    False
8765    False
8766    False
8767    False
8768    False
8769    False
8770    False
8771    False
8772    False
8773    False
8774    False
8775    False
8776    False
8777    False
8778    False
8779    False
8780    False
8781    False
8782    False
8783    False
8784    False
8785    False
8786    False
8787    False
8788    False
8789    False
Length: 8790, dtype: bool
```

You'll notice that `duplicated` shows the results on a row-by-row basis. This is not the most efficient way of determining if there are duplicated rows. One quick trick we can use is to call `sum`, which will add the values of the results, where `False` will be **0** and `True` will be **1**. The result will be a rough sense of whether there are any duplicated rows.

```python
df.duplicated().sum()
```

The output is:

```Output
0
```

Given the nature of the data source (a government reference database), it makes sense that there are no duplicate entries. For purposes of learning more about cleaning data, let's make a mess so we can see how to clean it up. Let's start by using the `append()` method to duplicate data.

```python
df = df.append(df, ignore_index=True)
```

The `append()` method has basically stacked the DataFrame by appending a copy of `df` to the end of the DataFrame. (In SQL terms, we performed a [UNION](https://www.w3schools.com/sql/sql_union.asp?azure-portal=true).) The `ignore_index=True` parameter means that the internal index numbering for the newly doubled DataFrame continues seamlessly.

Now let's look directly at how many times individual values in a column (such as `NDB_No`, which is a key) are duplicated. We'll use the `groupby` function to create a "group" for each instance of `NDB_No`, and then we'll count each instance.

```python
df.groupby('NDB_No')['NDB_No'].count()
```

The output is:

```Output
NDB_No
1001     2
1002     2
1003     2
1004     2
1005     2
1006     2
1007     2
1008     2
1009     2
1010     2
1011     2
1012     2
1013     2
1014     2
1015     2
1016     2
1017     2
1018     2
1019     2
1020     2
1021     2
1022     2
1023     2
1024     2
1025     2
1026     2
1027     2
1028     2
1029     2
1030     2
        ..
43544    2
43546    2
43550    2
43566    2
43570    2
43572    2
43585    2
43589    2
43595    2
43597    2
43598    2
44005    2
44018    2
44048    2
44055    2
44061    2
44074    2
44110    2
44158    2
44203    2
44258    2
44259    2
44260    2
48052    2
80200    2
83110    2
90240    2
90480    2
90560    2
93600    2
Name: NDB_No, Length: 8790, dtype: int64
```

Because we duplicated the original dataset, finding duplicates of everything is not unexpected. However, these duplicate values will pose a problem for us later in the section if they're not dealt with, so let's remove them now:

```python
df = df.drop_duplicates('NDB_No', keep="last")
df.info()
```

The output is:

```Output
<class 'pandas.core.frame.DataFrame'>
Int64Index: 8790 entries, 8790 to 17579
Data columns (total 53 columns):
NDB_No                8790 non-null int64
Shrt_Desc             8790 non-null object
Water_(g)             8789 non-null float64
Energ_Kcal            8790 non-null int64
Protein_(g)           8790 non-null float64
Lipid_Tot_(g)         8790 non-null float64
Ash_(g)               8465 non-null float64
Carbohydrt_(g)        8790 non-null float64
Fiber_TD_(g)          8196 non-null float64
Sugar_Tot_(g)         6958 non-null float64
Calcium_(mg)          8442 non-null float64
Iron_(mg)             8646 non-null float64
Magnesium_(mg)        8051 non-null float64
Phosphorus_(mg)       8211 non-null float64
Potassium_(mg)        8364 non-null float64
Sodium_(mg)           8707 non-null float64
Zinc_(mg)             8084 non-null float64
Copper_mg)            7533 non-null float64
Manganese_(mg)        6630 non-null float64
Selenium_(ï¿½g)       7090 non-null float64
Vit_C_(mg)            7972 non-null float64
Thiamin_(mg)          8156 non-null float64
Riboflavin_(mg)       8174 non-null float64
Niacin_(mg)           8153 non-null float64
Panto_Acid_mg)        6548 non-null float64
Vit_B6_(mg)           7885 non-null float64
Folate_Tot_(ï¿½g)     7529 non-null float64
Folic_Acid_(ï¿½g)     6751 non-null float64
Food_Folate_(ï¿½g)    7022 non-null float64
Folate_DFE_(ï¿½g)     6733 non-null float64
Choline_Tot_ (mg)     4774 non-null float64
Vit_B12_(ï¿½g)        7597 non-null float64
Vit_A_IU              8079 non-null float64
Vit_A_RAE             7255 non-null float64
Retinol_(ï¿½g)        6984 non-null float64
Alpha_Carot_(ï¿½g)    5532 non-null float64
Beta_Carot_(ï¿½g)     5628 non-null float64
Beta_Crypt_(ï¿½g)     5520 non-null float64
Lycopene_(ï¿½g)       5498 non-null float64
Lut+Zea_ (ï¿½g)       5475 non-null float64
Vit_E_(mg)            5901 non-null float64
Vit_D_ï¿½g            5528 non-null float64
Vit_D_IU              5579 non-null float64
Vit_K_(ï¿½g)          5227 non-null float64
FA_Sat_(g)            8441 non-null float64
FA_Mono_(g)           8124 non-null float64
FA_Poly_(g)           8125 non-null float64
Cholestrl_(mg)        8380 non-null float64
GmWt_1                8490 non-null float64
GmWt_Desc1            8491 non-null object
GmWt_2                4825 non-null float64
GmWt_Desc2            4825 non-null object
Refuse_Pct            8740 non-null float64
dtypes: float64(48), int64(2), object(3)
memory usage: 3.6+ MB
```

The DataFrame is now half of its previous size, which is what we would expect. But look at this line in the `df.info()` output:

`Int64Index: 8790 entries, 8790 to 17579`

Remember, counting starts with zero. Although there are now only 8790 entries per column, the indexing for the DataFrame does not run 0 through 8789, as we might have expected. We can see this more directly by looking at the `head` part of the redacted DataFrame:

```python
df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

> |  | NDB_No | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | ... | Vit_K_(ï¿½g) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | GmWt_1 | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | 8790 | 1001 | BUTTER,WITH SALT | 15.87 | 717 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | ... | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 | 5.00 | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 |
> | 8791 | 1002 | BUTTER,WHIPPED,W/ SALT | 16.72 | 718 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | ... | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 | 3.80 | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 |
> | 8792 | 1003 | BUTTER OIL,ANHYDROUS | 0.24 | 876 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | ... | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 | 12.80 | 1 tbsp | 205.0 | 1 cup | 0.0 |
> | 8793 | 1004 | CHEESE,BLUE | 42.41 | 353 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | ... | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 | 28.35 | 1 oz | 17.0 | 1 cubic inch | 0.0 |
> | 8794 | 1005 | CHEESE,BRICK | 41.11 | 371 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | ... | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 | 132.00 | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 |

5 rows × 53 columns
***

> [!div class="alert is-tip"]
>
> ### Question
>
> Is this behavior of the `drop_duplicates()` method not updating the index values of the DataFrame surprising or unexpected for you? Can you explain why this method behaves as it does in this case? If not, study the documentation for this method by using `df.drop_duplicates` in the code cell below until you're satisfied with your understanding of this behavior.
