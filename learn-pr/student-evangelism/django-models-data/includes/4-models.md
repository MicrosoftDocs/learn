Models are at the heart of any ORM. A model is a representation of some piece of data that your application will work with. This can be a person, a product, a category, or any other form of data that your application needs.

## Create a model

In Django, a model is any class that inherits a collection of functionality from `django.models.Model`. The collection includes methods that allow you to query the database, create new entries, and save updates. You can also define fields, set metadata, and establish relationships between models.

If you wanted to create two models, `Product` and `Category`, you would add two classes:

```python
from django.db import models
class Product(models.Model):
    # details would go here
    pass

class Category(models.Model):
    # details would go here
    pass
```

## Add methods

Before we discuss how to configure the data for your model, it's important to highlight the fact that a model is a Python class. As a result, you can both add methods and override the ones that `Django.models.Model` provides, or the ones inherent to all Python objects. 

One method in particular to highlight is `__str__`. You use this method to display an object if no fields are specified. If `Product` has a `name` field (which we'll see in just a moment), you can return it as the default string representation for `Product` by overriding `__str__`.

```python
class Product(models.Model):
    name = models.TextField()
    
    def __str__(self):
        return self.name
```

## Add fields

Fields define the data structure of a model. Fields might include the name of an item, a creation date, a price, or any other piece of data that the model needs to store.

Different pieces of data have different data types, validation rules, and other forms of metadata. The Django ORM contains a rich suite of options to configure the fields of your models to your specifications. The ORM is extensible, so you can create your own rules as needed.

### Defining the field type

The core piece of metadata for all fields is the type of data that it will store, such as a string or a number. Field types map both to a database type and an HTML form control type (such as a text box or a check box). [Django includes several field types](https://docs.djangoproject.com/en/3.1/ref/models/fields/#field-types), including:

- `CharField`: A single line of text.
- `TextField`: Multiple lines of text.
- `BooleanField`: A Boolean true/false option.
- `DateField`: A date.
- `TimeField`: A time.
- `DateTimeField`: A date and time.
- `URLField`: A URL.
- `IntegerField`: An integer.
- `DecimalField`: A fixed-precision decimal number.

To add fields to our `Product` and `Category` classes, we might have the following code:

```python
from django.db import models
class Product(models.Model):
    name = models.TextField()
    price = models.DecimalField()
    creation_date = models.DateField()

class Category(models.Model):
    name = models.TextField()
```

### Field options

You can use [field options](https://docs.djangoproject.com/en/3.1/ref/models/fields/#field-options) to add metadata to allow null or blank values, or mark a field as unique. You can also set validation options and provide custom messages for validation errors. 

As with field types, field options map to the appropriate settings in the database. The rules will be enforced in any forms that Django generates on your behalf.

Field options are passed into the function for the field itself. Different fields might support different options. Some of the most common are:

- `null`
  - Boolean option to allow null values.
  - Default is `False`.
- `blank`
  - Boolean option to allow blank values.
  - Default is `False`.
- `default`
  - Allows the configuration of a default value if a value for the field is not provided.
  - If you want to set the default value to a database `null`, set `default` to `None`.
- `unique`
  - This field must contain a unique value.
  - Default is `False`.
- `min_length` and `max_length`
  - Used with string types to identify the minimum and maximum string length.
  - Default is `None`.
- `min_value` and `max_value`
  - Used with number types to identify the minimum and maximum values.
- `auto_now` and `auto_now_add`.
  - Used with date/time types to indicate if the current time should be used.
  - `auto_now` will *always* set the field to the current time on save, which is useful for `last_update` fields.
  - `auto_now_add` will set the field to the current time on creation, which is useful for `creation_date` fields.

> [!NOTE]
> The values `null` and `blank` can seem similar, but they mean different things in database terms. `null` is the lack of a value, whereas `blank` is specifically an empty value.

To add options to our models, the code might look like this:

```python
from django.db import models
class Product(models.Model):
    name = models.TextField(max_length=50, min_length=3, unique=True)
    price = models.DecimalField(min_value=0.99, max_value=1000)
    creation_date = models.DateField(auto_now_add=True)

class Category(models.Model):
    name = models.TextField(max_length=50, min_length=3, unique=True)
```

### Keys and relationships

A standard practice in relational databases is for each row in a table to have a primary key, typically an automatically incremented integer. Django's ORM will add this key automatically to every model that you create, by adding a field named `id`. 

If you want to override this behavior, you can set the field that you want to be your primary key. However, you should rely on Django's `id` field in most situations.

Relational databases also have relationships between tables. A product has a category, an employee has a manager, and a car has a manufacturer. Django's ORM supports all the relationships that you might want to create between your models. 

The most common relationship is "one-to-many," technically known as a *foreign key relationship*. In a foreign key relationship, multiple items share a single attribute. Multiple products are grouped into a single category, for example. To model this relationship, you use the `ForeignKey` field.

To create the relationship, you add the `ForeignKey` field to the child object. If your products are grouped into categories, you add the `category` property to the `Product` class, and you set the type to be `ForeignKey`. 

Django automatically adds a property to the parent to provide access to all children called `<child>_set`, where `<child>` is the name of the child object. In our example, `Category` will automatically have `product_set` added to provide access to all products in the category.

`ForeignKey` has one mandatory parameter, [`on_delete`](https://docs.djangoproject.com/en/3.1/ref/models/fields/#django.db.models.ForeignKey.on_delete). This parameter tells Django what to do if the parent is deleted. That is, if we delete a category, what should happen to the products in that category?

The two most common options are:

- `CASCADE`, which will delete all products if a category is deleted in our example.
- `PROTECT`, which will return an error if we try to delete a category that contains products.

> [!NOTE]
> In most situations, you'll want to use `PROTECT`.

To update our model to create the relationship, we can use the following code:

```python
from django.db import models
class Product(models.Model):
    name = models.TextField()
    price = models.DecimalField()
    creation_date = models.DateField()
    category = models.ForeignKey(
        'Category', #The name of the model
        on_delete=models.PROTECT
    )

class Category(models.Model):
    name = models.TextField()
    # product_set will be automatically created
```
