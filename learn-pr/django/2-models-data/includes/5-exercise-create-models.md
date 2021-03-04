By creating a model we are able to define any essential fields and the behavior of our data. Let's add the necessary models for our **dog_shelters** application.

## Create models

The first step in our process is to add the models. Django provides an empty file named **models.py** which you can use for your models.

1. Open the **dog_shelters/models.py** file inside Visual Studio Code
1. Add two Python classes to contain our models by entering the below code under the comment `Create your models here`.

    ```python
    # Create your models here
    class Shelter(models.Model):
        name = models.CharField(max_length=200)
        location = models.CharField(max_length=200)
        def __str__(self):
            return self.name

    class Dog(models.Model):
        shelter = models.ForeignKey(Shelter, on_delete=models.PROTECT)
        name = models.CharField(max_length=200)
        description = models.TextField()
        intake_date = models.DateTimeField(auto_now_add=True)
        def __str__(self):
            return self.name
    ```

By adding these models, we now have a representation for shelters and dogs. Note the relationship between `Dog` and `Shelter`; a `Shelter` can house many `Dog`s. Also note the `auto_now_add` for `intake_date`, which will automatically set the field to the current date if a custom date isn't provided.

We are also using `ForeignKey` in the `Dog` class. This tells Django there is a relationship between a `Dog` and the `Shelter`. By defining this relationship we are telling Django that every **dog** is related to a single **shelter**.

## Register the model

All applications must be registered with the project in Django. It may seem a little counter-intuitive, but just because an application folder exists inside a project doesn't mean it automatically gets loaded. We need to register it by adding it to the list of `INSTALLED_APPS`.

1. Find the configuration class name within the **dog_shelters** folder. To find this class name go to the **dog_shelters/apps.py** file to find the below code and to see that the class name is `DogSheltersConfig`.

    ```python
    class DogSheltersConfig(AppConfig):
        name = 'dog_shelters'
    ```

1. Open **settings.py** in **project**
1. Add the full path to the class name under the comment `#[TODO] - Add the app to the list of INSTALLED_APPS`.

    ```python
        #[TODO] - Add the app to the list of INSTALLED_APPS
        'dog_shelters.apps.DogSheltersConfig',
    ```

    The `INSTALLED_APPS` list will now contain the following:

    ```python
    INSTALLED_APPS = [
        #[TODO] - Add the app to the list of INSTALLED_APPS
        'dog_shelters.apps.DogSheltersConfig',
        'django.contrib.admin',
        'django.contrib.auth',
        'django.contrib.contenttypes',
        'django.contrib.sessions',
        'django.contrib.messages',
        'django.contrib.staticfiles',
    ]
    ```

    By adding this line to the list of `INSTALLED_APPS` it tells Django that this app needs to be included when running the project.

## Summary

You have now created two models for your Django application. Creating models is the foundation to all Django projects.
