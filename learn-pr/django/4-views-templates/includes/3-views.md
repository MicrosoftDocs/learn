In programming, a **view** is typically a component responsible for displaying information to the user. The tasks a view performs can vary depending on the framework and conventions, including being responsible for loading data. In Django, a view is typically responsible for validating a user's request, loading or modifying the appropriate data, and returning an HTML template with the information to the user.

We are going to begin our exploration by discussing creating views manually, and configuring the appropriate URLconfs. In a later unit we will see how some of the code we wrote by hand can be handled for us automatically by Django.

## Creating a view

Creating a view from scratch in Django is typically done by creating a function. The function will commonly contain the appropriate code to perform the task requested by the user, and return a template with the appropriate data to display to the user.

View functions will always take at least one parameter, which represents the user's request, and is named `request`. You can provide additional parameters as needed if you are expecting additional information from the user in the URL, such as the name or ID of an item. You will register those when creating the route, which we talk about below.

### Loading data

You can use the Django ORM to load any data needed from the registered database. The project we are building has two models, `Shelter` and `Dog`. We can load all objects or perform other queries by using the models we created. To load all shelters, for example, we would use `Shelter.objects.all()`. We can load an individual shelter by using `Shelter.objects.get(pk=1)`.

> [!NOTE]
> `pk` is a shortcut for primary key. You could use `id` and have the same result, but by using `pk` it works if you have changed the property representing the primary key to a different name.

#### 404 errors

A 404 error in web applications means "not found". As a best practice, you should return a 404 whenever a request is made for an object that doesn't exist. Django provides a shortcut for attempting to load data, `get_object_or_404` and `get_list_or_404`. `get_object_or_404` will load an object by a primary key, or return a 404 to the user if one is not found. `get_list_or_404` will perform the same operation, except it accepts a filter parameter. We will use `get_object_or_404` in our exercise.

### Rendering the template

Django's templating engine will take the HTML template we build, combine it with any data we provide, and emit the HTML for the browser. The helper function to perform this task is `render`. `render` needs the object which represents the request, which is the `request` parameter we highlighted earlier. You also pass in the name of the template, typically an HTML file which will reside in a folder named **templates**. 

To pass data into the template, you provide `render` with a `context` dictionary object. `context` will contain a set of key/value pairs, where each key becomes a variable in the template.

### Example

To create a view to display all shelters, you might use the following code:

```python
def shelter_list(request):
    shelters = Shelter.objects.all()
    context = { 'shelters': shelters }
    return render(request, 'shelter_list.html', context)
```

## Registering a path

Paths are used by almost any web framework to process user requests. They convert the portion of the URL after the name of the domain and before the query string (which comes after the **?**) into a function call. A call to **www.contoso.com/shelters** might call a function to list all shelters, while **www.contoso.com/shelters/1** might call a function to display a shelter with an ID of 1.

Paths are registered in Django by creating a URLConf. A URLConf is a list of paths, indicating the pattern to match, the function to call, and optionally a name.

Let's say we have a module called `views`, which is a Django convention. We can route index traffic where a path isn't specified (such as **www.contoso.com**) to a function in `views` called `index`, and give it a name called **index** by using the following path:

```python
path('', views.index, 'index')
```

You can also create virtual folders for specific requests. For example, if you want to list all shelters if someone requested **/shelters**, you could use the following:

```python
path('shelters', views.shelter_list, 'shelter_list')
```

### URL parameters

It's a common practice to pass parameters to an application as part of the URL, such as an ID or a name. Because these values will change, we don't want to hard code them into our path. Django allows you to specify a parameter by using a special syntax where you can indicate the type of data you are expecting, such as an integer, and a name.

For example, to create a path for someone to request a specific shelter by an ID, we would want a parameter of type integer (since our primary key is an integer). We can then provide the name we wish to use for the variable, which will then be passed in as a parameter to the view function. The syntax for identifying this parameter would be `<int:pk>`. Notice the type declaration, the `:`, and then the name of the variable. The full path might look like this:

```python
path('shelter/<int:pk>', views.shelter_detail, name='shelter_detail')
```

The associated view function would have the following signature:

```python
def shelter_detail(request, pk):
    # code
```

The `pk` from the path signature is passed into `shelter_detail` as a parameter, just as if we were calling it like a normal Python function.
