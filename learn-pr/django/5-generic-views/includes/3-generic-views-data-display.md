The generic views system in Django streamlines the creation of repetitive code. The common operations you perform in a data-driven application share the same pattern. For example, to display an individual item by its id or primary key, the workflow is always:

1. Load the item from the database by ID
1. If the item is not found, return a 404
1. If the item is found, pass the item to a template for display

The generic view system acknowledges this fact, and provides classes you can use which contain the core code already written. You inherit from the appropriate class, set a couple of properties, and then register an appropriate path in your URLconf. The rest is taken care of for you!

Django includes two generic views for displaying data: `ListView` and `DetailView`.

## DetailView for item detail

`DetailView` is used to display a detail page for an item. `DetailView` will retrieve the item for the specified `model` by the primary key, and pass it to the template. You can set the `template_name` to the name of the template to be used; `<model>_detail.html` is the default. Finally, we can set `context_object_name` to the name of the variable we wish to use in our template.

Creating a detail view using the generic view for a Dog could use the following code.

```python
from . import models
from django.views import generic

class DogDetailView(generic.DetailView):
    model = models.Dog
    template_name = 'dog_detail.html'
    context_object_name = 'dog'
```

Registering `DogDetailView` is similar to any other `path` entry. The key thing to ensure you include is a parameter named `pk`. Django uses this convention to identify the primary key. You will also note we use the `as_view()` method to convert the class into a view.

```python
path('dog/<int:pk>', views.DogDetailView.as_view(), name='dog_detail')
```

## ListView for a list of items

`ListView` behaves in a similar fashion to `DetailView`. You are able to set `context_object_name` for the name of the variable in the view, and `template_name` for the name of the template.

The primary difference is `ListView` is designed to work with any form of a query which returns multiple items. As a result, you must override the `get_queryset` function. `get_queryset` is called by the generic view system to retrieve the items from the database, allowing you to order or filter your items as needed.

To create a view to display the list of all shelters using the generic `ListView`, you might use the following:

```python
from . import models
from django.views import generic

class ShelterListView(generic.ListView):
    template_name = 'shelter_list.html'
    context_object_name = 'shelters'

    def get_queryset(self):
        return models.Shelter.objects.all()
```

Registering the view is performed much in the same way as our `DetailView`:

```python
path('', ShelterListView.as_view(), name='shelter_list')
```
