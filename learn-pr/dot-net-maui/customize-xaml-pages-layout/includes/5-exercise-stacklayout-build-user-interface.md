In this exercise, you use nested `StackLayout` containers to arrange the views in your User Interface (UI). The first screenshot shows the layout implemented by the starter project, and the second one shows the layout for the completed project. Your job is to use `StackLayout` containers and `LayoutOptions` to turn the starter project into the completed version.

:::image type="content" source="../media/5-starter-complete.png" alt-text="Screenshot showing the starter solution with all of the labels placed vertically in close proximity. Next to it, is the completed solution with controls aligned and positioned in a more intuitive manner.":::

## Explore the starter solution

The starter solution contains a fully functional tip calculator app. Start by exploring the UI to understand what the app does.

1. Using Visual Studio, open the starter solution in the **exercise2/TipCalculator** folder in the repo that you cloned at the start of the previous exercise.

1. Build and run the app on your preferred operating system.

1. Enter a number into the text box and use the app to see how it works.

1. Experiment with the tip amount buttons and the slider.

1. When you're finished, close the app.

1. Open **MainPage.xaml**. Notice that all the views are placed into one `VerticalStackLayout`, as shown by the following XAML markup:

    ```xml
    <ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:local="clr-namespace:TipCalculator"
             x:Class="TipCalculator.MainPage">
        <VerticalStackLayout>
    
            <Label Text="Bill" />
            <Entry x:Name="billInput" Placeholder="Enter Amount" Keyboard="Numeric" />
    
            <Label Text="Tip"   />
            <Label x:Name="tipOutput" Text="0.00" />
    
            <Label Text="Total" />
            <Label x:Name="totalOutput" Text="0.00" />
    
            <Label Text="Tip Percentage" />
            <Label x:Name="tipPercent" Text="15%" />
            <Slider x:Name="tipPercentSlider" Minimum="0" Maximum="100" Value="15" />
    
            <Button Text="15%" Clicked="OnNormalTip" />
            <Button Text="20%" Clicked="OnGenerousTip" />
    
            <Button x:Name="roundDown" Text="Round Down" />
            <Button x:Name="roundUp"   Text="Round Up" />
    
        </VerticalStackLayout>
    </ContentPage>
    ```

## Fix the UI

Now that you saw the app run, you can make it look better by adding `HorizontalStackLayout` containers. The goal is to make the app look like the screenshot at the start of the lab.

1. Open the **MainPage.xaml** file.

1. Add `40` units of padding and `10` units of spacing to the `VerticalStackLayout`:

    ```xml
    <VerticalStackLayout Padding="40" Spacing="10">
    ```

1. Add a `HorizontalStackLayout` to group the `Label` that says **Bill** with the `Entry` field below it. Set the `Spacing` property to `10`.

1. Set the `WidthRequest` of the **Bill** `Label` to `100` and the `VerticalOptions` property to `Center`. These changes ensure that the label is aligned vertically with the `Entry` field.

    ```xml
    <HorizontalStackLayout Spacing="10">
        <Label Text="Bill" WidthRequest="100" VerticalOptions="Center"/>
        <Entry ... />
    </HorizontalStackLayout>
    ```

1. Add another `HorizontalStackLayout` to group the `Label` that says **Tip** with the `Label` named **tipOutput**. Set the `Spacing` property to `10`, and the `Margin` property to `0,20,0,0`.

1. Set the `WidthRequest` of the **Tip** `Label` to `100`

    ```xml
    <HorizontalStackLayout Margin="0,20,0,0" Spacing="10">
        <Label Text="Tip" WidthRequest="100" />
        <Label .../>
    </HorizontalStackLayout>
    ```

1. Use a `HorizontalStackLayout` to group the `Label` that says **Total** with the `Label` named **totalOutput**. Set the `Spacing` property to `10`.

1. Set the `WidthRequest` of the **Total** `Label` to `100`

    ```xml
    <HorizontalStackLayout Spacing="10">
        <Label Text="Total" WidthRequest="100"  />
        <Label .../>
    </HorizontalStackLayout>
    ```

1. Add another `HorizontalStackLayout` to group the `Label` that says **Tip Percentage** with the `Label` named **tipPercent**.

1. Set the `VerticalOptions` property of this `HorizontalStackLayout` to `End` and set the `Spacing` property to `10`:

1. Set the `WidthRequest` of the **Tip Percentage** `Label` to `100`

    ```xml
    <HorizontalStackLayout VerticalOptions="End" Spacing="10">
        <Label Text="Tip Percentage" WidthRequest="100"/>
        <Label ... />
    </HorizontalStackLayout>
    ```

1. Use a `HorizontalStackLayout` to group the `Button` with the caption **15%** and the `Button` with the caption **20%.**

1. Set the `Margin` property of this `StackLayout` to `0,20,0,0`, and the `Spacing` property to `10`:

    ```xml
    <HorizontalStackLayout  Margin="0,20,0,0" Spacing="10">
        <Button Text="15%" ... />
        <Button Text="20%" ... />
    </HorizontalStackLayout>
    ```

1. Add a final `HorizontalStackLayout` to group the `Button` with the caption, **Round Down** and the `Button` with the caption, **Round Up.**. Set the `Margin` property of this `StackLayout` to `0,20,0,0`, and the `Spacing` property to `10`:

    ```xml
    <HorizontalStackLayout Margin="0,20,0,0" Spacing="10">
            <Button ... Text="Round Down" />
            <Button ... Text="Round Up" />
    </HorizontalStackLayout>
    ```

1. On all four button controls, set the `HorizontalOptions` property to `Center` and the `WidthRequest` property to `150`. For example:

    ```xml
    <Button Text="15%" WidthRequest="150" HorizontalOptions="Center" ... />
    ```

The complete XAML markup for the content page should look like this:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:local="clr-namespace:TipCalculator"
             x:Class="TipCalculator.MainPage">

    <VerticalStackLayout Padding="40" Spacing="10">

        <HorizontalStackLayout Spacing="10">
            <Label Text="Bill" WidthRequest="100" VerticalOptions="Center" />
            <Entry x:Name="billInput" Placeholder="Enter Amount" Keyboard="Numeric" />
        </HorizontalStackLayout>

        <HorizontalStackLayout Margin="0,20,0,0" Spacing="10">
            <Label Text="Tip"  WidthRequest="100" />
            <Label x:Name="tipOutput" Text="0.00" />
        </HorizontalStackLayout>

        <HorizontalStackLayout Spacing="10">
            <Label Text="Total" WidthRequest="100"/>
            <Label x:Name="totalOutput" Text="0.00" />
        </HorizontalStackLayout>

        <HorizontalStackLayout VerticalOptions="End" Spacing="10">
            <Label Text="Tip Percentage" WidthRequest="100"/>
            <Label x:Name="tipPercent" Text="15%" />
        </HorizontalStackLayout>
        
        <Slider x:Name="tipPercentSlider" Minimum="0" Maximum="100" Value="15" />

        <HorizontalStackLayout Margin="0,20,0,0" Spacing="10">
            <Button Text="15%" Clicked="OnNormalTip" WidthRequest="150" HorizontalOptions="Center"/>
            <Button Text="20%" Clicked="OnGenerousTip"  WidthRequest="150" HorizontalOptions="Center"/>
        </HorizontalStackLayout>
        
        <HorizontalStackLayout Margin="0,20,0,0" Spacing="10">
            <Button x:Name="roundDown" Text="Round Down" WidthRequest="150" HorizontalOptions="Center"/>
            <Button x:Name="roundUp"   Text="Round Up" WidthRequest="150" HorizontalOptions="Center"/>
        </HorizontalStackLayout>

    </VerticalStackLayout>

</ContentPage>
```

## Examine the results

Run the app again and look at the differences in the UI. Verify that the controls are aligned correctly, and are properly sized and spaced.

You used `VerticalStackLayout` and `HorizontalStackLayout` containers to improve the aesthetics of an existing UI. These layouts are the simplest layout panels, but are powerful enough to produce a reasonable UI.
