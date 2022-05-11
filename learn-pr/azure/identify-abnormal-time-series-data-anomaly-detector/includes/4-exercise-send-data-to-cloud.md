Now that you have the Anomaly Detector instance, IoT Hub and Blob storage resources created, we'll be loading data from the household smart meter device to the cloud. Since you're just monitoring one metric, which in this case is "power", you'll be using the Univariate Anomaly Detector API. Next, we'll format the data in a json file with parameters and structure needed for the Univariate Anomaly Detector API.  We are using IoT Hub in the business use case in this module, however you can use other services such as Event Hub or Kafka for ingesting stream data to Azure Anomaly Detector.

## Run simulation to send data from smart meter to IoT Hub

In this exercise, you'll need Jupyter Notebook to run the code blocks to do the following:

- Send the household smart meter device data for the “power” meter into IoT Hub that will automatically route the raw data into the blob storage container *learninputcontainer*. 
- Format the raw data from the input blob storage container, then store the processed data in an output Blob storage container *learnoutputcontainer*.

> **Note:** Since we don’t have a real-life electricity smart meter to connect to IoT Hub in the cloud, we'll simulate reading data from a csv file.  See the Summary page at the end of the module on how to connect your device and the data stream directly to IoT Hub.  


## Create connection to IoT Hub

To send data to IoT Hub, you need to create a connection between the client device and Iot Hub. In this case, we'll be using the local machine as a client to send data to IoT Hub. A connection is created between the client device and the IoT Hub in order to send data to the IoT Hub.

> **Note:** If you need to find out how to connect a real-life device to IoT Hub, please refer to the summary section at the end of this learn module.  

Let's start by setting up the environment and installing some required Python packages we'll use in this module.  

```python
pip install azure-core azure-ai-anomalydetector azure-iot-device azure-storage-blob azure-core pandas matplotlib bokeh ipywidgets
```

Copy and replace the connection string values in the code below for _**BLOB_CONNECTION_STRING**_, and _**IOTHUB_DEVICE_CONNECTION_STRING**_ that you created from the setup exercise.

```python
import os
import csv
import time
import uuid
import json
import random
import datetime
import time
import numpy as np
from azure.iot.device import IoTHubDeviceClient, Message
from dateutil.parser import parse
from IPython.display import clear_output 

# The connection string for a device should never be stored in code. For the sake of simplicity we're using an environment variable here.
conn_str = "IOTHUB_DEVICE_CONNECTION_STRING"
blob_conn_str = "BLOB_CONNECTION_STRING"

# The client object is used to interact with your Azure IoT hub.
device_client = IoTHubDeviceClient.create_from_connection_string(conn_str)

# Connect the client.
device_client.connect()

# define function to send telemetry data to IoT Hub
def send_message_to_cloud(data):
    #convert data to json format
    json_obj = json.dumps(data, indent = 2)
    msg = Message(json_obj)
    #msg = Message(data)
    msg.message_id = uuid.uuid4()
    msg.content_encoding = "UTF-8"
    msg.content_type = "application/json"
    device_client.send_message(msg)
```

## Load device data

To read the simulated data from a csv file, the function below simply reads the data and calls the function to send the data to IoT Hub. It downloads the dataset that contains our sample power meter readings from the provided csv file.

> [!NOTE]
> See the Summary page at the end of the module for SDKs and how to send telemetry data from an IoT Device to Azure IoT Hub.

```python
from urllib.request import urlretrieve

#download dataset from url to local directory
url = "https://raw.githubusercontent.com/MicrosoftDocs/mslearn-detect-anomalies-in-realtime/main/power.csv"
local_file_path = "power.csv"
filename, headers = urlretrieve(url, filename=local_file_path)
```

Define function to simulate reading data from a data source and sending it to your Iot Hub in json format.  In this case, we will be using a csv file to simulate as the data source.

```python
#simulate reading data from smart meter device to IoT Hub.  
def read_sensor_data():       
    with open('power.csv') as f:
        reader = csv.reader(f)
        count = 0
        temp_idx = 1
        time_idx = 0
        max_num_records = 1500

        entry_list = list()
        # Skip first row header
        next(reader)

        print("sending message to IoT Hub...")
        for row in reader:
            temperature = row[temp_idx]
            date_time = parse(row[time_idx]).strftime("%Y-%m-%dT%H:%M:00Z") 
          
            entry = {}
            entry['timestamp'] = date_time
            entry['value'] = temperature

            clear_output(wait=True) 
            print(("sending message to IoT Hub {count} of {max_num_records}").format(count=count, max_num_records=max_num_records)) 

            #send data date_time IoT Hub
            send_message_to_cloud(entry)

            if count > max_num_records:
                break
            count += 1
```

- Run the function to send data to Iot Hub. Then close the device connection to IoT Hub when the data load process is complete.  

```python
#run device to Cloud simulation 
read_sensor_data()
print("message to IoT Hub completed")
# finally, shut down the client
device_client.shutdown()
```

## Format raw data in Azure blob with metadata for anomaly detector

As the data stream is sent to IoT Hub, it’s important to process the raw data to be formatted in a json file with other metadata before it's sent to the Univariate Anomaly Detector API. The following are the metadata minimum parameters needed:

![Diagram displaying time series data in a valid JSON format.](..\media\4-exercise-send-data-to-cloud-1.png)

* **Granularity**. This is the frequency in which the data is captured. For example, “minutely”, “hourly”, “daily”, "monthly" or "yearly".
* **Series**. This contains an array of all the time series data to be processed.
* **Timestamp**. The timestamp needs to be in UTC format.
* **Value**. The data metric needs to be in numeric type.  E.g.,  the numeric watts reading for power reading.
* **CustomInterval** (optional). If the time rate has a non-standardize interval, then add the “CustomInterval” by specifying the granularity. For example, if the rate is every 8 minutes, the custominterval value needs to be set to 8. 

> [!NOTE]
> The time series data needs to be captured in a sequential order and evenly distributed with no gaps or missing timestamps.

Create function the adds the metadata parameters into a json file that are needed for the Univariate Anomaly Detector API.  Once the data is formatted, store the processed data to the output container for the blob storage.

```python         
def format_json_data(telemetry_data):
    # parse into json file
    parse_json_records = [json.loads(str(item)) for item in telemetry_data.strip().split('\r\n')]
    data = []
    for item in parse_json_records:
        data.append(item['Body'])

    # format data for Anomaly Detector by specify the granularity rate the data is captured and series field that contain the time-series data 
    request_data = {}
    request_data['granularity'] =  "minutely"
    request_data['series'] = data

    # Create the BlobServiceClient object which will be used to create a container client 
    blob_service_client = BlobServiceClient.from_connection_string(blob_conn_str)

    local_file_name = "request_data.json"
    # Create a blob client using the local file name as the name for the blob
    blob_srv_client = blob_service_client.get_blob_client(container=output_container, blob=local_file_name)

    # send json file to local directory
    json_object = json.dumps(request_data, indent = 2)
    with open("request_data.json", "w") as outfile:
        outfile.write(json_object)

    # writing to file                
    with open("request_data.json", "rb") as blob_file:
        blob_srv_client.upload_blob(data=blob_file, overwrite=True)
```

- Create a function that downloads the raw data files from the input blob storage container *learninputcontainer*; then writes the processed data into an output blob storage container *learnoutputcontainer* after the json file is formatted.

```python
from azure.storage.blob import BlobServiceClient
from azure.storage.blob import ContainerClient
import json

input_container="learninputcontainer"
output_container = "learnoutputcontainer"

def process_raw_data():
    container = ContainerClient.from_connection_string(conn_str=blob_conn_str, container_name=input_container)
    blob_name= ''
    json_paths=[]
    blob_list = container.list_blobs()
    for blob in blob_list:
        # read raw data from blob storage
        blob_name = blob.name
        print(blob.name + '\n')
        blob_client = container.get_blob_client(blob_name)
        filestream = blob_client.download_blob()     
        filecontents = filestream.content_as_text()

        #call function to format data
        format_json_data(filecontents)
```

- Run the function to prepare and process the data in a json format that is ready to be used by the Univariate Anomaly Detector API.

```python 
process_raw_data()
```

Well done!  Now that you have successfully sent the data to IoT Hub and formatted the time series data, you are ready to run the Univariate Anomaly Detector API and visual the anomalies in a LIVE interactive streaming graph in the next unit.