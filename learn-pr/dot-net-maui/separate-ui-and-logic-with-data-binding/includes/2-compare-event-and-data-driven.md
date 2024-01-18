
An event-driven user interface (UI) is designed around the events a control exposes. These events are associated with event handler code which is invoked when the event is triggered. For example, let's say you have a button that when clicked performs a long-running operation. The event handler assigned to the `Clicked` event could start the operation and then set the button's `IsEnabled` property to `false`, preventing the button from being clicked again while the operation is running.

A data-driven UI is designed around the UI working with a data object instead of triggering code in the code-behind file. Properties of controls are bound to the data object's properties, and those bindings can detect changes in the properties. Using the previous example, consider the button that performs a long-running operation. Instead of disabling the button in the code-behind, the `IsEnabled` property is bound data object's `IsBusy` property. Whenever the data object becomes "busy" the button's enabled state is automatically changed to match.

## Pros and cons of using events and code-behind

Using the control's event handler with the code-behind is a quick and convenient way of designing the app logic for your UI. You use code to call out to services to get data, perform operations on that data, and interact with the controls on the page. The code is used to keep the UI and data synchronized.

Consider the example of a weather service app. The following XAML fragment represents a simple UI button the user clicks to get the latest data and update the UI with the humidity.

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

:::image type="content" source="../media/2-compare-event-and-data-driven/events-ui-example.png" alt-text="A .NET MAUI UI that has an entry control for a postal code, a button with the text refresh. Under those two controls is a label that represetnts the humidity.":::

There are three named controls in this example:

- `Entry` control named **PostalCode**.
- `Button` control named **RefreshWeatherButton**.
- `Label` control named **Humidity**.

The `RefreshWeatherButton` has an event handler declared for the `Clicked` event. When the button is clicked, the event handler queries a weather service for the latest weather forcast, using the `PostalCode` entry control, and sets the `Humidity` label's text to the current humidity.

```csharp
private void RefreshWeatherButton_Clicked(object sender, EventArgs e)
{
    WeatherService.Location = PostalCode.Text;
    WeatherService.Refresh();
    Humidity.Text = $"Humidity: {WeatherService.Humidity}";
}
```

In this one event handler, three controls are tightly coupled to each other and the data through the code-behind.

This design works great for small UIs, but as soon as the UI becomes complex, maintaining tightly coupled code-behind can become troublesome. If you delete or change a control, you must clean up any code using those UI controls, which could include the event handler. If you decide to redesign the UI, you'll have a lot of code to clean up too.

## Data binding helps

Data binding in XAML is one of many declarative ways of designing how your app interacts with data.

Data binding can be declared in the XAML along with the controls themself, much like how events are. Because the bindings don't require code-behind, you can easily create, alter, or redesign the UI to fit how you want to present the data.

Let's take the same example as in the previous section, but change it for data binding:

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

You can spot the properties that are data bound, they use the syntax `{Binding ...}` for the value of the property. Don't worry about the specifics just yet, we'll cover that later in the module.

The same three controls are declared in the XAML, but none of them are named, as a name isn't needed at this time.

- `Entry` control:

  This control's `Text` property is bound to a property named `Location`.

- `Button` control:

  The button's `Command` property is bound to a property named `RefreshWeather`. `Command` is a property on the button that invokes code when the button is pressed. It's an alternative to the `Clicked` event that is used in data binding.

- `Label` control:

  This `Text` property is bound to a property named `Humidity`.

In this simple UI, all of the code-behind has been eliminated. Removing all code-behind isn't the point of data binding, even though it's usually possbile. Code-behind still has its place. How much data binding you implement is up to you.

The UI is now loosly coupled to a data object. Why is it loosly coupled instead of tightly coupled? Because of the way bindings are evaluated. Each control has a `BindingContext` property. If the context isn't set, the parent control's context is used, and so on until the root of the XAML is evaluated. When bindings are evaluated, the context's object instance is checked for the required properties, like the label control's `Text` binding to the context's `Humidity` property. If `Humidity` doesn't exist on the context, nothing happens.

Because the UI is loosly coupled, you can redesign the UI without the worry of breaking code. However, you can break functionallity. For example, you can delete the button and the app still compiles and runs, but you don't have a way to refresh the weather. On the other hand, you could replace the `Entry` and `Button` controls with the single `SearchBar` control. This control lets you enter text and invoke a command.

```xaml
<SearchBar Text="{Binding Location, Mode=OneWayToSource}" SearchCommand="{Binding RefreshWeather}" />
```

As you can see, using data binding in your UI design can help you evolve and change your UI without a lot of work. It keeps the UI synchronized with the data automatically.
