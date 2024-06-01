Data bindings can be declared in either code or in XAML using markup extensions. This unit discusses the latter as it's the most common way to create bindings. There are a couple of reasons to prefer XAML. First, most people consider bindings to be part of their UI code because the bindings get data for the UI to display. Second, there's a markup extension named `Binding` that makes it easy to do.

## What are data bindings

A _binding_ ties two properties together. One property is in your UI and the other is in your data-model object. If the value of either property changes, the binding object can update the other one. In other words, bindings are intermediary objects that synchronize your UI and data. We use the terms _source_ and _target_ to identify the two objects involved:

- **Source**: A source can be an object of any type. In practice, you typically use a data-object as your source. You need to identify the property on that source object to participate in the binding. You identify the property by setting the `Path` property in the binding.

- **Target**: The target is a property that is implemented using a special property called a `BindableProperty`. The object with the `BindableProperty` must derive from `BindableObject`. All of the controls provided in .NET MAUI derive from `BindableObject` and most of their properties are `BindableProperties`.

The following diagram illustrates how a binding is an intermediary object between two properties:

:::image type="content" source="../media/3-use-data-bindings-xaml/binding-intermediary.png" alt-text="A diagram that illustrates a binding as an intermediary between a source object property and a target object bindable property.":::

## How to create a data binding in XAML

Let's look at a simple binding created in XAML by using the `{Binding}` markup extension. It's binding the `WeatherService.Humidity` property of the source to the `Text` property of the UI control.

```xaml
<VerticalStackLayout Margin="10">
    <VerticalStackLayout.Resources>
        <ResourceDictionary>
            <services:WeatherService x:Key="myWeatherService" />
        </ResourceDictionary>
    </VerticalStackLayout.Resources>

    <Label Text="{Binding Path=Humidity, Source={StaticResource myWeatherService}}" />
</VerticalStackLayout>
```

The binding source is:

- An object instance of the `WeatherService` type. This is referenced through the `{StaticResource ...}` XAML extension, which points to an object in the stack layout's resource dictionary.

- The `Path` points to a property named `Humidity` on the `WeatherService` type.

  The `Path` is the first unnamed parameter on the `{Binding}` syntax, and the `Path=` syntax can be omitted. These two bindings are equivalent:

  ```xaml
  <Label Text="{Binding Path=Humidity, Source={StaticResource myWeatherService}}" />
  <Label Text="{Binding Humidity, Source={StaticResource myWeatherService}}" />
  ```

The binding target is:

- The `Label` control.
- The control's `Text` property.

When the UI is displayed, the `{Binding}` XAML extension creates a binding between the `WeatherService` and `Label`. The binding reads the `WeatherService.Humidity` property's value into the `Label.Text` property.

## Use another control as a binding source

One useful feature of binding is being able to bind to other controls. The following XAML is a simple demonstration:

```xaml
<VerticalStackLayout HorizontalOptions="Center" VerticalOptions="Center">
    <Label x:Name="TargetLabel" Text="TEXT TO ROTATE" BackgroundColor="Yellow" />
    <Slider WidthRequest="100" Maximum="360"
            Value="{Binding Rotation, Mode=OneWayToSource, Source={x:Reference TargetLabel}}" />
</VerticalStackLayout>
```

The `Slider.Value` property is bound to the `Label.Rotation` property, but in a different way than previously explained. This is using the binding mode `OneWayToSource`, which reverses the typical binding mechanism. Instead of the **Source** updating the **Target**, `OneWayToSource` updates the **Source** when the **Target** changes. In this example when the slider moves, it updates the rotation of the label based on the slider's value, as illustrated in the following animation:

:::image type="content" source="../media/3-use-data-bindings-xaml/rotate.gif" alt-text="An animated image of a slider control being dragged with a mouse. As the slider moves, a piece of text rotates to match the position of the slider.":::

The typical scenario for binding controls to one another is when a control, usually a collection control such as a `ListView` or `CarouselView`, has a selected item that you want to use as a data source. In the example of a page displaying the weather forecast, you might have a `ListView` present a five-day forecast. When the user selects a day in the list, the details of that weather forecast are displayed in other controls. If the user selects another day, the other controls are again updated with the selected day's details.

## Use the same source across multiple bindings

The previous example demonstrated using a static resource as a source for a single binding. That source can be used in multiple bindings. Here's an example of declaring a binding across three different controls, all binding to the same object and property `Path`, though some omitting the `Path` property:

```xaml
<VerticalStackLayout Margin="10">
    <VerticalStackLayout.Resources>
        <vm:SimpleWeatherServiceObject x:Key="myWeatherService" />
    </VerticalStackLayout.Resources>
    <Entry Text="{Binding Humidity, Source={StaticResource myWeatherService}}}" />
    <Label Text="{Binding Path=Humidity, Source={StaticResource myWeatherService}}" />
</VerticalStackLayout>
```

You don't have to use the same `Path` when using the same `Source`:

```xaml
<VerticalStackLayout Margin="10">
    <VerticalStackLayout.Resources>
        <vm:SimpleWeatherServiceObject x:Key="myWeatherService" />
    </VerticalStackLayout.Resources>
    <Entry Text="{Binding Temperature, Source={StaticResource myWeatherService}}}" />
    <Label Text="{Binding Path=Humidity, Source={StaticResource myWeatherService}}" />
</VerticalStackLayout>
```

Rarely do you present a single piece of data from a source, though it could happen. Usually you have several controls using different pieces of data from the same source. This situation is so common that the `BindableObject` class has a property named `BindingContext` that works as a source for data binding. Remember that .NET MAUI controls inherit from the `BindableObject` class, so the .NET MAUI controls have the `BindingContext` property.

Setting the `Source` of the binding is optional. A binding that doesn't have `Source` set automatically searches the XAML visual tree for a `BindingContext`, which is set in the XAML or assigned to a parent element by code. Bindings are evaluated following this pattern:

01. If the binding defines a `Source`, that source is used and searching stops. The binding's `Path` is applied to the `Source` to get a value. If `Source` isn't set, the search begins for a binding source.

01. The search begins with the target object itself. If the target object's `BindingContext` isn't null, the search stops and the binding's `Path` is applied to the `BindingContext` to get a value. If the `BindingContext` is null, then the search continues.

01. This process continues until it reaches the XAML root. The search ends by checking the `BindingContext` of the root for a non-null value. If no valid `BindingContext` was found, the binding has nothing to bind against and does nothing.

It's common to set the `BindingContext` at the root object's level, to apply to the entire XAML.

There's one last convenient feature that's worth mentioning. Bindings watch for changes to the _object reference_ of their source. This works even for bindings that use `BindingContext` as their source. If the `Source` or `BindingContext` is reassigned to another object, the bindings grab the data from the new source and update their target.
