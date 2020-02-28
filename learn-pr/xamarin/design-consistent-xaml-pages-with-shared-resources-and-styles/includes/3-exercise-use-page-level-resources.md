All the exercises in this module relate to the prebuilt **TipCalculator** application. You'll modify and improve this app throughout this module. In this exercise, you'll use page-level resources to eliminate repeated XAML values.

## Open the starter solution

1. Clone or download the [!INCLUDE [module-exercise-repo](module-exercise-repo.md)] from GitHub.

    [!include[](../../../includes/android-windows-path-length-warning.md)]

1. Open the starter solution from the **exercise1** > **start** folder by using Visual Studio.

1. Verify that it builds and runs in your environment. (Any platform is fine.)

1. Take a few minutes to work with the application so you understand how it behaves.

## Find repeated XAML

1. Open **StandardTipPage.xaml**.

1. Find the code that sets the background color of the root grid. Notice that a hard-coded value is used.

1. Find the code that sets the "left column" labels to `Navy`, `22`, and `Bold`. Notice that these same values are used on three labels.

    ```xml
    <!-- Left column = static labels -->
    <Label x:Name="billLabel" Text="Bill" TextColor="Navy" FontSize="22" FontAttributes="Bold" ... />
    <Label x:Name="tipLabel" Text="Tip" TextColor="Navy" FontSize="22" FontAttributes="Bold" ... />
    <Label x:Name="totalLabel" Text="Total" TextColor="Navy" FontSize="22" FontAttributes="Bold" ... />
    ```

1. Find the code that sets the "right column" labels to `Navy` and `22`. Notice that these same values are used on two labels.

1. Notice that some of the property settings seem to form a logical group. For example, the combination of `Navy` and `22` is used on multiple labels.

1. Consider the difficulty of modifying the `FontSize` value. You would need to change it in five places.

## Find repeated code

The app implements simple "light" and "dark" color schemes for `StandardTipPage`. Here, you'll examine the code that's used to change the colors.

1. Open **StandardTipPage.xaml.cs**.

1. Locate the two event handlers that update the UI colors.

    ```csharp
    void OnLight(object sender, EventArgs e)
    {
        LayoutRoot.BackgroundColor = Color.Silver;

        tipLabel.TextColor = Color.Navy;
        billLabel.TextColor = Color.Navy;
        totalLabel.TextColor = Color.Navy;
        tipOutput.TextColor = Color.Navy;
        totalOutput.TextColor = Color.Navy;
    }

    void OnDark(object sender, EventArgs e)
    {
        ...
    }
    ```

1. Notice how the code must update the colors for each control individually, resulting in repeated code.

## Define resources

You've now seen all the repeated code that exists in the application. Let's create resources in XAML to start eliminating some of this repeated code.

1. Open the **TipCalculator** project.

1. Open **StandardTipPage.xaml**.

1. Define a `Color` resource inside `Page.Resources`. Give it an `x:Key` resource of `bgColor` and a value of `#c0c0c0`.

1. Define a second `Color` resource. Give it an `x:Key` resource of `fgColor` and a value of `#606060`.

    ```xml
    <Page.Resources>
        <ResourceDictionary>
            <Color x:Key="bgColor">#c0c0c0</Color>
            <Color x:Key="fgColor">#606060</Color>
        </ResourceDictionary>
    </Page.Resources>
    ```

## Use static resources

Now, let's apply the resources that you created.

1. Use the `StaticResource` markup extension to apply the `bgColor` resource to the `Background` property of the page's root `Grid`.

1. Use the `StaticResource` markup extension to apply the `fgColor` resource to the `TextColor` property of all the `Label` instances that use `TextColor` of `Navy`.

    ```xml
    <Grid x:Name ="LayoutRoot" BackgroundColor="{StaticResource bgColor}" Padding="10">
    <Label x:Name="tipOutput" Text="0.00" TextColor="{StaticResource fgColor}" FontSize="22" Grid.Row="1" Grid.Column="1" />
    ```

## Run the application

Run the application on a platform of your choice. Verify that **StandardTipPage** displays dark text on a light background at startup.
