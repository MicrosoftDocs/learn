Like displaying data, the code to allow users to modify data is repetitive. It can also be rather tedious, as several steps are required to ensure the data is valid and sent correctly. Fortunately, the generic view system can streamline the amount of code we need to enable this functionality.

## Creating new items

Before we explore how Django can streamline our development, we should review what goes into allowing users to modify data. Let's explore the workflow the server uses to manage the process of creating a new item or piece of data, and the work which goes into creating the HTML form.

## Creation workflow

At the surface, the code to allow a user to create an item might seem trivial. As it turns out, it's a deceptively involved process.

1. User sends a **GET** request to signal they want the form to create a new item
1. Server sends the form, with a special token to prevent [cross-site request forgery (CSRF)](https://en.wikipedia.org/wiki/Cross-site_request_forgery?azure-portal=true)
1. User completes the form and selects submit, which sends a **POST** request to indicate the form has been completed
1. Server validates the CSRF token to ensure no tampering has taken place
1. Server validates all information to ensure it meets the rules; an error message is returned should validation fail
1. Server attempts to save the item to the database; if it fails, an error message is returned to the user
1. Upon successfully saving the new item, the server redirects the user to a success page

This requires a lot of code! And most of it is [boilerplate](https://en.wikipedia.org/wiki/Boilerplate_code?azure-portal=true), meaning it's the same every single time you create it. 

### Forms

Creating an HTML form can be a tedious process. There's a lot of copying and pasting of `input` tags, looping through lists to create dropdowns, and setting up radio buttons. And whenever model changes it requires returning to the form to update it.

You may have noticed the models we create in Django contain everything necessary to create the form. When we added the various fields we indicated the data types, which are coupled with different HTML elements. A boolean field would be a checkbox, a foreign key would commonly be a dropdown list, etc.

## Generic views to modify data

One of Django's key goals is to eliminate the need to constantly recreate the same blocks of code over and over. To support this goal for data modifications, Django provides a collection of generic classes and forms to manage this for us. As we will see, it will include all the necessary code, and can even create the form for us dynamically. The classes for for creating, updating and deleting data called `CreateView`, `UpdateView` and `DeleteView`.

### CreateView

`CreateView` is used to allow a user to create items. It will walk through the process highlighted above, and dynamically create the form. Upon success, it will display the detail page for the newly created item.

You specify the `model` and `template_name` you wish to associate with it just as you would with the other generic views. They key difference for `CreateView` is the inclusion of a `fields` property where you list the editable fields. This allows you to ensure fields which shouldn't be edited, like a creation date, don't appear on the form. The view to create a new dog might look like the following:

```python
from . import models
from django.views import generic

class DogCreateView(generic.CreateView):
    model = models.Dog
    template_name = 'dog_form.html'
    fields = ['name', 'description', 'shelter']
```

### UpdateView

`UpdateView` behaves in an identical fashion to `CreateView`. The only difference is it will automatically load an item based on the `pk` parameter, the convention Django uses for the primary key for an item.

```python
from . import models
from django.views import generic

class DogUpdateView(generic.CreateView):
    model = models.Dog
    template_name = 'dog_form.html'
    fields = ['name', 'description', 'shelter']
```

> [!NOTE]
> Upon successfully creating or updating an item, Django will redirect to the details page for the item. It retrieves the URL for the details by using `get_absolute_url` on the associated model. You implement this method by returning the correct URL. You should always retrieve the appropriate URL from the URLconf, which can be done by using `reverse`:
>
> ```python
> from django.db import models
> # TODO: Import reverse
> from django.urls import reverse
> class Dog(models.Model):
>     # Existing code
>     def get_absolute_url(self):
>         return reverse('dog_detail', args=[str(self.id)])
> ```

### DeleteView

`DeleteView` is similar to `UpdateView`. It will allow a user to delete an item, identifying the item to be deleted by its `pk`. Unlike `UpdateView`, no `fields` field is needed, as you will be deleting the entire item. Also, because no item has been newly created or updated, we need to determine where we want to redirect the user. We do this by setting the `success_url` to the appropriate value. You can lookup a URL by using `reverse_lazy`.

```python
from . import models
from django.views import generic
from django.urls import reverse_lazy

class AuthorDelete(DeleteView):
    model = Author
    success_url = reverse_lazy('author-list')
```

> [!NOTE]
> `reverse_lazy` is used due to the order in which information is loaded into Django.

## Form templates for Create and Update

The generic views can create the HTML form for us dynamically. All we need to provide is a template to act as the placeholder for the form. This allows us to ensure it matches the rest of our site. Fortunately, we don't need much code to create it.

The generic views will automatically create a `form` variable for our template to use. The form elements provided by Django can be displayed inside `<p>` tags or as a `<table>`.

The `form` variable contains all of the appropriate HTML to create the controls form the form. It **does not** contain the `<form>` tag itself, or a **submit** button. Our template must include four items:

1. `form` element with the `method` set to **POST**, as this will trigger the save operation on the server
1. `{% csrf_token %}` to add the CSRF token to prevent spoofing
1. `{{ form.as_p }}` or `{{ form.as_table }}` to display the dynamically generated form
1. `submit` button

The code below can act as the host for any generic view form:

```html
<form method="post">{% csrf_token %}
    {{ form.as_p }}
    <button type="submit">Save</button>
</form>
```
