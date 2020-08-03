Finally, it's time to test your model with data that was never found in your dataset.

On July 30th, 2020 NASA launched the Preserverance rover to Mars from Cape Canaveral at 7:50am Eastern time. 

Gather the input data for the model:
- Crewed or Uncrewed
- High Temp
- Low Temp
- Ave Temp
- Temp at Launch Time
- Hist High Temp
- Hist Low Temp
- Hist Ave Temp
- Percipitation at Launch Time
- Hist Ave Percipitation
- Wind Direction
- Max Wind Speed
- Visibility
- Wind Speed at Launch Time
- Hist Ave Max Wind Speed
- Hist Ave Visibility
- Condition

You can find this information on most Weather sites. Remember the data should be all numerical. 

As an example, this is completely made up data:

```python
# ['Crewed or Uncrewed', 'High Temp', 'Low Temp', 'Ave Temp',
#        'Temp at Launch Time', 'Hist High Temp', 'Hist Low Temp',
#        'Hist Ave Temp', 'Percipitation at Launch Time',
#        'Hist Ave Percipitation', 'Wind Direction', 'Max Wind Speed',
#        'Visibility', 'Wind Speed at Launch Time', 'Hist Ave Max Wind Speed',
#        'Hist Ave Visibility', 'Condition']

data_input = [ 1.  , 75.  , 68.  , 71.  ,  0.  , 75.  , 55.  , 65.  ,  0.  , 0.08,  0.  , 16.  , 15.  ,  0.  ,  0.  ,  0.  ,  0.  ]

tree_model.predict([data_input])
```

## Continue Improving

As you continue to improve your model in ways described throughout this learning path, be sure to keep an eye out on other [NASA rocket launches](https://www.nasa.gov/launchschedule/?azure-portal=true) to see if your model is able to accurately predict the outcomes. 

You can also use weather predictions combined with your machine learning model to see if you can predict if there is a delay even before the launches happen!