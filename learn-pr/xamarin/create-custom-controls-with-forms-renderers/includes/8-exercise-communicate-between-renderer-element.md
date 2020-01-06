In this exercise, you'll send notifications between the renderer and the shared code without tightly coupling the element and the renderer.

## Open the solution

This exercise continues where the previous one ended. You can use your existing solution or begin with the **exercise2** > **final** solution in your cloned or downloaded copy of the [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

## Send a message from the element

You need to clear the drawing surface when a user taps the clear/delete button. But you don't want to hold a reference from the element to the renderer, so you'll send a notification by using the built-in Messaging Center.

1. Open **SketchView.cs** in the shared project.

1. Create a public method named `Clear`.

1. Call `MessagingCenter.Send` with a message of "Clear".

    ```csharp
    public void Clear ()
    {
        MessagingCenter.Send(this, "Clear");
    }
    ```

1. Open **MainPage.xaml.cs**.

1. In the `OnClearClicked` method, call the new `Clear` method on `sketchView`.

## Subscribe to a message in the renderer

Take these steps in each platform-specific project that you want to support:

1. Open **SketchViewRenderer.cs**.

1. Create a new `void` method named `OnMessageClear` that accepts a `SketchView` parameter named `sender`. This method will be called when the Clear message is received.

1. You want to ensure that you respond only to messages from the element associated with this instance of the renderer. Check if `sender` matches `Element`. If it does, call the `Clear` method on `Control`.

    ```csharp
    void OnMessageClear(SketchView sender)
    {
        if (sender == Element)
            Control.Clear();
    }
    ```

1. Go to the `OnElementChanged` method.

1. After the native control is assigned, call `MessagingCenter.Subscribe` to subscribe to the Clear message and set `OnMessageClear` to the `Action` callback.

1. To clean up your code, override `Dispose` and `Unsubscribe` from these messages.

1. Run the app, draw something, and then tap the clear button.

```csharp
protected override void OnElementChanged(ElementChangedEventArgs e)
{
    if (Control == null)
    {
        ...
        MessagingCenter.Subscribe<SketchView>(this, "Clear", OnMessageClear);
    }
}

protected override void Dispose(bool disposing)
{
    if (disposing)
    {
        MessagingCenter.Unsubscribe<SketchView>(this, "Clear");
    }

    base.Dispose(disposing);
}
```

## Create a controller interface

Next, you'll send a notification from the platform-specific renderers to the Xamarin.Forms sketch view element. To send the notification, you'll add a public method on the element. But you want to raise it only from the renderers. To reduce discoverability, you'll define the method within an interface and explicitly implement it.

1. In the **XFDraw** shared project, create a new public interface named `ISketchController`.

1. Add a `void` method named `SendSketchUpdated` that doesn't accept any arguments.

```csharp
public interface ISketchController
{
    void SendSketchUpdated();
}
```

## Implement the controller interface

To notify the shared code, you'll create and raise a public event.

1. Open **SketchView.cs** in the shared project.

1. Explicitly implement `ISketchController`.

1. Add a new public event handler named `SketchUpdated`.

1. In `SendSketchUpdated`, invoke the `SketchUpdated` event.

```csharp
class SketchView : View, ISketchController
{
    ...
    public event EventHandler SketchUpdated;

    void ISketchController.SendSketchUpdated()
    {
        if(SketchUpdated != null)
            SketchUpdated(this, EventArgs.Empty);
    }
}
```

## Notify the element

Complete these steps in each platform-specific project:

1. Open **SketchViewRender.cs** and find the `OnElementChanged` method.

1. When the native control has been instantiated, subscribe to its `LineDrawn` event. Create a handler method named `PaintViewLineDrawn`.

1. In the `PaintViewLineDrawn` handler method, cast `Element` to `ISketchController` and call the explicitly defined `SendSketchUpdated` method.

```csharp
protected override void OnElementChanged(ElementChangedEventArgs e)
{
    ...
    paintView.LineDrawn += PaintViewLineDrawn;
}

private void PaintViewLineDrawn(object sender, System.EventArgs e)
{
    var sketchCon = (ISketchController)Element;

    if (sketchCon == null)
        return;

    sketchCon.SendSketchUpdated();
}
```

## Subscribe to the event

The final step is to subscribe to the event on the `SketchView` in the shared code. You'll use the event to disable the clear button if the drawing surface is blank. To control the enabled state of the `ToolbarItem`, you need to use a command. If you're familiar with commands, you can implement this on your own. Or you can use the provided code. Add the following code to **MainPage.xaml.cs** in the shared project:

1. Create a Boolean property named `IsCanvasDirty` with a backing field to track the state of the canvas. Define the command and call `ChangeCanExecute` on the command when the `IsCanvasDirty` property is updated.

    ```csharp
    public partial class MainPage : ContentPage
    {
        bool IsCanvasDirty
        {
            get { return isCanvasDirty; }
            set
            {
                isCanvasDirty = value;

                if (clearCommand != null)
                    clearCommand.ChangeCanExecute();
            }
        }
        bool isCanvasDirty;

        Command clearCommand;
        ...
    }
    ```

1. Subscribe to the `SketchUpdated` event and instantiate `clearCommand`. Assign the new command to the `trash` toolbar item. The command replaces the event handler. Delete the `Clicked` subscription.

    ```csharp
    public MainPage()
    {
        ...
        sketchView.SketchUpdated += OnSketchUpdated;

        clearCommand = new Command(OnClearClicked, () => { return IsCanvasDirty; });

        var trash = new ToolbarItem()
        {
            Text = "Clear",
            Icon = "trash.png",
            Command = clearCommand
        };
        ...
    }
    ```

1. In the constructor, subscribe to `sketchView`'s `SketchUpdated` event with an event handler method named `OnSketchUpdated`. When `OnSketchUpdated` is called, set `IsCanvasDirty` to `true`. When `OnClearClicked` is called, call `sketchView.Clear` and set `IsCanvasDirty` to `false`.

    ```csharp
    public MainPage()
    {
       ...
       sketchView.SketchUpdated += OnSketchUpdated;
    }

    void OnSketchUpdated(object sender, EventArgs e)
    {
        IsCanvasDirty = true;
    }

    void OnClearClicked ()
    {
        sketchView.Clear();
        IsCanvasDirty = false;
    }
    ```

1. Run the app.

## Summary

In this exercise, you sent notifications between the shared element and the platform-specific renderers without tightly coupling the renderer instance to the element. Specifically, you'll notify the platform-specific code to clear the drawing surface from the shared UI, and you'll notify the shared code when the drawing surface is updated.
