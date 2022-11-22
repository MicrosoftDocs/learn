Now that you've successfully trained a model, ran the detect API using your train model, it’s time to view the results.   We’ll observe the behavior correlation between all the smart meter readings as well as the key contributors of any anomaly found.

In this exercise, you'll need Jupyter Notebook to run the code blocks below.

- We'll get results from running the detect API with your trained model
- Next, we'll plot the test dataset from the smart meter readings on the graph
- Finally, we'll plot the results of the multivariate anomaly detector on the graph

Before we view the results, let's start by setting up the environment.  Copy and replace the values in the code below for _**ANOMALY_DETECTOR_NAME**_ and _**API_KEY_ANOMALY DETECTOR**_ that you created from the setup exercise. You'll also need the **_RESULT_ID_** from the previous exercise.

```python
from bokeh.io import output_file, show, output_notebook, save
from bokeh.layouts import gridplot
from bokeh.plotting import figure
from matplotlib import pyplot
from bokeh.models import ColumnDataSource, HoverTool, DatetimeTickFormatter
from bokeh.palettes import Dark2_5 as palette
from math import pi
import pandas as pd
import numpy as np
import os
import json
import requests
import pprint
import itertools  
import shutil
import uuid
import zipfile
from datetime import datetime
from datetime import datetime as dt
from urllib.request import urlretrieve
%matplotlib inline
output_notebook()

API_VERSION="v1.1-preview.1"
subscription_key = "API_KEY_ANOMALY DETECTOR"
ANOMALY_DETECTOR_NAME = "ANOMALY_DETECTOR_NAME"
ENDPOINT = "{}.cognitiveservices.azure.com/anomalydetector/{}".format(ANOMALY_DETECTOR_NAME, API_VERSION)
API_RESULTS = "https://{endpoint}/multivariate/results/{result_id}"
HEADERS = {
    "Ocp-Apim-Subscription-Key": f"{subscription_key}"
}
result_id = "RESULT_ID"
DATASET_FILENAME = "smart_meter_data.zip"
BLOB_SOURCE = ''
```

## Get the results from the detection  

To query and retrieve the results, we'll need to create a function the call the API_RESULT url defined above which returns a JSON file containing the results.  It requires the result_id as a parameter.
  
```python
#get results from running the detect API on the trained model
def get_results(result_id):
    header = HEADERS
    result = json.loads(requests.get(API_RESULTS.format(endpoint=ENDPOINT, result_id=result_id), headers=header).content)
    if result['summary']['status'] != 'READY':
        print("result not ready")
        return
    else:
        return result
        return
 ```

Run the following function with the RESULT_ID to get the results from the detect inference using your train model.

```python    
raw_result = get_results(result_id)
 ```

## Extract zip file and load testing dataset  

We'll be extracting the actual test data from each of the csv files and loading it into a dataframe. This is the same data used to run the detect API using your train model. The timestamps and values from the dataset will be used to plot on the graph.

```python
def unzip_file(zip_src, dst_dir):
    r = zipfile.is_zipfile(zip_src)
    if r:
        fz = zipfile.ZipFile(zip_src, 'r')
        for file in fz.namelist():
            fz.extract(file, dst_dir)
    else:
        print('This is not zip')
        
# download data file zip file and location each csv file into a dataframe
def load_data(local_data_path, start, end):
    new_dir = os.path.join('.', str(uuid.uuid1()))
    shutil.rmtree(new_dir, ignore_errors=True)
    os.mkdir(new_dir)
    unzip_file(local_data_path, new_dir)
    files = os.listdir(new_dir)
    frames = []
    for file in files:
        if file[-4:] != '.csv':
            continue
        frame = pd.read_csv('{}\\{}'.format(new_dir, file), skip_blank_lines=True)
        frame['timestamp'] = pd.to_datetime(frame['timestamp'])   
        var = file[:file.find('.csv')]
        frame = frame.rename(columns={'value': var})
        frame = frame[frame['timestamp'] >= start]
        frame = frame[frame['timestamp'] <= end]       
        frame['timestamp'] = frame['timestamp'].dt.strftime('%Y-%m-%d %H:%M:%S')
        frame.set_index(['timestamp'], inplace=True)
        frames.append(frame)
    shutil.rmtree(new_dir, ignore_errors=True)
    return frames
```

## Configure the graph settings

Create a constructor function to create a graph and interactive tool settings

```python
def plot_lines_multi(x, y, p, color, name, t_str="hover,save,pan,box_zoom,reset,wheel_zoom", t_loc='above'):
    '''...
    '''
    p.line(x, y, color=color, legend_label=name)
```

## Plot the graph with your test dataset

Loop through the time-series testing data and plot the household smart meter readings for power, voltage, kitchen, and laundry room.

Parsing the anomaly results:

We'll loop through the list of results and extract the following information at each timestamp:
- **isAnomaly**: True or False. True if the timestamp has an anomaly.
- **score**: A number that the model calculates for each timestamp to determine whether it's an anomaly. The model considers whether a data point is anomalous from both global and local perspective. If score at a timestamp is higher than a certain threshold, then the timestamp is marked as an anomaly. If score is lower than the threshold but is relatively higher in a segment, it's also marked as an anomaly.
- **sensitivity**: Controls the margin between the expected value.  If the actual value falls outside the margin, then it's anomalous. The higher the sensitivity, the lower the margin. The higher the sensitivity, the more anomalies will be found.

Appending the detected anomaly results on the graph:
    
We'll loop through the results and plot values for isAnomaly, score, and severity for each timestamp on the graph.

```python
def draw(data_source, local_data_path, result_id, sensitivity, start, end):
    urlretrieve(data_source, local_data_path)
    series = load_data(local_data_path, start, end)
    p_list = []
    colors = itertools.cycle(palette)
    for var, color in zip(series, colors):
        name = var.columns.values[0]
        p_value = figure(background_fill_color="#fafafa", x_axis_type="datetime")       
        timestamp_idx = var[name]
        value = pd.to_datetime(var.index)
        #plot_lines_multi(var.index, var[name], p_value, color, name)
        plot_lines_multi(value, timestamp_idx, p_value, color, name)
        #configure datetime format to be display on the x-axis
        p_value.xaxis.formatter = DatetimeTickFormatter(
            days=["%m/%d %H:%M"],
            months=["%m/%d %H:%M"],
            years=["%m/%d %H:%M"],
            hours=["%m/%d %H:%M"],
            minutes=["%m/%d %H:%M"]
        )
        p_value.xaxis.major_label_orientation = pi/4
        
        #display timestamp and value when cursor hovered over a data point
        hover = HoverTool(tooltips=[( 'Timestamp', '@x{%Y-%m-%d %H:%M:%S.%3N}'), ('value', '@y')],
            formatters = {'@x' : 'datetime'},)
        p_value.add_tools(hover)        
        p_list.append(p_value)           

    ##### Parse the anomaly results  ######  

    # extract isAnomaly, score and severity value from results JSON object
    start_dt = datetime.strptime(start, "%Y-%m-%d %H:%M:00")
    end_dt = datetime.strptime(end, "%Y-%m-%d %H:%M:00")
    filter_item = list(filter(lambda x: 'value' in x and 'isAnomaly' in x['value'] and datetime.strptime( x['timestamp'],"%Y-%m-%dT%H:%M:00Z") >= start_dt and datetime.strptime( x['timestamp'],"%Y-%m-%dT%H:%M:00Z") <= end_dt, raw_result['results']))
    timestamps = [item['timestamp'] for item in filter_item]
    isAnomaly = [item['value']['isAnomaly'] for item in filter_item]
    score = [item['value']['score'] for item in filter_item]
    Severity = [item['value']['severity'] for item in filter_item]
    result = pd.DataFrame({'Timestamp': timestamps, 'isAnomaly': isAnomaly, 'score': score, 'Severity': Severity})
    result.loc[(result.Severity <= (1 - sensitivity)) & (result.isAnomaly == True), 'isAnomaly'] = False
    result['Timestamp'] = pd.to_datetime(result['Timestamp'])
    result.set_index(['Timestamp'], inplace=True)
    result = result.reindex(['isAnomaly', 'score', 'Severity'], axis=1)
    colors = ['red', 'blue', 'black']

    ##### Append the detected anomaly results on the graph ######
    
    # append anomaly results to graph
    for col, color in zip(result.columns, colors):
        p = figure(background_fill_color="#fafafa", x_axis_type="datetime")        
        p.line(result.index, result[col], color=color, alpha=0.8, legend_label=col)
        #configure datetime format to be display on the x-axis
        p.xaxis.formatter = DatetimeTickFormatter(
            days=["%m/%d %H:%M"],
            months=["%m/%d %H:%M"],
            years=["%m/%d %H:%M"],
            hours=["%m/%d %H:%M"],
            minutes=["%m/%d %H:%M"]
        )
        p.xaxis.major_label_orientation = pi/4
        
        #define display information when cursor hovered over a data point
        hover = HoverTool(tooltips=[( 'Timestamp', '@x{%Y-%m-%d %H:%M:%S.%3N}'), ('value', '@y')],
            formatters = {'@x' : 'datetime'},)
        p.add_tools(hover)     
        p_list.append(p)
    grid = gridplot([[x] for x in p_list], sizing_mode='scale_width', plot_height=70)
    show(grid)
    
    #get anomaly with the highest anomaly score
    result = result.sort_values(by=['score'], ascending=False)  
    top_anomaly = list(result[result.isAnomaly].index.strftime('%Y-%m-%dT%H:%M:%SZ'))[0]
    top_anomaly_list = list(result[result.isAnomaly])[0]   
    return series, raw_result, top_anomaly
   ```

## Display graph with household smart meter anomalies 

Now we'll run the application to display the graph showing the energy use behavior for a household and the anomalies found.

```python
severity = 0.9
local_data_path = "smart_meter_data.zip"
test_start_date = "2006-12-19 00:00:00"
test_end_date = "2006-12-19 20:26:00"

series, raw_result, top_anomaly = draw(BLOB_SOURCE, local_data_path, result_id, severity, test_start_date, test_end_date)
```
[ ![Diagram displaying graph showing anomalies.](..\media\7-exercise-evaluate-and-visualize-anomaly-contributors-1.png) ](..\media\7-exercise-evaluate-and-visualize-anomaly-contributors-1.png#lightbox)

## Find contributors of an anomaly

We'll define a function to display the JSON results at a timestamp where an anomaly was found. It will show the anomaly contributors at that timestamp. This will give you an idea of the root cause.

```python
import json

def show_contribution(raw_result, anomaly_timestamp):
    anomalies = [x for x in raw_result['results'] if 'interpretation' in x['value'] and x['timestamp'] == top_anomaly]
    anomaly_result = anomalies[0]
    formatted_str = json.dumps(anomaly_result, indent=2)
    print(formatted_str)
```

When an anomaly is detected at a given timestamp, the multivariate Result API will return a list of contributors for that timestamp. The culprits of the anomaly are ranked by the contributorScore. The variable with the highest contributorScore will be the main problem. In this case, the anomaly at timestamp _2006-12-19T08:42:00Z_ came from the _Kitchen sub meter_.

```python
print("Top anomaly timestamp: ", top_anomaly)
show_contribution(raw_result, top_anomaly)
```
[ ![Diagram displaying contributors of an anomaly.](..\media\7-exercise-evaluate-and-visualize-anomaly-contributors-2.png) ](..\media\7-exercise-evaluate-and-visualize-anomaly-contributors-2.png#lightbox)

Congratulations, you have completed the exercises in this module!  See the summary to see how you can apply the techniques you have learned in your applications.