We want to update our application to provide a list of dog shelters. We also want the application to allow someone to click or tap an individual shelter to see the details. We'll do this by creating two views and then registering the appropriate paths.

## Create views

1. In Visual Studio Code, open *dog_shelters/views.py*.
1. At the end of the line that reads `from django.shortcuts import render`, add `, get_object_or_404`. The line should now read:

    ```python
    from django.shortcuts import render, get_object_or_404
    ```

1. Below the line that reads `from django.shortcuts import render`, add the following Python code to import your models:

    ```python
    from . import models
    ```

1. At the end of *views.py*, add the following code to load all shelters, create the context object for the template, and then render the template for the user. This will become our list view for shelters and the default page for our site.

    ```python
    def shelter_list(request):
        shelters = models.Shelter.objects.all()
        context = {'shelters': shelters}
        return render(request, 'shelter_list.html', context)
    ```

1. At the end of *views.py*, add the following code to load a specific shelter by its `pk` or primary key, create the context object for the template, and then render the template for the user. This will become the details page for a shelter.

    ```python
    def shelter_detail(request, pk):
        shelter = get_object_or_404(models.Shelter, pk=pk)
        context = {'shelter': shelter}
        return render(request, 'shelter_detail.html', context)
    ```

## Create the URLconf

For our views to be callable, we need to register the appropriate paths.

1. Create a new file in *dog_shelters* called *urls.py*.
1. Add the following code to register the paths for the two views that we created:

    ```python
    from django.urls import path
    from . import views

    urlpatterns = [
        path('', views.shelter_list, name='shelter_list'),
        path('shelter/<int:pk>', views.shelter_detail, name='shelter_detail'),
        # More patterns to come later
    ]
    ```

Notice that we created a default path (`''`) to point to our `shelter_list` view. We also registered `shelter/<int:pk>` to reference our `shelter_detail` view. As highlighted earlier, `pk` will be passed as the `pk` parameter to `shelter_detail`.

## Register URLconf with our project

Django uses one core *urls.py* file as its URLconf. As a result, we need to ensure that the one we created is properly registered.

1. Open *project/urls.py*.
1. Toward the bottom of the file, find line 17, which reads:

    ```python
    from django.urls import path
    ```

   At the end of the line, add `, include`. The new line 17 should now be the following:

    ```python
    from django.urls import path, include
    ```

1. Below the line that reads `TODO: Register URLconf`, add the following:

    ```python
    # TODO: Register URLconf
    path('', include('dog_shelters.urls')),
    ```

    > [!IMPORTANT]
    > The trailing comma is required.

1. Save all files by selecting **File** > **Save All**.
