Application Insights automatically captures any information written to the standard output and error logs, and provides a query capability to view data in these logs.

## Write log data

To capture telemetry data for Application insights, you can write any values to the standard output log in the scoring script for your service by using a `print` statement, as shown in the following example:

```python
def init():
    global model
    model = joblib.load(Model.get_model_path('my_model'))
def run(raw_data):
    data = json.loads(raw_data)['data']
    predictions = model.predict(data)
    log_txt = 'Data:' + str(data) + ' - Predictions:' + str(predictions)
    print(log_txt)
    return predictions.tolist()
```

Azure Machine Learning creates a *custom dimension* in the Application Insights data model for the output you write.

## Query logs in Application Insights

To analyze captured log data, you can use the Log Analytics query interface for Application Insights in the Azure portal. This interface supports a SQL-like query syntax that you can use to extract fields from logged data, including custom dimensions created by your Azure Machine Learning service.

For example, the following query returns the **timestamp** and **customDimensions.Content** fields from log traces that have a **message** field value of *STDOUT* (indicating the data is in the standard output log) and a **customDimensions.["Service Name"]** field value of *my-svc*:

```sql
traces
|where message == "STDOUT"
  and customDimensions.["Service Name"] = "my-svc"
| project  timestamp, customDimensions.Content
```

This query returns the logged data as a table:

| **timestamp** | **customDimensions_Content** |
| ------------- | ---------------------------- |
| 01/02/2020... | Data:[[1, 2, 2.5, 3.1], [0, 1, 1,7, 2.1]] - Predictions:[0 1] |
| 01/02/2020... | Data:[[3, 2, 1.7, 2.0]] - Predictions:[0] |
