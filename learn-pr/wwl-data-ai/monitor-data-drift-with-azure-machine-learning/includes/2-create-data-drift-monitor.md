Azure Machine Learning supports data drift monitoring through the use of *datasets*. You can compare two registered datasets to detect data drift, or you can capture new feature data submitted to a deployed model service and compare it to the dataset with which the model was trained.

## Monitor data drift by comparing datasets

It's common for organizations to continue to collect new data after a model has been trained. For example, a health clinic might use diagnostic measurements from previous patients to train a model that predicts diabetes likelihood, but continue to collect the same diagnostic measurements from all new patients. The clinic's data scientists could then periodically compare the growing collection of new data to the original training  data, and identify any changing data trends that might affect model accuracy.

To monitor data drift using registered datasets, you need to register two datasets:

* A *baseline* dataset - usually the original training data.
* A *target* dataset that will be compared to the baseline based on time intervals. This dataset requires a column for each feature you want to compare, and a timestamp column so the rate of data drift can be measured.

After creating these datasets, you can define a *dataset monitor* to detect data drift and trigger alerts if the rate of drift exceeds a specified threshold. You can create dataset monitors using the visual interface in Azure Machine Learning studio, or by using the **DataDriftDetector** class in the Azure Machine Learning SDK as shown in the following example code:

```python
from azureml.datadrift import DataDriftDetector

monitor = DataDriftDetector.create_from_datasets(workspace=ws,
                                                 name='dataset-drift-detector',
                                                 baseline_data_set=train_ds,
                                                 target_data_set=new_data_ds,
                                                 compute_target='aml-cluster',
                                                 frequency='Week',
                                                 feature_list=['age','height', 'bmi'],
                                                 latency=24)
```

After creating the dataset monitor, you can *backfill* to immediately compare the baseline dataset to existing data in the target dataset, as shown in the following example, which backfills the monitor based on weekly changes in data for the previous six weeks:

```python
import datetime as dt

backfill = monitor.backfill( dt.datetime.now() - dt.timedelta(weeks=6), dt.datetime.now())
```

## Monitor data drift in service inference data

If you have deployed a model as a real-time web service, you can capture new inferencing data as it is submitted, and compare it to the original training data to detect data drift. This is a little more complex to set up initially than using a dataset monitor, but has the benefit of automatically collecting new target data as the deployed model is used.

### Register the baseline dataset with the model
To monitor deployed models for data drift, you must include the training dataset in the model registration to provide a baseline for comparison as shown in the following example code:

```python
from azureml.core import Model, Dataset

model = Model.register(workspace=ws,model_path='./model/model.pkl', model_name='my_model',    
                       datasets=[(Dataset.Scenario.TRAINING, train_ds)])
```

### Enable data collection for the deployed model

To collect inference data for comparison, you must enable data collection for services in which the model, is used. To do this, you must use the **ModelDataCollector** class in each service's scoring script, writing code to capture data and predictions and write them to the data collector (which will store the collected data in Azure blob storage):

```python
from azureml.monitoring import ModelDataCollector

def init():
    global model, data_collect, predict_collect
    model_name = 'my_model'
    model = joblib.load(Model.get_model_path(model_name))

    # Enable collection of data and predictions
    data_collect = ModelDataCollector(model_name,
                                      designation='inputs',
                                      features=['age','height', 'bmi'])
    predict_collect = ModelDataCollector(model_name,
                                         designation='predictions',
                                         features=['prediction'])
def run(raw_data):
    data = json.loads(raw_data)['data']
    predictions = model.predict(data)

    # collect data and predictions
    data_collect(data)
    predict_collect(predictions)

    return predictions.tolist()
```

With the data collection code in place in the scoring script, you can enable data collection in the deployment configuration:

```python
from azureml.core.webservice import AksWebservice

dep_config = AksWebservice.deploy_configuration(collect_model_data=True)
 ```

### Configure data drift detection

Now that the baseline dataset is registered with the model, and the target data is being collected by deployed services, you can configure data drift monitoring by using a **DataDriftDetector** class:

```python
from azureml.datadrift import DataDriftDetector, AlertConfiguration

# create a new DataDriftDetector object for the deployed model
model = ws.models['my_model']
datadrift = DataDriftDetector.create_from_model(ws, model.name, model.version,
                                     services=['my-svc'],
                                     frequency="Week")
```

The data drift detector will run at the specified frequency, but you can run it on-demand as an experiment:

```python
from azureml.core import Experiment, Run
from azureml.widgets import RunDetails
import datetime as dt

# or specify existing compute cluster
run = datadrift.run(target_date=dt.today(),
                    services=['my-svc'],
                    feature_list=['age','height', 'bmi'],
                    compute_target='aml-cluster')

# show details of the data drift run
exp = Experiment(ws, datadrift._id)
dd_run = Run(experiment=exp, run_id=run.id)
RunDetails(dd_run).show()
```
