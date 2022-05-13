In this exercise, you'll use a .NET MAUI application to see the effect of the four primary layout options when applied to a view contained in a `Grid`. You won't be writing code in the exercise. Instead, you'll use a solution that's provided to you and select buttons to change the layout options of a label.

## Open the starter solution

1. Clone or download the exercise repo from [GitHub](https://github.com/microsoftdocs/mslearn-dotnetmaui-customize-xaml-pages-layout).

   > [!NOTE]
   > If you are planning to run and debug your .NET MAUI apps on Android from Windows, it is best to clone or download the exercise content to a short folder path, such as C:\dev\, to avoid build-generated files exceeding the maximum path length.

1. Open the starter solution from the **exercise1/Alignment** folder by using Visual Studio.

## Test the application behavior

Run the app to test `LayoutOptions` and see how the different layout options change the size and position of the label.

1. You'll see buttons that change the horizontal and vertical `LayoutOptions`. Select them and observe what happens. The image below shows what happens if you select the Horizontal and Vertical alignment option of Center:

   :::image type="content" source="../media/3-layout-android.png" alt-text="Screenshot of the Alignment app running on an Android device. The user has selected the Horizontal and Vertical Center alignment option.":::

   Note that the alignment options (`Start`, `Center`, `End`, and `Fill`) can change both the size and the alignment of a view.
