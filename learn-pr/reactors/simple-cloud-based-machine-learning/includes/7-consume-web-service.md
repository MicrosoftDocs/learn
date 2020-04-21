> [!Note]
> **Sarah: Conversion feedback**
> 
> - Suggest moving the **Takeaway** at the end of the unit, to the list of Learning objectives
>    in the Introduction unit or to the abstract summary in the module index.yml.

> [!Note]
> **Sarah: Action items**
> 
> - Try it yourself block needs Input and Output code, and Hint text. Search on TBD.
> - Need output cell content. Search on TBD.
>

Next, consume the web service. To see if this works, try it here from the notebook session in which the web service was created. Just call the predictor directly:

```Python
forest_fire_predictor.service(5.4, 0.2, 9, 22.1)
```

Here's the output:

```Output
TBD
```

At any later time, you can use the stored API key and service URL to call the service. In the example below, data can be packaged in JavaScript Object Notation (JSON) format and sent to the web service.

```Python
import urllib2
import json

data = {"Inputs": { 
            "input1": {
                "ColumnNames": [ "wind", "rain", "month", "RH"],
                "Values": [["5.4", "0.2", "9", "22.1"]] 
            }
        }, # Specified feature values
        
        "GlobalParameters": {}
    }

body = json.dumps(data)
headers = {'Content-Type':'application/json', 'Authorization':('Bearer '+ api_key)}
req = urllib2.Request(service_url, body, headers) 

try:
    response = urllib2.urlopen(req)
    result = json.loads(response.read())  # load JSON-formatted string response as dictionary
    print(result['Results']['output1']['value']['Values'][0][0]) # Get the returned prediction
    
except urllib2.HTTPError, error:
    print("The request failed with status code: " + str(error.code))
    print(error.info())
    print(json.loads(error.read()))
```

The output is:

```Output
TBD
```

### Try it yourself

Try this same process of training and hosting a model through Azure ML Studio with the _Pima Indians Diabetes_ dataset (in CSV format in your data folder). The dataset has nine columns. Use any of the eight features you choose to try and predict the ninth column, `Outcome (1 = diabetes, 0 = no diabetes)`.

<details> 

  <summary>Hint - TBD<i>(expand to reveal)</i></summary>

  ```Python
  TBD
  ```

  ```Output
  TBD
  ```
  
</details>

***

> [!div class="alert is-tip"]
> ### Takeaway
>
> In this module, you explored fitting a model and deploying it as a web service. You did this by using now-familiar tools in an Azure Notebook to build a model relating variables surrounding forest fires and then posting that as a function in Azure ML Studio. From there, you saw how you and others can access the pre-fitted models to make predictions on new data from anywhere on the web.

You have now created your own ML web service. Let's now see how you can also interact with existing ML web services for even more sophisticated applications.
