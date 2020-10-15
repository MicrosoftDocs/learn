The Translator Text API is the member of Azure Cognitive Services that translates text from one language to another. It relies on state-of-the-art neural machine translation (NMT) and supports more than 60 languages.

Like the Computer Vision API, the Translator Text API is invoked through REST calls over the internet. Unlike the Computer Vision API, the Translator Text API currently has no Python SDK available. That doesn't mean you can't use it from a Python application. It means that you must invoke the API by using raw HTTP requests and write code to parse the JSON payloads that are returned.

It's not as hard as it sounds, as you will prove when you modify the Contoso Travel site to pass text extracted from photos by the Computer Vision API to the Translator Text API for translation into another language.

Resources that are used in this exercise are located in a [Git repository for code samples](https://github.com/MicrosoftDocs/mslearn-build-ai-web-app-with-python-and-flask?azure-portal=true).


### Reactivate your virtual environment

> Only complete the steps in this section if you closed the Command Prompt window or terminal where you were running your Python virtual environment. Otherwise, continue to the next section, "Subscribe to the Translator Text API."

If you closed your Command Prompt window or terminal, you need to configure a new window or terminal to use your existing Python virtual environment. The environment variables also need to be recreated.

1. Open a new Command Prompt window or terminal. Change (`cd`) to your project directory. For details, see the section "Create the project directory" in the [Exercise - Set up a development environment](../1-exercise-set-up-environment?azure-portal=true) unit. <!-- #create-the-project-directory -->

1. Reactivate your Python virtual environment. For details, see the section "Activate your virtual environment" in the [Exercise - Set up a development environment](../1-exercise-set-up-environment?azure-portal=true) unit. <!-- #activate-your-virtual-environment -->
 
1. Reset the **FLASK_ENV** environment variable. For details, see the section "Set the Flask environment variable" in the [Exercise - Build a page for uploading photos](../3-exercise-upload-photos?azure-portal=true) unit. <!-- #set-the-flask-environment-variable -->

1. Reset the **VISION_KEY** and **VISION_ENDPOINT** environment variables. For details, see the section "Set Computer Vision environment variables" in the [Exercise - Use Cognitive Services to extract text from photos](../4-exercise-extract-text?azure-portal=true) unit. <!-- #set-computer-vision-environment-variables -->


## Subscribe to the Translator Text API

To call the Translator Text API, you must obtain an API key. As with the Computer Vision API, this key travels in each request that you place to the Translator Text API in an `Ocp-Apim-Subscription-Key` header and maps calls to Azure subscriptions.

In your Command Prompt window or terminal, use the following command to subscribe to the Translator Text API. A new resource named **translator-text** will be added to the resource group that you created earlier in the [Exercise - Use Cognitive Services to extract text from photos](https://docs.microsoft.com/learn/modules/python-flask-build-ai-web-app/4-exercise-extract-text?azure-portal=true) unit. <!-- #create-the-resource-group --> 

```console
az cognitiveservices account create --resource-group contoso-travel-rg --name translator-text --location global --kind TextTranslation --sku F0 --yes
```

Unlike the Computer Vision API, which requires you to specify an Azure region, the Translator Text API is a "global" API that doesn't live in a specific region. That's the reason for the `--location global` parameter. Among other things, you don't have to retrieve an endpoint URL for the Translator Text API as you do for the Computer Vision API. One endpoint, `https://api.cognitive.microsofttranslator.com/translate?api-version=3.0`, serves all regions.


### Get an API key for the Translator Text API

Next, use the following command to get an API key for the Translator Text API:

```console
az cognitiveservices account keys list --resource-group contoso-travel-rg --name translator-text --query key1 --output tsv
```

The output from the command is a string that contains numbers and letters. **This value is your Translator Text API key**. Copy the key to a text file and save it so you can easily retrieve it. You'll need the key later in this unit and in a subsequent unit.

This API key uses the Text Translator API's free tier (`--sku F0`), which supports translating up to 2 million characters of text per month. In a production environment, you would want to subscribe to one of the [paid tiers](https://azure.microsoft.com/pricing/details/cognitive-services/translator-text-api/?azure-portal=true).


## Modify the site to use the Translator Text API

You're now subscribed to the Translator Text API and have a key to call the API. The next step is to modify the Contoso Travel website to use the Translator Text API to translate text extracted from photos with the Computer Vision API.


### Update the code

We need to update the **app.py** file and the **index.html** file.

1. In Visual Studio Code, open the **index.html** file. Insert the following statements at line 42 in the file, just before the `<img>` element:

    ```html
    <select id="language" class="form-control" name="language">
        <option value="en">English</option>
        <option value="zh-Hant">Chinese (simplified)</option>
        <option value="zh-Hans">Chinese (traditional)</option>
        <option value="fr">French</option>
        <option value="de">German</option>
        <option value="it">Italian</option>
        <option value="ja">Japanese</option>
        <option value="ko">Korean</option>
        <option value="pt">Portugese</option>
        <option value="es">Spanish</option>
    </select>
    ```

    Here's the modified markup that shows the correct position of the new code in the file. Notice the indentation of the `<select>` element:

    ```html
    <div class="container">
        <div class="row">
            <div class="col-sm-12 text-center">
                <form method="POST" enctype="multipart/form-data">
                    <div style="display: none">
                        <input type="file" id="upload-file" name="file" accept=".jpg,.jpeg,.png,.gif">
                        <input type="submit" id="submit-button" value="Upload">
                    </div>
                    <select id="language" class="form-control" name="language">
                        <option value="en">English</option>
                        <option value="zh-Hant">Chinese (simplified)</option>
                        <option value="zh-Hans">Chinese (traditional)</option> 
                        <option value="fr">French</option>
                        <option value="de">German</option>
                        <option value="it">Italian</option>
                        <option value="ja">Japanese</option>
                        <option value="ko">Korean</option>
                        <option value="pt">Portugese</option>
                        <option value="es">Spanish</option>
                    </select>
                    <img id="uploaded-image" src="{{ image_uri }}">
                    <input type="button" id="upload-button" class="btn" value="Upload Photo">
                </form>
            </div>
        </div>
    </div>
    ```

    The added markup defines a drop-down list (an HTML `<select>` element) with a selection of languages that text can be translated into.

1. Also in the **index.html** file, add the following JavaScript statements near the end of the `<script>` block at the bottom of the file:

    ```javascript
    $("#language").val("{{ language }}");
    ```

    Here's how the modified `<script>` block should look in the file:

    ```javascript
    <script type="text/javascript">
        $(function() {
            $("#upload-button").click(function() {
                $("#upload-file").click();
            });

            $("#upload-file").change(function() {
                $("#submit-button").click();
            });

            $("#language").val("{{ language }}");
        });
    </script>
    ```

    The purpose of the added JavaScript statement is to initialize the drop-down list with the currently selected language. Without this statement, the drop-down list would revert to the default language (English) each time a photo is uploaded.

1. Now open the **app.py** file. Replace the first line of code with this statement:

    ```python
    import os, base64, json, requests
    ```

1. Next, add the following statements immediately after the statements that create a `ComputerVisionClient` instance. (These lines of code are near the top of the file.) This code fetches the Translator Text API key:

    ```python
    # Retrieve the Translator Text API key 
    translate_key = os.environ["TRANSLATE_KEY"]
    ```

1. Now locate the `index()` method in the **app.py** file. Replace the contents of the `index()` method with the following code:

    ```python
    @app.route("/", methods=["GET", "POST"])
    def index():

        language = "en"

        if request.method == "POST":
            # Display the image that was uploaded
            image = request.files["file"]
            uri = "data:image/jpg;base64," + base64.b64encode(image.read()).decode("utf-8")
            image.seek(0)

            # Use the Computer Vision API to extract text from the image
            lines = extract_text_from_image(image, vision_client)

            # Use the Translator Text API to translate text extracted from the image
            language = request.form.get("language", "en")
            translated_lines = translate_text(lines, language, translate_key)

            # Flash the translated text
            for translated_line in translated_lines:
                flash(translated_line)

        else:
            # Display a placeholder image
            uri = "/static/placeholder.png"

        return render_template("index.html", image_uri=uri, language=language)
    ```

    The new `index()` method reads the language selected in the drop-down list from the request and passes it to the `translate_text()` method, which translates the text into the specified language. Then it flashes the translated text so **index.html** will present it to the user.

1. Finally, add the `translate_text()` method to the end of the **app.py** file:

    ```python
    # Method that translates text into the specified language
    def translate_text(lines, language, key):
        uri = "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&to=" + language

        headers = {
            'Ocp-Apim-Subscription-Key': key,
            'Content-type': 'application/json'
        }

        input=[]

        for line in lines:
            input.append({ "text": line })

        try:
            response = requests.post(uri, headers=headers, json=input)
            response.raise_for_status() # Raise exception if call failed
            results = response.json()

            translated_lines = []

            for result in results:
                for translated_line in result["translations"]:
                    translated_lines.append(translated_line["text"])

            return translated_lines

        except requests.exceptions.HTTPError as e:
            return ["Error calling the Translator Text API: " + e.strerror]

        except Exception as e:
            return ["Error calling the Translator Text API"]
    ```

    This method calls the Translator Text API to translate the text that's passed in. It returns the translated text, or an error message if something went wrong.

An interesting aspect of this code is that if the call to the Computer Vision API returns an error message or a message indicating that no text was detected in the photo, the message itself is translated into the language that the user selected.

Save your changes to the **index.html** and **app.py** files.


## Set the Translation environment variable

Now we need to set a local environment variable that corresponds to the Translator Text API key.

Return to your Command Prompt window or terminal. In the following command, replace `<translator_text_api_key>` with [your translation key](https://docs.microsoft.com/learn/modules/python-flask-build-ai-web-app/5-exercise-translate-text?azure-portal=true). <!-- #get-an-api-key-for-the-translator-text-api -->

- **Windows**

   ```command
   set TRANSLATE_KEY=<translator_text_api_key>
   ```

- **macOS or Linux**

   ```console
   export TRANSLATE_KEY=<translator_text_api_key>
   ```


## Translate text extracted from photos

The final step is to test the changes that you made by uploading photos to the site and allowing the Translator Text API to translate the text in them.

1. In your Command Prompt window or terminal, make sure the current directory is still set to **mslearn-build-ai-web-app-with-python-and-flask/src/starter** in your [project directory](https://docs.microsoft.com/learn/modules/python-flask-build-ai-web-app/1-exercise-set-up-environment?azure-portal=true). <!-- #create-the-project-directory --> Then restart Flask:

    ```console
    flask run
    ```

1. Refresh your website page in the browser, or open a new browser window and go to `http://localhost:5000/`.

1. Confirm the home page now has a drop-down list for selecting a language, as pictured in this screenshot:

    ![Screenshot that shows the drop down to select a language.](../media/select-language.png)

    _Selecting a language_

1. Use the drop-down to select the language that you want to translate text into. Then select **Upload Photo** and upload a picture that contains text.

1. Confirm that after a brief pause, the text extracted from the photo and translated into the language that you specified appears in a modal dialog box. Then dismiss the dialog box.

    ![Screenshot that shows text extracted from a photo and translated into the specified language.](../media/translated-text.png)

    _Extracting text from a photo_

Repeat this process with other photos to gauge the Translator Text API's ability to translate text submitted to it.


## Next steps

At this point, your Flask website can accept photo uploads, extract text from photos, and translate the extracted text into another language. In the next unit, you'll learn how to deploy your website as an Azure web app so others can access the great functionality.

- We're going to make some final changes to the code, so stop Flask (CTRL+C). We'll restart it when we're ready to deploy your website.
- Leave your Command Prompt window or terminal open. We'll return to it in the next exercise.
