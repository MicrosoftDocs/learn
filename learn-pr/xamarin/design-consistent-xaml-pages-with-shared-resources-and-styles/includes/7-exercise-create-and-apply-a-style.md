In this exercise, you'll define and apply a page-level style in the **Tip Calculator** application.

This exercise is a continuation of the previous exercise. Use your existing solution as the starting point for these steps.

## Define a style

Let's start by implementing a style for "size 22 Bold" font to use on our labels. We'll store the style in a page-level dictionary.

1. Open the **TipCalculator** project.

1. Open the **StandardTipPage.xaml** file.

1. Add a `Style` instance to the page's resource dictionary. Use a `Key` value of `infoLabelStyle` and a `TargetType` value of `Label`.

    ```xml
    <Style x:Key="infoLabelStyle" TargetType="Label">
    ...
    </Style>
    ```

1. Add a `Setter` instance that sets the `FontSize` property to `22`.

1. Add a `Setter` instance that sets the `FontAttributes` property to `Bold`.

    ```xml
    <Style x:Key="infoLabelStyle" TargetType="Label">
        <Setter Property="FontSize" Value="22" />
        <Setter Property="FontAttributes" Value="Bold" />
    </Style>
    ```

## Apply the style

With the style set up, you'll apply it to some of your labels.

1. Locate the three `Label` instances that use a `TextSize` value of `22` and a `FontAttributes` value of `Bold`. Remove those property assignments from the labels.

1. Use the `StaticResource` markup extension to assign the style to the three labels. Sample code for one `Label` instance is provided:

    ```xml
    <Label Style="{StaticResource infoLabelStyle}" ... />
    ```

1. Run the app on a platform of your choice. The app should look exactly like it did before. However, the font attributes are now being set with a style.

## Change the font styles

Let's take a look at how easy it is to update styles.

1. Go back to your style in the resource dictionary and change the font size to `32`.

1. Run the app again to view the changes.

## Create a base style

Let's expand the implementation of **StandardTipPage** by adding a base style. You'll define a new `Style` instance with values that overlap with the `Style` instance that you wrote previously. You'll refactor it in the next part.

1. Open the **StandardTipPage.xaml** file.

1. Add a `Style` instance to the page's resource dictionary. Use an `x:Key` value of `baseLabelStyle` and a `TargetType` value of `Label`.

1. Add a `Setter` instance to your style that sets the `FontSize` property to `22`. Notice how this setter also appears in your other `Style` instance.

1. Apply `baseLabelStyle` to the two labels on the page that display the calculated amounts for the tip and the total. Remove the explicit `FontSize` settings from these labels.

1. Run the application on a platform of your choice. Verify that the UI looks the same as it did previously.

    ```xml
    <Page.Resources>
        ...
        <Style x:Key="baseLabelStyle" TargetType="Label">
            <Setter Property="FontSize" Value="22" />
        </Style>
        ...
    </Page.Resources>
    ```

## Use style inheritance

You're now ready to refactor your styles by using inheritance. Refactoring will let you eliminate the repeated use of `Setter`.

1. Open the **StandardTipPage.xaml** file.

1. Locate the `infoLabelStyle` style in the page's resource dictionary. Set the `BasedOn` property to `baseLabelStyle`.

    ```xml
    <Style x:Key="infoLabelStyle" BasedOn="{StaticResource baseLabelStyle}" TargetType="Label">
        <Setter Property="FontAttributes" Value="Bold" />
        <Setter Property="FontSize" Value="22" />
    </Style>
    ```

1. Remove the setter for `FontSize` from `infoLabelStyle`. You no longer need it because this style now inherits the `FontSize` setting from the base style.

1. Run the app and verify that the UI looks the same.

    ```xml
    <Style x:Key="infoLabelStyle" BasedOn="{StaticResource baseLabelStyle}" TargetType="Label">
        <Setter Property="FontAttributes" Value="Bold" />
    </Style>
    ```