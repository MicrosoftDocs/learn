> [!Note]
> **Sarah: Conversion feedback**
> 
> - Suggest moving the **Takeaway** at the end of the unit, to the list of Learning objectives
>    in the Introduction unit or to the abstract summary in the module index.yml.

> [!Note]
> **Sarah: Action items**
> 
> - Try it yourself blocks need Input and Output code, and Hint text. Search on TBD.
> - Need output cell content. Search on TBD.
> - Several Input cells need intro statements. Search on "Add introduction"
>

Computer vision is a hot topic in academic AI research and in business, medical, government, and environmental applications. We will explore it here by seeing firsthand how computers can tag and identify images.

The first step in using the Cognitive Services Computer Vision API is to create a client object using the` ComputerVisionClient` class.

Replace `ACCOUNT_ENDPOINT` with the account endpoint provided from the free trial. Replace `ACCOUNT_KEY` with the account key provided from the free trial.

```python
!pip install azure-cognitiveservices-vision-computervision
```

The output is:

```Output
TBD
```

<!-- Add introduction for snippet -->

```python
from azure.cognitiveservices.vision.computervision.models import VisualFeatureTypes
from msrest.authentication import CognitiveServicesCredentials

# Get endpoint and key from environment variables
endpoint = 'ACCOUNT_ENDPOINT'
# Example: endpoint = 'https://westcentralus.api.cognitive.microsoft.com'
key = 'ACCOUNT_KEY'
# Example key = '1234567890abcdefghijklmnopqrstuv

# Set credentials
credentials = CognitiveServicesCredentials(key)

# Create client
client = ComputerVisionClient(endpoint, credentials)
```

Here's the output:

```Output
TBD
```

Now that we have a client object to work with, let's see what we can do.

By using `analyze_image`, we can see the properties of the image with `VisualFeatureTypes.tags`.

```python
url = 'https://cdn.pixabay.com/photo/2014/05/02/23/54/times-square-336508_960_720.jpg'

image_analysis = client.analyze_image(url,visual_features=[VisualFeatureTypes.tags])

for tag in image_analysis.tags:
    print(tag)
```

Here's the output:

```Output
TBD
```

### Try it yourself

How can you use the code above to also see the description by using the `VisualFeatureTypes` property?

<br />

<details> 

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  tbd
  ```

  The output is:

  ```Output
  tbd
  ```
  
</details>

<br /><br />

***

Now let's look at the subject domain of the image. An example of a domain is celebrity. As of now, the `analyze_image_by_domain` method only supports celebrities and landmarks domain-specific models.

```python
# This will list the available subject domains 
models = client.list_models()

for x in models.models_property:
    print(x)
```

Here's the output:

```Output
TBD
```

Let's analyze an image by domain:

```python
domain = "landmarks"

# Public-domain image of Seattle
url = "https://images.pexels.com/photos/37350/space-needle-seattle-washington-cityscape.jpg"

# English-language response
language = "en"

analysis = client.analyze_image_by_domain(domain, url, language)

for landmark in analysis.result["landmarks"]:
    print(landmark["name"])
    print(landmark["confidence"])
```    

Here's the output:

```Output
TBD
```

### Try it yourself

How can you use the code above to predict an image of a celebrity, by using [this image](https://images.pexels.com/photos/270968/pexels-photo-270968.jpeg?azure-portal=true)? Remember that the domains were printed out earlier.

<br />

<details> 

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  tbd
  ```

  The output is:

  ```Output
  tbd
  ```
  
</details>

<br /><br />

***

Let's see how we can get a text description of an image using the `describe_image` method. Use `max_description`s to retrieve how many descriptions of the image the API service can find.

```python
domain = "landmarks"
url = "https://images.pexels.com/photos/726484/pexels-photo-726484.jpeg"
language = "en"
max_descriptions = 3

analysis = client.describe_image(url, max_descriptions, language)

for caption in analysis.captions:
    print(caption.text)
    print(caption.confidence)
```

Here's the output:

```Output
TBD
```

### Try it yourself

What other descriptions can be found with other images?
What happens if you change the count of descriptions to output?

<br />

<details> 

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  tbd
  ```

  The output is:

  ```Output
  tbd
  ```
  
</details>

<br /><br />

***

Let's say that the images contain text. How do we retrieve that information?

There are two methods that need to be used for this type of call:
- `Batch_read_file`
- `get_read_operation_result`

`TextOperationStatusCodes` is used to ensure that the `batch_read_file` call is completed before the text is read from the image.

```python
# import models
from azure.cognitiveservices.vision.computervision.models import TextRecognitionMode
from azure.cognitiveservices.vision.computervision.models import TextOperationStatusCodes
import time

url = "https://images.pexels.com/photos/6375/quote-chalk-think-words.jpg"
mode = TextRecognitionMode.handwritten
raw = True
custom_headers = None
numberOfCharsInOperationId = 36

# Async SDK call
rawHttpResponse = client.batch_read_file(url, mode, custom_headers,  raw)

# Get ID from returned headers
operationLocation = rawHttpResponse.headers["Operation-Location"]
idLocation = len(operationLocation) - numberOfCharsInOperationId
operationId = operationLocation[idLocation:]

# SDK call
while True:
    result = client.get_read_operation_result(operationId)
    if result.status not in ['NotStarted', 'Running']:
        break
    time.sleep(1)

# Get data
if result.status == TextOperationStatusCodes.succeeded:
    for textResult in result.recognition_results:
        for line in textResult.lines:
            print(line.text)
            print(line.bounding_box)
```

Here's the output:

```Output
TBD
```

### Try it yourself

What other images with words can be analyzed?

<br />

<details> 

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  tbd
  ```

  The output is:

  ```Output
  tbd
  ```
  
</details>

<br /><br />

***

You can find more Cognitive Services demonstrations at the following URLs:

- [Hands on with AI - Interactive demos](https://aidemos.microsoft.com?azure-portal=true)
- [Student demos on GitHub](https://github.com/microsoft/AcademicContent/tree/master/Events%20and%20Hacks/Student%20Hacks?azure-portal=true)
- [Cognitive Services site](https://azure.microsoft.com/services/cognitive-services/directory/?azure-portal=true)

Images come in varying sizes, and there might be cases where you want to create a thumbnail of the image. For this, we need to install the Pillow library, which you can learn about at https://python-pillow.org/. Pillow is the PIL fork, or Python Imaging Library, which allows for image processing.

```python
# Install Pillow
!pip install Pillow
```

Here's the output:

```Output
TBD
```

Now that the Pillow library is installed, we will import the Image module and create a thumbnail from a provided image. (Once generated, you can find the thumbnail image in your project folder on Azure Notebooks.)

```python
# Pillow package
from PIL import Image

# IO package to create local image
import io

width = 50
height = 50
url = "https://images.pexels.com/photos/37350/space-needle-seattle-washington-cityscape.jpg"

thumbnail = client.generate_thumbnail(width, height, url)

for x in thumbnail:
    image = Image.open(io.BytesIO(x))

image.save('thumbnail.jpg')
```

The output is:

```Output
TBD
```

> [!div class="alert is-tip"]
> ### Takeaway
>
> In this unit, you explored how to access computer-vision cognitive services by API. Specifically, you used tools to analyze and describe images that you submitted to these services.
