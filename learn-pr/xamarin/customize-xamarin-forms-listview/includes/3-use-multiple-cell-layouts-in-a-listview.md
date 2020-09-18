The ability to define a custom cell layout gives us a lot of power to control the user experience. But if different rows represent different types of items, we might want to have different cell templates for each of those types.

Consider our smart home app with a `ListView` of smart devices. If we imagine the ideal layout for a doorbell row and the ideal layout for a thermostat row, they're likely to be different.

In this unit, we'll use a `DataTemplateSelector` to display different cell templates in our `ListView`.

## What is a DataTemplateSelector?

We can use a `DataTemplateSelector` to choose a `DataTemplate` for each element in our source collection. Because the `DataTemplate` defines which cell type to use, using different templates changes the cell.

Remember that, if all our rows are the same, whether we're using a `ViewCell` or something simpler like a `TextCell`, we need to take the following steps:

1. Create a `DataTemplate`.
1. Tell the `DataTemplate` the cell type to use.
1. Assign the `DataTemplate` to the `ListView.ItemTemplate` property.

When we do this in XAML, it's elegant and might not even seem like three separate steps:

```xaml
...
    <ListView.ItemTemplate>
        <DataTemplate>
            <ViewCell>
                ...
            </ViewCell>
        </DataTemplate>
    </ListView.ItemTemplate>
...
```

But if we want our rows to be able to use different layouts, our `ListView.ItemTemplate` property will be set to a custom `DataTemplateSelector` _instead of_ `DataTemplate`. The `ListView` will then ask the selector which `DataTemplate` to use for each row.

## Create a DataTemplateSelector

To create the selector, we need to add a class that derives from `DataTemplateSelector` and override its `OnSelectTemplate` method:

```csharp
class SmartDeviceSelector : Xamarin.Forms.DataTemplateSelector
{
    protected override DataTemplate OnSelectTemplate (object item, BindableObject container)
    {
        ...
    }
}
```

The data-bound collection item (for example, the doorbell or thermostat), is passed to `OnSelectTemplate` as the `item` parameter. You can often use simple branching logic to return the correct `DataTemplate`:

```csharp
...
protected override DataTemplate OnSelectTemplate (object item, BindableObject container)
{
    if (item is doorbell)
        return DoorbellTemplate;
    else
        return GenericTemplate;
}
...
```

In the previous code, we don't *instantiate* either `DoorbellTemplate` or `GenericTemplate`. For performance reasons, we'll reuse the same template instances. The template instances can generally be created as part of the constructor of the selector. We need one template instance per cell type.

For similar performance reasons, we'll always reuse the selector instance itself. When you're using XAML, you can do this most easily by creating it in the `ResourceDictionary` and referencing it as a `StaticResource`:

```xaml
<ContentPage.Resources>
    <ResourceDictionary>
        <local:CharacterSelector x:Key="SmartDeviceSelector"/>
    </ResourceDictionary>
</ContentPage.Resources>
 
<ListView x:Name="listMessages"
          ItemTemplate="{StaticResource SmartDeviceSelector}"
          ItemsSource="{Binding ChatHistory}"
          HasUnevenRows="True"
          ... />
```
