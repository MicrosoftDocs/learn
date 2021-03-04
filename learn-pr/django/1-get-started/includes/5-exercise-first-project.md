Now that we have explored some basic concepts of Django let's begin creating the project.

## Create a project with Django-admin

As highlighted previously, a Django project is the container for our entire project, and any applications we create. Let's create our project.

Inside the **terminal** window in **Visual Studio Code**, execute the following command

> [!IMPORTANT]
> The trailing dot at the end of the command is important. It instructs `django-admin` to use the current folder. If you leave off the dot it will create an additional subdirectory.

```bash
django-admin startproject helloproject .
```

After running the above command, the new project should now be in your chosen directory. In this instance, you would see a new folder called **helloproject**.

## Navigating the project structure

Now that the Django project has been created let's look at the structure to see what was included.

```text
manage.py
helloproject/
    __init__.py
    settings.py
    urls.py
    asgi.py
    wsgi.py
```

- [**manage.py**](https://docs.djangoproject.com/en/3.1/ref/django-admin?azure-portal=true) is a command-line utility created in every Django project and actually has the same function as 'django-admin'. Below is an example of how this could be used if you were inside the project folder and wanted to see the available subcommands. 

    ```bash   
    python manage.py help
    ``` 

- **helloproject** is considered the Python package for your project.
- **init.py**, an empty file that functions to tell Python that this directory should be considered a package.
- **settings.py** contains all of your settings or configurations.
- **urls.py** contains the urls within the project.
- **asgi.py** and **wsgi.py** serve as the entry point for your web servers depending on what type of server is deployed.

## Running the project

Now that Django is installed, a project has been created, and we have examined the project structure it is time to make sure our project is working correctly.

1. Inside the **terminal** window in **Visual Studio Code**, enter the following code to start the server

    ```bash      
    python manage.py runserver
    ```

    The project will perform system checks and start your development server. Copy and paste the URL of your development server, which should be **http://localhost:8000**, into your preferred browser and you should see a Django 'Congratulations' page with a rocket taking off.

1. Stop the server temporarily, as we will be reconfiguring our project. Inside the **terminal** window, press **Ctl-C**.

## Create the Hello World app

Now that we have learned the basics about the Django framework, and examined the folder structure of our project it is time to create our first app! While this is a starter **Hello, world!** app it will give you the starting blocks in understanding how apps are created and how they work in unison with the Django project.

Inside the **terminal** window, execute the following command to create the app

```bash
python manage.py startapp hello_world
```

With this command, Django will create the required folders and files and the following structure should now be visible.

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
