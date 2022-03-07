As highlighted before, the admin site doesn't provide access to your data by default. Fortunately, it takes only a couple of lines of code to register any models you want to be editable through the tool.

## Register models

1. Open **dog_shelters/admin.py**.
1. Underneath the comment that reads `# Register your models here.`, add the following code to register your models.

    ```python
    # Register your models here.
    from .models import Shelter, Dog

    admin.site.register(Shelter)
    admin.site.register(Dog)
    ```

1. Save the file.
1. Return to your browser, and refresh the page.

   Notice that you have **Dogs** and **Shelters** listed under **DOG_SHELTERS**.

    :::image type="content" source="../media/dogs-shelters-admin.png" alt-text="Screenshot showing the Site administration screen." lightbox="../media/dogs-shelters-admin.png":::

## Access our data

With our models registered, we can now manage our data. If there was any data already in the database, we could modify it as needed.

In our data model, which you can explore by opening **models.py**, we have `Shelter` and `Dog`. A `Shelter` contains multiple `Dogs` to create the relationship between the models.

Let's create a new `Dog` to explore how the admin site functions for data.

1. Select **Add** next to **Dogs**.

    :::image type="content" source="../media/add-dog.png" alt-text="Screenshot showing the Add shelter screen." lightbox="../media/add-dog.png":::

    Notice that when you select the drop-down list for **Shelter**, no shelters are listed because we haven't created one.

    > [!NOTE]
    > If you're continuing with a project you started earlier, you might see a shelter if you created one.

    The drop-down exists so that we can select the shelter into which we would register the dog. We can create a new one by selecting the plus sign (**+**).

1. Select the plus sign (**+**).

   A new window opens where you can create a **Shelter**.

    :::image type="content" source="../media/new-shelter.png" alt-text="Screenshot showing an Add shelter screen." lightbox="../media/new-shelter.png":::

1. Enter a **Name** and **Location** for the shelter, such as **Contoso** and **Redmond, WA**.
1. Select **SAVE**.

    The screen updates and shows the newly created **Shelter** as the selected option for the dog.
1. Enter a **Name** and **Description** for the dog.
1. Select **SAVE**.

   The screen returns to the list of dogs, and the information on the newly created dog appears.

    :::image type="content" source="../media/new-dog.png" alt-text="Screenshot showing a list of dogs." lightbox="../media/new-dog.png":::

1. If you select the dog, you'll be taken to the details page where you can update any values or delete the entry.

    > [!NOTE]
    > The display shows the name of the dog or the shelter if you go to the **Shelters** portion of the admin site. This information appears because we set the `__str__` method on our objects. The default display of any object is the value returned by `__str__`.
