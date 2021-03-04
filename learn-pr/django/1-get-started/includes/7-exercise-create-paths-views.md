With our app structure created, we can begin to take the necessary steps to add our own custom code. We will do this by creating a view, and then registering a path inside a URLconf.

## Create the view

1. Inside **Visual Studio Code**, open **views.py**, which will be inside **hello_world**
1. Replace the code inside **views.py** with the following

    ```python
    from django.shortcuts import render
    from django.http import HttpResponse

    def index(request):
        return HttpResponse("Hello, world!")
    ```

    `HttpResponse` is a helper function that allows you to return text or other primitive types to the caller.

    > [!NOTE]
    > When opening **views.py** you may receive a message from Visual Studio Code prompting you to install **PyLint**. If you receive this message, click **Install PyLint**.

## Create the route

With the view created, the next step is to map it to the appropriate URL, or path.
        
1. Inside **Visual Studio**, create a file in **hello_world** named **urls.py**
2. Add the following code to the new **urls.py**

    ```python
    from django.urls import path
    from . import views

    urlpatterns = [
        path('', views.index, name='index'),
    ]
    ```

The most important part of this code is the `urlpatterns` tuple. This tuple is where the views and URLs are connected or mapped. As you can see, we have imported our **views.py** file so we are able to use it within the `urlpatterns` line.

## Register our URLconf with the project

Our newly created `URLconf` is inside our **hello_world** application. However, the project controls all user requests. As a result, we need to register our `URLconf` in the core **urls.py** file, which will be inside **helloproject**.

1. Open **urls.py** inside **helloproject**
1. Note the doc comments at the beginning. These comments explain how you can register new `URLconf` modules.
1. **Replace** the line that reads `from django.urls import path` with the following `import` statement to add `include` and `path`

    ```python
    from django.urls import include, path
    ```

    `include` allows us to import `URLconf` modules. `path` is used to identify the root for the `URLconf`.

1. Below the line that reads `urlpatterns = [` (inside the list), add the following code:

    ```
    path('/', include('hello_world.urls')),
    ```

    This code will register our `URLconf`.

The code below the doc comment should now look like the following:

```python
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('/', include('hello_world.urls')),
    path('admin/', admin.site.urls),
]
```
    
## Running your first app

Now that the structure is complete, views have been added, and the URLs mapped it is time to run your app!

1. Inside the **terminal** in **Visual Studio Code**, execute the following command to start the server again

    ```bash      
    python manage.py runserver
    ```

1. Open the URL in your preferred browser

    http://localhost:8000/

You should now see **Hello, world!** on your browser window. Congratulations! You have created your first Django application.
