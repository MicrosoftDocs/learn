In this unit, you'll see how change feed can help maintain referential integrity between two containers in Azure Cosmos DB. In this scenario, you use change feed to listen to the productCategory container. When you update the name of a product category, change feed captures the updated name and updates all the products in that category with the new name.

For this exercise, you'll complete the following steps:

- Start Azure Cloud Shell and open the code editor to show your code for change feed.
- Complete some C# code to highlight key concepts to understand.
- Start the change feed processor so that it begins to listen to the productCategory container.
- Query the product container for the category whose name you're changing and the number of products in that category.
- Update the category name, and watch change feed propagate the changes to the product container.
- Query the new product container with the new category name, and count the number of products to ensure that they're all updated.
- Change the name back to the original, and watch change feed propagate the changes back.

## Start Azure Cloud Shell and open the code editor

Go to the code that you'll update for change feed.

1. In Cloud Shell, if necessary, change the current directory to the location of the project.

    ```bash
    cd mslearn-model-partition-data-azure-cosmos-db/modeling
    ```

1. Open the *Program.cs* file in the code editor.

    ```bash
    code Program.cs
    ```

1. You should now see the following code in Cloud Shell.

    :::image type="content" source="../media/5-cloud-shell-vs-code.png" lightbox="../media/5-cloud-shell-vs-code.png" alt-text="Screenshot of Cloud Shell with the code editor open, displaying a list of 'using' statements, the app namespace, and the start of the Program class.":::

## Complete the code for change feed

Add code to handle the changes that are passed into the delegate, loop through each product for that category, and update them.

1. Select Ctrl+G, and then type **603** to go to the function that starts the change feed processor.

1. You should now see the following code:

    :::image type="content" source="../media/5-change-feed-function.png" lightbox="../media/5-change-feed-function.png" alt-text="Screenshot of Cloud Shell, displaying the function where change feed has been implemented.":::

   At lines 593 and 594 are two container references. You need to update them with the correct container names. Change feed works by creating an instance of the change feed processor on the container reference. In this case, you're watching for changes to the productCategory container.

1. At line 593, replace **{container to watch}** with **productCategory**.

1. At line 594, replace **{container to update}** with **product**. When a product category name is updated, every product in that category needs to be updated with the new product category name.

1. Below the *container to watch* and *container to update* lines, review the *leaseContainer* line. The leaseContainer works like a checkpoint on the container. It knows what has been updated since the last time it was checked by the change feed processor.
  
   When change feed sees a new change, it calls a delegate and passes the changes in a read-only collection.

1. At line 609, you need to add some code that will be called when change feed has a new change that needs to be processed. To do so, copy the following code snippet and paste it below the line that starts with `//To-Do:`

    ```csharp
    //Fetch each change to productCategory container
    foreach (ProductCategory item in input)
    {
        string categoryId = item.id;
        string categoryName = item.name;
    
        tasks.Add(UpdateProductCategoryName(productContainer, categoryId, categoryName));
    }
    ```

1. Your code should now look like the code in the following image:

    :::image type="content" source="../media/5-change-feed-function-delegate-code.png" lightbox="../media/5-change-feed-function-delegate-code.png" alt-text="Screenshot of the Cloud Shell window that displays the fully completed code for change feed.":::

    By default, change feed runs every second. In scenarios where there are many inserts or updates made in the watched container, the delegate might have more than one change. For this reason, you type the delegate `input` as `IReadOnlyCollection`.

    This code snippet loops through all the changes in the delegate `input` and saves them as strings for `categoryId` and `categoryName`. It then adds a task to the task list with a call to another function that updates the product container with the new category name.

1. Select Ctrl+G, and then enter **648** to find your `UpdateProductCategory()` function. Here you write some code that updates each product in the product container with the new category name captured by change feed.

1. Copy the following code snippet and paste it below the line that starts with **//To-Do:**. The function does two things. It first queries the product container for all the products for the passed in `categoryId`. It then updates each product with the new product category name.

    ```csharp
    //Loop through all products
    foreach (Product product in response)
    {
        productCount++;
        //update category name for product
        product.categoryName = categoryName;
    
        //write the update back to product container
        await productContainer.ReplaceItemAsync(
            partitionKey: new PartitionKey(categoryId),
            id: product.id,
            item: product);
    }
    ```

    Your code should now look like this.

    :::image type="content" source="../media/5-change-feed-function-update-product.png" lightbox="../media/5-change-feed-function-update-product.png" alt-text="Screenshot of Cloud Shell, showing the fully implemented update product category name function called by the change feed function.":::

    The code reads the rows from the response object of the query and then updates the product container with all the products returned by the query.

    You're using a `foreach()` loop to go through each product that's returned by the query. For each row, you update a counter so that you know how many products were updated. You then update the category name for the product to the new `categoryName`. Finally, you call `ReplaceItemAsync()` to update the product back in the product container.

1. Select Ctrl+S to save your changes.

1. Select Ctrl+Q to close the editor.

1. To compile and execute the project, run the following command:

    ```bash
    dotnet build
    dotnet run
    ```

1. Your screen should now display the main menu for the application.

    :::image type="content" source="../media/5-main-menu.png" lightbox="../media/5-main-menu.png" alt-text="Screenshot that shows the main menu for the application with multiple options for working with the data.":::

## Run the change feed sample

Now that you've completed the code for change feed, let's see it in action.

1. On the main menu, select **a** to start the change feed processor. Your screen displays the progress.

    :::image type="content" source="../media/5-change-feed-start.png" lightbox="../media/5-change-feed-start.png" alt-text="Screenshot of the output of the application as it builds and then starts change feed.":::

1. Press any key to return to the main menu.

1. Select **b** on the main menu to update the product category name. The following sequence takes place:
    
    a. Queries the products container for the "Accessories, Tires, and Tubes" category, and counts how many products are in that category.  
    b. Updates the category name and replaces the word "and" with an ampersand (&).  
    c. Change feed picks up that change and, using the code you wrote, updates all the products for that category.  
    d. Change feed reverts the name change and changes the category name back, replacing "&" with the original "and."  
    e. Change feed picks up that change and updates all the products back to the original product category name.

1. Select **b** on the main menu and follow the prompts until change feed runs a second time, and then hold. The results will look like the following:

    :::image type="content" source="../media/5-change-feed-update-category-name.png" lightbox="../media/5-change-feed-update-category-name.png" alt-text="Screenshot of the output of the application as the category name is changed.":::

1. If you clicked too far and went back to the main menu, select **b** again to observe the changes.

1. When you're done, type **x** to exit and return to Cloud Shell.
