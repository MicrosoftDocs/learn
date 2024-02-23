An event-driven user interface (UI) is designed around the events a control exposes. These events can be associated with event handler code that's invoked when the event is triggered. For example, let's say you have a button that when clicked performs a long-running operation. The event handler assigned to the `Clicked` event could start the operation and then set the button's `IsEnabled` property to `false`, preventing the button from being clicked again while the operation is running.

A data-bound UI uses data binding to present and interact with data. Properties of controls are bound to the data object's properties, and those bindings can detect changes in the properties. Using the previous example, consider the button that performs a long-running operation. Instead of disabling the button in code-behind, the `IsEnabled` property is bound to the data object's `IsBusy` property. Whenever the data object becomes "busy" the button's enabled state is automatically changed to match.

## Pros and cons of using events and code-behind

Using the control's event handler with code-behind is a quick and convenient way of designing the app logic for your UI. You use code to call services to get data, perform operations on that data, and interact with the controls on the page. The code is used to keep the UI and data synchronized.

Consider the example of a weather service app. The following XAML fragment contains a simple UI button the user selects to get the latest data and update the UI with the humidity.

```xaml
<VerticalStackLayout Margin="10">
    <HorizontalStackLayout Spacing="20">
        <Label Text="Postal Code:" VerticalOptions="Center" />
        <Entry x:Name="PostalCode" WidthRequest="100" />
        <Button x:Name="RefreshWeatherButton" Text="Refresh" WidthRequest="200" Clicked="RefreshWeatherButton_Clicked" />
    </HorizontalStackLayout>
    <Label x:Name="Humidity" Text="Humidity: ?" />
</VerticalStackLayout>
```

:::image type="content" source="../media/2-compare-event-and-data-bound/events-ui-example.png" alt-text="Screenshot of a .NET MAUI app that has an entry control for a postal code, a button with the text refresh. Under those two controls is a label that represents the humidity.":::

There are three named controls in this example:

- `Entry` control named **PostalCode**.
- `Button` control named **RefreshWeatherButton**.
- `Label` control named **Humidity**.

The `RefreshWeatherButton` has an event handler declared for the `Clicked` event. When the button is clicked, the event handler queries a weather service for the latest weather forecast, using the data entered in the `PostalCode` entry control, and sets the `Humidity` label's text to the current humidity.

```csharp
private void RefreshWeatherButton_Clicked(object sender, EventArgs e)
{
    WeatherService.Location = PostalCode.Text;
    WeatherService.Refresh();
    Humidity.Text = $"Humidity: {WeatherService.Humidity}";
}
```

In this one event handler, three controls are tightly coupled to each other and the data through the code-behind.

This design works great for small UIs, but as soon as the UI becomes complex, maintaining a tightly coupled code-behind can become troublesome. If you delete or change a control, you must clean up any code using those UI controls, which could include the event handler. If you decide to redesign the UI, you'll have lots of code to refactor too. And when the backing data structure changes, you have to dive into the code of each UI to stay in sync.

## Data binding helps

Data bindings can be implemented in XAML or code, but are much more common in XAML where they help to reduce the size of the code-behind file. By replacing procedural code in event handlers with declarative code or markup, the app is simplified and clarified. Because the bindings don't require code-behind, you can easily create, alter, or redesign the UI to fit how you want to present the data.

Let's take the same example as in the previous section, but update it to use data binding:

```xaml
<VerticalStackLayout Margin="10">
    <HorizontalStackLayout Spacing="20">
        <Label Text="Postal Code:" VerticalOptions="Center" />
        <Entry Text="{Binding Location, Mode=OneWayToSource}" WidthRequest="100" />
        <Button Text="Refresh" Command="{Binding RefreshWeather}" WidthRequest="200" />
    </HorizontalStackLayout>
    <Label Text="{Binding Humidity}" />
</VerticalStackLayout>
```

You can spot the properties that are data bound, they use the XAML extension syntax `{Binding ...}` for the value of the property. Don't worry about the specifics yet, that is covered later in this module.

The same three controls are declared in the XAML, but none of them are named, as a name isn't required:

- `Entry` control:

  This control's `Text` property is bound to a property named `Location`.

- `Button` control:

  The button's `Command` property is bound to a property named `RefreshWeather`. `Command` is a property on the button that invokes code when the button is pressed. It's an alternative to the `Clicked` event that's used in data binding.

- `Label` control:

  This `Text` property is bound to a property named `Humidity`.

In this simple UI, all of the code-behind is eliminated. Removing all code-behind isn't the point of data binding, even though it's usually possible. Code-behind still has its place. How much data binding you implement is up to you.

Now the UI is loosely coupled to a data object. Why is it loosely coupled instead of tightly coupled? Because of the way bindings are evaluated. Each control has a `BindingContext` property. If the context isn't set, the parent control's context is used, and so on, until the root of the XAML is evaluated. When bindings are evaluated, the context's object instance is checked for the required properties, like the label control's `Text` binding to the context's `Humidity` property. If `Humidity` doesn't exist on the context, nothing happens.

Because the UI is loosely coupled, you can redesign the UI without the worry of breaking code. However, you can break functionality. For example, you can delete the button and the app still compiles and runs, but you don't have a way to refresh the weather. On the other hand, you could replace the `Entry` and `Button` controls with the single `SearchBar` control. This control lets you enter text and invoke a command.

```xaml
<SearchBar Text="{Binding Location, Mode=OneWayToSource}" SearchCommand="{Binding RefreshWeather}" />
```

As you can see, using data binding in your UI design can help you evolve and change your UI without much work. It keeps the UI synchronized with the data automatically and the app logic is separated from the UI.
