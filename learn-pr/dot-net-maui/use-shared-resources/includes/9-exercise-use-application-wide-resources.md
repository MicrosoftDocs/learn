The goal of this exercise is to make resources available across multiple pages by moving them to a resource dictionary in the Tip Calculator Application class.

This exercise is a continuation of the previous exercise. Either use your existing solution as the starting point for these steps, or open the **TipCalculator** project in the **exercise4/TipCalculator** folder in the repository that you cloned in the first exercise.

## Verify page-level resources

Let's verify that resources defined on one page aren't available on another page. At the end of this section, your app doesn't run correctly. However, you fix it in the next section.

1. In the **TipCalculator** project, open the **CustomTipPage.xaml** file.

1. Set the **infoLabelStyle** resource as the style for the **billLabel** label, and remove the existing settings for the **FontSize** and **FontAttributes** properties.

    ```XML
    <Label x:Name="billLabel" Text="Bill" Style="{StaticResource infoLabelStyle}" Grid.Row="0" Grid.Column="0" />
    ```

1. Run the app.

1. Select **Use Custom Calculator** to display the **CustomTipPage** page. Look at the Bill label. The font size should be smaller than the other labels and it isn't bold. This behavior is because the page didn't find a resource named **infoLabelStyle** (it's in the resource dictionary for a different page), so the default values are used for the font size and font attributes.

    :::image type="content" source="../media/9-custom-tip-page.png" alt-text="A screenshot of the CustomTipPage page. The Bill label isn't styled correctly.":::

## Create a dictionary for application-level resources

Let's create an application-wide resource dictionary to hold resources to use on multiple pages.

1. Open the **App.xaml** file. Notice that this file currently contains a resource dictionary with some existing resource dictionaries and styles that are used by default for controls built into .NET MAUI. To see all the styles included by default, view the **Resources/Styles.xaml** file.

    ```XML
    <?xml version = "1.0" encoding = "UTF-8" ?>
    <Application xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
                 xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
                 xmlns:local="clr-namespace:TipCalculator"
                 x:Class="TipCalculator.App">
        <Application.Resources>
            <ResourceDictionary>
                <ResourceDictionary.MergedDictionaries>
                    <ResourceDictionary Source="Resources/Colors.xaml" />
                    <ResourceDictionary Source="Resources/Styles.xaml" />
                </ResourceDictionary.MergedDictionaries>
            </ResourceDictionary>
        </Application.Resources>
    </Application>
    ```

1. Open the **StandardTipPage.xaml** file, and move the **fontSize** resource, and the **baseLabelStyle** and **infoLabelStyle** styles to the resource dictionary in the **App.xaml** file. Place them after the existing styles so that the **App.Xaml** file looks like the following example:

    ```xml
    <Application xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
                 ...>
        <Application.Resources>
            <ResourceDictionary>
                <ResourceDictionary.MergedDictionaries>
                    <ResourceDictionary Source="Resources/Colors.xaml" />
                    <ResourceDictionary Source="Resources/Styles.xaml" />
                </ResourceDictionary.MergedDictionaries>
                
                <Color x:Key="bgColor">#C0C0C0</Color>
                <Color x:Key="fgColor">#0000AD</Color>
                <x:Double x:Key="fontSize">22</x:Double>

                <Style x:Key="baseLabelStyle" TargetType="Label">
                    <Setter Property="FontSize" Value="{StaticResource fontSize}" />
                </Style>
                <Style x:Key="infoLabelStyle" BasedOn="{StaticResource baseLabelStyle}" TargetType="Label">
                    <Setter Property="FontAttributes" Value="Bold" />
                </Style>
            </ResourceDictionary>
        </Application.Resources>
    </Application>
    ```

1. Run the app.

1. Select **Use Custom Calculator** tab and verify that the Bill label is now styled correctly.
