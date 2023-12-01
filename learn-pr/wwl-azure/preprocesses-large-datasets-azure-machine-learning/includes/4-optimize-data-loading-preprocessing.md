Data scientists can load and process data more quickly using RAPIDS with GPU compute.

Recall the large volume of flight data you received as a data scientist for the air carrier company. One important performance metric of this company is whether a flight is delayed for more than 15 minutes. You want to train a classification model so you can predict when a future flight will be delayed. Before you can train the model, you need to load and process the data.

You'll learn how to load and process data in Azure Machine Learning by using the RAPIDS cuDF library.

## RAPIDS

RAPIDS is a machine-learning framework created by NVIDIA. You can use the RAPIDS libraries for:

- Data loading and preprocessing
- Machine learning
- Graph analytics
- Visualization

Here, we'll focus on data loading and preprocessing with RAPIDS cuDF.

> [!NOTE]
> To learn more about how to use RAPIDS for machine learning, graph analytics and visualization, go to the [RAPIDS Docs](https://docs.rapids.ai/api).

### cuDF

A typical approach for data scientists is to use the **pandas** library to process tabular data. When working with large volumes of data however, it can take a long time to load and manipulate your data with pandas on CPUs. Next to a decline in performance, you may run into memory issues. To improve performance and avoid memory issues on your compute, use GPUs to process large data more quickly. As pandas only works with CPUs, you'll have to use the **cuDF** library to work with GPUs.

**cuDF** is essentially pandas on GPU. Similar to pandas, cuDF is a Python DataFrame library for loading and processing data.

For example, let's look at how we can **load data** with both pandas and cuDF to see how similar they are:

Load a CSV file into a DataFrame with pandas:

```python
import pandas as pd

flight_data = pd.read_csv(csvfile)
```

Load a CSV file into a DataFrame with cuDF:

```python
import cudf

flight_data = cudf.read_csv(csvfile)
```

After you loaded the data, you may want to process it to prepare it for model training. Let's look at some data manipulations we can do with cuDF.

> [!TIP]
> When working with data, use the [cuDF documentation](https://docs.rapids.ai/api/cudf/stable/) to find the methods you need.

For example, working for the air carrier company you've received all the flight data. The data includes where and when an airplane took off, and where and when it landed. The values for the origin and destination of a flight are the codes of the airports they visited. 

You find an open dataset with information about the airports, like the full names of the airport, the codes, and the location on the map. To add the airport data to your flight data, you want to merge these two datasets.

You can **merge** your flight data with the airports dataset using the following code:

```python
data = cudf.merge(flight_data, airports, left_on='Dest', right_on='iata_code', how='left')
data = cudf.merge(flight_data, airports, left_on='Origin', right_on='iata_code', how='left')
```

To make columns more easily interpretable, you can **rename** them:

```python
data = data.rename(columns= { 'latitude_deg_y' : 'origin_lat', 'longitude_deg_y': 'origin_long',
                              'latitude_deg_x' : 'dest_lat', 'longitude_deg_x': 'dest_long',
                              'Description' : 'Airline'})
```

Machine learning models can be affected by missing data. An easy way to avoid this, especially when working with large datasets, is to remove the rows in which any of the columns have missing values.

Similar to when using pandas, you can **remove missing values** by dropping the rows using the `dropna` function:

```python
data = data.dropna() 
```

For data scientists working with pandas, cuDF is a familiar approach to data processing that is compatible with GPU and will allow you to process data much faster.

> [!TIP]
> If you want to improve performance even more, learn about [multi-GPU processing with Dask](https://docs.rapids.ai/api/dask-cudf/stable/).
