As highlighted before, the admin site does not provide access to your data by default. Fortunately, it only takes a couple of lines of code to register any models you wish to be editable through the tool.

## Registering models

1. Open **dog_shelters/admin.py**
1. Below the comment which reads `# Register your models here.`, add the following code to register your models

    ```python
    # Register your models here.
    from .models import Shelter, Dog

    admin.site.register(Shelter)
    admin.site.register(Dog)
    ```

1. Save the file
1. Return to your browser and refresh the page
1. Notice you have **Dogs** and **Shelters** listed under **DOG_SHELTERS**

    :::image type="content" source="<Missing media: Module3_DjangoAdminNewModels.PNG>" alt-text="Django Admin New Models." lightbox="<Missing media: Module3_DjangoAdminNewModels.PNG>":::

## Accessing our data

With our models registered, we can now manage our data! If there was any data already in the database we would be able to modify it as needed.

In our data model, which you can explore by opening **models.py**, we have `Shelter` and `Dog`. A `Shelter` contains multiple `Dogs` to create the relationship between the models.

Let's create a new `Dog` to explore how the admin site functions for data.

1. Click **Add** next to **Dogs**

    :::image type="content" source="../media/add-dog.png" alt-text="Add dog dialog with Shelter dropdown selected." lightbox="../media/add-dog.png":::

1. Notice when you select the dropdown for **Shelter** no shelters are listed because we haven't created one

    > [!NOTE]
    > If you are continuing with a project you started earlier you may see a shelter if you created one.

    The dropdown exists to allow us to select the Shelter into which we would register the dog. We can create a new one by clicking the **+** sign

1. Click the **+**
1. A new window opens allowing you to create a **Shelter**

    :::image type="content" source="../media/new-shelter.png" alt-text="New shelter screen." lightbox="../media/new-shelter.png":::

1. Provide a **Name** and **Location** for the shelter, such as **Contoso** and **Redmond, WA**
1. Click **Save**
1. Notice the screen now updates, showing the newly created **Shelter** as the selected option for the dog
1. Provide a **Name** and **Description** for the dog
1. Click **Save**
1. The screen returns to the list of dogs, showing you the newly created dog

    :::image type="content" source="../media/new-dog.png" alt-text="Screenshot of list of dogs." lightbox="../media/new-dog.png":::

1. If you click the dog you will be taken to the details page where you can update any values or delete the entry

    > [!NOTE]
    > You will notice the display is the name of the dog (or shelter if you navigate to the Shelters portion of the admin site). This is because we set the `__str__` method on our objects. The default display of any objects is the value returned by `__str__`.
