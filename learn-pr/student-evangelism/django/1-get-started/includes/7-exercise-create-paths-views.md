With our app structure created, we can begin to take the steps to add our own custom code. We'll create a view and then register a path inside a `URLconf`.

## Create the view

1. Inside Visual Studio Code, open **views.py**, which will be inside **hello_world**.
1. Replace the code inside **views.py** with the following code:

    ```python
    from django.shortcuts import render
    from django.http import HttpResponse

    def index(request):
        return HttpResponse("Hello, world!")
    ```

    The helper function `HttpResponse` allows you to return text or other primitive types to the caller.

    > [!NOTE]
    > When you open **views.py**, you might receive a message from Visual Studio Code that prompts you to install **PyLint**. If you receive this message, select **Install PyLint**.

## Create the route

With the view created, the next step is to map it to the appropriate URL, or path.

1. Inside Visual Studio Code, create a file in **hello_world** named **urls.py**.
1. Add the following code to the new **urls.py**.

    ```python
    from django.urls import path
    from . import views

    urlpatterns = [
        path('', views.index, name='index'),
    ]
    ```

The most important part of this code is the `urlpatterns` tuple. This tuple is where the views and URLs are connected or mapped. As you can see, we've imported our **views.py** file so we can use it within the `urlpatterns` line.

## Register our `URLconf` with the project

Our newly created `URLconf` is inside our **hello_world** application. Because the project controls all user requests, we need to register our `URLconf` in the core **urls.py** file, which is inside **helloproject**.

1. Open **urls.py** inside **helloproject**.
1. Note the doc comments at the beginning. These comments explain how you can register new `URLconf` modules.
1. **Replace** the line that reads `from django.urls import path` with the following `import` statement to add `include` and `path`.

    ```python
    from django.urls import include, path
    ```

    Using `include` allows us to import `URLconf` modules, and `path` is used to identify the root for the `URLconf`.

1. Inside the list, underneath the line that reads `urlpatterns = [`, add the following code:

    ```python
    path('', include('hello_world.urls')),
    ```

    This code registers our `URLconf`.

The code underneath the doc comment should now look like the following sample:

```python
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('', include('hello_world.urls')),
    path('admin/', admin.site.urls),
]
```

## Run your first app

The structure is complete, views were added, and the URLs were mapped. Now it's time to run your app!

1. Inside the **terminal** window in Visual Studio Code, run the following command to start the server again.

    ```bash
    python manage.py runserver
    ```

1. Open the URL in your preferred browser:

    http://localhost:8000/

You should now see **Hello, world!** in your browser window. Congratulations! You've created your first Django application.
