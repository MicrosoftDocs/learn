Now that you have the Anomaly Detector API instance, IoT Hub and Blob storage instances created, you'll be loading data from the smart meter device to the cloud. You want to monitor the power usage to detect abnormal energy consumption of a household. Since you're just monitoring one metric, which in this case is "power", you'll be using the Univariate Anomaly Detector API.

## Run simulation to send data from smart meter to IoT Hub

In this exercise, you'll need Jupyter Notebook to run the code blocks below.

- We’ll be sending the telemetry data for the power meter into IoT Hub. 
- Since we don’t have a real-life electricity smart meter to connect to IoT Hub in the cloud, we'll simulate reading data from a csv file, format into a json file and send to Azure IoT Hub. 
- In the previous setup exercise, the Azure IoT Hub was configured to automatically route the raw data it receives into the blob storage. Now, we'll process and format the raw data into a json file with parameters that will be sent to the Univariate Anomaly Detector API.

## Create connection to IoT Hub

To send data to IoT Hub, you need to create a connection between the client device and Iot Hub. In this case, we'll be using the local machine as a client to send data to IoT Hub. To find out how to connect a real-life device to IoT Hub, please refer to the summary section at the end of this learn module.  To send data to IoT Hub, a connection is created between the client device and the IoT Hub.

Let's start by setting up the environment and installing some required Python packages we'll use in this module.  

```python
pip install --upgrade azure-ai-anomalydetector
```

```python
pip install --upgrade azure-core
```

```python
pip install azure-iot-device azure-storage-blob azure-core pandas matplotlib bokeh ipywidgets
```

Copy and replace the values in the code below for _**BLOB_CONNECTION_STRING**_, and _**IOTHUB_DEVICE_CONNECTION_STRING**_ that you created from the setup exercise.

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

To read the simulated data from a csv file, the function below simply reads the data and calls the function to send the data to IoT Hub. 

> [!NOTE]
> In a real-life scenario, you'll replace the csv file with the data source.  Depending on where your data source stream is, you can use the function to send the data to IoT Hub.  If you have a device with internet connection, you can configure the IoT connection settings on the device and the data stream will automatically be sent directly to IoT Hub.

Download the dataset the contains sample power meter readings from the provided csv file.

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

Run code to send data to Iot Hub. Then close the device connection to IoT Hub when the data load process is complete.  

```python
#run device to Cloud simulation 
read_sensor_data()
print("message to IoT Hub completed")
# finally, shut down the client
device_client.shutdown()
```

## Format raw data in Azure blob with metadata for anomaly detector

As the data stream is sent to IoT Hub, it’s important to know the frequency at which the time series data is being captured. When the data is received by the IoT Hub, the raw data needs to be formatted in a json file with other metadata before it's sent to the Univariate Anomaly Detector API. The following are the metadata minimum requirements needed:

![Diagram displaying time series data in a valid JSON format.](..\media\4-exercise-send-data-to-cloud-1.png)

- Granularity. This is the frequency in which the data is captured. For example, “minutely”, “hourly”, “daily”, "monthly" or "yearly".
- Series. This contains an array of all the time series data to be processed.
- Timestamp. The timestamp needs to be in UTC format.
- Value. The data metric needs to be in numeric type.  E.g.,  the numeric watts reading for power reading.
- CustomInterval (optional). If the time rate has a non-standardize interval, then add the “CustomInterval” by specifying the granularity. For example, if the rate is every 8 minutes, the custominterval value needs to be set to 8. 

> [!NOTE]
> The time series data needs to be captured in a sequential order and evenly distributed with no gaps or missing timestamps.

Create function the adds the metadata and the dataset into a json file that needed for the Univariate Anomaly Detector API.  Once the data is formatted, it is uploaded to input container for the blob storage.

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

Create a function that downloads the raw data files from the input container for blob storage. 

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

Run code to prepare and process the data in a format that is ready to be used by the Univariate Anomaly Detector API.

```python 
process_raw_data()
```