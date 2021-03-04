By creating our models we created an API we can use to access the data in our database. This API allows us to create, retrieve, update and delete objects in our database. Let's explore the API by working with the models we created.

## Configure the interactive shell

Django includes an interactive shell where you can execute Python code in the Django environment.

1. Return to the **terminal** in **Visual Studio Code** by clicking **View** > **Terminal**
1. Enter the following command to start the shell

    ```bash
    python manage.py shell
    ```

1. Import our models from the **models** inside **dog_shelters**

    ```python
    from dog_shelters.models import Shelter, Dog
    ```

## Creating and modifying objects

Because our models are Python classes, we create new instances using the same syntax we would use to create an object. Because they inherit from `Django.models.Model`, they inherit the functionality for the Django ORM, including `save`, which we use to save the object to the database.

1. Create a new shelter by executing the following Python in our shell

    ```python
    shelter = Shelter(name="Demo shelter", location="Seattle, WA")
    shelter.save()
    ```

    `save` will write the object to the database. Because we created this from scratch, it will execute an `INSERT` statement in the database.

1. Update the location of the shelter to **Redmond, WA** by setting the `location` field and calling `save`

    ```python
    shelter.location = "Redmond, WA"
    shelter.save()
    ```

    This will issue an `UPDATE` statement to update the value in the database.

1. Create two new dogs for the shelter by executing the following Python in our shell

    ```python
    Dog(name="Sammy", description="Cute black and white dog", shelter=shelter).save()
    Dog(name="Roscoe", description="Lab mix", shelter=shelter).save()
    ```

    As before, `save` insert the dog. Notice how we set the `shelter` parameter to the `shelter` object we created before. Django will automatically set the relationship in the database.

    You will also note we didn't set up a local variable for each `Dog`. Because we won't reuse the objects, we don't need to set them to a variable.

## Retrieving objects

To retrieve objects from a database, Django provides an `objects` property on all `Model` classes. `objects` provides multiple functions, including `all`, `filter`, and `get`.

1. Retrieve all dogs in our **Demo shelter** by executing the following command:

    ```python
    Shelter.dog_set.all()
    ```

    `dog_set` stores the list of all dogs for a particular shelter. Django will return a QuerySet object with the two dogs we created.

    ```bash
    <QuerySet [<Dog: Sammy>, <Dog: Roscoe>]>
    ```

1. Retrieve the second dog by using `get` by executing the following code:

    ```python
    Dog.objects.get(pk=1)
    ```

    `get` will return only one object. You can pass parameters into `get` to provide a query string. Here we use `pk`, which is a special keyword to indicate the **primary key**. The result returned will be Roscoe.

    ```bash
    <Dog: Roscoe>
    ```

1. Retrieve all dogs in the **Demo shelter** by using `filter` by executing the following code

    ```python
    Dog.objects.filter(shelter__name='Demo shelter')
    ```

    Similar to `get`, `filter` allows us to pass a query in the parameters. Notice we can use two underscores (`__`) to navigate from property to property. Because we want to find all dogs in the shelter named **Demo shelter**, we use `shelter__name` to access the `name` property of `shelter`. The result returned will be all dogs (because we only have one shelter).

    ```bash
    <QuerySet [<Dog: Sammy>, <Dog: Roscoe>]>
    ```

## Close the shell

Once you're done playing with the objects, you can exit the shell by executing the `exit()` command.

## Summary

You have now seen how you can programmatically work with data in Django through the Django ORM.
