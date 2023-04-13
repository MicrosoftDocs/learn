Now that we've explored some basic concepts of Django, let's begin creating the project.

## Create a project with Django-admin

As highlighted previously, a Django project is the container for our entire project and any applications we create. Let's create our project.

Inside the **terminal** window in Visual Studio Code, run the following command:

```bash
django-admin startproject helloproject .
```

> [!IMPORTANT]
> The trailing period at the end of the command is important. It instructs `django-admin` to use the current folder. If you leave off the period, it will create an additional subdirectory.

After you run the preceding command, the new project should now be in your chosen directory. In this instance, you would see a new folder called **helloproject**.

## Explore the project structure

Now that the Django project has been created, let's look at the structure to see what was included.

```text
manage.py
helloproject/
    __init__.py
    asgi.py
    settings.py
    urls.py
    wsgi.py
```

- The command-line utility [manage.py](https://docs.djangoproject.com/en/3.1/ref/django-admin?azure-portal=true) is created in every Django project. It has the same function as django-admin. The following example shows how it could be used if you were inside the project folder and wanted to see the available subcommands.

    ```bash   
    python manage.py help
    ``` 

- **helloproject** is considered the Python package for your project.
- **init.py** is an empty file that functions to tell Python that this directory should be considered a package.
- **settings.py** contains all of your settings or configurations.
- **urls.py** contains the URLs within the project.
- **asgi.py** and **wsgi.py** serve as the entry point for your web servers depending on what type of server is deployed.

## Run the project

Now that Django is installed, a project has been created, and we've examined the project structure, it's time to make sure our project is working correctly.

1. Inside the **terminal** window in Visual Studio Code, enter the following code to start the server.

    ```bash      
    python manage.py runserver
    ```

    The project performs system checks and starts your development server. Copy and paste the URL of your development server, which should be http://localhost:8000, into your preferred browser. You should see a Django **Congratulations** page with an image of a rocket taking off.

1. Stop the server temporarily, because we'll need to reconfigure our project. Inside the **terminal** window, select **Ctrl+C**.

## Create the Hello World app

We've learned the basics about the Django framework and examined the folder structure of our project. Now it's time to create our first app! The **Hello, world!** app will help you understand how apps are created and how they work in unison with the Django project.

Inside the **terminal** window, run the following command to create the app.

```bash
python manage.py startapp hello_world
```

With this command, Django creates the required folders and files, and the following structure should now be visible.

```text         
hello_world/
    __init__.py
    admin.py
    apps.py
    migrations/
        __init__.py
    models.py
    tests.py
    views.py
```

## Register app with project

Because apps and projects are separate in Django, you must register your app with the project. This is done by updating the `INSTALLED_APPS` variable inside **settings.py** for the project, adding a reference to the config class for the app. The config class is found in **apps.py**, and is the same name as the project. In our example, the class will be named `HelloWorldConfig`.

1. Inside **helloproject**, open **settings.py**.
1. Find the list `INSTALLED_APPS`, which should be in line 33.
1. Add the following to the end of the list, inside the square brackets (`[ ]`):

    ```python
    'hello_world.apps.HelloWorldConfig',
    ```

1. The updated `INSTALLED_APPS` list should look like the following:

    ```python
    INSTALLED_APPS = [
        'django.contrib.admin',
        'django.contrib.auth',
        'django.contrib.contenttypes',
        'django.contrib.sessions',
        'django.contrib.messages',
        'django.contrib.staticfiles',
        'hello_world.apps.HelloWorldConfig',
    ]    
    ```

1. Save all files by selecting **File** > **Save all**.

Congratulations! You've now created your first Django project and app. Next is to create a path and view to add some functionality.
