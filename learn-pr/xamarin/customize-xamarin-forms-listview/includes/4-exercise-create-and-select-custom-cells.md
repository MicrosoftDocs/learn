In this exercise, you'll work with a real version of the smart home device app. The app has a `ListView` that shows smoke detectors, smart thermostats, and video doorbells. In the first version of the code, all these devices are displayed with a simple `TextCell`. To make the app more useful and visually compelling, you'll change the code so that it uses a different cell template for each device type. Two of the cell templates have been provided. You'll create the third.

## Open the starter solution

In Visual Studio, open the starter solution from this module's **exercise1** > **start** folder in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

[!include[](../../../includes/android-windows-path-length-warning.md)]

1. Explore the SmartHome shared project. The *ViewCells* folder contains two prebuilt `ViewCell` controls that aren't currently used. The *Data* and *Devices* folders contain the data source and models for the smart devices.
1. Open *MainPage.xaml.cs*.
1. Notice that the `BindingContext` is a collection of `SmartDevice` items coming from the `DeviceManager` class.
1. Run the application on at least one platform. To start, there's a simple presentation provided in *MainPage.xaml*.

## Create a DataTemplateSelector

1. In the shared project, create a new class named `DeviceTemplateSelector`.
1. Add a default constructor.
1. Update the class signature to derive from `DataTemplateSelector`. You'll need to add a Xamarin.Forms `using` statement.
1. Override `OnSelectTemplate`.

```csharp
using Xamarin.Forms;
...
public class DeviceTemplateSelector : DataTemplateSelector
{
   public DeviceTemplateSelector()
   {
   }

   protected override DataTemplate OnSelectTemplate(object item, BindableObject container)
   {
   }
}
```

## Choose a DataTemplate

Next, you'll add the code to select a data template at runtime, depending on the smart device being represented in the cell.

1. Add three `DataTemplate` fields, one for each type of smart device. Look in the *Devices* folder in the shared project.
1. In the constructor, instantiate each `DataTemplate` and pass in the type of the corresponding `ViewCell`. Look in the *ViewCells* folder in the shared project. Because we don't have a `ViewCell` for `DoorBell` yet, that one will still use `TextCell`.
1. In `OnSelectTemplate`, determine the type of the passed in `item` parameter. If it matches one of the smart device models, return the appropriate `DataTemplate`.

```csharp
public class DeviceTemplateSelector : DataTemplateSelector
{
    DataTemplate doorBellTemplate;
    DataTemplate smokeTemplate;
    DataTemplate thermostatTemplate;

    public DeviceTemplateSelector()
    {
        doorBellTemplate   = new DataTemplate(typeof(TextCell));
        smokeTemplate      = new DataTemplate(typeof(SmokeDetectorViewCell));
        thermostatTemplate = new DataTemplate(typeof(ThermostatViewCell));
    }

    protected override DataTemplate OnSelectTemplate(object item, BindableObject container)
    {
        if (item is DoorBell)
            return doorBellTemplate;

        if (item is SmokeDetector)
            return smokeTemplate;

        if (item is Thermostat)
            return thermostatTemplate;

        throw new Exception("Could not find the device type");
    }
}
```

## Use the DataTemplateSelector

Now replace the existing `DataTemplate` definition in your *MainPage.xaml* with the new custom `DataTemplateSelector`.

1. Open *MainPage.xaml*.
1. Add a local namespace so you can reach your data template selector class: `xmlns:local="clr-namespace:SmartHome"`.
1. Create a page-level `ResourceDictionary`.
1. In the resource dictionary, add a `DeviceTemplateSelector` with a key of `DeviceSelector`: `<local:DeviceTemplateSelector x:Key="DeviceSelector" />`.
1. Find the old `DataTemplate` definition assigned to the `ListView`. Delete it.
1. Delete the `ListView.ItemTemplate` tags. You'll assign the `DataTemplateSelector` to `ItemTemplate` directly.
1. Set the `ItemTemplate` property on the `ListView` to your data template selector as a `StaticResource` by using the `DeviceSelector` key.
1. Set `HasUnevenRows` to `True` so the `ListView` respects the different heights of your view cells.
1. Run the application. You should see three different cell types, one for each device type.

```xaml
<ContentPage.Resources>
    <ResourceDictionary>
        <local:DeviceTemplateSelector x:Key="DeviceSelector" />
    </ResourceDictionary>
</ContentPage.Resources>

<ListView ItemsSource="{Binding .}" ItemTemplate="{StaticResource DeviceSelector}" HasUnevenRows="True" />
```

## Create a custom ViewCell for doorbells

Now you'll create a custom `ViewCell` for the `DoorBell` device type.

1. Right-click the *ViewCells* folder and select **Add** > **New item**.
1. In the dialog box, select **ContentView**.
1. Change the name at the bottom of the dialog box to **DoorBellViewCell.xaml** and then select **OK**.
    > [!WARNING]
    > This will create two files: *DoorbellViewCell.xaml* and *DoorbellViewCell.xaml.cs*. If you don't see the .xaml file, you might have accidentally selected **ContentView (csharp)** in the dialog box.
1. In the .xaml file, change the root XML element from `ContentView` to `ViewCell`.
1. Additionally, in the ViewCell's XAML file, remove `.ViewCells` from the root element's `x:Class` attribute to align with other classes in the project.

    ```xaml
    <ViewCell ...
        x:Class="SmartHome.DoorBellViewCell">
    ```

1. In the .xaml.cs file, change the base class from `ContentView` to `ViewCell`.
1. Additionally, in the ViewCell's C# file, remove the `.ViewCells` from the namespace to match our other ViewCell classes.

### Add a user interface to DoorBellViewCell

The `DoorBell` cell will be similar to `SmokeDetectorViewCell`.

1. In *DoorbellViewCell.xaml*, remove any content from the `ViewCell` element. (Don't remove the namespace declarations from the `ViewCell` tag itself.)

    ```xaml
    <ViewCell xmlns=...>
    <!-- Nothing in here -->
    </ViewCell>
    ```

1. Open *SmokeDetectorViewCell.xaml* and copy the entire `<Grid>`, including the Grid tag and its contents.
1. Paste the Grid inside the `ViewCell` open and close tags in *DoorbellViewCell.xaml*.

### Update the bindings

The main difference between `SmokeDetectorViewCell` and `DoorBellViewCell` is the names of the properties they need to bind to.

1. The `DoorBell` class has a `IconUrl` property that supplies the image, so change the Image tag's `Source` to bind to `IconUrl`. (No converter is necessary.)
1. `DoorBell` and `SmokeDetector` both get their `Name` and `TimeStamp` properties from their common base class, so these bindings don't need to change.
1. Change the status label so that its `Text` is bound to `DoorBellStatus`. The existing format string will work.
1. Remove the `TextColor` binding from the status label.

The final `DoorBellViewCell` should look similar to this:

```xaml
<ViewCell ...>
    <Grid Padding="10">
        <Grid.ColumnDefinitions>
            ...
        </Grid.ColumnDefinitions>

        <Image Grid.Column="0" Source="{Binding IconUrl}" VerticalOptions="Center" WidthRequest="48" HeightRequest="48" />

        <StackLayout Grid.Column="1" VerticalOptions="Center">
            <Label Text="{Binding Name}" FontAttributes="Bold" />
            <Label Text="{Binding DoorBellStatus, StringFormat='Status: {0}'}" FontSize="Micro" />
        </StackLayout>

        <Label Grid.Column="2" Text="{Binding TimeStamp}" FontSize="Micro" />

    </Grid>
</ViewCell>
```

> [!TIP]
> Visual Studio 2019 includes a ViewCell template with XAML, so you'll no longer need to transform a ContentView template.

## Add DoorbellViewCell to DataTemplateSelector

1. In the `DeviceTemplateSelector` class, change `doorBellTemplate` to use `DoorBellViewCell` instead of `TextCell`.
1. Run the application. You should see all three custom cell types in use.
