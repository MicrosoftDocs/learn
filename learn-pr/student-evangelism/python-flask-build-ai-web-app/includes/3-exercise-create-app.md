We are going to create our application iteratively, focusing on specific concepts as we go. To start we will create the landing page for our application, which will display the form the user will use.

Typically, the entry point for Flask applications is a file named **app.py**. We're going to follow this convention and create the core of our application. We will perform the following steps:

- Create our core application
- Add the route for our application
- Create the HTML template for our site
- Test the application

## Create core application

1. Returning to the instance of Visual Studio Code we were using previously, create a new file named **app.py** by clicking **New file** in the **Explorer** tab

![Visual Studio Code new file dialog](../media/create-file.png)

> [!IMPORTANT]
> If this is your first time using Visual Studio Code to create a Python application you will receive messages about installing the Python extension and the linter **pylint**. Click **Install** to install each of these add-ons.

2. Add the code to create our Flask application

```python
from flask import Flask, render_template

app = Flask(__name__)
```

The import statement includes references to `Flask`, which is the core of any Flask application. `render_template` will be used in a little while when we wish to return our HTML.

`app` will be our core application. We will use this when we register our routes in the next step.

## Add the route

Our application will use one route - **/**. This is sometimes called either the **default** or **index** route, as it's the one which will be used if the user doesn't provide anything beyond the name of the domain or server.

Add the following code to the end of **app.py**

```python
@app.route('/', methods=['GET'])
def index():
    return render_template('index.html')
```

By using `@app.route` we indicate the route we wish to create. The path will be **/**, which is the default route. We indicate this will be used for **GET**. If a **GET** request comes in for **/**, Flask will automatically call the function declared immediately below the decorator, `index` in our case. In the body of `index` we indicate we will return an HTML template named **index.html** to the user.

## Create the HTML template for our form

Jinja, the templating engine for Flask, focuses quite heavily on HTML. As a result, we can use all of the existing HTML skills and tools we already have. We are going to use [Bootstrap](https://getbootstrap.com) to layout our page (to make it a little prettier). Using Bootstrap means we use a handful of different CSS classes on our HTML; if you're not familiar with Bootstrap you can ignore the classes and focus on the HTML (which is really the important part).

Templates for Flask need to be created in a folder named **templates**, which is fitting. Let's create the folder, the necessary file, and add the HTML.

1. Create a new folder named **templates** by clicking **New Folder** in the **Explorer** tool in Visual Studio Code
2. Click on the **templates** folder you just created, and click on **New File** to add a file to the folder
3. Name the file **index.html**
4. Add the following HTML

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
        integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <title>Translator</title>
</head>
<body>
    <div class="container">
        <h1>Translation service</h1>
        <div>Enter the text you wish to translate, choose the language, and click Translate!</div>
        <div>
            <form method="POST">
                <div class="form-group">
                    <textarea name="text" cols="20" rows="10" class="form-control"></textarea>
                </div>
                <div class="form-group">
                    <label for="language">Language:</label>
                    <select name="language" class="form-control">
                        <option value="en">English</option>
                        <option value="it">Italian</option>
                        <option value="ja">Japanese</option>
                        <option value="ru">Russian</option>
                        <option value="de">German</option>
                    </select>
                </div>
                <div>
                    <button type="submit" class="btn btn-success">Translate!</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
```

The core components in the HTML above are the `textarea` for the text the user wishes to translate, and the dropdown list (`select`) which the user will use to indicate the target language. If you wish to add more languages, you can consult the [list of supported languages](https://docs.microsoft.com/azure/cognitive-services/Translator/language-support?WT.mc_id=python-11210-chrhar) for other options; set the `value` attribute to the language code (such as **pl** for Polish).

## Test the application

With our initial site created, it's time to test it! We're going to use the integrated terminal inside Visual Studio Code to make our lives a little easier.

1. Open the integrated terminal by clicking **Ctl-\`** or **Cmd-\`** on a Mac
2. Execute the following command to set the Flask runtime to development, which means the server will automatically reload with every change

```bash
# Windows
set FLASK_ENV=development

# Linux/macOS
export FLASK_ENV=development
```

3. Run the application!

```bash
flask run
```

4. Open the application in a browser by navigating to **http://localhost:5000**

You should see the form displayed! Congratulations!
