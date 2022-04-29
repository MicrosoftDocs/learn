In this exercise, you'll use nested `StackLayout` containers to arrange the views in your User Interface (UI). The first screenshot shows the layout implemented by the starter project, and the second one shows the layout for the completed project. Your job is to use `StackLayout` containers and `LayoutOptions` to turn the starter project into the completed version.

:::image type="content" source="../media/5-starter-complete.png" alt-text="Screenshot showing the starter solution, with all the labels placed vertically in close proximity, and the completed solution, with controls aligned and positioned in a more intuitive manner.":::

## Explore the starter solution

The starter solution contains a fully functional tip calculator app. You'll start by exploring the  UI to understand what the app does.

1. Using Visual Studio, open the starter solution in the **exercise2/start/TipCalculator** folder in the repo that you cloned at the start of the previous exercise.

1. Build and run the app on either iOS or Android.

1. Enter a number into the text box and use the app to see how it works.

1. Experiment with the tip amount buttons and the slider.

1. When you have finished, close the app.

1. Open **MainPage.xaml**. Notice that all the views are placed into one vertical `StackLayout`, as shown by the following XAML markup:

    ```xml
    <ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:local="clr-namespace:TipCalculator"
             x:Class="TipCalculator.MainPage"
             BackgroundColor="{DynamicResource SecondaryColor}">
        <StackLayout>
    
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
    
        </StackLayout>
    </ContentPage>
    ```

## Fix the UI

Now that you've seen the app run, you can make it look better by adding `StackLayout` containers. The goal is to make the app look like the screenshot at the start of the lab.

1. Open the **MainPage.xaml** file.

1. Add `40` units of padding to the `ContentPage` to avoid any overlap of the UI and the iOS status bar if you are running on an iPhone:

    ```xml
    <ContentPage ... 
                 Padding="40">
    ```

1. Add a horizontal `StackLayout` to group the `Label` that says **Bill** with the `Entry` field below it. Set the `Spacing` property to `10`.

1. Set the `WidthRequest` of the **Bill** `Label` to `100` and the `VerticalOptions` property to `Center`. This will ensure that the label is aligned vertically with the `Entry` field.

    ```xml
    <StackLayout Orientation="Horizontal" Spacing="10">
        <Label Text="Bill" WidthRequest="100" />
        <Entry ... />
    </StackLayout>
    ```

1. Add another horizontal `StackLayout` to group the `Label` that says **Tip** with the `Label` named **tipOutput**. Set the `Spacing` property to `10`, and the `Margin` property to `0,20,0,0`.

1. Set the `WidthRequest` of the **Tip** `Label` to `100`

    ```xml
    <StackLayout Orientation="Horizontal" Margin="0,20,0,0" Spacing="10">
        <Label Text="Tip" WidthRequest="100"  />
        <Label .../>
    </StackLayout>
    ```

1. Use a horizontal `StackLayout` to group the `Label` that says **Total** with the `Label` named **totalOutput**. Set the `Spacing` property to `10`.

1. Set the `WidthRequest` of the **Total** `Label` to `100`

    ```xml
    <StackLayout Orientation="Horizontal" Spacing="10">
        <Label Text="Total" WidthRequest="100"  />
        <Label .../>
    </StackLayout>
    ```

1. Add another horizontal `StackLayout` to group the `Label` that says **Tip Percentage** with the `Label` named **tipPercent**.

1. Set the `VerticalOptions` property of this `StackLayout`to `EndAndExpand` and set the `Spacing` property to `10`:

1. Set the `WidthRequest` of the **Tip Percentage** `Label` to `100`

    ```xml
    <StackLayout Orientation="Horizontal" VerticalOptions="EndAndExpand" Spacing="10">
        <Label Text="Tip Percentage" WidthRequest="100"/>
        <Label ... />
    </StackLayout>
    ```

1. Use a horizontal `StackLayout` to group the `Button` with the caption **15%** and the `Button` with the caption **20%.**

1. Set the `Margin` property of this `StackLayout` to `0,20,0,0`, and the `Spacing` property to `10`:

    ```xml
    <StackLayout Orientation="Horizontal" Margin="0,20,0,0" Spacing="10">
        <Button Text="15%" ... />
        <Button Text="20%" ... />
    </StackLayout>
    ```

1. Add a final horizontal `StackLayout` to group the `Button` with the caption, **Round Down** and the `Button` with the caption, **Round Up.**. Set the `Margin` property of this `StackLayout` to `0,20,0,0`, and the `Spacing` property to `10`:

    ```xml
    <StackLayout Orientation="Horizontal" Margin="0,20,0,0" Spacing="10">
            <Button ... Text="Round Down" />
            <Button ... Text="Round Up" />
        </StackLayout>
    ```

1. On all four button controls, set the `HorizontalOptions` property to `CenterAndExpand` and the `WidthRequest` property to `150`. For example:

    ```xml
    <Button Text="15%" WidthRequest="150" HorizontalOptions="CenterAndExpand" ... />
    ```

The complete XAML markup for the content page should look like this:

```xml
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:local="clr-namespace:TipCalculator"
             x:Class="TipCalculator.MainPage"
             BackgroundColor="{DynamicResource SecondaryColor}"
             Padding="40">
    <StackLayout>

        <StackLayout Orientation="Horizontal" Spacing="10">
            <Label Text="Bill" VerticalOptions="Center" WidthRequest="100"/>
            <Entry x:Name="billInput" Placeholder="Enter Amount" Keyboard="Numeric"/>
        </StackLayout>

        <StackLayout Orientation="Horizontal" Margin="0,20,0,0" Spacing="10">
            <Label Text="Tip" WidthRequest="100"  />
            <Label x:Name="tipOutput" Text="0.00" />
        </StackLayout>

        <StackLayout Orientation="Horizontal" Spacing="10">
            <Label Text="Total" WidthRequest="100"/>
            <Label x:Name="totalOutput" Text="0.00" />
        </StackLayout>

        <StackLayout Orientation="Horizontal" VerticalOptions="EndAndExpand" Spacing="10">
            <Label Text="Tip Percentage" WidthRequest="100"/>
            <Label x:Name="tipPercent" Text="15%" />
        </StackLayout>
                
        <Slider x:Name="tipPercentSlider" Minimum="0" Maximum="100" Value="15"/>

        <StackLayout Orientation="Horizontal" Margin="0,20,0,0" Spacing="10">
            <Button Text="15%" WidthRequest="150" HorizontalOptions="CenterAndExpand" Clicked="OnNormalTip" />
            <Button Text="20%" WidthRequest="150" HorizontalOptions="CenterAndExpand" Clicked="OnGenerousTip" />
        </StackLayout>

        <StackLayout Orientation="Horizontal" Margin="0,20,0,0" Spacing="10">
            <Button x:Name="roundDown" WidthRequest="150" HorizontalOptions="CenterAndExpand" Text="Round Down" />
            <Button x:Name="roundUp"   WidthRequest="150" HorizontalOptions="CenterAndExpand" Text="Round Up" />
        </StackLayout>
        
    </StackLayout>
</ContentPage>
```

## Examine the results

Run the app again and look at the differences in the UI. Verify that the controls are aligned correctly, and properly sized and spaced.

You used nested `StackLayout` containers to improve the aesthetics of an existing UI. `StackLayout` is the simplest layout panel, but it's powerful enough to produce a reasonable UI.
