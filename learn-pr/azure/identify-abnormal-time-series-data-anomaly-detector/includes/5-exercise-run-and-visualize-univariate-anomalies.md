With the raw data processed and formatted, you're now ready to run the Univariate Anomaly Detector API to find anomalies that may be present in the power meter dataset.

In this exercise, you'll need Jupyter Notebook to run the code blocks below.

- We'll be running the Univariate Anomaly Detector API on data from the power meter reading from the smart meter.  
- Next, we'll plot the output results on a graph.  
- Finally, we'll adjust the sensitivity levels to control how fine-tuned the threshold of classifying whether or not a data point is anomalous.

Let's start by setting up the environment.  Copy and replace the values in the code below for _**BLOB_CONNECTION_STRING**_, _**ANOMALY_DETECTOR_NAME**_ and _**API_KEY_ANOMALY DETECTOR**_ that you created from the setup exercise.

```python
import time
import random
import requests
import json
import pytz
import pandas as pd
import numpy as np
from datetime import timedelta, datetime 
from math import pi
from datetime import datetime as dt
from dateutil import parser
import warnings
warnings.filterwarnings('ignore')

import matplotlib.pyplot as plt
%matplotlib inline 
# Import library to display results
from bokeh.plotting import figure,output_notebook, show
from bokeh.palettes import Blues4
from bokeh.models.sources import ColumnDataSource
from bokeh.models import PolyAnnotation
from bokeh.models import Band
from bokeh.io import output_notebook, show, push_notebook
from bokeh.models import DatetimeTickFormatter
from bokeh.models.tools import HoverTool
from ipywidgets import interact, widgets, fixed
from threading import Thread

output_notebook()

API_VERSION="v1.1-preview.1"
apikey = 'API_KEY_ANOMALY DETECTOR' 
apiName = 'ANOMALY_DETECTOR_NAME'
endpoint_latest = "https://{}.cognitiveservices.azure.com/anomalydetector/{}/timeseries/last/detect".format(apiName, API_VERSION)
blob_conn_str = "BLOB_CONNECTION_STRING"
BLOB_DATASET = ''
```

## Load the dataset from Blob Storage

We need to load the dataset we processed in the previous exercise from the Blob Storage.  We'll be using it as input to run the Anomaly Detector API.

```python
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient
import json

output_container = "learnoutputcontainer"

blob_service_client = BlobServiceClient.from_connection_string(blob_conn_str)
container_client = blob_service_client.get_container_client(output_container)
blob_list = container_client.list_blobs()
for blob in blob_list:
    # read data from blob storage
    blob_name = blob.name
    blob_client = container_client.get_blob_client(blob_name)
    filestream = blob_client.download_blob()     
    BLOB_DATASET =  json.loads(filestream.readall())
```

## Create function to run Anomaly Detector API

The _"**…/timeseries/last/detect**”_ url endpoint from the Univariate Anomaly Detector APIs is used for real-time streaming data scenarios. We'll be using this API, since we're simulating a scenario where the power meter reading is continuously sending data from the smart meter device to the cloud to detect anomalies as they occur.

```python
def detect(endpoint, apikey, request_data):
    headers = {'Content-Type': 'application/json', 'Ocp-Apim-Subscription-Key': apikey}
    response = requests.post(endpoint, data=json.dumps(request_data), headers=headers)
    if response.status_code == 200:
        return json.loads(response.content.decode("utf-8"))
    else:
        print(response.status_code)
        raise Exception(response.text)
```
## Set properties for finding anomalies

The smart meter device reading is being ingested in a continuous manner.  As a result, the data needs to be partition to segments and send to the Anomaly Detector API using a sliding window technique. This is because the API evaluates whether the latest data points it receives in the segment to select the best model that will fit the data pattern. As the API is evaluating the data points, its algorithm is able to predict what the expected next data point will be, based on previous values in a segment.  The API uses the predicted expected value at a timestamp to determine the upper and lower margin should be from the value. These margins are boundaries that determine whether a data point is anomalies. An anomaly is found when a data point fall outside the upper and lower margin.

We'll use the following input parameters for the Anomaly Detector API:
- **sensitivity**: controls how large or small the upper and lower margin should be. The higher the sensitivity level, the lower the margin. The possible values are between 0-99.
- **granularity**: the time interval between each timestamp. The time interval must be fixed for all the data points in the time series. For example, if the power meter reading is captured every 1 minute, then the granularity is set to minutely. The possible granularity values are _minutely_, _hourly_, _daily_, _weekly_, _monthly_, _yearly_.  
- **maxAnomalyRatio** (optional): establishes the maximum number of anomalies the API can return based on the total number of data points given. For example, if the maximum anomaly ratio is set to 0.1, then the API will only return up to 10% of the total data points as anomalies.  

Here are some of the output fields we'll be using from the Anomaly Detector API results:
- **isAnomaly**.  Indicates whether an anomaly was detected in a data point
- **ExpectedValue**.  Based on the data point patterns, the API predicts what should be the next expected value
- **Upper margin** used to calculate upper boundary, which equals to expectedValue + (100 - marginScale)*upperMargin.  Based on the predicted expected balance, the API provides an accepted maximum boundary range the data points should fall within.
- **Lower margin** used to calculate lower boundary, which equals to expectedValue - (100 - marginScale)*lowerMargin.  Based on the predicted expected balance, the API provides an accepted minimum boundary range the data points should fall within.
- **isPositiveAnomaly** indicates if the actual data point is greater than the predicted expected value
- **isNegativeAnomaly** indicates if the actual data point is lesser than the predicted expected value

```python
def detect_anomaly(sensitivity):
    sample_data = json.load(open('request_data.json'))
    points = sample_data['series']
    sliding_window_skip_point = 29
    result = {'expectedValues': [None]*len(points), 'upperMargins': [None]*len(points), 
              'lowerMargins': [None]*len(points), 'isNegativeAnomaly': [False]*len(points), 
              'isPositiveAnomaly':[False]*len(points), 'isAnomaly': [False]*len(points)}
    anom_count = 0
    for i in range(sliding_window_skip_point, len(points)+1):
        single_sample_data = {}
        single_sample_data['series'] = points[i-29:i]
        single_sample_data['granularity'] = 'minutely'
        single_sample_data['maxAnomalyRatio'] = 0.25
        single_sample_data['sensitivity'] = sensitivity
        single_point = detect(endpoint_latest, apikey, single_sample_data)
        if single_point['isAnomaly'] == True:
            anom_count = anom_count + 1

        result['expectedValues'][i-1] = single_point['expectedValue']
        result['upperMargins'][i-1] = single_point['upperMargin']
        result['lowerMargins'][i-1] = single_point['lowerMargin']
        result['isNegativeAnomaly'][i-1] = single_point['isNegativeAnomaly']
        result['isPositiveAnomaly'][i-1] = single_point['isPositiveAnomaly']
        result['isAnomaly'][i-1] = single_point['isAnomaly']
    
    return result, sensitivity
```

## Configure graph with results

Define and configure your interactive visualization graph. The graph displays the following information as the results are being streamed:

- **Actual** data points from the dataset
- **Expected values** predicted by the Anomaly Detector API
- **Upper and lower margins** which are acceptable boundaries that the Anomaly Detector API generates based on the predicted expected value

```python
def build_figure(result, sample_data, sensitivity):
    plot_data = ColumnDataSource(data=dict(x=np.array([], dtype=datetime), y=np.array([], dtype=float), ax=np.array([], dtype=datetime), ay=np.array([], dtype=float), ex=np.array([], dtype=float), basex=np.array([], dtype=datetime), upper=np.array([], dtype=float), lower=np.array([], dtype=float) ))
    columns = {'expectedValues': result['expectedValues'], 'isAnomaly': result['isAnomaly'], 'isNegativeAnomaly': result['isNegativeAnomaly'],
      'isPositiveAnomaly': result['isPositiveAnomaly'], 'upperMargins': result['upperMargins'], 'lowerMargins': result['lowerMargins']
      , 'value': [x['value'] for x in sample_data['series']], 'timestamp': [parser.parse(x['timestamp']) for x in sample_data['series']]}
    
    response = pd.DataFrame(data=columns)    
    response['timestamp'] = response['timestamp'].dt.tz_convert(None)
    values = response['value'].tolist()
    label = response['timestamp'].tolist()
    anomalies = []
    anomaly_labels = []
    index = 0
    anomaly_indexes = []

    #loop through all the data points to see if there is an anomaly found
    for anom in response['isAnomaly']:
        if anom == True and ( float(values[index]) > response.iloc[index]['expectedValues'] + response.iloc[index]['upperMargins'] or 
                         float(values[index]) < response.iloc[index]['expectedValues'] - response.iloc[index]['lowerMargins']):
            anomalies.append(values[index])
            anomaly_labels.append(label[index])
            anomaly_indexes.append(index)
        index = index+1
    upperband = (response['expectedValues'] + response['upperMargins'])
    lowerband = (response['expectedValues'] - response['lowerMargins'])
    band_x = np.append(label, label[::-1])
    band_y = np.append(lowerband, upperband[::-1])  
   
    p = figure( x_axis_type='datetime', width=1000, height=600, title="Anomaly Detection Result ({0} Sensitivity)".format(sensitivity))
    
    circle = p.circle('ax', 'ay', size=5, color='tomato', legend_label='Anomaly', source=plot_data)
    value_line = p.line('x', 'y', legend_label='Actual', color="#2222aa", line_width=1, source=plot_data)    
    expected_line = p.line('x', 'ex', legend_label='Expected', line_width=1, line_dash="dotdash", line_color='olivedrab', source=plot_data)
    band = Band(base='basex', lower='lower', upper='upper', level='underlay', source=plot_data,  fill_alpha=0.5, line_width=1, line_color='black')
    p.add_layout(band)
    p.legend.border_line_width = 1
    p.legend.background_fill_alpha  = 0.1
        
    #configure datetime format to be display on the x-axis
    p.xaxis.formatter = DatetimeTickFormatter(
        seconds=["%d%b%y %H:%M:%S"],
        minutes=["%d%b%y %H:%M:%S"],
        hours=["%d%b%y %H:%M:%S"],
        days=["%d%b%y %H:%M:%S"],
        months=["%d%b%y %H:%M:%S"],
        years=["%d%b%y %H:%M:%S"],
        milliseconds=["%d%b%y H:%M:%S"]
    )
    p.xaxis.major_label_orientation = pi/4
    p.x_range.follow="end"
    #define display information when cursor hovered over a data point
    hover = HoverTool(tooltips=[( 'Timestamp', '@x{%Y-%m-%d %H:%M:%S.%3N}'), ('value', '@y')],
        formatters = {'@x' : 'datetime'},)
    p.add_tools(hover)        
    handle = show(p, notebook_handle=True)    
    stop_threads = False

    def update_callback( id, stop):    
        expected_list = response['expectedValues'].tolist()
        upper_list = upperband.tolist()
        lower_list = lowerband.tolist()
        new_data=dict(x=np.array([], dtype=datetime), y=np.array([], dtype=float), ax=np.array([], dtype=datetime), ay=np.array([], dtype=float), ex=np.array([], dtype=float), basex=np.array([], dtype=datetime), upper=np.array([], dtype=float), lower=np.array([], dtype=float) )
        period = 1  # in seconds (simulate waiting for new data)x=np.array([], dtype=datetime), y=np.array([], dtype=float),
        n_show = 300  # number of points to keep and showy=np.array([], dtype=float), 
        count = 0
        while (count < len(label)):                         
            timestamp = label[count]
            value = values[count]
            expected_value = expected_list[count]
            upper_value = upper_list[count]
            lower_value = lower_list[count]                        
            x = np.array([])
            y = np.array([])
            ax = np.array([])
            ay = np.array([])
            ex = np.array([])
            base = np.array([])
            up = np.array([])
            low = np.array([])                                  
            count+=1
            new_data['x'] = [timestamp]       
            new_data['y'] = [value]
            new_data['ax'] = np.append(ax, [timestamp]) #skip red dot if timestamp has no anomaly
            new_data['ay'] = np.append(ay, [np.nan])  #skip red dot if data point has no anomaly
            new_data['ex'] = np.append(ex,[expected_value])
            new_data['basex'] = np.append(base, timestamp)
            new_data['upper'] = np.append(up, upper_value)
            new_data['lower'] = np.append(low, lower_value)            
            ts = pd.to_datetime(timestamp, format="y-m-d H:M:S")            
            #check if current timestamp has an anomaly detected
            if (len(list(filter(lambda x : x == ts, anomaly_labels))) > 0):
                # get the index of anomaly data point
                idx = anomaly_labels.index(ts)
                new_data['ax'] = [anomaly_labels[idx]]
                new_data['ay'] = [anomalies[idx]]
            count+=1
            plot_data.stream(new_data, n_show)
            push_notebook(handle=handle)
            time.sleep(period)
            if stop():
                print("exit")
                break     
    #callback to update graph with new data in notebook
    thread = Thread(target=update_callback, args=(id, lambda: stop_threads))
    thread.start()
```

## Visualize and Evaluate Sensitivity impact to anomalies found

To fully understand the role the sensitivity level plays in detecting anomalies: 
- We'll compare the difference between the sensitivity level set at 95 vs 70. 
- We'll see how it impacts the upper and lower margins. 
- Finally, we'll observe the expected values vs actual data points; as well as the number of anomalies found.

Here's an example of how setting a high severity level will show more data points with anomalies. In addition, the upper and lower margins (shown in the yellow overlay on the graph) are thinner with a higher sensitivity level.

```python
# 95 sensitvity
result, sensitivity = detect_anomaly(95)
build_figure(result, BLOB_DATASET, sensitivity)
```
[ ![Diagram displaying anomaly sensitivity level at 95](..\media\5-exercise-run-and-visualize-univariate-anomalies-1.png) ](..\media\5-exercise-run-and-visualize-univariate-anomalies-1.png#lightbox)


Now, we'll change the sensitivity level and see the difference in the number of anomalies found.  Here's an example of how lowering the severity shows lesser anomaly data points.  Also, you can see that the upper and lower margins (shown in the yellow overlay on the graph) are thicker with a lower sensitivity level.

```python
# 70 sensitvity
result, sensitivity = detect_anomaly(70)
build_figure(result, BLOB_DATASET, sensitivity)
```
[ ![Image alt text.](..\media\5-exercise-run-and-visualize-univariate-anomalies-2.png) ](..\media\5-exercise-run-and-visualize-univariate-anomalies-2.png#lightbox)
