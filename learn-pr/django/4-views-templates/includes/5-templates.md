Templates are text files that can be used to generate text-based formats such as HTML or XML. Each template will contain some static data that is shared across the site, but can also contain placeholders for dynamic data. They contain variables and tags that control the behavior and what will appear as the final page. Let's explore how templates work in Django.

## Variables

Variables in a template behave in a similar fashion to any other programming language. They allow us to indicate a value which is evaluated at runtime. Django provides a way to display variables in a template by using the `{{ }}` syntax. Any variable placed inside the double curly braces is evaluated for its text content, and then placed into the template. If we wanted to display the dog's name, for example, we could use `{{dog.name}}`.

Variables are passed into a template by the view, using the `render` function, which we will explore in a later module. You are able to pass values and other data to a template, including a QuerySet from the Django ORM. This allows you to display data from the database for your application.

## Filters

Filters are a great way to control how the data appears when requested in a template. Since these filters are already created they provide an easy way to format data without having to write any special code. For example, let's say we have to print out the names of the dog breeds and we want to make sure the first letter of every name is capitalized.

```html
{{ dog.name | capfirst }}
```

As you can see the variable is to the left of the pipe symbol `|` and the filter is on the right. This is just one of many filters that can be used to manipulate the data when using Django template filters.

## Tags

Tags can be used to perform loops, create text, or provide other types of commands for the template engine. They often resemble Python syntax. However, because they run inside the template (rather than the Python interpreter) you will notice some slight differences in syntax. Without the ability to rely on tabs like we would with Python, each block statement will require a corresponding `end`.

We can use `if` statements for boolean logic, and `for` loops for iteration. The core syntax for `if` statements looks like the following:

```html
{% if dogs %}
    <h2>There are {{ dogs | length }} ready for adoption!</h2>
{% else %}
    <h2>We have no dogs ready for adoption. Please check back later!</h2>
{% endif %}
```

> [!NOTE]
> `elif` is used in the same fashion as `elif` in Python.

Similarly, we can use a `for` loop to display the names of all dogs in a list.

```html
<ul>
    {% for dog in dogs %}
        <li>{{ dog.name }}</li>
    {% endfor %}
<ul>
```

## Template inheritance

Templates are used to generate the HTML you wish your user to see while using your application. Pages in an application typically share a common structure, where navigation might be on the left, a title on the top, a consistent stylesheet, etc. Django templates support this through inheritance.

### Creating a parent page

Creating a parent page is the same as creating any Django HTML template. You provide the outer structure, and then include `{% block %} placeholders. These placeholders allow the children to provide the content to be placed in those placeholders. Let's create a parent page to import a stylesheet, provide a default title, and a header we wish to have displayed on all pages.

```html
<html>
<head>
    <link rel="stylesheet" href="site.css">
    <title>{% block title %}Shelter site{% endblock %}</title>
</head>
<body>
    <h1>Shelter site</h1>
    {% block content %}
    {% endblock %}
</body>
</html>
```

### Creating a child page

We can create a child page from the parent by using the `extends` keyword. When using `extends` we provide the name of the HTML file of the parent template. We then use add the appropriate {% block %} statements to add the content specific to that page.

```html
{% extends "parent.html" %}

{% block title %}
Welcome to the Shelter site!
{% endblock %}

{% block content %}
Thank you for visiting our site!
{% endblock %}
```

When displayed, the page would look like the following:

```html
<html>
<head>
    <link rel="stylesheet" href="site.css">
    <title>Welcome to the shelter site</title>
</head>
<body>
    <h1>Shelter site</h1>
    Thank you for visiting our site!
</body>
</html>
```

Notice how the placeholders are replaced by the content in the child page.

> [!NOTE]
> For this example we used static text. As we will see, you can use dynamic content as well!
