In programming, a *view* is typically a component that displays information to the user. The tasks that a view performs can vary depending on the framework and conventions, including responsibility for loading data. 

In Django, a view is typically responsible for:

- Validating a user's request.
- Loading or modifying the appropriate data.
- Returning an HTML template with the information to the user.

We're going to begin our exploration by discussing creating views manually and configuring the appropriate *URLconfs*. A URLconf is a list of paths that indicate the pattern to match, the function to call, and optionally a name. In a later unit, we'll see how Django can automatically handle some of the code that we wrote by hand.

## Create a view

To create a view from scratch in Django, you typically create a function. The function commonly contains the appropriate code to:

- Perform the task that the user has requested.
- Return a template with the appropriate data to display to the user.

View functions always take at least one parameter named `request`, which represents the user's request. You can provide more parameters as needed if you're expecting more information from the user in the URL, such as the name or ID of an item. You'll register those when creating the route, which we talk about later in the unit.

### Loading data

You can use the Django ORM to load any data that you need from the registered database. 

The project that we're building has two models, `Shelter` and `Dog`. We can load all objects or perform other queries by using the models that we created. To load all shelters, for example, we would use `Shelter.objects.all()`. We can load an individual shelter by using `Shelter.objects.get(pk=1)`.

> [!NOTE]
> `pk` is a shortcut for primary key. You can use `id` and have the same result, but using `pk` will ensure that the command works if you've changed the property that represents the primary key to a different name.

#### 404 errors

A 404 error in web applications means "not found." As a best practice, you should return a 404 whenever a request is made for an object that doesn't exist. 

Django provides shortcuts for trying to load data:

- `get_object_or_404` and `get_list_or_404`: Loads an object by a primary key, or returns a 404 to the user if an object is not found. 
- `get_list_or_404`: Performs the same operation as the other shortcut, except that it accepts a filter parameter. 

We'll use `get_object_or_404` in our exercise.

### Rendering the template

Django's templating engine will take the HTML template that we build, combine it with any data that we provide, and emit the HTML for the browser. The helper function to perform this task is `render`. 

The `render` function needs the object that represents the request, which is the `request` parameter that we highlighted earlier. You also pass in the name of the template, typically an HTML file that will reside in a folder named *templates*. 

To pass data into the template, you provide `render` with a `context` dictionary object. The `context` object contains a set of key/value pairs, where each key becomes a variable in the template.

### Example

To create a view to display all shelters, you might use the following code:

```python
def shelter_list(request):
    shelters = Shelter.objects.all()
    context = { 'shelters': shelters }
    return render(request, 'shelter_list.html', context)
```

## Register a path

Almost any web framework uses paths to process user requests. Paths convert the portion of the URL after the name of the domain and before the query string (which comes after the question mark) into a function call. 

A call to `www.contoso.com/shelters` might call a function to list all shelters, whereas `www.contoso.com/shelters/1` might call a function to display a shelter with an ID of 1. You register paths in Django by creating a URLconf. 

Let's say we have a module called `views`, which is a Django convention. We can route index traffic where a path isn't specified (such as `www.contoso.com`) to a function in `views` called `index`, and give it a name called `index`, by using the following path:

```python
path('', views.index, 'index')
```

We can also create virtual folders for specific requests. For example, if we wanted to list all shelters if someone requests **/shelters**, we could use the following command:

```python
path('shelters', views.shelter_list, 'shelter_list')
```

### URL parameters

It's a common practice to pass parameters to an application as part of the URL, such as an ID or a name. Because these values will change, we don't want to hard code them into our path. In Django, you can specify a parameter by using a special syntax. In that syntax, you can indicate the type of data you're expecting, such as an integer, and a name.

For example, to create a path for someone to request a specific shelter by an ID, we would want a parameter of type `integer`. (The reason is that our primary key is an integer.) We can then provide the name that we want to use for the variable, which will then be passed in as a parameter to the view function. The syntax for identifying this parameter would be `<int:pk>`. Notice the type declaration, the colon, and then the name of the variable. 

The full path might look like this:

```python
path('shelter/<int:pk>', views.shelter_detail, name='shelter_detail')
```

The associated view function would have the following signature:

```python
def shelter_detail(request, pk):
    # code
```

The `pk` part of the path signature is passed into `shelter_detail` as a parameter, just as if we were calling it like a normal Python function.
