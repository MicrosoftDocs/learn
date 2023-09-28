Computer vision is a hot topic in academic AI research and in business, medical, government, and environmental applications. We'll explore it here by seeing firsthand how computers can tag and identify images.

Make sure you've run `pip install` for the `azure-cognitiveservices-vision-computervision` package within your environment first.

The first step in using the Azure AI Vision API is to create a client object by using the `ComputerVisionClient` class.

Replace `ACCOUNT_ENDPOINT` with the account endpoint provided from the free trial. Replace `ACCOUNT_KEY` with the account key provided from the free trial.

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

Now that we have a client object to work with, let's see what we can do.

By using `analyze_image`, we can see the properties of the image with `VisualFeatureTypes.tags`.

```python
url = 'https://cdn.pixabay.com/photo/2014/05/02/23/54/times-square-336508_960_720.jpg'

image_analysis = client.analyze_image(url,visual_features=[VisualFeatureTypes.tags])

for tag in image_analysis.tags:
    print(tag)
```

Here's the output:

```output
{'additional_properties': {}, 'name': 'text', 'confidence': 0.9976017475128174, 'hint': None}
{'additional_properties': {}, 'name': 'skyscraper', 'confidence': 0.9624584913253784, 'hint': None}
{'additional_properties': {}, 'name': 'city', 'confidence': 0.9478592872619629, 'hint': None}
{'additional_properties': {}, 'name': 'billboard', 'confidence': 0.9370654821395874, 'hint': None}
{'additional_properties': {}, 'name': 'building', 'confidence': 0.8910864591598511, 'hint': None}
{'additional_properties': {}, 'name': 'light', 'confidence': 0.7848806381225586, 'hint': None}
{'additional_properties': {}, 'name': 'street', 'confidence': 0.6592667102813721, 'hint': None}
{'additional_properties': {}, 'name': 'night', 'confidence': 0.3002099096775055, 'hint': None}
{'additional_properties': {}, 'name': 'several', 'confidence': 0.19980567693710327, 'hint': None}
{'additional_properties': {}, 'name': 'crowd', 'confidence': 0.0050629377365112305, 'hint': None}
```

### Try it yourself

How can you use the previous code to also see the description by using the `VisualFeatureTypes` property?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  image_analysis_desc = client.analyze_image(url,visual_features=[VisualFeatureTypes.description])
  print(image_analysis_desc)
  ```

  The output is:

  ```output
  {'color': None, 'image_type': None, 'categories': None, 'tags': None, 'metadata': <azure.cognitiveservices.vision.computervision.models._models_py3.ImageMetadata object at 0x7fb6c8923f98>, 'additional_properties': {}, 'brands': None, 'objects': None, 'adult': None, 'faces': None, 'description': <azure.cognitiveservices.vision.computervision.models._models_py3.ImageDescriptionDetails object at 0x7fb6c8923550>, 'request_id': 'e72fb514-00bd-4735-ac8b-7c4671c336ba'}
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

```output
{'additional_properties': {}, 'name': 'celebrities', 'categories': ['people_', '人_', 'pessoas_', 'gente_']}
{'additional_properties': {}, 'name': 'landmarks', 'categories': ['outdoor_', '户外_', '屋外_', 'aoarlivre_', 'alairelibre_', 'building_', '建筑_', '建物_', 'edifício_']}
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

```output
Space Needle
0.9998365640640259
```

### Try it yourself

How can you use the previous code to predict an image of a celebrity by using [this image](https://images.pexels.com/photos/270968/pexels-photo-270968.jpeg?azure-portal=true)? Remember that the domains were printed out earlier.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  domain_2 = "celebrities"

  # Public-domain image of Seattle
  url_2 = "https://images.pexels.com/photos/270968/pexels-photo-270968.jpeg"

  analysis_2 = client.analyze_image_by_domain(domain_2, url_2, language)

  for celebrities in analysis_2.result["celebrities"]:
      print(celebrities["name"])
      print(celebrities["confidence"])
  ```

  The output is:

  ```output
  Elvis Presley
  0.9977160692214966
  ```

</details>

<br /><br />

***

Let's see how we can get a text description of an image by using the `describe_image` method. Use `max_descriptions` to retrieve how many descriptions of the image the API service can find.

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

```output
a bridge over a body of water
0.6252799422757869
a bird standing on a bridge
0.3151035321369864
a bridge over some water
0.3141035321369864
```

### Try it yourself

What other descriptions can be found with other images?
What happens if you change the count of descriptions to output?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  max_descriptions = 2

  analysis_2 = client.describe_image(url_2, max_descriptions, language)

  for caption in analysis_2.captions:
      print(caption.text)
      print(caption.confidence)
  ```

  The output is:

  ```output
  Elvis Presley jumping a skate board
  0.3821096023262668
  Elvis Presley riding a skate board in the air
  0.26785632250282876
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

# Async SDK call
recognize_printed_results = client.batch_read_file(url,  raw=True)

# Get the operation location (URL with an ID at the end) from the response
operation_location_remote = recognize_printed_results.headers["Operation-Location"]
# Grab the ID from the URL
operation_id = operation_location_remote.split("/")[-1]

# Call the "GET" API and wait for it to retrieve the results 
while True:
    get_printed_text_results = client.get_read_operation_result(operation_id)
    if get_printed_text_results.status not in ['NotStarted', 'Running']:
        break
    time.sleep(1)

# Print the detected text, line by line
if get_printed_text_results.status == TextOperationStatusCodes.succeeded:
    for text_result in get_printed_text_results.recognition_results:
        for line in text_result.lines:
            print(line.text)
            print(line.bounding_box)
print()
```

Here's the output:

```output
OU
[496.0, 2324.0, 1225.0, 1745.0, 1718.0, 2323.0, 919.0, 2902.0]
UTSIL
[944.0, 2061.0, 1921.0, 955.0, 2338.0, 1213.0, 1458.0, 2462.0]
OF THE BO
[1102.0, 3226.0, 2829.0, 481.0, 3389.0, 833.0, 1661.0, 3467.0]
```

### Try it yourself

What other images with words can be analyzed?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  url = "https://cdn.pixabay.com/photo/2016/10/20/08/55/board-1754932_960_720.jpg"

  # Async SDK call
  recognize_printed_results = client.batch_read_file(url,  raw=True)

  # Get the operation location (URL with an ID at the end) from the response
  operation_location_remote = recognize_printed_results.headers["Operation-Location"]
  # Grab the ID from the URL
  operation_id = operation_location_remote.split("/")[-1]

  # Call the "GET" API and wait for it to retrieve the results 
  while True:
      get_printed_text_results = client.get_read_operation_result(operation_id)
      if get_printed_text_results.status not in ['NotStarted', 'Running']:
          break
      time.sleep(1)

  # Print the detected text, line by line
  if get_printed_text_results.status == TextOperationStatusCodes.succeeded:
      for text_result in get_printed_text_results.recognition_results:
          for line in text_result.lines:
              print(line.text)
              print(line.bounding_box)
  print()
  ```

  The output is:

  ```output
  If you stumble
  [151.0, 128.0, 816.0, 108.0, 819.0, 203.0, 154.0, 224.0]
  make it part
  [162.0, 268.0, 772.0, 253.0, 774.0, 347.0, 164.0, 362.0]
  of the dance
  [202.0, 391.0, 839.0, 382.0, 841.0, 485.0, 204.0, 495.0]
  author unknown
  [533.0, 504.0, 898.0, 506.0, 897.0, 572.0, 533.0, 571.0]
  ```

</details>

<br /><br />

***

You can find more Azure AI services demonstrations at the following URLs:

- [Hands on with AI - Interactive demos](https://aidemos.microsoft.com?azure-portal=true)
- [Student demos on GitHub](https://github.com/microsoft/AcademicContent/tree/main/archive/Events%20and%20Hacks)
- [Azure AI services site](https://azure.microsoft.com/services/cognitive-services/directory/?azure-portal=true)

Images come in varying sizes. Sometimes you might want to create a thumbnail of an image. For these cases, we need to install the Pillow library. To learn about the Pillow library, see the [Pillow website](https://python-pillow.org/). Pillow is the Python Imaging Library (PIL) fork, which allows for image processing.

```python
# Install Pillow
!pip install Pillow
```

Now that the Pillow library is installed, we'll import the Image module and create a thumbnail from a provided image. After it's generated, you can find the thumbnail image in your project folder.

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

:::image type="content" alt-text="A generated thumbnail." source="../media/thumbnail.jpg" loc-scope="azure":::
