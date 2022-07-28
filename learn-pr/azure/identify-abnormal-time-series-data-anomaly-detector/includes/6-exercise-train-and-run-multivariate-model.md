
At this point, you've learned how to send the power meter readings to the cloud and use the Anomaly Detector univariate API to find issues the time-series data that only has one variable. This also helps the electricity company to be alerted quickly when a power outage occurs.  However, they now want to drill down into the issue and pinpoint what factors are causing the high energy consumption.

In this exercise, you'll need Jupyter Notebook to run the code blocks below.

- We'll train a model using a dataset with multiple metrics.  
- We'll use the trained model to run the detect model inference to get results with holistic view of all the different smart meter metrics and pinpoint root causes of failures found.  

## Input data structure for multivariate Anomaly Detector API

All time-series data used to train and generate the model with the Multivariate Anomaly Detector API must be zipped into one single file. Each time-series will be as follows: the first column is **_timestamp_** and the second column is **_value_** (all in lowercase) as the header row. The name of the csv file needs to be the name of the metric to monitor (for example, power.csv, voltage.csv, kitchen.csv, laundryroom.csv). Finally, the zip file should have a SAS URI link to an externally accessible source like an Azure Blob Storage container.

![Diagram displaying csv input file structure.](..\media\6-exercise-train-and-run-multivariate-model-1.png)

## Set connection string and environment variables

Before we train the model, let's start by setting up the environment. Copy and replace the values in the code below for _**BLOB_CONNECTION_STRING**_, _**ANOMALY_DETECTOR_NAME**_ and _**API_KEY_ANOMALY DETECTOR**_ that you created from the setup exercise.

```python
import os
import time
from datetime import datetime
import requests
import json
from azure.ai.anomalydetector import AnomalyDetectorClient
from azure.ai.anomalydetector.models import DetectionRequest, ModelInfo
from azure.core.credentials import AzureKeyCredential
from azure.core.exceptions import HttpResponseError

API_VERSION = "v1.1-preview"
ANOMALY_DETECTOR_NAME = "ANOMALY_DETECTOR_NAME"
anomaly_detector_endpoint = "https://{}.cognitiveservices.azure.com/".format(ANOMALY_DETECTOR_NAME)

subscription_key = "API_KEY_ANOMALY DETECTOR"
HEADERS = {
    "Ocp-Apim-Subscription-Key": f"{subscription_key}"
}
blob_conn_str = "BLOB_CONNECTION_STRING"
container_name = "mvadlearninputcontainer"
BLOB_SOURCE = ''
SLIDING_WINDOW = 200
MODEL_ID = ''
RESULT_ID = ''
```

## Get sample household smart meter dataset

We'll be using the _Individual household electric power consumption Data Set_ curtesy of University of California, Irvine.  This dataset contains the power consumption of a single household for a year.  The dataset is available at [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption).  The dataset contains some of the following features:
- **Date and time**: dd/mm/yyyy hh:mm:ss
- **Power**: household minute-averaged power (in kilowatt)
- **Voltage**: minute-averaged voltage (in volt)
- **Kitchen submeter**: energy submetering containing mainly a dishwasher, an oven and a microwave (in watt)
- **Laundry submeter**: energy submetering containing mainly a washing-machine, a tumble-drier, a refrigerator and a light.

```python
from urllib.request import urlretrieve

#download dataset from url to local directory
url = "https://github.com/MicrosoftDocs/mslearn-detect-anomalies-in-realtime/raw/main/energy-data.zip"
DATASET_FILENAME = "smart_meter_data.zip"
filename, headers = urlretrieve(url, filename=DATASET_FILENAME)
```

## Upload dataset to Azure Blob Storage

The Multivariate Anomaly Detector API reads input from an externally accessible Azure storage Uri (preferably a Shared Access Signature Uri). So, the zipped file containing the csv dataset need to be loaded to an Azure Blob Storage container.

```python
from azure.storage.blob import BlobServiceClient
from azure.storage.blob import ContainerClient
from datetime import datetime, timedelta
from azure.storage.blob import ResourceTypes, AccountSasPermissions, generate_account_sas, generate_blob_sas

# Create the BlobServiceClient object which will be used to create a container client 
blob_service_client = BlobServiceClient.from_connection_string(blob_conn_str)

# Get the ContainerClient
try:
    container_client = blob_service_client.get_container_client(container_name)
    container_properties = container_client.get_container_properties()

except Exception as e:
    # if Container does not exist, create the container
    container_client = blob_service_client.create_container(container_name)
    
# Create a blob client using the local file name as the name for the blob
blob_srv_client = blob_service_client.get_blob_client(container=container_name, blob=DATASET_FILENAME)

# upload local dataset to blob 
with open(DATASET_FILENAME, "rb") as blob_file:
    blob_srv_client.upload_blob(data=blob_file, overwrite=True)

#generate a shared access signature (SAS) token for blob
sas_token = generate_blob_sas(
    blob_service_client.account_name,
    container_name=container_name,
    blob_name=filename,
    account_key=blob_service_client.credential.account_key,
    resource_types=ResourceTypes(object=True),
    permission=AccountSasPermissions(read=True),
    protocol="https",
    start=datetime.utcnow(),
    expiry=datetime.utcnow() + timedelta(hours=4)
)

#append the blob url to the SAS token
BLOB_SOURCE = blob_srv_client.url + '?' + sas_token
```
## Set training and testing data timestamp range

We need to specify the timestamp ranges to be used for the training data and testing data.  The dataset for training needs to be a large size to get better accuracy. Also, make sure the timestamp range you give for testing data doesn't overlap with the training data.

```python
#Timestamp range to use for training
train_start_date = "2006-12-16 17:24:00"
train_end_date = "2006-12-18 02:43:00"

#Timestamp range to use for testing
test_start_date = "2006-12-19 00:00:00"
test_end_date = "2006-12-19 20:26:00"
```

## Create and train a Multivariate Anomaly Detection model

We'll create a class that uses the anomaly detector SDK to call the different APIs in the Multivariate Anomaly Detector service.

- The **init** initializes the function with the client connection to your Multivariate Anomaly Detection service and sets the location of the Blob.
- The **train** function uses the _train_ method of the Multivariate Anomaly Detector APIs to train the model with your data that is stored in the Azure Blob. You also need to specify the start and end timestamp of the training dataset. 

   > [!NOTE]
   > You need a large training dataset (e.g. 1000 rows of data) for better model accuracy. The function's output is the unique trained model_id.

- The **detect** function uses the _detect_ method of the Multivariate Anomaly Detector APIs to detect the anomalies in the data in the Azure Blob. The output is the result_id from the results of the API for all the input time-series data points.
- The **export** function uses the _export_ method of the Multivariate Anomaly Detector APIs to export the trained model to a file destination (e.g. local directory). 

   > [!NOTE]
   > You can take the model zip file to other environments or your application for inference.

```python
class MultivariateSample():

    def __init__(self, subscription_key, anomaly_detector_endpoint, data_source=None):
        self.sub_key = subscription_key
        self.end_point = anomaly_detector_endpoint
        # Create an Anomaly Detector client
        self.ad_client = AnomalyDetectorClient(AzureKeyCredential(self.sub_key), self.end_point)
        self.data_source = BLOB_SOURCE

    def train(self, start_time, end_time, max_tryout=500):
        try:
            
            # Number of models available now
            model_list = list(self.ad_client.list_multivariate_model(skip=0, top=10000))

            # Use sample data to train the model
            print("Training new model...")
            data_feed = ModelInfo(start_time=start_time, end_time=end_time, source=self.data_source)
            response_header = \
            self.ad_client.train_multivariate_model(data_feed, cls=lambda *args: [args[i] for i in range(len(args))])[-1]
            trained_model_id = response_header['Location'].split("/")[-1]

            # Model list after training
            new_model_list = list(self.ad_client.list_multivariate_model(skip=0, top=10000))

            # Wait until the model is ready. It usually takes several minutes
            model_status = None
            tryout_count = 0
            while (tryout_count < max_tryout and model_status != "READY"):
                model_status = self.ad_client.get_multivariate_model(trained_model_id).model_info.status
                tryout_count += 1
                time.sleep(2)

            assert model_status == "READY"
            print("Done.", "\n--------------------")
            
            # Return the latest model id
            return trained_model_id
        except Exception as e:
            print("Error code: ", e)

    def detect(self, model_id, start_time, end_time, max_tryout=500):
        # Detect anomaly in the same data source (but a different interval)
        try:
            detection_req = DetectionRequest(source=self.data_source, start_time=start_time, end_time=end_time)
            response_header = self.ad_client.detect_anomaly(model_id, detection_req,
                                                            cls=lambda *args: [args[i] for i in range(len(args))])[-1]
            result_id = response_header['Location'].split("/")[-1]
            # Get results (may need a few seconds)
            r = self.ad_client.get_detection_result(result_id)
            tryout_count = 0
            while r.summary.status != "READY" and tryout_count < max_tryout:
                time.sleep(1)
                r = self.ad_client.get_detection_result(result_id)
                tryout_count += 1
            if r.summary.status != "READY":
                print("Request timeout after %d tryouts.".format(max_tryout))
                return None
        except HttpResponseError as e:
            print('Error code: {}'.format(e.error.code), 'Error message: {}'.format(e.error.message))
        except Exception as e:
            raise e
        return r 

    def export_model(self, model_id, model_path="/engine_model.zip"):
        # Export the model
        model_stream_generator = self.ad_client.export_model(model_id)
        with open(model_path, "wb") as f_obj:
            while True:
                try:
                    f_obj.write(next(model_stream_generator))
                except StopIteration:
                    break
                except Exception as e:
                    raise e         
```

## Run Multivariate Anomaly Detector experiment

We are now ready to run the main function that will start the multivariate Anomaly Detection experiment. It calls the other functions to create, train, detect, and export the model. Each time the train function is executed, a new **Model ID** is generated. Once you have the model that is trained, you can then use the model ID to run the detect API on your test dataset. To see the results of the detection, you need the **Result ID** to get the results of the detection. Copy the result ID to get the results of the detection to use in the next exercise.

```python
if __name__ == '__main__':
    
    # Create a new sample and client
    sample = MultivariateSample(subscription_key, anomaly_detector_endpoint, data_source=None)
    
    #format training start and end datetime range
    train_start_dt = datetime.strptime(train_start_date, "%Y-%m-%d %H:%M:%S")
    train_end_dt = datetime.strptime(train_end_date, "%Y-%m-%d %H:%M:%S")
    
    #format testing start and end datetime range
    test_start_dt = datetime.strptime(test_start_date, "%Y-%m-%d %H:%M:%S")
    test_end_dt = datetime.strptime(test_end_date, "%Y-%m-%d %H:%M:%S")

    # Train a new model
    MODEL_ID = sample.train(train_start_dt, train_end_dt) 
    print("Model ID: ", MODEL_ID)

    # Reference model id and test start and end timestamp range
    result = sample.detect(MODEL_ID, test_start_dt, test_end_dt)
    RESULT_ID = result.result_id
    print("Result ID:\t", RESULT_ID)

    print("Exporting model....")
    # Export model
    sample.export_model(MODEL_ID, "energy_model.zip")
```

Excellent! You have now trained a model and exported it to a zip file. You can now use the model to detect anomalies in your data.  In the next unit, you'll visualize the results of the detection and see root causes of the anomalies.