All the exercises in this module relate to the prebuilt **TipCalculator** application. You modify and improve this app throughout the module. In this exercise, you use page-level resources to eliminate repeated XAML values.

[!include[](../../../includes/dotnet8-sdk-version.md)]

## Open the starter solution

1. Clone or download the exercise repo from [GitHub](https://github.com/microsoftdocs/mslearn-dotnetmaui-use-shared-resources).

    > [!NOTE]
    > It is best to clone or download the exercise content to a short folder path, such as C:\dev\, to avoid build-generated files exceeding the maximum path length.

1. Open the starter solution from the **exercise1/TipCalculator** folder by using Visual Studio or this folder directly in Visual Studio Code.

1. Verify that it builds and runs in your environment. (Any platform is fine.)

1. Take a few minutes to examine and run the application so you understand how it behaves.

    The application provides two pages. The **StandardTipPage** page is a simple tip calculator. You enter a value, and the page calculates the tip (15%) and the total due. The following image shows the application running on an Android device:

    :::image type="content" source="../media/3-standard-tip-page.png" alt-text="A screenshot of the standard tip page of tip calculator app running on Android.":::

    The **Light** and **Dark** buttons enable you to change the color theme of the page. The default is the Light theme. If you select **Dark**, the colors for the background and text are reversed.

    The **Use Custom Calculator** button switches the display to the **CustomTipPage** page. This page enables you to vary the tip percentage by using a slider. You can also select the 15% and 20% buttons to calculate the tip based on predefined rates.

    :::image type="content" source="../media/3-custom-tip-page.png" alt-text="A screenshot of the custom tip page of the Tip Calculator in Android.":::

## Find repeated XAML

1. Open the **StandardTipPage.xaml** file.

1. Find the XAML markup that sets the background color of the **LayoutRoot** grid. Notice that it uses a hard-coded value.

    ```xml
    <Grid x:Name ="LayoutRoot" BackgroundColor="Silver" Padding="10">
    ```

1. Find the XAML markup that sets the text color of the labels in the "left column" to Navy, and the font size to 22. Notice that these same values are used on three labels.

    ```XML
    <!-- Left column = static labels -->
    <Label x:Name="billLabel"  Text="Bill"  TextColor="Navy" FontSize="22" ... />
    <Label x:Name="tipLabel"   Text="Tip"   TextColor="Navy" FontSize="22" ... />
    <Label x:Name="totalLabel" Text="Total" TextColor="Navy" FontSize="22" ... />
    ```

1. Find the XAML code that sets the color of the labels in the "right column" to Navy and the point size to 22. Notice that these same values are used on two labels.

    Some of the property settings seem to form a logical group. For example, the combination of Navy and 22 is used on multiple labels.

    ```xml
    <!-- Right column = user input and calculated-value output -->
    <Entry ... />
    <Label x:Name="tipOutput"   Text="0.00" TextColor="Navy" FontSize="22"   ... />
    <Label x:Name="totalOutput" Text="0.00" TextColor="Navy" FontSize="22"   ... />
    ```

    Consider the work involved in modifying the **TextColor** and **FontSize** values. You would need to change it in five places.

## Define resources

Now let's create resources in XAML, so you can start eliminating some of the repeated code that you found in the application.

1. Open the **StandardTipPage.xaml** file.

1. Define a **Color** resource inside a **ContentPage.Resources** section. Give the resource an **x:Key** resource ID of **bgColor** and the value **#C0C0C0** (you could also use the name of the color `Silver`).

1. Define a second **Color** resource. Give it an **x:Key** resource ID of **fgColor** and the value **#0000AD** (you could also use the name of the color `Navy`).

1. Define an **x:Double** resource with an ID of **fontSize**. Set the value of this resource to **22**.  

    ```XML
    <ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
                 ...>
    
        <ContentPage.Resources>
            <ResourceDictionary>
                <Color x:Key="bgColor">#C0C0C0</Color>
                <Color x:Key="fgColor">#0000AD</Color>
                <x:Double x:Key="fontSize">22</x:Double>
            </ResourceDictionary>
        </ContentPage.Resources>
    
        <Grid x:Name ="LayoutRoot" ...>
            ...
    ```

## Use static resources

Now, let's apply the resources that you created.

1. Use the **StaticResource** mark-up extension to apply the **bgColor** resource to the **Background** property of the **LayoutRoot** **Grid** control.

     ```XML
    ...
    <Grid x:Name ="LayoutRoot" BackgroundColor="{StaticResource bgColor}" Padding="10">
    ```

1. Apply the **fgColor** resource to the **TextColor** property of all the **Label** controls that currently set the **TextColor** to Navy. Additionally, replace the hard-coded font size with the **fontSize** static resource.

    ```XML
    ...
    <!-- Left column = static labels -->
    <Label x:Name="billLabel"  Text="Bill"  TextColor="{StaticResource fgColor}" FontSize="{StaticResource fontSize}" ... />
    <Label x:Name="tipLabel"   Text="Tip"   TextColor="{StaticResource fgColor}" FontSize="{StaticResource fontSize}" ... />
    <Label x:Name="totalLabel" Text="Total" TextColor="{StaticResource fgColor}" FontSize="{StaticResource fontSize}" ... />
    ...
    ```

1. Run the application. Verify that **StandardTipPage** still displays dark text on a light background at startup, as it did before.

> [!NOTE]
> Don't worry about the styling for **CustomTipPage** or the **Light** and **Dark** themes at this point; you'll address these issues later.
