# Use Change Feed to maintain referential integrity between two containers

In this exercise we will show how Change Feed can maintain referential integrity between two containers in Azure Cosmos DB. In this scenario we will use Change Feed to listen to the productCategory container. When the name of a product category is updated, Change Feed will capture the updated name and we will take that name and update all the products in that category with the new name. We will then change the name back just so we can see the change happening again.

For this exercise we will complete the following steps:

- Start Azure Cloud Shell and open VS Code to show our code for Change Feed.
- Complete some C# code to highlight key concepts to understand.
- Start Change Feed Processor so it begins to listen to the productCategory container.
- Query the product container for the category we are changing the name of and the number of products in that category.
- Update the category name and watch change feed propagate the changes to the product container
- Query the new product container with the new category name and count the number of products to make sure they were all updated.
- Change the name back and watch change feed propagate the changes back.

## Start Azure Cloud Shell and open VS Code

Follow these steps to navigate to our code that we will view and update for Change Feed.

1. Open Azure Cloud Shell from the Azure Portal.
1. Navigate to the directory where our project is by changing the current directory to the one where our project is

```bash
cd mslearn-model-partition-data-azure-cosmos-db/modeling
```

1. Open VS Code to our Program.cs file

```bash
code Program.cs
```

1. You should now see this in Azure Cloud Shell

:::image type="content" source="../media/5-cloud-shell-vs-code.png" alt-text="cloud shell with vs code":::

1. Next navigate to the function that starts the Change Feed Processor.
1. Type **CTRL + G**, then type in **605** to go to that line in the file.
1. You should now see this.

:::image type="content" source="../media/5-change-feed-function.png" alt-text="change feed function":::

1. Notice on lines 591 and 592 two container references. We need to update those with the correct container names. Change Feed works by creating an instance of Change Feed Processor on the container reference. In this case we are watching for changes to the productCategory container so replace **{container to watch}** with **productCategory**.
1. When a product category name gets updated we need to update every product in that category with the new product category name. So we need a container reference to the product container. Replace **{container to update}** with **product**.
1. The *leases container* below that works like a check point on the container. It knows what has been updated since the last time it was checked by the Change Feed Processor.
1. When change feed sees a new change it calls a delegate and passes the changes in a read-only collection.
1. Navigate to **line 604**. Here we need to add some code that will be called when change feed has a new change that needs to be processed.
1. Next we will take the following code and paste it into our Change Feed function. In this code snippet we will create a List of Task objects that we will call `WhenAll()` on after we have looped through all of the changes. Next we will for each through each of the changes in the delegate `input` and save them to as string variables for `categoryId` and `categoryName`. Last, we will add a Task to the Task List with a call to another function that will update the product container with the new category name.
1. Copy this code snippet below and paste it below the line that starts with `//To-Do:`

```csharp
List<Task> tasks = new List<Task>();

//Fetch each change to productCategory container
foreach (ProductCategory item in input)
{
    string categoryId = item.id;
    string categoryName = item.name;

    tasks.Add(UpdateProductCategoryName(productContainer, categoryId, categoryName));
}

await Task.WhenAll(tasks);
```

1. Your code should now look like this.

:::image type="content" source="../media/5-change-feed-function-delegate-code.png" alt-text="change feed delegate complete":::

1. Next type **CTRL + G** and enter **650** to find our `UpdateProductCategory()` function. Here we need to write some code that will update each product in the product container with the new category name captured by Change Feed. This function does two things. It first queries the product container for all the products for the passed in `categoryId`. It then updates each product with the new product category name
1. Locate the line that starts with **//To-Do:**.
1. Here we need to write code that will read the rows from the response object from the query and then update the product container with all of the products returned by the query.
1. For this code we need to first create a `foreach()` loop to go through each product returned by the query. Next we will update a counter so we know how many products were updated. Next we will change the category name on the product object returned to the new `categoryName` that was passed into the function. Last we will call `ReplaceItemAsync()` on the product container we changed the *{placeholder name}* for to earlier in this exercise.
1. Copy this code snippet below and paste it below the line that starts with **//To-Do:**

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

1. Your code should now look like this.

:::image type="content" source="../media/5-change-feed-function-update-product.png" alt-text="change feed update product":::

1. Next type **CRTL + S** to save our changes and **CTRL + Q** to quit the editor.
1. Next type **dotnet build** to compile our project and **dotnet run** to execute it.
1. Your screen should now look like this with the main menu for the application.

:::image type="content" source="../media/5-main-menu.png" alt-text="main menu":::

1. First start the Change Feed Processor by pressing **a**. Your screen should look like this.

:::image type="content" source="../media/5-change-feed-start.png" alt-text="start change feed":::

1. Press any key to return to the main menu.
1. Next we will Update the product category name. Menu item **b** does the following things.
    1. Query the products container and for category, Accessories, Tires and Tubes and counts how many products are in that category.
    1. Updates that category name and replaces the word *and* with an ampersand *&*.
    1. Change Feed then picks up that change, and using the code we wrote, updates all the products for that category.
    1. It then reverts the name change and changes the category name back, replacing the *&* with the original *and* in the name.
    1. Change Feed then picks up that change and updates all the products back to the original product category name.

1. Press **b** from the main menu and follow the prompts until change feed runs a second time, then hold. Your screen will look like this below.

:::image type="content" source="../media/5-change-feed-update-category-name.png" alt-text="change feed update category name.":::

1. If you clicked too far and went back to the main menu. Just click **b** again and you can watch the changes again.

1. When you are done you can exit the application by typing **x** to return to the Azure Cloud Shell.

## Summary

In this exercise you learned how Change Feed in Cosmos DB can be used to maintain referential integrity between two containers when denormalizing data. We showed the references to the container being listened to as well as the second container to update. We wrote code to handle the changes passed into the delegate, then wrote code that looped through each of the products for that category and updated them.