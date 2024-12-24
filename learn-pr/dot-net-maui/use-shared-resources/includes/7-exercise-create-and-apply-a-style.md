In this exercise, you define and apply a page-level style in the Tip Calculator application.

This exercise is a continuation of the previous exercise. Either use your existing solution as the starting point for these steps, or open the **TipCalculator** project in the **exercise3/TipCalculator** folder in the repository that you cloned in the first exercise.

## Define a style

Let's start by implementing a "size 22 Bold" font style to use for labels. Store the style in a page-level dictionary.

1. In the **TipCalculator** project, open the **StandardTipPage.xaml** file.

1. Add a **Style** to the page's resource dictionary, after the existing resources. Use an **x:Key** value of **infoLabelStyle** and a **TargetType** value of **Label**.

    ```XML
    <ContentPage.Resources>
        <ResourceDictionary>
            ...
            <Style x:Key="infoLabelStyle" TargetType="Label">
            </Style>
        </ResourceDictionary>
    </ContentPage.Resources>
    ```

1. Add a **Setter** instance that sets the **FontSize** property of the style to the value in the **fontSize** resource.

1. Add another **Setter** that sets the **FontAttributes** property to **Bold**.

    ```XML
    <Style x:Key="infoLabelStyle" TargetType="Label">
        <Setter Property="FontSize" Value="{StaticResource fontSize}" />
        <Setter Property="FontAttributes" Value="Bold" />
    </Style>
    ```

## Apply the style

1. Locate the three **Label** controls that use a **FontSize** value of **{StaticResource fontSize}** and a **FontAttributes** value of Bold. Remove these property assignments from the labels.

1. Use the **StaticResource** mark-up extension to assign the **infoLabelStyle** style to these three labels:

    ```XML
    <!-- Left column = static labels -->
    <Label x:Name="billLabel"  Text="Bill"  ... Style="{StaticResource infoLabelStyle}" ... />
    <Label x:Name="tipLabel"   Text="Tip"   ... Style="{StaticResource infoLabelStyle}" ... />
    <Label x:Name="totalLabel" Text="Total" ... Style="{StaticResource infoLabelStyle}" ... />
    ```

1. Run the app. The app should look exactly like it did before. However, the font attributes for the labels are now being set with a style.

## Change the font style

Let's take a look at how it's easy to update styles.

1. Go back to your style in the resource dictionary and change the **fontSize** resource to **32**.

1. Run the app again to view the changes. The three labels for Bill, Tip, and Total should be bigger.

1. Change the **fontSize** resource back to **22**.

## Create a base style

Let's expand the implementation of the **StandardTipPage** page by adding a base style. You define a new **Style** with values that overlap with the **Style**  that you created in the previous steps. Then, you refactor this new style in the next part of this exercise.

1. Open the **StandardTipPage.xaml** file.

1. Add another **Style** to the page's resource dictionary. Use an **x:Key** value of **baseLabelStyle** and a **TargetType** value of **Label**.

    > [!IMPORTANT]
    > Define this style above the **infoLabelStyle** style. This positioning will be important later when you inherit from this style. A style can only inherit from another style that is already in scope.

1. Add a **Setter** that sets the **FontSize** property. Notice that this setter is a repetition of the setter from the earlier **infoLabelStyle**.

    ```XML
    <ContentPage.Resources>
        <ResourceDictionary>
            ...
            <Style x:Key="baseLabelStyle" TargetType="Label">
                <Setter Property="FontSize" Value="{StaticResource fontSize}" />
            </Style>
            ...
        <ResourceDictionary>
    </ContentPage.Resources>
    ```

1. Apply the new **baseLabelStyle** to the two labels on the page that display the calculated amounts for the tip and the total. Remove the explicit **FontSize** settings from these labels. The following code shows an example.

    ```xml
    <!-- Right column = user input and calculated-value output -->
    ...
    <Label x:Name="tipOutput"   Text="0.00" TextColor="Navy" Style="{StaticResource baseLabelStyle}" Grid.Row="1" Grid.Column="1" />
    <Label x:Name="totalOutput" Text="0.00" TextColor="Navy" Style="{StaticResource baseLabelStyle}" Grid.Row="2" Grid.Column="1" />
    ```

1. Run the application. Verify that the values for the calculated Tip and Total amounts (containing the values 0.00) are still styled correctly.

## Use style inheritance

You're now ready to refactor your styles by using inheritance. Refactoring lets you eliminate the repeated use of setter.

1. Open the **StandardTipPage.xaml** file.

1. Locate the **infoLabelStyle** style in the page's resource dictionary. Move this style below the **baseLabelStyle** in the resource dictionary.

1. Set the **BasedOn** property for the **infoLabelStyle** style to **baseLabelStyle**. Remove the setter for **FontSize**. You no longer need it because this style now inherits the **FontSize** setting from the base style.

    ```XML
    <ContentPage.Resources>
        <ResourceDictionary>
            ...
            <Style x:Key="baseLabelStyle" TargetType="Label">
                <Setter Property="FontSize" Value="{StaticResource fontSize}" />
            </Style>
            <Style x:Key="infoLabelStyle" BasedOn="{StaticResource baseLabelStyle}" TargetType="Label">
                <Setter Property="FontAttributes" Value="Bold" />
            </Style>
        <ResourceDictionary>
    </ContentPage.Resources>
    ```

    > [!NOTE]
    > The order of the resources in the resource dictionary is important. The **baseLabelStyle** style must be defined before any other styles that reference it otherwise style inheritance won't work.

1. Run the app and verify that the styles for the labels and calculated amounts are still styled correctly.
