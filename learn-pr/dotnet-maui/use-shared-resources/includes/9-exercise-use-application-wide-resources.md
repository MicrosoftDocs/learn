The goal of this exercise is to make resources available across multiple pages by moving them to a resource dictionary in the Tip Calculator Application class.

This exercise is a continuation of the previous exercise. Either use your existing solution as the starting point for these steps, or open the **TipCalculator** project in the **exercise4/start/TipCalculator** folder in the repository that you cloned in the first exercise.

## Verify page-level resources

Let's verify that resources defined on one page aren't available on another page. Your app won't run correctly at the end of this section. However, you'll fix it in the next section.

1. In the **TipCalculator** project, open the **CustomTipPage.xaml** file.

1. Set the **infoLabelStyle** resource as the style for the **billLabel** label, and remove the existing settings for the **FontSize** and **FontAttributes** properties.

    ```XML
    <Label x:Name="billLabel" Text="Bill" Style="{StaticResource infoLabelStyle}" Grid.Row="0" Grid.Column="0" />
    ```

1. Run the app.

1. Select **Use Custom Calculator** to display the **CustomTipPage** page. Look at the Bill label. The font size should be smaller than the other labels and it isn't bold. This is because the page hasn't found a resource named **infoLabelStyle** (it's in the resource dictionary for a different page), so the default values are used for the font size and font attributes.

    :::image type="content" source="../media/9-custom-tip-page.png" alt-text="A screenshot of the CustomTipPage page. The Bill label isn't styled correctly.":::

## Create a dictionary for application-level resources

Let's create an application-wide resource dictionary to hold resources to use on multiple pages.

1. Open the **App.xaml** file. Notice that this file currently contains a resource dictionary with some existing resources and styles that are used by default for buttons and labels:

    ```XML
    <Application xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
                 xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
                 xmlns:windows="clr-namespace:Microsoft.Maui.Controls.PlatformConfiguration.WindowsSpecific;assembly=Microsoft.Maui.Controls"
                 xmlns:local="clr-namespace:TipCalculator"
                 x:Class="TipCalculator.App"
                 windows:Application.ImageDirectory="Assets">
        <Application.Resources>
            <ResourceDictionary>

                <Color x:Key="PageBackgroundColor">#512bdf</Color>
                <Color x:Key="PrimaryTextColor">White</Color>
    
                <Style TargetType="Label">
                    <Setter Property="TextColor" Value="{DynamicResource PrimaryTextColor}" />
                    <Setter Property="FontFamily" Value="OpenSansRegular" />
                </Style>
    
                <Style TargetType="Button">
                    <Setter Property="TextColor" Value="{DynamicResource PrimaryTextColor}" />
                    <Setter Property="FontFamily" Value="OpenSansRegular" />
                    <Setter Property="BackgroundColor" Value="#2b0b98" />
                    <Setter Property="Padding" Value="14,10" />
                </Style>
    
            </ResourceDictionary>
        </Application.Resources>
    </Application>
    ```

1. Move the **fontSize** resource, and the **baseLabelStyle** and **infoLabelStyle** styles from the **StandardTipPage.xaml** file to the resource dictionary in the **App.xaml** file, after the existing styles:

    ```xml
    <Application xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
                 ...>
        <Application.Resources>
            <ResourceDictionary>
                ...
                <x:String x:Key="fontSize">22</x:Int32>
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
