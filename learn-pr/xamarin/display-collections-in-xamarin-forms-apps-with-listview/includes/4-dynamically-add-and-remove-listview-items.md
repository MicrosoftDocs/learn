Most modern applications display content that can change over time. For example, think about popular social media applications like Facebook, Twitter, and Instagram. Each of these applications displays a list of content to their users. If a user uploads a new photo, that photo is added to the list for everyone to see. In this unit, we'll look at how we can dynamically add and remove items to a Xamarin.Forms `ListView`.

## Dynamically modify a ListView control

To dynamically add and remove elements in a Xamarin.Forms `ListView` control, we modify the collection of data that was assigned to the `ItemsSource` property.

The following code gives a few examples of the types of operations we're discussing. Assuming that the `ItemsSource` property in the `ListView` control is set to `Cookbook.Recipes`, the first line adds a new item, the second line removes an item, and the third line replaces an item.

```csharp 
Cookbook.Recipes.Add(new Recipe { Name = "Mac n Cheese" });

Cookbook.Recipes.RemoveAt(0);

Cookbook.Recipes[0] = new Recipe { Name = "Golden Heaven Food" }
```

Here, we're only talking about adding, deleting, and replacing records of a collection. We're not modifying the contents of an item that's already in the collection. We'll see how to do that later in the module.

## Use an ObservableCollection type

The preceding code might or might not work correctly. It depends on how the `Recipes` type is implemented. The issue is that the `ListView` control needs to be notified when its `ItemsSource` collection changes.

We need to use a collection that implements the `INotifyCollectionChanged` interface. This interface has an event called `CollectionChanged` that's raised whenever the collection is altered. `ListView` is aware of this interface and will automatically subscribe to the `CollectionChanged` event.

The standard library contains the `ObservableCollection<T>` type that implements `INotifyCollectionChanged`. As long as we use this collection for our data, our `ListView` control will update immediately when we change contents of the collection.

This code example shows how to use `ObservableCollection<T>`:

```csharp
public static class Cookbook
{
    public static ObservableCollection<Recipe> Recipes { get; private set; }

    static Cookbook()
    {
        Recipes = new ObservableCollection<Recipe>();
    }
}
```