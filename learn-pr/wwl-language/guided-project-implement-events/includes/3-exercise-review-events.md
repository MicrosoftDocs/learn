In this exercise, you'll review the use of event handler registrations and how they're linked to code-behind pages. You'll also look at the event handler code in the code-behind page.

> [!IMPORTANT]
> You need to have completed the Setup instructions in the previous unit, Prepare, before you begin this Exercise.

## Event handler registrations

Open WPF\MainWindow.xaml and review existing event handlers registrations

1. Open the `WPF\MainWindow.xaml` file.

1. Review the existing event handler registrations by finding the `ToolBar` tag in the file.

    ```csharp
    <ToolBar ToolBarTray.IsLocked="True">
    <Button x:Name="btnPlay" Click="btnPlay_Click">
        <TextBlock Text="▶ Play"/>
    </Button>
        <Button x:Name="btnPause" Click="btnPause_Click">
        <TextBlock Text="⏸ Pause"/>
    </Button>
    <Button x:Name="btnStop" Click="btnStop_Click">
        <TextBlock Text="⏹ Stop"/>
    </Button>
                
    <Separator Margin="5px" />

    <Button x:Name="btnStepBackward" Click="btnStepBackward_Click"  >
        <TextBlock Text="🡄 Prev." />
    </Button>
    <Button x:Name="btnStepForward" Click="btnStepForward_Click">
        <TextBlock Text="🡆 Next" />
    </Button>
                
    <Separator Margin="5px" />
                
    <Button x:Name="btnSave" Click="btnSave_Click">
        <TextBlock Text="💾 Save" />
    </Button>
    <Button x:Name="btnLoad" Click="btnLoad_Click">
        <TextBlock Text="📂 Load" />
    </Button>
    </ToolBar>
    ```

1. Examine the buttons, for example the Play button.

    ```csharp
    <Button x:Name="btnPlay" Click="btnPlay_Click">
            <TextBlock Text="▶ Play"/>
        </Button>
    ```

The file `MainWindow.xaml`, typically called a `xaml` file (pronounced "zaml"), holds your UI elements. The code-behind file has code that acts on those UI elements. In this case, when someone selects the Play button in the zaml file, control passes to the code-behind file.

## Open the "code-behind" file WPF\MainWindow.xaml.cs and review handler code

Examine the *handler* for the Play button in code-behind file WPF\MainWindow.xaml.cs.

```csharp
private void btnPlay_Click(object sender, RoutedEventArgs e)
{
    PlayUIState = PlayUIMode.Playing;
}
```

Every UI element that does something when an event occurs has a code-behind handler code for that event. An event in this case can be a Click as shown here, a MouseDragEvent, or a CollectionChangedEvent, among many others. The concept of UI controls and attaching events to them is important. While not a core concept when it comes to programming, understanding how to manipulate controls in this way gives you a common and robust way of handling events.
