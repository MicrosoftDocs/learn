In this exercise, you'll use a Xamarin.Forms application to see the effect of the four primary layout options when applied to a view contained in a `StackLayout`. You won't be writing code in the exercise. Instead, you'll use a solution that's provided to you and select buttons to change the layout options of a label.

## Open the starter solution

To start, let's open the starter solution.

1. Open the **Alignment** project from the **exercise1** > **start** folder in your cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

    [!include[](../../../includes/android-windows-path-length-warning.md)]

## Test the application behavior

Let's run the app to test `LayoutOptions`. Your goal is to see how the different layout options change the size and position of the label.

1. Run the application on either iOS or Android.

1. You'll see buttons that change the horizontal and vertical `LayoutOptions`. Select them and observe what happens.

## Examine the results

There are a couple interesting points to take away from this exercise. First, notice that the alignment options (`Start`, `Center`, `End`, and `Fill`) can change both the size and the alignment of a view. Second, the layout panel can overrule the view's settings. For example, the vertical `StackLayout` completely ignores the `VerticalOptions` of the label.
