In this exercise, you add two converters to the Weather app from the previous exercise. The first converter converts an enumeration value to an image resource. The second converter converts the temperature from Farenheight to Celsius.

## Convert to an image

The current binding context of the weather app's page is a data object with properties describing the weather forecast. One of those properties is the sky condition, which is an enumeration. When weather information is displayed, the app should show an icon to visualize the sky condition. This means that the enumeration needs to be converted to an image resource.

01. Open the project from the previous exercise in Visual Studio. If you don't have a copy, you can download it from [GitHub]().

01. Add a folder to the project named _Converters_.
01. Add a new class to the _Converters_ folder named _WeatherConditionToImageConverter.cs_.
01. Open _WeatherConditionToImageConverter.cs_ in the code editor and replace all the code with the following:

    ```csharp
    using System.Globalization;
    using WeatherClient.Models;
    
    namespace WeatherClient.Converters;
    
    internal class WeatherConditionToImageConverter : IValueConverter
    {
        public object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
        {
            WeatherType weatherCondition = (WeatherType)value!;
    
            return weatherCondition switch
            {
                Models.WeatherType.Sunny => ImageSource.FromFile("sunny.png"),
                Models.WeatherType.Cloudy => ImageSource.FromFile("cloud.png"),
                _ => ImageSource.FromFile("question.png")
            };
        }
    
        public object? ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture) =>
            throw new NotImplementedException();
    }
    ```

    This code defines the `WeatherConditionToImageConverter` converter in the `WeatherClient.Converters` namespace. This converter expects the `WeatherType` enumeration as the value, and returns an image resource based on that value.

01. Open the _MainPage.xaml_ file.
01. On the root element, add a new XML namespace named `cvt` and map it to the .NET namespace `WeatherClient.Converters`.

    ```xaml
    <ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
                 xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
                 xmlns:cvt="clr-namespace:WeatherClient.Converters"
                 x:Class="WeatherClient.MainPage">
    ```

01. Add an instance of the `WeatherConditionToImageConverter` converter to the page's resources, with the key of `WeatherConditionToImageConverter`:

    ```xaml
    <ContentPage ...
    
        <ContentPage.Resources>
            <cvt:WeatherConditionToImageConverter x:Key="WeatherConditionToImageConverter" />
        </ContentPage.Resources>
    ```

01. Find the `<Image>` control named `imgCondition`.
01. Change the `Source="question.png"` property to the following binding:

    ```xaml
    Source="{Binding Condition, Converter={StaticResource WeatherConditionToImageConverter}}"
    ```

01. Run the project.

Notice that when you press the **Refresh** button, the **Condition** field changes to an icon:

:::image type="content" source="../media/6-exercise-create-converter/image-resource.png" alt-text="A screenshot of the .NET MAUI app displaying the weather forecast with a sun icon for the sky condition.":::

## Convert Farenheight to Celsius

The final converter for the app is one that lets the **Use Celsius** switch change the **Temperature** value. This one is a bit more involved than the previous converter.

01. Add a new class to the _Converters_ folder named _FahrenheitToCelsiusConverter.cs_.
01. Open _FahrenheitToCelsiusConverter.cs_ in the code editor and replace all the code with the following:

    ```csharp
    using System.Globalization;
    
    namespace WeatherClient.Converters;
    
    internal class FahrenheitToCelsiusConverter : IValueConverter
    {
        public bool IsActive { get; set; }
    
        public object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
        {
            if (IsActive)
            {
                double temperature = System.Convert.ToDouble((int)value!);
                return $"{UnitConverters.FahrenheitToCelsius(temperature):#} C";
            }
            else
                return $"{(int)value!:#} F";
        }
    
        public object? ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture)
        {
            if (IsActive)
                return UnitConverters.CelsiusToFahrenheit((double)value!);
            else
                return (double)value!;
        }
    }
    ```

    An important difference between this converter and the previous is the `IsActive` property. This property is controlling whether or not the converter will convert the incoming Fahrenheit value to Celsius. Converters that are applied to the binding are always active. There are times when you want to prevent a converter from changing the value. This is usually done in the `Convert` method directly, using `parameter` as a toggle. This converter takes a different approach of exposing a public property to turn the converter on and off.

    This converter also formats the resulting string with a `C` or `F` moniker indicating Celsius or Fahrenheit.

01. Open the _MainPage.xaml_ file.
01. Add an instance of the `FahrenheitToCelsiusConverter` converter to the page's resources, with the key of `FahrenheitToCelsiusConverter`:

    ```xaml
    <ContentPage ...
    
        <ContentPage.Resources>
            <cvt:WeatherConditionToImageConverter x:Key="WeatherConditionToImageConverter" />
            <cvt:FahrenheitToCelsiusConverter x:Key="FahrenheitToCelsiusConverter" />
        </ContentPage.Resources>
    ```

01. Find the `<Label>` control named `lblTemperature`.
01. Change the `Text="{Binding Temperature}` property, adding the converter:

    ```xaml
    Text="{Binding Temperature, Converter={StaticResource FahrenheitToCelsiusConverter}}"
    ```

01. Run the project.

Now when you press the **Refresh** button, the **Temperature** field has an **F** at end to indicate Fahrenheit.

:::image type="content" source="../media/6-exercise-create-converter/converter-fahrenheit.png" alt-text="A screenshot of the .NET MAUI app displaying the weather forecast with a cloud icon for the sky condition. The temperature set to 40 degrees Fahrenheit.":::

Press the **Use Celsius** switch. Notice that it doesn't have any effect on the converter. Let's fix that next.

## Toggle the converter

Now that the converter exists and is attached to the temperature label, we need a way to toggle it to convert from Fahrenheit to Celsius. The `Switch` control has a property named `IsToggle`, which is a Boolean value. The converter's `IsActive` property is also a Boolean, so these two properties are a good match to allow the UI to control the converter.

01. Open the _MainPage.xaml_ file.
01. Locate the `Switch` control named `swiCelsius`.
01. Add the `IsToggled` property to the XAML with the following binding:

    ```xaml
    IsToggled="{Binding IsActive, Mode=OneWayToSource, Source={StaticResource FahrenheitToCelsiusConverter}}"
    ```

    This binding binds to the converter `FahrenheitToCelsiusConverter.IsActive` property. It uses the mode `OneWayToSource`. This inverts the binding so that instead of the source property (`IsActive`) controlling the target (`IsToggled`), the target sets the source. When the switch control is interacted with, changing the **target** `IsToggled` property, the converter updates the **source** `FahrenheitToCelsiusConverter.IsActive` property to match.

01. Next, open the _Mainpage.xaml.cs_ code-behind file.
01. Find the `swiCelsius_Toggled` method and the change code.

    This method forcibly changed the label `Text` property, which is now controlled by the binding and converter. We want this code to instead trigger a binding update for the label, letting the converter do its conversion:

    ```csharp
    private void swiCelsius_Toggled(object sender, ToggledEventArgs e)
    {
        object temp = BindingContext;
        BindingContext = null;
        BindingContext = temp;
    }
    ```

    This is a trick to reset the `BindingContext` property to its same value, forcing all bindings to reevaluate themselves.

01. Run the project.

Notice that the switch not only converts the value on the screen to and from Celsius and Fahrenheit, respectively. Also, when you toggle Celsius and then press **Refresh** the new temperature value is processed by the converter and displayed correctly.
