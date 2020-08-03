To begin training our machine learning model, we will start by teaching the computer what parts of the data to look at to make predictions. We know that the column that we are interested in the model to predict is the "Launched" column, so we will extract this column and store it in a variable as a list of `Y` and `N`.

## Further data cleansing

Next, we will remove some of the columns that are not needed for making this prediction. Columns like "Name" are great for humans to give us more context about the data, but the name of a launch is probably the least likely indicator of whether weather will cause the launch to be post-poned. In this module, we will focus the columns involving wind speed, conditions, and precipitation.

> [!NOTE]
> Although variable names like `x` and `y` are not typically recommended, they are norms in data science to represent the input and output data. This is due to the grounding in mathematical algorithms (you might remember formulas like y=mx+b for example)*

```python
# First we save the output we are interested in, in this case "launch" yes and no's into the output variable
y = launch_data['Launched?']

# removing the columns we are not interested in
launch_data.drop(['Name','Date','Time (East Coast)','Location','Launched?','Hist Ave Sea Level Pressure','Sea Level Pressure','Day Length','Notes','Hist Ave Visibility', 'Hist Ave Max Wind Speed'],axis=1, inplace=True)

# Saving the rest of the data as input data
X = launch_data
```

With this, you now have two variables; the output is in `y` and input is in `X`. You can see an overview of the input data by looking at the columns in the newly created `X` variable:

```python
# list of variables that our machine learning algorithm is going to look at:
X.columns
```

The `X` input data represents the weather for a particular day. In this case, we aren't worried about the date or time because we want the profile of the weather for that day to be the indicator for whether a launch should happen, not the date or time. 