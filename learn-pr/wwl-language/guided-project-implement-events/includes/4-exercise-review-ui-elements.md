In this exercise, you'll replace the current `MainWindow.xaml` file contents with a newer version of that file. You'll then review the new UI Xaml elements. Lastly, you need to build the solution, to make sure that it works with the new version of `MainWindow.xaml`.

## Replace MainWindow.xaml with a new version

1. Open `resources\MainWindow.xaml` file.

1. Press Ctrl-A, to select the entire contents of the file.

1. Press Ctrl-C, to copy the highlighted contents.

1. Highlight the contents of the existing `WPF\MainWindow.xaml` by pressing Ctrl-A while in the file.

1. Copy the contents of `resources\MainWindow.xaml` into the existing `WPF\MainWindow.xaml` by pressing Ctrl-V, to paste the contents into the file.

## Review the new UI XAML elements

Review the contents of your new `MainWindow.xaml` file. Note the `btnEditAnt` and `btnEditCellColor` buttons. These buttons will initiate the "Edit Ant" and "Edit field cell color" modes we'll implement later. The `btnBackToGame` button will exit the other modes.

1. Review the `btnEditAnt` button.

    ```cshsarp
    <Button x:Name="btnEditAnt">
        <TextBlock Text="🐜 Ant"/>
    </Button>              
    ```

1. Review the `btnEditCellColor` button.

    ```csharp
    <Button x:Name="btnEditCellColor">
        <TextBlock Text="🎨 Cell Color"/>
    </Button>
    ```

1. Review the `btnBackToGame` button.

    ```csharp
    <Button x:Name="btnBackToGame" Visibility="Collapsed">
        <TextBlock Text="❌ Back" />
    </Button>
    ```

The other elements, including `WrapPanel`, `pnlRuleText`, and buttons `btnEditRuleStart`, `btnEditRuleApply`, `btnEditRuleCancel`, and `txtEditRule` support editing generalized Langton's Ant rules. Other changes are cosmetic and not important for how the form functions.

## Check your work

Build the solution to make sure the new `MainWindow.xaml` is working correctly. Enter `dotnet build` and press Enter. If your program builds, you have completed this exercise.