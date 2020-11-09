Every Flask application begins with a file named **app.py** that Flask automatically looks for when an application starts. The following **app.py** file implements the simplest possible website: a single page that displays "Hello, world" to the user.

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def index():
    return "<h1>Hello, world</h1>"
```

The first statement imports a class named `Flask` from the `flask` package installed with pip. The second statement instantiates that class to create a Flask app and assigns it to the variable named `app`.

The fourth and fifth statements define a method that's called when the user requests the site's home page, such as https:\//www\.contoso\.com/. The preceding statement, `@app.route("/")`, is a *decorator* that maps the route ("/") to the method. The method name is unimportant, but `index` is commonly used as the name for the method that renders the site's home page.

If you want to use a name other than **app.py** for the Python file, identify the file to run with a `FLASK_APP` environment variable. Flask will run the app that you specify rather than running **app.py**.

## Routing in Flask

Suppose your website contains several pages rather than just one. You can use `@app.route()` to map all the routes that the site supports to methods that render the corresponding pages:

```python
from flask import Flask

app = Flask(__name__)

# Define a route for the app's home page
@app.route("/")
def index():
    return "<h1>This is the home page</h1>"

# Define a route for the app's About page
@app.route("/about")
def about():
    return "<h1>This is the About page</h1>"

# Define a route for the app's Contact Us page
@app.route("/contact")
def contact():
    return "<h1>This is the Contact Us page</h1>"
```

If the app is hosted at https\:\//www\.contoso\.com, it now supports the following URLs:

- https\:\//www\.contoso\.com\/
- https\:\//www\.contoso\.com\/about
- https\:\//www\.contoso\.com\/contact

You can continue to add routes and methods until all the pages that your site supports are accessible by URL. Once more, the method names are unimportant. It's the routes that count.

## HTML templates

You typically don't want to include inline HTML in the methods that render your site's pages. Instead, define those pages in HTML files.

Flask contains a method named `render_template()` that looks for HTML files in a subdirectory named **templates** and renders the files to the page. The following example produces the same output as the previous example. It assumes that the directory in which **app.py** is located has a subdirectory named **templates**. The subdirectory contains HTML files named **index.html**, **about.html**, and **contact.html**.

```python
from flask import Flask, render_template

app = Flask(__name__)

# Define a route for the app's home page
@app.route("/")
def index():
    return render_template("index.html")

# Define a route for the app's About page
@app.route("/about")
def about():
    return render_template("about.html")

# Define a route for the app's Contact Us page
@app.route("/contact")
def contact():
    return render_template("contact.html")
```

Why is the method named `render_template()`? In fact, the method can do more than simply load static HTML files. It also allows you to pass in user-defined variables and inject these values into the page at runtime. As an example, you could place a file named **master.html** in the **templates** subdirectory and include the following markup in the HTML file:

```html
<h1>{{ message }}</h1>
```

You could then write **app.py** this way:

```python
from flask import Flask, render_template

app = Flask(__name__)

# Define a route for the app's home page
@app.route("/")
def index():
    return render_template("master.html", message="This is the home page")

# Define a route for the app's About page
@app.route("/about")
def about():
    return render_template("master.html", message="This is the About page")

# Define a route for the app's Contact Us page
@app.route("/contact")
def contact():
    return render_template("master.html", message="This is the Contact Us page")
```

In effect, **master.html** becomes a template for output. You customize the output for each page by passing a variable named `message` into the template and referencing that variable in the template by using `{{ ... }}` expressions. For more information about how to use templates in Flask, see [Templates](https://flask.palletsprojects.com/en/1.1.x/tutorial/templates/?azure-portal=true).

## Control-of-flow expressions

Expressions delimited by `{{` and `}}` aren't the only special ones that Flask supports. It also supports control-of-flow statements enclosed in `{%` and `%}`. For example, the following HTML template displays a default message on a page if the `message` variable isn't defined:

```html
{% if message %}
    <h1>{{ message }}</h1>
{% else %}
    <h1>No message specified</h1>
{% endif %}
```

Expressions such as these can even be used to conditionally run JavaScript code:

```html
{% if message %}
    <h1>{{ message }}</h1>
{% else %}
    <script type="text/javascript">
        window.alert("No message specified");
    </script>
{% endif %}
```

Control-of-flow statements are frequently used in conjunction with the Flask `flash()` function to display error messages. Let's say you come across an error condition in **app.py** and want to display a message to the user in a JavaScript alert box. The following example shows the code for the **app.py** file. There's a statement to initialize the app's `secret_key` property with a random number, which is required for flashing messages.

```python
import os
from flask import Flask, render_template, flash

app = Flask(__name__)
app.secret_key = os.urandom(1)

# Define a route for the app's home page
@app.route("/")
def index():
    flash("This is an error message")
    return render_template("index.html", message="This is the home page")
```

And here's the code for the **index.html** file:

```html
{% with messages = get_flashed_messages() %}
    {% if messages %}
        <script type="text/javascript">
            window.alert("{{ messages[0] }}");
        </script>
    {% endif %}
{% endwith %}
```

This example assumes that just one error message was flashed, but you can call `flash()` multiple times to queue several messages and enumerate them with a `{% for message in messages %}` statement. For more information about how to use message flashing in Flask, see [Message Flashing](https://flask.palletsprojects.com/en/1.1.x/patterns/flashing/?azure-portal=true).

## Static files

Most websites contain images, style sheets, and other static files that don't change as the application runs. Flask looks for these files in a special subdirectory named **static**.

Let's say your site includes a style sheet named **main.css** and a banner named **banner.jpg**. You can store these files in the **static** subdirectory and reference them with HTML:

```html
<link rel="stylesheet" href="/static/main.css">
<img src="/static/banner.jpg">
```

You can also use the Flask `url_for()` function to resolve these URLs:

```html
<link rel="stylesheet" href="url_for('static', filename='main.css')">
<img src="url_for('static', filename='banner.jpg')">
```

A benefit of using `url_for()` is that the resulting URLs are absolute. The absolute URLs help to sidestep issues that can arise when browsers handle relative URLs in inconsistent ways.
