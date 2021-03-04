Models are at the heart of any ORM. A model is a representation of some piece of data your application will work with. This could be a `Person`, a `Product`, a `Category`, or any other form of data your application needs.

## Creating a model

 In Django, a model is any class which inherits from `django.models.Model`. By inheriting from `Model`, the class will inherit a collection of functionality, including methods allowing you to query the database, create new entries, and save updates. You will also be able to define fields, set metadata, and establish relationships between models.

If we wanted to create two models - `Product` and `Category`, we would add two classes:

```python
from django.db import models
class Product(models.Model):
    # details would go here
    pass

class Category(models.Model):
    # details would go here
    pass
```

## Adding methods

Before we discuss how to configure the data for your model, it's important to highlight the fact a model is a Python class. As a result, you can both add methods and override the ones `Django.models.Model` provides or the one inherent to all Python objects. One method in particular to highlight is `__str__`. `__str__` is the method used to display an object if no fields are specified. If `Product` has a `name` field (which we will see in just a moment), you could return it as the default string representation for `Product` by overriding `__str__`.

```python
class Product(models.Model):
    name = models.TextField()
    
    def __str__(self):
        return self.name
```

## Adding fields

fields define the data structure of a model. fields might include the `name` of an item, a `creation_date`, a `price`, or any other piece of data the model needs to store.

Different pieces of data will have different data types, validation rules, and other forms of metadata. The Django ORM contains a rich suite of options to configure the fields of your models to your specifications, and is extensible allowing you to create your own rules as needed.

### Defining the field type

The core piece of metadata for all fields is the type of data it will store, such as a string or number. Field types map both to a database type and an HTML form control type (such as a textbox or checkbox). [Django includes several field types](https://docs.djangoproject.com/en/3.1/ref/models/fields/#field-types), including:

- `CharField`: Single line of text
- `TextField`: Multiple lines of text
- `BooleanField`: Boolean True/False option
- `DateField`: A date
- `TimeField`: A time
- `DateTimeField`: A date and time
- `URLField`: A URL
- `IntegerField`: An integer
- `DecimalField`: A fixed-precision decimal number

To add fields to our `Product` and `Category` classes, we might have the following:

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

[Field options](https://docs.djangoproject.com/en/3.1/ref/models/fields/#field-options) allow you to add metadata to allow null or blank values, or mark a field as unique. You can also set validation options, and provide custom error messages should a validation error occur. As with the field types, these also map to the appropriate settings in the database, and the rules will be enforced in any forms Django generates on our behalf.

Field options are passed into the function for the field itself. Different fields may support different options. Some of the most common are:

- `null`
  - Boolean option to allow null values
  - Default is `False`
- `blank`
  - Boolean option to allow blank values
  - Default is `False`
- `default`
  - Allows the configuration of a default value if a value for the field is not provided
  - If you wish to set the default value to a database `null`, set `default` to `None`
- `unique`
  - This field must contain a unique value
  - Default is `False`
- `min_length` and `max_length`
  - Used with string types to identify the minimum and maximum string length
  - Default is `None`
- `min_value` and `max_value`
  - Used with number types to identify the minimum and maximum values
- `auto_now` and `auto_now_add`
  - Used with date/time types to indicate if the current time should be used
  - `auto_now` will **always** set the field to the current time on save, useful for `last_update` fields
  - `auto_now_add` will set the field to the current time on creation, useful for `creation_date` fields

> [!NOTE]
> `null` and `blank` can seem similar, but in database terms mean very different things. `null` is the lack of a value, while a `blank` is specifically an empty value.

To add options to our models, it might look like this:

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

A standard practice in relational databases is for each row in a table to have a primary key, typically an auto-incremented integer. Django's ORM will add this automatically to every model you create, by adding a field named `id`. If you wish to override this you can do so by setting the field you wish to be your primary key. However, in most situations you should rely on Django's `id` field.

Relational databases also have relationships between tables. A product would have a category, an employee a manager, and a car a manufacturer. Django's ORM supports all the relationships you may wish to create between your models. The most common is a "one-to-many" relationship, technically known as a **foreign key relationship**. This indicates a relationship where multiple items share a single attribute. Multiple products would be grouped into a single category, for example. To model this relationship, we use the `ForeignKey` field.

To create the relationship, you add the `ForeignKey` field to the child object. If our products are grouped into categories, we will add the `category` property to the `Product` class, and set the type to be `ForeignKey`. Django will automatically add a property to the parent to provide access to all children called `<child>_set`, where `<child>` is the name of the child object. In our example, `Category` will automatically have `product_set` added to provide access to all products in the category.

#### on_delete

`ForeignKey` has one mandatory parameter, `on_delete`. [on_delete](https://docs.djangoproject.com/en/3.1/ref/models/fields/#django.db.models.ForeignKey.on_delete) instructs Django what to do should the parent be deleted; if we delete a category what should happen to the products in that category?

The two most common options are `CASCADE`, which will delete all products if a category is deleted in our example, and `PROTECT`, which would return an error if we try to delete a category which contains products.

> [!NOTE]
> In most situations you will want to use `PROTECT`.

To update our model to create the relationship, we could use the following code:

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
