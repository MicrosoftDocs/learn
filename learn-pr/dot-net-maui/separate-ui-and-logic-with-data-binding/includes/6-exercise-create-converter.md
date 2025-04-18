In this exercise, you add a converter to the Weather app created in the previous exercise. The first converter converts an enumeration value to an image resource. The second converter converts the temperature from Fahrenheit to Celsius.

## Convert to an image

The current binding context of the weather app's page is a data object with properties describing the weather forecast. One of those properties is the sky condition, which is an enumeration. When weather information is displayed, the app should show an icon to help the user visualize the sky condition. To show these icons, the enumeration needs to be converted to an image resource.

1. Open the Weather Sample project from the previous exercise in Visual Studio or Visual Studio Code.
1. Add a folder to the project named _Converters_.
1. Add a new class to the _Converters_ folder named _WeatherConditionToImageConverter.cs_.
1. Open _WeatherConditionToImageConverter.cs_ in the code editor and replace all the code with the following code:

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

1. Open the _MainPage.xaml_ file.
1. On the root element, add a new XML namespace named `cvt` and map it to the .NET namespace `WeatherClient.Converters`.

    ```xaml
    <ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
                 xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
                 xmlns:cvt="clr-namespace:WeatherClient.Converters"
                 x:Class="WeatherClient.MainPage">
    ```

1. Add an instance of the `WeatherConditionToImageConverter` converter to the page's resources, with the key of `WeatherConditionToImageConverter`:

    ```xaml
    <ContentPage ...
    
        <ContentPage.Resources>
            <cvt:WeatherConditionToImageConverter x:Key="WeatherConditionToImageConverter" />
        </ContentPage.Resources>
    ```

1. Find the `<Image>` control in `Grid.Row="0"`.
1. Change the `Source="question.png"` property to the following binding:

    ```xaml
    Source="{Binding Condition, Converter={StaticResource WeatherConditionToImageConverter}}"
    ```

1. Run the project.

Notice that when you select the **Refresh** button, the **Condition** field changes to an icon:

:::image type="content" source="../media/6-exercise-create-converter/image-resource.png" alt-text="A screenshot of the .NET MAUI app displaying the weather forecast with a sun icon for the sky condition.":::
