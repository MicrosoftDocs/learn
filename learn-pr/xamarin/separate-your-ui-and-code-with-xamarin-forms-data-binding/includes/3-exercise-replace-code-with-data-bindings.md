You'll build a simplified version of the educational geography app that focuses on countries' flags. In this first exercise, you replace data-manipulation code with bindings.

## Open and run the starter solution

We've provided a starter solution for you to work with. It contains a fully functional app that's implemented without data binding.

1. Clone or download the [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

    [!include[](../../../includes/android-windows-path-length-warning.md)]

1. Go to the **exercise1** > **start** folder.

1. Open the **FlagFacts.sln** solution.

1. Build and run the application to make sure it works. It displays a single flag, and you can edit the details of the flag. The **Show** button on the toolbar displays the details of the underlying `Flag` in an alert box.

1. The solution contains four projects, but you do all your work in the **FlagFacts** project. **FlagFacts** is the shared code and the UI layer. You also have a data assembly that loads all the flag data. The other projects are the platform-specific host projects.

1. For reference, here's a summary of the classes and files you work with.

| File | Description |
| --- | --- |
| **App.cs** | Contains the `Application` class for your Xamarin.Forms application. This class defines the starting page for the app. |
| **MainPage.xaml(.cs)** | Defines the UI and logic for your initial page. The **XAML** file defines the UI by using markup. The associated code file then provides the behavior for the UI. |
| **FlagRepository.cs** | This class is in the **FlagData** project. It contains the sample data you work with. |
| **Flag.cs** | This class is also in the **FlagData** project. It defines the `Flag` class used for all the objects that come from the repository. |

## Create a binding in code

Here, you manually create a single binding in code. There are three required pieces of information: source (`BindingContext`), property path, and target `BindableProperty`.

1. Open **MainPage.xaml.cs**, and locate the `InitializeData` method.

1. Comment out or delete the lines that set the **country** `Picker` control's `SelectedItem` property and the `SelectedIndexChanged` event handler.

1. Set the `BindingContext` on the `country` control to the active `Flag`.

1. Create a `Binding` object, and set its `Path`. You want to tie this binding to the `Country` property on your flag.

1. Finally, add a binding to the `country` control by using the `SetBinding` method. You want to associate the `Binding` to the `Picker.SelectedItemProperty` property.

    ```csharp
    private void InitializeData()
    {
        country.ItemsSource = (IList) repository.Countries;
        // country.SelectedItem = CurrentFlag.Country;
        // country.SelectedIndexChanged += (s, e) => CurrentFlag.Country = repository.Countries[country.SelectedIndex];
        country.BindingContext = CurrentFlag;
        country.SetBinding(Picker.SelectedItemProperty,
                           new Binding(nameof(CurrentFlag.Country)));
        ...
    }
    ```

1. Run the application, and make sure the country picker is correctly populated. Change its value, and then select **Show**. It should change the underlying object as shown in the following screenshot.

    ![Screenshot of the FlagFacts app showing the extra information for New Zealand.](../media/show-flag.png)

## Create bindings in XAML

Here, you replace UI-update code with bindings written in XAML.

1. Remove the property setters and event handlers from the following controls in the code-behind:

    * **country**
    * **adopted**
    * **hasShield**
    * **description**

    Leave the **flagImage** control alone for now. This control requires some more work to data bind.

1. Set the `BindingContext` of the page to the `Flag` object you want to pull data from. Set it at the end of the `InitializeData` method. In particular, make sure it's set _after_ the `Picker.ItemsSource` property is set. If the country Picker no longer displays the country when you run the app, it's likely you set the `ItemsSource` _after_ the `BindingContext`. This setting clears the value.

    ```csharp
    private void InitializeData()
    {
        country.ItemsSource = (IList)repository.Countries;
        // country.SelectedItem = CurrentFlag.Country;
        // country.SelectedIndexChanged += (s, e) => CurrentFlag.Country = repository.Countries[country.SelectedIndex];
        // country.BindingContext = CurrentFlag;
        // country.SetBinding(Picker.SelectedItemProperty, new Binding(nameof(CurrentFlag.Country)));

        flagImage.Source = CurrentFlag.GetImageSource();

        // adopted.Date = CurrentFlag.DateAdopted;
        // adopted.DateSelected += (s, e) => CurrentFlag.DateAdopted = e.NewDate;

        // hasShield.IsToggled = CurrentFlag.IncludesShield;
        // hasShield.Toggled += (s, e) => CurrentFlag.IncludesShield = hasShield.IsToggled;

        // description.Text = CurrentFlag.Description;

        // Set the binding context
        this.BindingContext = CurrentFlag;
    }
    ```

1. Open **MainPage.xaml**, and add `{Binding PROPERTY_NAME}` tags on each of the previous controls to tie the appropriate property to each target. Use the C# code you commented out to determine the proper source and target properties for each binding. For example, the **country** element looks like the following code:

    ```xml
    <Picker x:Name="country" SelectedItem="{Binding Country}" />
    ```

    This binding ties the `SelectedItem` property of the `Picker` control to the `Country` property of the `BindingContext` (flag).

    ```xml
    <Picker x:Name="country" SelectedItem="{Binding Country}" />

    <Label Text="Current Design was Adopted on" FontAttributes="Bold" />
    <DatePicker x:Name="adopted" MinimumDate="01/01/1700" HorizontalOptions="Start"
                Date="{Binding DateAdopted}" />

    <Label Text="Has Shield" FontAttributes="Bold" />
    <Switch x:Name="hasShield" IsToggled="{Binding IncludesShield}" />

    <Label Text="Fun Fact" FontAttributes="Bold" />
    <Label x:Name="description" Text="{Binding Description}" />
    ```

1. Run the application, and make sure that each field displays data.

1. Select the arrows on the toolbar to try different flags. The values should change. You're changing the `BindingContext`, and that's why the bound values get updated.

1. Change a control's value. For example, select a new country. Then select **Show** to verify that the underlying object changed.