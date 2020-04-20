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
>

Now we need to address missing values. First, let’s look to see which columns have more than half of their values missing:

```Python
# Missing values
df.isnull().sum()>(len(df)/2)
```

The output is: 

```Output
TBD
```

Let's break down the code in the call above just a bit. `df.isnull().sum()` tells pandas to take the sum of all of the missing values for each column. `len(df)/2` is just another way of expressing half the number of rows in the `DataFrame`. Taken together with the angle bracket symbol `>`, this line of code is looking for any columns with more than half of its entries missing, and there is one: **Cabin**.

We could try to do something about those missing values. However, if any pattern does emerge in the data that involves **Cabin**, it will be highly cross-correlated with both **Pclass** and **Fare** (as higher-fare, better-class accommodations were grouped together on the _Titanic_). Given that too much cross-correlation can be detrimental to a model, it is probably just better for us to drop **Cabin** from our `DataFrame`:

```Python
df.drop('Cabin',axis=1,inplace=True)
```

The output is: 

```Output
TBD
```

Let's now run `info` to see if there are columns with just a few null values.

One note on the data: given that 1,503 died in the _Titanic_ tragedy (and that we know that some survived), this data set clearly does not include every passenger on the ship (and none of the crew). Also remember that **Survived** is a variable that includes both those who survived and those who perished.

Back to missing values. **Age** is missing several values, as is **Embarked**. Let's see how many values are missing from **Age**:

```Python
df['Age'].isnull().value_counts()
```

The output is: 

```Output
TBD
```

As we saw above, **Age** isn't really correlated with **Fare**, so it is a variable that we want to eventually use in our model. That means that we need to do something with those missing values. But we before we decide on a strategy, we should check to see if our median age is the same for both genders.

```Python
df.groupby('Gender')['Age'].median().plot(kind='bar')
```

The output is: 

```Output
TBD
```

The median ages are different for men and women sailing on the _Titanic_, which means that we should handle the missing values accordingly. A sound strategy is to replace the missing ages for passengers with the median age _for the genders for each passenger_.

```Python
df['Age'] = df.groupby('Gender')['Age'].apply(lambda x: x.fillna(x.median()))
```

The output is: 

```Output
TBD
```

Any other missing values?

```Python
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

```Python
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

```Python
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

```Python
df = pd.get_dummies(data=df, columns=['Gender', 'Embarked'],drop_first=True)
df.head()
```

The output is: 

```Output
TBD
```

Let's do a final look at the correlation matrix to see if there is anything else we should remove.

```Python
df.corr()
```

The output is: 

```Output
TBD
```

**Pclass** and **Fare** have some amount of correlation, we can probably get rid of one of them. In addition, we need to remove **Survived** from our **X** `DataFrame` because it will be our response `DataFrame`, **Y**:

```Python
X = df.drop(['Survived','Pclass'],axis=1)
y = df['Survived']
```

The output is: 

```Output
TBD
```

```Python
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.3,random_state=67)
```

The output is: 

```Output
TBD
```

### Try it yourself

Now we need to split the training and test data, which you'll do as an exercise.

```Python
from sklearn.model_selection import train_test_split
```

Review how we used `train_test_split` in the [Linear regression: Fitting the model](../4-linear-regression-fit-model.yml) unit.

Set `test_size = 0.3` and `random_state = 67` to get the same results as below when you run through the rest of the code example.

Now you will import and fit the logistic regression model.

<details> 

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  ```Python
  from sklearn.linear_model import LogisticRegression

  lr = LogisticRegression()
  ```

  ```Output
  TBD
  ```

</details>

***

<details> 

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  ```Python
  lr.fit(X_train,y_train)
  ```

  ```Output
  TBD
  ```

</details>

***

<details> 
  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  ```Python
  predictions = lr.predict(X_test)
  ```

  ```Output
  TBD
  ```
  
</details>

***
