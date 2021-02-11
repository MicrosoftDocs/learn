The Surface Duo dual-screen device can report the angle between the two screens. This information can be incorporated into your app's user interface, or be part of the input for a game experience.

## Get the hinge angle

You can retrieve the value of the hinge angle using the following code:

```csharp
var hingeAngle = await DualScreenInfo.Current.GetHingeAngleAsync();
```

## Detect hinge angle changes

To monitor the hinge angle as it changes, implement an event handler following these steps:

1. Configure the `HingeAngleChanged` event (such as in `OnAppearing`, and remove it in `OnDisappearing`):

    ```csharp
    DualScreenInfo.Current.HingeAngleChanged += DualScreen_HingeAngleChanged;
    ```

2. Implement the even handler to perform some action as the hinge angle changes. In this example, a label's text is updated with the current hinge angle:

    ```csharp
    void DualScreen_HingeAngleChanged(object sender, HingeAngleChangedEventArgs e)
    {
        Device.BeginInvokeOnMainThread(() =>
        {
            label.Text = e.HingeAngleInDegrees.ToString();
        });
    }
    ```

    > [!WARNING]
    > Constantly monitoring sensors such as the hinge angle can adversely affect battery life.
