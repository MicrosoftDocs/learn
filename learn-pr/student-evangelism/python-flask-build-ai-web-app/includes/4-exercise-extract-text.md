Azure Cognitive Services is a set of more than 20 services and APIs for infusing intelligence backed by machine learning and neural networks into the applications that you write. One member of the Cognitive Services family is the Computer Vision API, which can analyze images uploaded to the service. The API supports the following actions:

- Identify objects in images.
- Generate captions for images (for example, "A child riding a bicycle").
- Use optical character recognition (OCR) to extract text from images.
- Find faces in images and identify facial attributes like age and gender.
- Generate "smart thumbnails" centered on the subjects of images. 
- Recognize famous people and landmarks in images.

Like all Cognitive Services APIs, the Computer Vision API is invoked by placing calls over the internet to a REST endpoint. Rather than place those calls directly, you can use the Python SDK for the Computer Vision API to simplify your code. The SDK abstracts calls to the Computer Vision API and handles JSON payloads so you don't have to write code to generate and consume JSON.

The OCR feature of the Computer Vision API will enable the Contoso Travel website to extract text from images. In this unit, you'll modify the Contoso Travel site to use the Computer Vision API to extract text from uploaded photos.

Resources that are used in this exercise are located in a [Git repository for code samples](https://github.com/MicrosoftDocs/mslearn-build-ai-web-app-with-python-and-flask).


### Reactivate your virtual environment

> _Only complete the steps in this section if you closed the Command Prompt window or terminal where you were running your Python virtual environment. Otherwise, continue to the next section, "Subscribe to the Computer Vision API."_
>
> If you closed your Command Prompt window or terminal, you need to configure a new window or terminal to use your existing Python virtual environment. Flask also needs to be set to development mode again with the environment variable.
>
> 1. Open a new Command Prompt window or terminal. Change (`cd`) to your project directory. For details, see the section "Create the project directory" in the [Exercise - Set up a development environment](../1-exercise-set-up-environment.yml?azure-portal=true) unit. <!-- #create-the-project-directory -->
> 
> 1. Reactivate your Python virtual environment. For details, see the section "Activate your virtual environment" in the [Exercise - Set up a development environment](../1-exercise-set-up-environment.yml?azure-portal=true) unit. <!-- #activate-your-virtual-environment -->
> 
> 1. Re-add the **FLASK_ENV** environment variable. For details, see the section "Set the Flask environment variable" in the [Exercise - Build a page for uploading photos](../3-exercise-upload-photos.yml?azure-portal=true) unit. <!-- #set-the-flask-environment-variable -->
>


## Subscribe to the Computer Vision API

To call the Computer Vision API, you must first obtain an API key. This key travels in each request you place to the Computer Vision API in an HTTP header named `Ocp-Apim-Subscription-Key`. Azure uses the key to authenticate the caller and determine which Azure subscription to bill calls to. Most Azure Cognitive Services APIs have free tiers for which no billing is performed. But if you plan to place thousands of calls a day to a Cognitive Services API, you'll be billed for it through your Azure subscription.

You can get a Computer Vision API key by using the Azure CLI or the Azure portal. In this exercise, you'll get an API key and a corresponding URL for placing calls to the Computer Vision API with that key by using the Azure CLI.


### Install and sign into the Azure CLI

To complete the steps in this unit, the Azure CLI needs to be installed and you must be signed in.

If you haven't installed the Azure CLI, see the instructions for how to "Install the Azure CLI" in the [Exercise - Set up a development environment](../1-exercise-set-up-environment.yml?azure-portal=true) unit. After you complete the install, sign in with your Microsoft account. <!-- #install-the-azure-cli --> 


### Create the resource group

You need to create a resource group to hold all of the Azure resources that you create in this module. 

Use the following command to create a resource group named **contoso-travel-rg** in the Azure North Central US region:

```console
az group create --name contoso-travel-rg --location northcentralus
``` 

Resource groups are an important feature of Azure. They serve as containers that group together other Azure resources. When you run a task on a resource group, the task impacts all resources in the group. You can view billing information, apply security rules, and even delete all resources, and all these tasks affect all Azure resources in the resource group. *Every* Azure resource that you create must be part of a resource group.


### Subscribe to the API

Now use the following command to subscribe to the Computer Vision API. A new resource named **computer-vision** will be added to the resource group you created:

```console
az cognitiveservices account create --resource-group contoso-travel-rg --name computer-vision --location northcentralus --kind ComputerVision --sku F0 --yes
```

The `--sku F0` parameter subscribes to the free tier of the Computer Vision API that allows up to 20 calls per minute and a maximum of 5,000 calls per month. This approach is fine for development, but in production, you would want to subscribe to one of the paid tiers that support more traffic. For a summation of pricing tiers for the Computer Vision API, see [Cognitive Services pricing - Computer Vision API](https://azure.microsoft.com/pricing/details/cognitive-services/computer-vision/?azure-portal=true).


### Get an API key for the Computer Vision API

Next, use the following command to get an API key for the Computer Vision API:

```console
az cognitiveservices account keys list --resource-group contoso-travel-rg --name computer-vision --query key1 --output tsv
```

The output from the command is a string that contains numbers and letters. **This value is your Computer Vision API key**. Copy the key to a text file and save it so you can easily retrieve it. You'll need the key later in this unit and in a subsequent unit.


### Get an endpoint URL to call the Computer Vision API

Now use the following command to get the endpoint for when we call the Computer Vision API:

```console
az cognitiveservices account show --name computer-vision --resource-group contoso-travel-rg --query properties.endpoint --output tsv
```

The endpoint URL is composed of "https://" + your region + ".api.cognitive.microsoft.com/". Save the endpoint URL in a text file so you can easily retrieve it.

The choice of **North Central US** as the region for your Computer Vision API resource *and* the resource group that holds it isn't arbitrary. You can locate a resource group and its resources in any of the more than 50 regions that Azure supports. However, it's desirable to locate all the resources that compose a resource group in the same region in order to minimize cost and maximize performance. 

The Computer Vision API isn't supported in all regions, but it is supported in North Central US. For a list of regions in which Cognitive Services is available, refer to [Products available by region](https://azure.microsoft.com/global-infrastructure/services/?products=cognitive-services?azure-portal=true).


## Modify the site to use the Computer Vision API

You're now subscribed to the Computer Vision API and have an endpoint and a key to call the API. The next step is to modify the Contoso Travel website to use these values to call the Computer Vision API and extract text from photos.


### Update the code

We need to update the **app.py** file and the **index.html** file.

1. In Visual Studio Code, open the **app.py** file and replace the contents with the following code:

    ```python
    import os, base64
    from flask import Flask, render_template, request, flash

    from azure.cognitiveservices.vision.computervision import ComputerVisionClient
    from azure.cognitiveservices.vision.computervision.models import VisualFeatureTypes
    from azure.cognitiveservices.vision.computervision.models import ComputerVisionErrorException
    from msrest.authentication import CognitiveServicesCredentials

    # Create a ComputerVisionClient instance to call the Computer Vision API
    vision_key = os.environ["VISION_KEY"]
    vision_endpoint = os.environ["VISION_ENDPOINT"]
    vision_credentials = CognitiveServicesCredentials(vision_key)
    vision_client = ComputerVisionClient(vision_endpoint, vision_credentials)

    app = Flask(__name__)
    app.secret_key = os.urandom(24)

    @app.route("/", methods=["GET", "POST"])
    def index():
        if request.method == "POST":
            # Display the image that was uploaded
            image = request.files["file"]
            uri = "data:image/jpg;base64," + base64.b64encode(image.read()).decode("utf-8")
            image.seek(0)

            # Use the Computer Vision API to extract text from the image
            lines = extract_text_from_image(image, vision_client)

            # Flash the extracted text
            for line in lines:
                flash(line)

        else:
            # Display a placeholder image
            uri = "/static/placeholder.png"

        return render_template("index.html", image_uri=uri)

    # Method that extracts text from images
    def extract_text_from_image(image, client):
        try:
            result = client.recognize_printed_text_in_stream(image=image)
            lines=[]

            if len(result.regions) == 0:
                lines.append("Photo contains no text to translate")

            else:
                for line in result.regions[0].lines:
                    text = " ".join([word.text for word in line.words])
                    lines.append(text)

            return lines

        except ComputerVisionErrorException as e:
            return ["Computer Vision API error: " + e.message]

        except:
            return ["Error calling the Computer Vision API"]
    ```

    The modified **app.py** file defines a method named `extract_text_from_image()` that accepts an image and a `ComputerVisionClient` instance. The method calls the `ComputerVisionClient.recognize_printed_text_in_stream()` method to pass the image to the Computer Vision API. It also returns one or more lines of text representing the text extracted from the image, a message indicating no text was found, or an error message indicating that something went wrong.

    The `index()` method calls the `extract_text_from_image()` method each time a photo is uploaded and uses the Flask `flash()` function to "flash" the results.

    The `ComputerVisionClient` object comes from the Python SDK for the Computer Vision API. An instance is created and initialized with your Computer Vision API endpoint and API key when the application starts up. The endpoint and API key are read from environment variables through the Python `os.environ` mapping object.

1. Now open the **index.html** file. Add the following code and markup before the `<script>` element at the bottom of the file:

    ```html
    <div class="container">
        <div class="row">
            <div id="myModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Result</h4>
                        </div>
                        <div class="modal-body"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    {% with messages = get_flashed_messages() %}
        {% if messages %}
            <script type="text/javascript">
                // If flash messages are queued up, show them in a modal dialog box
                var messages = {{ messages | safe }};
                body = $(".modal-body");
                body.empty();

                for (i=0; i<messages.length; i++) {
                    body.append("<h2>" +  messages[i] + "</h2>");
                }

                $("#myModal").modal("show");
            </script>
        {% endif %}
    {% endwith %}
    ```

    The first section of this code defines a modal dialog box by using Bootstrap. The second section populates the dialog box with the text that's returned by the `extract_text_from_image()` method and flashed by the `index()` method, and then displays the dialog box on the website page.

Save your changes to the **index.html** and **app.py** files.


## Set Computer Vision environment variables

Now we need to set two local environment variables that correspond to the Computer Vision API key and the URL endpoint.

Return to your Command Prompt window or terminal. In the following command, replace `<computer_vision_api_key>` with your API key and `<computer_vision_endpoint>` with your endpoint URL. For details, see the earlier sections "Get an API key for the Computer Vision API" and "Get an endpoint URL to call the Computer Vision API." <!-- #get-an-api-key-for-the-computer-vision-api AND #get-an-endpoint-url-to-call-the-computer-vision-api -->

- **Windows**

   ```command
   set VISION_KEY=<computer_vision_api_key>
   set VISION_ENDPOINT=<computer_vision_endpoint>
   ```

- **macOS or Linux**

   ```console
   export VISION_KEY=<computer_vision_api_key>
   export VISION_ENDPOINT=<computer_vision_endpoint>
   ```

When your website is running locally, calls to the `os.environ` mapping object will load these variables from the environment. Later, when you deploy your website to Azure, the same variables will come from application settings in Azure. No code changes will be required.


## Extract text from photos

Now let's run the modified website, upload a few photos, and try out the Computer Vision API.

1. In your Command Prompt window or terminal, make sure the current directory is still set to **mslearn-build-ai-web-app-with-python-and-flask/src/starter** in your project directory. Then restart Flask:

    ```console
    flask run
    ```

1. Refresh your website page in the browser, or open a new browser window and go to `http://localhost:5000/`.

1. Select the **Upload Photo** button and upload a picture that contains text. Confirm that after a brief pause, the text extracted from the photo appears in a modal dialog box. Then dismiss the dialog box.

    ![Screenshot that shows the Contoso Travel web site extracting text from a photo.](../media/extracted-text.png)

    _Extracting text from a photo_

Repeat this process with other photos to gauge the Computer Vision API's ability to extract text from uploaded photos. This ability isn't perfect, but the API should get the extraction right, or almost right, most of the time.


## Stop Flask

Stop Flask with the CTRL+C command. You'll restart Flask when you're ready to test the new updates to your website.

Leave your Command Prompt window or terminal open. You'll return to it in the next unit.


## Next steps

Now your Flask website can accept photo uploads and extract text from the photos. The next step is to be able to pass text extracted from photos with the Computer Vision API and translate the text into another language. For this task, you'll learn how to use the Cognitive Services Translator Text API.
