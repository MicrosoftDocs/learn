In this exercise, you use the **DynamicResource** mark-up extension to update the TipCalculator UI when resource values change.

This exercise is a continuation of the previous exercise. Either use your existing solution as the starting point for these steps, or open the **TipCalculator** project in the **exercise2/TipCalculator** folder in the repository that you cloned in the previous exercise.

## Find repeated code

The app implements simple "light" and "dark" color schemes for the **StandardTipPage** page. Here, you examine the code used to change the colors.

1. Open the **StandardTipPage.xaml.cs** file.

1. Locate the two event handlers that update the UI colors.

    ```csharp
    private Color colorNavy = Colors.Navy;
    private Color colorSilver = Colors.Silver;

    ...

    void OnLight(object sender, EventArgs e)
    {
        LayoutRoot.BackgroundColor = colorSilver;

        tipLabel.TextColor = colorNavy;
        billLabel.TextColor = colorNavy;
        totalLabel.TextColor = colorNavy;
        tipOutput.TextColor = colorNavy;
        totalOutput.TextColor = colorNavy;
    }

    void OnDark(object sender, EventArgs e)
    {
        LayoutRoot.BackgroundColor = colorNavy;

        tipLabel.TextColor = colorSilver;
        billLabel.TextColor = colorSilver;
        totalLabel.TextColor = colorSilver;
        tipOutput.TextColor = colorSilver;
        totalOutput.TextColor = colorSilver;
    }

    ...
    ```

    Notice how the code updates the colors for each control individually, resulting in repeated code.

## Update resources from code

You start by writing code that updates a few resources stored in a page's resource dictionary.

1. Remove all the code from the **OnLight** method.

1. Add the following code shown to the **OnLight** method. This code sets the **fgColor** resource in the page's resource dictionary to the value in the **colorNavy** variable and sets the **bgColor** resource to the value in the **colorSilver** variable. The **colorNavy** and **colorSilver** variables use the static **Color.FromRgb** method, which makes it easy to convert a hexadecimal value to a color.

    ```csharp
    void OnLight(object sender, EventArgs e)
    {
        Resources["fgColor"] = colorNavy;
        Resources["bgColor"] = colorSilver;
    }
    ```

1. Repeat the previous two steps for the **OnDark** method, but reverse the colors; set **fgColor** to **colorSilver** and **bgColor** to **colorNavy**.

    ```csharp
    void OnDark(object sender, EventArgs e)
    {
        Resources["fgColor"] = colorSilver;
        Resources["bgColor"] = colorNavy;
    }
    ```

1. Run the app. Select the **Dark** and **Light** buttons. The UI doesn't change. Even though the code changes the resource values in the dictionary, the new value isn't propagated to the UI. The issue is that you're using the **StaticResource** mark-up extension to set the values in the XAML code.

## Update the UI dynamically

To fix the problem, modify your XAML so that updated resource values are loaded into your UI.

1. Stop the app, and open the **StandardTipPage.xaml** file.

1. Locate all of the places where you assign colors from resource values. Replace the use of the **StaticResource** mark-up extension with **DynamicResource**, as shown in this example.

    ```XML
    <Grid x:Name ="LayoutRoot" BackgroundColor="{DynamicResource bgColor}" Padding="10">
    ...
    <Label x:Name="billLabel"  Text="Bill"  TextColor="{DynamicResource fgColor}" ... />
    <Label x:Name="tipLabel"   Text="Tip"   TextColor="{DynamicResource fgColor}" ... />
    <Label x:Name="totalLabel" Text="Total" TextColor="{DynamicResource fgColor}" ... />
    ...
    ```

    > [!NOTE]
    > Don't change the **FontSize** properties from **StaticResource** to **DynamicResource**.

1. Run the app. Select the **Dark** and **Light** buttons. The UI now updates correctly.
