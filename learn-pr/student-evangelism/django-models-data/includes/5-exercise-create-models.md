By creating a model, you can define any essential fields and the behavior of your data. Let's add the necessary models for the *dog_shelters* application.

## Create models

The first step in the process is to add the models. Django provides an empty file named *models.py* that you can use for your models.

1. Open the *dog_shelters/models.py* file in Visual Studio Code.
1. Add two Python classes to contain the models by entering the following code under the comment `Create your models here`:

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

By adding these models, we now have a representation for shelters and dogs. Note the relationship between `Dog` and `Shelter`: a `Shelter` class can house many `Dog` values. Also note the `auto_now_add` value for `intake_date`. It automatically sets the field to the current date if a custom date isn't provided.

We're also using `ForeignKey` in the `Dog` class. This part tells Django there's a relationship between `Dog` and `Shelter`. By defining this relationship, we're telling Django that every dog is related to a single shelter.

## Register the model

All applications must be registered with the project in Django. It might seem a little counterintuitive, but just because an application folder exists inside a project doesn't mean it automatically gets loaded. We need to register it by adding it to the `INSTALLED_APPS` list.

1. Find the configuration class name within the *dog_shelters* folder. To find this class name, go to the *dog_shelters/apps.py* file and check that the class name is `DogSheltersConfig` in the following code:

    ```python
    class DogSheltersConfig(AppConfig):
        default_auto_field = 'django.db.models.BigAutoField'
        name = 'dog_shelters'
    ```

1. Open *settings.py* in *project*.
1. Add the full path to the class name under the comment `#[TODO] - Add the app to the list of INSTALLED_APPS`:

    ```python
        #[TODO] - Add the app to the list of INSTALLED_APPS
        'dog_shelters.apps.DogSheltersConfig',
    ```

    The `INSTALLED_APPS` list now contains the following items:

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

    Adding the line to the `INSTALLED_APPS` list tells Django that this app needs to be included when it runs the project.

## Summary

You've now created two models for your Django application. Creating models is the foundation to all Django projects.
