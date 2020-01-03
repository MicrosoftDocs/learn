Here, you create a value converter to translate the `ImageUrl` property on the `Flag` object into an `ImageSource` that the Xamarin.Forms image control can display. Specifically, the value converter loads images from your embedded resources located in the **FlagData** assembly.

This exercise is a continuation of the previous one. Use your existing solution, or begin from the **exercise2** > **final** solution in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

## Code a value converter

1. Open the **FlagExtensions.cs** file in the **Extensions** folder. This file contains the code you're currently using to load the image from your resources.

1. Create a new folder in the **FlagFacts** project called **Converters** to store your value converter.

1. Add a new empty class file to the **Converters** folder named `EmbeddedImageConverter`.

1. Implement the `IValueConverter` interface on the class:

    * The `Convert` method turns the inbound `value` into a string and assumes that it's the embedded resource ID. Use the code located in the `FlagExtensions.GetImageSource` method to load the resource.
    * The `ConvertBack` method throws `NotSupportedException`.
    * Because the image is in a different assembly, you need to tell the `ImageSource.FromResource` method where to find it. You can hardcode this value, like it is in the `GetImageSource` implementation. You also can create a public property on the value converter and pass a `Type` in to load the image data. Use this latter approach because it's more flexible. You can load images from _any_ assembly.

    ```csharp
    public class EmbeddedImageConverter : IValueConverter
    {
        /// Optional type located in the assembly you want to get the resource
        /// from - if not supplied, the API assumes the resource is located in
        /// this assembly.
        public Type ResolvingAssemblyType { get; set; }

        public object Convert(object value, Type targetType,
                              object parameter, CultureInfo culture)
        {
            var imageUrl = (value ?? "").ToString();
            if (string.IsNullOrEmpty(imageUrl))
                return null;

            return ImageSource.FromResource(imageUrl,
                ResolvingAssemblyType?.GetTypeInfo().Assembly);
        }

        public object ConvertBack(object value, Type targetType,
                                  object parameter, CultureInfo culture)
        {
            throw new NotSupportedException(
              $"{nameof(EmbeddedImageConverter)} cannot be used on two-way bindings.");
        }
    }
    ```

## Create an instance of your converter

1. Open **MainPage.xaml**, and assign a new `ResourceDictionary` to the `ContentPage.Resources` property.

1. Add an instance of your `EmbeddedImageConverter` class to the resources so that you can use it in your binding expression.

    * If you implemented the resolving type property on your converter, use `{x:Type data:Flag}` to pass in the proper type to locate the images.
    * You need to define your XML namespaces to use the custom types in XAML. If you don't recall the syntax, check the following code sample.
    * Make sure to give the resource an `x:Key`, such as "irConverter".

    ```xml
    <?xml version="1.0" encoding="utf-8" ?>
    <ContentPage xmlns="http://xamarin.com/schemas/2014/forms"
                 xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
                 xmlns:local="clr-namespace:FlagFacts"
                 xmlns:eff="clr-namespace:FlagFacts.Effects"
                 xmlns:data="clr-namespace:FlagData;assembly=FlagData"
                 xmlns:cvt="clr-namespace:FlagFacts.Converters"
                 x:Class="FlagFacts.MainPage"
                 Title="Fun with Flags">

        <ContentPage.Resources>
            <ResourceDictionary>
                <cvt:EmbeddedImageConverter x:Key="irConverter"
                        ResolvingAssemblyType="{x:Type data:Flag}" />
            </ResourceDictionary>
        </ContentPage.Resources>
        ...
    ```

## Use your converter in a binding

1. Data-bind the `Image.Source` property to the `ImageSource` property on the flag with a binding.

1. Add your converter to the binding. Assign it to the `Converter` property. Use the `{StaticResource}` markup extension to retrieve it from resources by using your assigned key.

1. Remove the code-behind, which is currently setting the source property. You also can remove the `x:Name` on the image in XAML because you no longer need to reference it in code-behind.

1. Run the application, and make sure the flag is properly displayed. Make sure to try a few countries by selecting the up and down arrows on the toolbar.

    ```xml
    <Image HeightRequest="200"
            Source="{Binding ImageUrl, Mode=OneWay, Converter={StaticResource irConverter}}"
            HorizontalOptions="Center"
            VerticalOptions="Center"
            Aspect="AspectFit" />
    ```