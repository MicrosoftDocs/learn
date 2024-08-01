In this exercise, you use a .NET MAUI application to see the effect of the four primary layout options when applied to a view contained in a `Grid`. You don't write code in the exercise. Instead, you use the provided solution and select buttons to change the layout options of a label.

[!include[](../../../includes/dotnet8-sdk-version.md)]

## Open the starter solution

1. Clone or download the exercise repo from [GitHub](https://github.com/microsoftdocs/mslearn-dotnetmaui-customize-xaml-pages-layout).

    > [!NOTE]
    > It is best to clone or download the exercise content to a short folder path, such as C:\dev\, to avoid build-generated files exceeding the maximum path length.

1. Open the starter solution from the **exercise1/Alignment** folder by using Visual Studio or this folder in Visual Studio Code.

## Test the application behavior

Run the app to test `LayoutOptions` and see how the different layout options change the size and position of the label.

1. Test the app by interacting with the buttons that change the horizontal and vertical `LayoutOptions`. Select them and observe what happens. The following image shows what happens if you select **Center** for both the Horizontal and Vertical alignment options:

   :::image type="content" source="../media/3-layout-android.png" alt-text="Screenshot of the Alignment app running on an Android device. The alignment option Center is selected for both Horizontal and Vertical alignment.":::

   The alignment options (`Start`, `Center`, `End`, and `Fill`) can change both the size and the alignment of a view.
