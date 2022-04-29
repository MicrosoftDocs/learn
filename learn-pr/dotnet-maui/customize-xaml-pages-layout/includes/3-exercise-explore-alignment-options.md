In this exercise, you'll use a .NET MAUI application to see the effect of the four primary layout options when applied to a view contained in a `StackLayout`. You won't be writing code in the exercise. Instead, you'll use a solution that's provided to you and select buttons to change the layout options of a label.

## Open the starter solution

**TBD: REPLACE URL FOR GITHUB REPO BELOW**

1. Clone or download the exercise repo from [GitHub](https://github.com/ADD-REPO-HERE).

   > [!NOTE]
   > If you are planning to run and debug your .NET MAUI apps on Android from Windows, it is best to clone or download the exercise content to a short folder path, such as C:\dev\, to avoid build-generated files exceeding the maximum path length.

1. Open the starter solution from the **exercise1/start/Alignment** folder by using Visual Studio.

## Test the application behavior

Run the app to test `LayoutOptions` and see how the different layout options change the size and position of the label.

1. Run the application on either iOS or Android.

1. You'll see buttons that change the horizontal and vertical `LayoutOptions`. Select them and observe what happens. The image below shows what happens if you select the Horizontal Center alignment option:

:::image type="content" source="../media/3-layout-android.png" alt-text="The Alignment app running on an Android device. The user has selected the Horizontal Center alignment option.":::

>[!NOTE]
> The vertical options don't appear to have any effect.

## Examine the results

There are a couple interesting points to take away from this exercise.

- The alignment options (`Start`, `Center`, `End`, and `Fill`) can change both the size and the alignment of a view.

- The layout panel can overrule the view's alignment settings. For example, the outermost `StackLayout` has a vertical orientation. This causes the `StackLayout` to override the `VerticalOptions` of the label. In general, a `StackLayout` only respects the alignment preferences on child views that are in the opposite direction to the `StackLayout` orientation. This means, that to modify the `VerticalOptions` of the label, the `StackPanel` must have an orientation of `Horizontal`. However, this would then cause the `HorizontalOptions` of the label to be ignored.
