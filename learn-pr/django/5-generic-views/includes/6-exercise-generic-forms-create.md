We want to allow users to register new dogs at a shelter. We will do this by using the generic `CreateView`.

## Update the model to support get_absolute_url

Let's start by updating the model to support `get_absolute_url`.

1. Inside Visual Studio Code, open **dog_shelters/models.py**
1. Add the following code below the line which reads `# TODO: Import reverse` to import the `reverse` function

    ```python
    # TODO: Import reverse
    from django.urls import reverse
    ```

1. Add the following code below the line which reads `# TODO: Add get_absolute_url` to read the **dog_detail** path from URLconf and pass the id as the parameter:

    ```python
    # TODO: Add get_absolute_url
    def get_absolute_url(self):
        return reverse('dog_detail', args=[str(self.id)])
    ```

## Create the DogCreateView

Let's create the `DogCreateView` view to allow someone to register a dog.

1. Inside Visual Studio Code, open **dog_shelters/views.py**
1. At the end of **views.py**, add the following code to create the `DogCreateView`

    ```python
    class DogCreateView(generic.CreateView):
        model = models.Dog
        template_name = 'dog_form.html'
        fields = ['shelter', 'name', 'description']
    ```

We set the model to be the `Dog`, our template to be **dog_form.html**, and the list of fields we want editable.

> [!NOTE]
> The order you list the fields will be the order they will be displayed in the form.

## Register the route

With our view created, let's register the route in our URLconf.

1. Inside Visual Studio Code, open **dog_shelters/urls.py**
1. Below the line which reads `# TODO: Register create view`, add the following code to register the route:

    ```python
    # TODO: Register create view
    path('dog/register', views.DogCreateView.as_view(), name='dog_register'),
    ```

## Create the template

Let's create the template to host our form.

1. Inside Visual Studio Code, create a new file inside **dog_shelters/templates** named **dog_form.html**
1. Add the following code to **dog_form.html** to create the template to host our form:

    ```html
    {% extends 'base.html' %}

    {# TODO: Register crispy_forms_tags #}

    {% block title %}
    Register dog at shelter
    {% endblock %}

    {% block content %}
    <h2>Register dog at shelter</h2>
    <form method="POST">
        {% csrf_token %}

        {{ form.as_p }}

        <button type="submit" class="btn btn-primary">Save</button>
    </form>
    {% endblock %}
    ```

    > [!NOTE]
    > We are adding a note for ourselves to add a library, which we'll do in the next exercise.

## Create a link to the registration page

Let's create a link on our shelter list page, which is currently the home page for our application, to the register page we just created.

1. Inside Visual Studio Code, open **dog_shelters/templates/shelter_list.html**
1. Below the line which reads `{# TODO: Add link to registration page #}`, add the following code to create the link:

    ```html
    {# TODO: Add link to registration page #}
    <div>
        <a href="{% url 'dog_register' %}">Register a dog available for adoption</a>
    </div>
    ```

## Test the page

Let's see our page in action!

1. Save all files by selecting **File** > **Save All**.
1. In your browser navigate to `http://localhost:8000`.
1. Select **Register a dog available for adoption**.
1. You should now see the form.

   :::image type="content" source="../media/dog-register.png" alt-text="Screenshot of the register dog page, with the dropdown list for shelter highlighted.":::

1. Notice how our foreign key relationship becomes a dropdown list.
1. Choose a shelter, add a name and description for a dog.
1. Select **Save**.
1. You are now redirected to the details page for your dog!

You have now created a creation form using the generic `CreateView` in Django.
