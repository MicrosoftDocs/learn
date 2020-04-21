> [!Note]
> **Sarah: Action items**
> 
> - Try it yourself block needs Input and Output code, and Hint text. Search on TBD.
> - Need output cell content. Search on TBD.
> - A topic reference needs to be adjusted to use a heading and link for the Learn module/unit: "that you worked with in Section 6"
>

We're now back into familiar territory: prepping data for the model and fitting the model. To keep it interesting, we'll use the scikit-learn `train_test_split()` function with a slight change of parameters to select 75 percent of the data points for training and 25 percent for validation (testing).

```Python
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(
        df[['wind','rain','month','RH']],
        df['temp'],
        test_size=0.25,
        random_state=42
    )
```

The output is:

```Output
TBD
```

Did you see what we did there? Rather than select all of the variables for the model, we were more selective and just chose windspeed, rainfall, month, and relative humidity in order to predict temperature.

Fit scikit-learn's `DecisionTreeRegressor` model using the training data. This algorithm is a combination of the linear regression and decision tree classification that you worked with in Section 6.

```Python
from sklearn.tree import DecisionTreeRegressor
from sklearn.metrics import r2_score
regressor = DecisionTreeRegressor(random_state=42)
regressor.fit(X_train, y_train)
y_test_predictions = regressor.predict(X_test)
print('R^2 for true vs. predicted test set forest temperature: {:0.2f}'.format(r2_score(y_test, y_test_predictions)))
```

Here's the output:

```Output
TBD
```

### Try it yourself

Play around with this algorithm. 

- Can you get better results by changing the variables that you select for the training and test data?
- What if you look at different variables for the response?

<details> 

  <summary>Hint - TBD<i>(expand to reveal)</i></summary>

  ```Python
  TBD
  ```

  ```Output
  TBD
  ```
  
</details>

***
