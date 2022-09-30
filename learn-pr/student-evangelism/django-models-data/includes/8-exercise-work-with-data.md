By creating our models, we created an API that we can use to access the data in our database. This API allows us to create, retrieve, update, and delete objects in our database. 

Let's explore the API by working with the models that we created.

## Configure the interactive shell

Django includes an interactive shell where you can run Python code in the Django environment.

1. Return to the terminal in Visual Studio Code by selecting **View** > **Terminal**.
1. Enter the following command to start the shell:

    ```bash
    python manage.py shell
    ```

1. Import the models from `models` inside `dog_shelters`:

    ```python
    from dog_shelters.models import Shelter, Dog
    ```

## Create and modify objects

Because our models are Python classes, we create new instances by using the same syntax that we'd use to create an object. Because they inherit from `Django.models.Model`, they inherit the functionality for the Django ORM. That functionality includes `save`, which we use to save the object to the database.

1. Create a new shelter by running the following Python command in the shell:

    ```python
    shelter = Shelter(name="Demo shelter", location="Seattle, WA")
    shelter.save()
    ```

    The `save` part will write the object to the database. Because we created this from scratch, it will execute an `INSERT` statement in the database.

1. Update the location of the shelter to Redmond, WA, by setting the `location` field and calling `save`:

    ```python
    shelter.location = "Redmond, WA"
    shelter.save()
    ```

    This command will issue an `UPDATE` statement to update the value in the database.

1. Create two new dogs for the shelter by running the following Python commands in the shell:

    ```python
    Dog(name="Sammy", description="Cute black and white dog", shelter=shelter).save()
    Dog(name="Roscoe", description="Lab mix", shelter=shelter).save()
    ```

    As before, `save` inserts the dog. Notice how we set the `shelter` parameter to the `shelter` object that we created before. Django will automatically set the relationship in the database.

    Also note that we didn't set up a local variable for each `Dog` instance. Because we won't reuse the objects, we don't need to set them to a variable.

## Retrieving objects

To retrieve objects from a database, Django provides an `objects` property on all `Model` classes. The `objects` property provides multiple functions, including `all`, `filter`, and `get`.

1. Retrieve all dogs in *Demo shelter* by running the following command:

    ```python
    shelter.dog_set.all()
    ```

    The `dog_set` part stores the list of all dogs for a particular shelter. Django will return a `QuerySet` object with the two dogs that we created.

    ```bash
    <QuerySet [<Dog: Sammy>, <Dog: Roscoe>]>
    ```

1. Retrieve the second dog by using `get` as shown in the following command:

    ```python
    Dog.objects.get(pk=1)
    ```

    The `get` function will return only one object. You can pass parameters into `get` to provide a query string. Here we use `pk`, which is a special keyword to indicate the primary key. The returned result will be Sammy.

    ```bash
    <Dog: Sammy>
    ```

1. Retrieve all dogs in *Demo shelter* by using `filter` as shown in the following command:

    ```python
    Dog.objects.filter(shelter__name='Demo shelter')
    ```

    Like `get`, `filter` allows us to pass a query in the parameters. Notice we can use two underscores (`__`) to go from property to property. Because we want to find all dogs in the shelter named *Demo shelter*, we use `shelter__name` to access the `name` property of `shelter`. The result returned will be all dogs, because we have only one shelter.

    ```bash
    <QuerySet [<Dog: Sammy>, <Dog: Roscoe>]>
    ```

## Close the shell

After you're done playing with the objects, you can close the shell by running the `exit()` command.

## Summary

You've now seen how you can programmatically work with data in Django through the Django ORM.
