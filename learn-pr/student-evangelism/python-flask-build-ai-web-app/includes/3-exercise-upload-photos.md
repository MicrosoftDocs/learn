Now that you have an environment for Python and Flask prepared and have the basics of Flask under your belt, it's time to build a website. A Flask website begins with an **app.py** file and basic assets such as HTML, CSS, and images. You start by using Git to download a set of starter files for the Contoso Travel site. Then you enhance the site to support photo uploads.

Resources that are used in this exercise are located in a [Git repository for code samples](https://github.com/MicrosoftDocs/mslearn-build-ai-web-app-with-python-and-flask?azure-portal=true).

## Create a site that supports photo uploads

We'll start by creating a website that supports uploading photos. You'll need Git installed on your computer. If Git isn't installed, go to the [Git website](https://git-scm.com/?azure-portal=true) and install it now. Versions are available for Windows, macOS, and Linux.


### Reactivate your Python virtual environment

> Only complete the steps in this section if you closed the Command Prompt window or terminal where you were running your Python virtual environment. Otherwise, continue to the next section, [Clone the GitHub repo](https://docs.microsoft.com/learn/modules/python-flask-build-ai-web-app/3-exercise-upload-photos?azure-portal=true). <!-- #clone-the-github-repo -->

1. Open a new Command Prompt window or terminal, and change the current directory (`cd`) to your [project directory](https://docs.microsoft.com/learn/modules/python-flask-build-ai-web-app/1-exercise-set-up-environment?azure-portal=true). 
<!-- #create-the-project-directory -->

1. Reactivate your [Python virtual environment](https://docs.microsoft.com/learn/modules/python-flask-build-ai-web-app/1-exercise-set-up-environment?azure-portal=true). 
<!-- activate-your-virtual-environment -->


### Clone the GitHub repo

We need to clone the GitHub repo that has the starter files for the website.

1. Return to your Command Prompt window or terminal.
Change (`cd`) to the [project directory](https://docs.microsoft.com/learn/modules/python-flask-build-ai-web-app/3-exercise-upload-photos?azure-portal=true). <!-- #clone-the-github-repo -->

1. Open a new Command Prompt window or terminal, and change the current directory (`cd`) to your [project directory](https://docs.microsoft.com/learn/modules/python-flask-build-ai-web-app/1-exercise-set-up-environment?azure-portal=true) <!-- create-the-project-directory --> that you created earlier.

1. Use the following command to clone the GitHub repo that has the starter files for the website:

    ```console
    git clone https://github.com/MicrosoftDocs/mslearn-build-ai-web-app-with-python-and-flask.git
    ```

    The `clone` command copies all the files for the sample into a folder named **mslearn-build-ai-web-app-with-python-and-flask**. The source code is placed in the **src** subfolder.
    
1. After the cloning completes, change to the subfolder that has the source code in the newly created folder:

    ```console
    cd mslearn-build-ai-web-app-with-python-and-flask
    cd src
    ```

1. Now change to the **starter** folder. This folder holds a template Flask app that you'll use for your development.

    ```console
    cd starter
    ```

> You might notice that there's also a **final** folder. The code in the final folder is the finished version of what you'll build. If you get confused at any point while writing code, feel free to check this folder for what your code should look like.


Take a moment to browse through the files that were copied into the **starter** folder. Confirm that you see the following files:

- starter/**app.py**, which holds the Python code that drives the site.
- starter/**templates/index.html**, which contains the site's home page.
- starter/**static/main.css**, which contains CSS to design the look of the home page.
- starter/**static/banner.jpg**, which contains the website banner.
- starter/**static/placeholder.png**, which contains a placeholder image for photos that have yet to be uploaded.

Here's the code that's in the **app.py** file right now:

```python
from flask import Flask, render_template

app = Flask(__name__)

# Define a route for the app's one and only page
@app.route("/")
def index():
    return render_template("index.html")
```

Currently, the app consists of a single page named **index.html** that's located in the **templates** subfolder. **index.html** doesn't contain any special expressions. Right now it's simply a static file, but that will change as you develop the site. **index.html** loads the popular Bootstrap framework and uses it to make the page responsive. It also loads **main.css** from the **static** subfolder and uses the CSS styles defined there to give the page a professional look.


### Start Flask

Now we're ready to start using Flask.

1. In your Command Prompt window or terminal, make sure the current directory is still set to **mslearn-build-ai-web-app-with-python-and-flask/src/starter** in your [project directory](https://docs.microsoft.com/learn/modules/python-flask-build-ai-web-app/1-exercise-set-up-environment?azure-portal=true). <!-- #create-the-project-directory -->

1. Run the following command to create an environment variable named **FLASK_ENV**. This variable tells Flask to run in development mode. Note there's no output message to confirm the Flask environment variable is created.

    **Windows**

    ```console
    set FLASK_ENV=development
    ```

    **macOS or Linux**

    ```console
    export FLASK_ENV=development
    ```

    Running Flask in development mode is helpful when you're working on a website. Flask automatically reloads any files that change while the site is running. If you let Flask default to production mode and change the contents of an HTML file or another asset, you have to restart Flask to see the change in your browser.

1. Use the following command to start Flask:

    ```console
    flask run
    ```
   
    The process can take a few seconds. When Flask is running successfully, you'll see an output message with details about your environment:

    ```output
     * Environment: development
     * Debug mode: on
     * Restarting with stat
     * Debugger is active!
     * Debugger PIN: 123-456-789
     * Running on http://111.0.0.1:5000/ (Press CTRL+C to quit)
     ```

     While Flask is running, the command prompt isn't available for other commands.

Now that Flask is running, you can check out your website. Open a browser and go to `http://localhost:5000/`. Confirm that the website appears in the browser as shown in this screenshot:

![Screenshot that shows the basic Contoso Travel website.](../media/initial-run.png)

_Contoso Travel_

The website looks good, but it doesn't offer any functionality yet. It doesn't support photo uploads, even though the user interface for doing so is in place. The next step is to modify the site to allow users to upload photos.


### Stop Flask

Because we need to make changes to our code, we'll stop Flask for now. We'll restart Flask later when we're ready to check out the improved website.

In your Command Prompt window or terminal, use the following command to stop Flask:

```console
CTRL+C
```

Remember to keep your Command Prompt window or terminal open. You'll return to it after we update the code.


## Add support for uploading photos

In this exercise, you modify the **index.html** and **app.py** files so users can upload photos to the website. You can use any text editor you'd like, but we recommend using Visual Studio Code. It's a free, lightweight Microsoft source-code editor for Windows, macOS, and Linux that features IntelliSense, integrated Git support, and more.

> [!Note]
> If Visual Studio Code isn't installed on your PC, go to the [Visual Studio Code website](https://code.visualstudio.com/?azure-portal=true) and install it now.

1. Start Visual Studio Code. From the top menu bar, select **File** > **Open Folder**, and select the **starter** directory that has the website files.

1. Use Visual Studio Code Explorer to open the **index.html** file, which is the website home page. The index.html file is stored in the **templates** folder. The home page is where users will upload photos.

    [ ![Screenshot that shows how to open the index H T M L file by using the V S Code Explorer.](../media/open-index.png) ](../media/open-index-expanded.png#lightbox)

    _Open the index.html file, which is the website home page._

1. Paste the following `<script>` block into the **index.html** file immediately before the closing `</body>` tag near the bottom of the file:

    ```html
    <script type="text/javascript">
        $(function() {
            $("#upload-button").click(function() {
                $("#upload-file").click();
            });

            $("#upload-file").change(function() {
                $("#submit-button").click();
            });
        });
    </script>
    ```

    The purpose of this code is simple. When the user selects the **Upload Photo** button on the home page, the code displays an open-file dialog so the user can choose a photo to upload. After the user closes the dialog, the code uploads the selected image.
    
    The code uses jQuery to simulate mouse clicks or selecting a button by using a hidden file-upload control defined in the **index.html** file:

    ```html
    <div style="display: none">
        <input type="file" id="upload-file" name="file" accept=".jpg,.jpeg,.png,.gif">
        <input type="submit" id="submit-button" value="Upload">
    </div>
    ```

    This approach is a common trick that's used in webpages. Developers can hide the default file-upload control and replace it with something that offers a better user experience and more robust design options.

1. In Visual Studio Code Explorer, open the **app.py** file. (It's the last file listed in the **starter** folder.) Replace the contents of the file with the following code:

    ```python
    import base64
    from flask import Flask, render_template, request

    app = Flask(__name__)

    @app.route("/", methods=["GET", "POST"])
    def index():
        if request.method == "POST":
            # Display the image that was uploaded
            image = request.files["file"]
            uri = "data:;base64," + base64.b64encode(image.read()).decode("utf-8")

        else:
            # Display a placeholder image
            uri = "/static/placeholder.png"

        return render_template("index.html", image_uri=uri)
    ```

    The revised **app.py** file still accesses the content in the **index.html** file when the home page is requested. The difference is when the user uploads a photo and the page is requested again with a POST command. The new code retrieves the uploaded image from the request (`image = request.files["file"]`), base-64 encodes it to create a data URI, and assigns the data URI to the `<img>` element declared in the page. This technique is commonly used to display an uploaded image in a webpage without writing the image to a temporary file on disk.

1. Return to the **index.html** file and find the `<img>` element on line 42. Replace `/static/placeholder.png` on that line with `{{ image_uri }}`. Here is the modified line:  

    ```html
    <img id="uploaded-image" src="{{ image_uri }}">
    ```

    What does this code do? Notice the `image_uri` variable passed to the `render_template()` method in the modified **app.py** file. When the page is first requested, the `image_uri` variable points to the placeholder image. When the page is requested again because an image was uploaded, the `image_uri` variable holds the data URI created from the image. Consequently, when the user uploads a photo, the photo replaces the placeholder image on the page.

Finish by saving your changes to the **index.html** and **app.py** files. It's time to see the results!


## Upload a photo

Let's make sure your changes have the desired effect by uploading a photo to the site.

1. Return to your Command Prompt window or terminal. Make sure the current directory is still set to **mslearn-build-ai-web-app-with-python-and-flask/src/starter** in your [project directory](https://docs.microsoft.com/learn/modules/python-flask-build-ai-web-app/1-exercise-set-up-environment?azure-portal=true). <!-- #create-the-project-directory -->

1. In your Command Prompt window or terminal, restart Flask:

    ```console
    flask run
    ```

1. Refresh your website page in the browser, or open a new browser window and go to `http://localhost:5000/`.

1. On your website, select the **Upload Photo** button at the bottom of the home page, and select a photo from your local file system.

1. Confirm that the photo you selected appears on the page:

    ![Screenshot that shows the Contoso Travel web site with an uploaded photo.](../media/uploaded-photo.png)

    _Contoso Travel showing an uploaded photo_


## Next steps

You now have a basic Flask website running that accepts photo uploads! The next step is to modify the site to extract text from those photos. That's where Azure Cognitive Services comes in.

- We're going to make more changes to the code, so go ahead and stop Flask (CTRL+C). We'll restart it when we're ready to review the updated website.
- Leave your Command Prompt window or terminal open. We'll return to it in the next unit.
