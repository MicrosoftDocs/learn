Every Flask application begins with a file named **app.py**, which Flask automatically looks for when an application starts up. The following **app.py** file implements the simplest possible website—one with a single page that displays "Hello, world" to the user:

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def index():
    return "<h1>Hello, world</h1>"
```

The first statement imports a class named `Flask` from the `flask` package installed with `pip`. The second statement instantiates that class to create a Flask app and assigns it to the variable named `app`.

The fourth and fifth statements define a function that's called when the user requests the site's home page—for example, **https:\//www\.contoso\.com/**. The preceding statement—`@app.route("/")`—is a *decorator* that maps the route ("/") to the function. The function name is unimportant, but `index` is commonly used as the name for the function that renders the site's home page.

If you want to use a name other **app.py** for the Python file, simply identify the file with a FLASK_APP environment variable and Flask will happily execute it rather than **app.py**.

## Routing in Flask

Suppose your website contains several pages rather than just one. You can use `@app.route()` to map all the routes that the site supports to functions that render the corresponding pages:

```python
from flask import Flask

app = Flask(__name__)

# Define a route for the app's home page
@app.route("/")
def index():
    return "<h1>This the home page</h1>"

# Define a route for the app's About page
@app.route("/about")
def about():
    return "<h1>This the About page</h1>"

# Define a route for the app's Contact Us page
@app.route("/contact")
def contact():
    return "<h1>This the Contact Us page</h1>"
``` 

If the app is hosted at https\:\//www\.contoso\.com, it now supports the following URLs:

- https\:\//www\.contoso\.com\/
- https\:\//www\.contoso\.com\/about
- https\:\//www\.contoso\.com\/contact

You can continue adding routes and functions until all the pages that your site supports are accessible by URL. Once more, the function names are unimportant. It's the routes that count.

## HTML templates

You typically don't want to include inline HTML in the functions that render your site's pages. Instead, you want to define those pages in HTML files.

Flask contains a function named `render_template()` that looks for HTML files in a subdirectory named "templates" and renders them out to the page. The following example produces the exact same output as the previous example. It assumes that the directory in which **app.py** is located has a subdirectory named "templates" containing HTML files named **index.html**, **about.html**, and **contact.html**:

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

Why is the function named `render_template()`? Because it can do more than simply load static HTML files. It also allows allows you to pass it user-defined variables and inject their values into the page at run-time. You could, for example, place a file named **master.html** in the "templates" subdirectory and include the following markup in it:

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

In effect, **master.html** becomes a template for output, and you customize the output for each page by passing a variable named `message` into the template and referencing that variable in the template using `{{ ... }}` expressions. For more information on using templates in Flask, see [Templates](http://flask.pocoo.org/docs/1.0/tutorial/templates/).

## Control-of-flow expressions

Expressions delimited by `{{` and `}}` aren't the only special ones that Flask supports. It also supports control-of-flow statements enclosed in `{%` and `%}`. For example, the following HTML template displays a default message in a page if the `message` variable isn't defined:

```html
{% if message %}
    <h1>{{ message }}</h1>
{% else %}
    <h1>No message specified</h1>
{% endif %}
```

Expressions such as these can even be used to conditionally execute JavaScript code:

```html
{% if message %}
    <h1>{{ message }}</h1>
{% else %}
    <script type="text/javascript">
        window.alert("No message specified");
    </script>
{% endif %}
```

Control-of-flow statements are frequently used in conjunction with Flask's `flash()` function to display error messages. Let's say you encounter an error condition in **app.py** and want to display a message to the user in a JavaScript alert box. Here's **app.py**, complete with a statement to initialize the app's `secret_key` property with a random number, which is required for flashing messages:

```python
import os
from flask import Flask, render_template, flash

app = Flask(__name__)
app.secret_key = os.urandom(1)

# Define a route for the app's home page
@app.route("/")
def index():
    flash("This is an error message")
    return render_template("index.html")
``` 

And here is **index.html**:

```html
{% with messages = get_flashed_messages() %}
    {% if messages %}
        <script type="text/javascript">
            window.alert("{{ messages[0] }}");
        </script>
    {% endif %}
{% endwith %}
```

This example assumes that just one error message was flashed, but you can call `flash()` multiple times to queue up several messages and enumerate them with a `{% for message in messages %}` statement. For more information on message flashing in Flask, see [Message Flashing](http://flask.pocoo.org/docs/1.0/patterns/flashing/).

## Static files

Most websites contain images, style sheets, and other static files that don't change as the application executes. Flask looks for these files in a special subdirectory named "static."

Let's say your site includes a style sheet named **main.css** and a banner named **banner.jpg**. You can drop these files into the "static" subdirectory and reference them in HTML this way:

```html
<link rel="stylesheet" href="/static/main.css">
<img src="/static/banner.jpg">
```

You can also use Flask's `url_for()` function to resolve these URLs:

```html
<link rel="stylesheet" href="url_for('static', filename='main.css')">
<img src="url_for('static', filename='banner.jpg')">
```

One benefit of using `url_for()` is that the resultant URLs are absolute, which sidesteps issues that sometimes arise when browsers handle relative URLs in inconsistent ways.