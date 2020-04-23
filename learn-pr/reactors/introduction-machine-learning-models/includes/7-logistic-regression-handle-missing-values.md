> [!Note]
> **Sarah: Conversion feedback**
> 
> - I changed all instances of "Sex" or "sex" to "Gender" or "gender." The former term is considered "racy" and should be avoided.
> - Line 188, I revised the text to reference content in unit topic 4.
>

> [!Note]
> **Sarah: Action items**
> 
> - Several output code blocks need content. Search on TBD.
> - Try it yourself block needs Output code. Search on TBD.
> - Try it yourself sections need introduction statements. Search on Sarah.
> - Need some introduction content from you. Search on Sarah.
>

Now we need to address missing values. First, let’s look to see which columns have more than half of their values missing:

```python
# Missing values
df.isnull().sum()>(len(df)/2)
```

The output is: 

```Output
PassengerId    False
Survived       False
Pclass         False
Sex            False
Age            False
SibSp          False
Parch          False
Fare           False
Cabin           True
Embarked       False
dtype: bool
```

Let's break down the code in the call above just a bit. `df.isnull().sum()` tells pandas to take the sum of all of the missing values for each column. `len(df)/2` is just another way of expressing half the number of rows in the `DataFrame`. Taken together with the angle bracket symbol `>`, this line of code is looking for any columns with more than half of its entries missing, and there is one: **Cabin**.

We could try to do something about those missing values. However, if any pattern does emerge in the data that involves **Cabin**, it will be highly cross-correlated with both **Pclass** and **Fare** (as higher-fare, better-class accommodations were grouped together on the _Titanic_). Given that too much cross-correlation can be detrimental to a model, it is probably just better for us to drop **Cabin** from our `DataFrame`:

```python
df.drop('Cabin',axis=1,inplace=True)
```

The output is: 

```Output
TBD
```

Let's now run `info` to see if there are columns with just a few null values.

```python
df.info()
```

```Output
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 891 entries, 0 to 890
Data columns (total 9 columns):
 #   Column       Non-Null Count  Dtype  
---  ------       --------------  -----  
 0   PassengerId  891 non-null    int64  
 1   Survived     891 non-null    int64  
 2   Pclass       891 non-null    int64  
 3   Sex          891 non-null    object 
 4   Age          714 non-null    float64
 5   SibSp        891 non-null    int64  
 6   Parch        891 non-null    int64  
 7   Fare         891 non-null    float64
 8   Embarked     889 non-null    object 
dtypes: float64(2), int64(5), object(2)
memory usage: 62.8+ KB
```

One note on the data: given that 1,503 died in the _Titanic_ tragedy (and that we know that some survived), this data set clearly does not include every passenger on the ship (and none of the crew). Also remember that **Survived** is a variable that includes both those who survived and those who perished.

Back to missing values. **Age** is missing several values, as is **Embarked**. Let's see how many values are missing from **Age**:

```python
df['Age'].isnull().value_counts()
```

The output is: 

```Output
False    714
True     177
Name: Age, dtype: int64
```

As we saw above, **Age** isn't really correlated with **Fare**, so it is a variable that we want to eventually use in our model. That means that we need to do something with those missing values. But we before we decide on a strategy, we should check to see if our median age is the same for both genders.

```python
df.groupby('Gender')['Age'].median().plot(kind='bar')
```

The output is: 

```Output
<matplotlib.axes._subplots.AxesSubplot at 0x1aeb58d0ec8>
```

:::image type="content" alt-text="A bar graph showing the median age for each gender." source="../media/output-bar-graph-1.png" loc-scope="azure":::

The median ages are different for men and women sailing on the _Titanic_, which means that we should handle the missing values accordingly. A sound strategy is to replace the missing ages for passengers with the median age _for the genders for each passenger_.

```python
df['Age'] = df.groupby('Gender')['Age'].apply(lambda x: x.fillna(x.median()))
```

The output is: 

```Output
TBD
```

Any other missing values?

```python
df.isnull().sum()
```

The output is: 

```Output
PassengerId      0
Survived         0
Pclass           0
Gender           0
Age              0
SibSp            0
Parch            0
Fare             0
Cabin          687
Embarked         2
dtype: int64
```

We are missing two values for **Embarked**. Check to see how that variable breaks down:

```python
df['Embarked'].value_counts()
```

The output is: 

```Output
S    644
C    168
Q     77
Name: Embarked, dtype: int64
```

The vast majority of passengers embarked on the _Titanic_ from Southampton, so we will just fill in those two missing values with the most statistically likely value (the median result): Southampton.

```python
df['Embarked'].fillna(df['Embarked'].value_counts().idxmax(), inplace=True)
df['Embarked'].value_counts()
```

The output is: 

```Output
S    646
C    168
Q     77
Name: Embarked, dtype: int64
```

<!-- Sarah, Add introduction statement for input code. -->

```python
df = pd.get_dummies(data=df, columns=['Gender', 'Embarked'],drop_first=True)
df.head()
```

```Output
----------------------------------------------------------------------------------------------------------------
|    |  PassengerId | Survived | Pclass | Age  | SibSp | Parch | Fare     | Sex_male | Embarked_Q | Embarked_S |
----------------------------------------------------------------------------------------------------------------
| 0  |       1      |     0    |    3   | 22.0 |   1   |   0   | 7.2500   |    1     |      0     |      1     |
----------------------------------------------------------------------------------------------------------------
| 1  |       2      |     1    |    1   | 38.0 |   1   |   0   | 71.2833  |    0     |      0     |      0     |
----------------------------------------------------------------------------------------------------------------
| 2  |       3      |     0    |    3   | 26.0 |   0   |   0   | 7.9250   |    0     |      0     |      1     |
----------------------------------------------------------------------------------------------------------------
| 3  |       4      |     0    |    1   | 35.0 |   1   |   0   | 53.100   |    0     |      0     |      1     |
----------------------------------------------------------------------------------------------------------------
| 4  |       5      |     0    |    3   | 35.0 |   0   |   0   | 8.0500   |    1     |      0     |      1     |
----------------------------------------------------------------------------------------------------------------
```

Let's do a final look at the correlation matrix to see if there is anything else we should remove.

```python
df.corr()
```

The output is: 


```Output
-------------------------------------------------------------------------------------------------------------------------------------------
|             | PassengerId | Survived  |   Pclass  |     Age   |    SibSp  |   Parch   |    Fare   | Sex_male  | Embarked_Q | Embarked_S |
-------------------------------------------------------------------------------------------------------------------------------------------
| PassengerId |       1     | -0.005007 |    3      | 22.0      |   1       |   0       | 7.2500    |    1      |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------------------------------
| Survived    |  -0.005007  |     1     |    1   | 38.0 |   1   |   0   | 71.2833  |    0     |      0     |      0     |
-------------------------------------------------------------------------------------------------------------------------------------------
| Pclass      |       3     |     0     |    3   | 26.0 |   0   |   0   | 7.9250   |    0     |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------------------------------
| Age         |       4     |     0     |    1   | 35.0 |   1   |   0   | 53.100   |    0     |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------------------------------
| SibSp       |       5      |     0     |    3   | 35.0 |   0   |   0   | 8.0500   |    1     |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------------------------------
| Parch       |       5      |     0     |    3   | 35.0 |   0   |   0   | 8.0500   |    1     |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------------------------------
| Fare        |       5      |     0     |    3   | 35.0 |   0   |   0   | 8.0500   |    1     |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------------------------------
| Sex_male    |       5      |     0     |    3   | 35.0 |   0   |   0   | 8.0500   |    1     |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------------------------------
| Embarked_Q  |       5      |     0     |    3   | 35.0 |   0   |   0   | 8.0500   |    1     |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------------------------------
| Embarked_S  |       5      |     0     |    3   | 35.0 |   0   |   0   | 8.0500   |    1     |      0     |      1     |
-------------------------------------------------------------------------------------------------------------------------------------------
```

**Pclass** and **Fare** have some amount of correlation, we can probably get rid of one of them. In addition, we need to remove **Survived** from our **X** `DataFrame` because it will be our response `DataFrame`, **Y**:

```python
X = df.drop(['Survived','Pclass'],axis=1)
y = df['Survived']
```

The output is: 

```Output
TBD
```

<!-- Sarah, Add introduction statement for input code. -->

```python
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.3,random_state=67)
```

The output is: 

```Output
TBD
```

### Try it yourself

Now we need to split the training and test data, which you'll do as an exercise.

```python
from sklearn.model_selection import train_test_split
```

Review how we used `train_test_split` in the [Linear regression: Fitting the model](../4-linear-regression-fit-model.yml?azure-portal=true) unit.

Set `test_size = 0.3` and `random_state = 67` to get the same results as below when you run through the rest of the code example.

Now you will import and fit the logistic regression model.

<br />

<details> 

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  from sklearn.linear_model import LogisticRegression

  lr = LogisticRegression()
  ```

  The output is:

  ```Output
  TBD
  ```

</details>

<br /><br />

***

<!-- Sarah: Add introduction statement for next exercise block. -->

<br />

<details> 

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  lr.fit(X_train,y_train)
  ```

  The output is:

  ```Output
  TBD
  ```

</details>

<br /><br />

***

<!-- Sarah: Add introduction statement for next exercise block. -->

<br />

<details> 
  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  predictions = lr.predict(X_test)
  ```

  The output is:

  ```Output
  TBD
  ```
  
</details>

<br /><br />

***
