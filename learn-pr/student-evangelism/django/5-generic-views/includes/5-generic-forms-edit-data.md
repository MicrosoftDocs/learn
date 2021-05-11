Like the code required to display data, the code to allow users to modify data is repetitive. It can also be tedious because several steps are required to ensure the data is valid and sent correctly. Fortunately, the generic view system can streamline the amount of code we need to enable this functionality.

## Create new items

Before we explore how Django can streamline our development, we should review the process that allows users to modify data. Let's explore the workflow the server uses to manage the process of creating a new item or piece of data, and the work that goes into creating the HTML form.

## Creation workflow

At the surface, the code to allow a user to create an item might seem trivial. As it turns out, it's a deceptively involved process.

1. The user sends a **GET** request to signal they want the form to create a new item.
1. The server sends the form with a special token to prevent [cross-site request forgery (CSRF)](https://en.wikipedia.org/wiki/Cross-site_request_forgery?azure-portal=true).
1. The user completes the form and selects **submit**, which sends a **POST** request to indicate the form has been completed.
1. The server validates the CSRF token to ensure no tampering has taken place.
1. The server validates all information to ensure it meets the rules. An error message is returned if validation fails.
1. The server attempts to save the item to the database. If it fails, an error message is returned to the user.
1. After successfully saving the new item, the server redirects the user to a success page.

This process requires quite a bit code! Most of it's [boilerplate](https://en.wikipedia.org/wiki/Boilerplate_code?azure-portal=true), which means it's the same every time you create it.

### Forms

Creating an HTML form can be a tedious process. Developers are often copying and pasting `input` tags, looping through lists to create drop-downs lists, and setting up radio buttons. Whenever the model changes, the form must be updated.

You might have noticed the models we create in Django contain everything necessary to create the form. When we added the various fields, we indicated the data types, which are coupled with different HTML elements. For example, a Boolean field would be a check box and a foreign key would commonly be a drop-down list.

## Generic views to modify data

One of Django's key goals is to eliminate the need to constantly re-create the same blocks of code over and over. To support this goal for data modifications, Django provides a collection of generic classes and forms to manage this workload for us. As we'll see, it includes all the necessary code and can even create the form for us dynamically. The classes used for creating, updating, and deleting data are called `CreateView`, `UpdateView`, and `DeleteView`.

### CreateView

The class `CreateView` is used to allow a user to create items. It walks through the preceding process and dynamically creates the form. After success, it displays the detail page for the newly created item.

You specify the `model` and `template_name` you want to associate with it just as you would with the other generic views. The key difference for `CreateView` is the inclusion of a `fields` property where you list the editable fields. By using this property, you can ensure fields that shouldn't be edited, like a creation date, don't appear on the form. The view to create a new dog might look like the following sample:

```python
from . import models
from django.views import generic

class DogCreateView(generic.CreateView):
    model = models.Dog
    template_name = 'dog_form.html'
    fields = ['name', 'description', 'shelter']
```

### UpdateView

The class `UpdateView` behaves in an identical fashion to `CreateView`. The only difference is that it automatically loads an item based on the `pk` parameter. Django uses this convention for the primary key for an item.

```python
from . import models
from django.views import generic

class DogUpdateView(generic.CreateView):
    model = models.Dog
    template_name = 'dog_form.html'
    fields = ['name', 'description', 'shelter']
```

After successfully creating or updating an item, Django redirects to the details page for the item. It retrieves the URL for the details by using `get_absolute_url` on the associated model. You implement this method by returning the correct URL. You can retrieve the appropriate URL from URLconf by using `reverse`. Note `kwargs` is used to pass the `pk` or primary key parameter to the route.

```python
from django.db import models
# TODO: Import reverse
from django.urls import reverse
class Dog(models.Model):
    # Existing code
    def get_absolute_url(self):
        return reverse('dog_detail', kwargs={"pk": self.pk})
```

### DeleteView

The class `DeleteView` is similar to `UpdateView`. It allows a user to delete an item and identifies the item to be deleted by using `pk`. Unlike `UpdateView`, `fields` isn't needed because you'll be deleting the entire item. Also, because no item has been newly created or updated, we need to determine where we want to redirect the user. We can create a redirect by setting the `success_url` to the appropriate value. You can look up a URL by using `reverse_lazy`.

```python
from . import models
from django.views import generic
from django.urls import reverse_lazy

class AuthorDelete(DeleteView):
    model = Author
    success_url = reverse_lazy('author-list')
```

> [!NOTE]
> We use `reverse_lazy` because of the order in which information is loaded into Django.

## Form templates for create and update

The generic views can create the HTML form for us dynamically. All we need to provide is a template to act as the placeholder for the form. The placeholder template ensures the form matches the rest of our site. Fortunately, we don't need much code to create it.

The generic views automatically create a `form` variable for our template to use. The form elements provided by Django can be displayed inside `<p>` tags or as a `<table>`.

The `form` variable contains all of the appropriate HTML to create the controls from the form. It *doesn't* contain the `<form>` tag itself or a **submit** button. Our template must include four items:

- The `form` element with the `method` set to **POST** because this setting triggers the save operation on the server.
- The code `{% csrf_token %}` to add the CSRF token to prevent spoofing.
- The code `{{ form.as_p }}` or `{{ form.as_table }}` to display the dynamically generated form.
- The `submit` button.

The following code can act as the host for any generic view form.

```html
<form method="post">{% csrf_token %}
    {{ form.as_p }}
    <button type="submit">Save</button>
</form>
```
