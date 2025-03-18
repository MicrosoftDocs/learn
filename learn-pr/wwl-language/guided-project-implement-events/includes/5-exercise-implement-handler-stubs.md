In this exercise, you'll connect handlers to the new UI elements. We'll start with editing Ants' rule and then will implement editing game field and Ants' state.

## Implement an event handler for the btnEditRuleStart button

1. Locate the button `btnEditRuleStart` in the MainWindow.xml file.

    ```csharp
    <Button x:Name="btnEditRuleStart">
        <TextBlock Text="✏ Edit"/>
    </Button>
    ```

1. Add a click event to the button.

    ```csharp
    <Button x:Name="btnEditRuleStart" Click="btnEditRuleStart_Click">
        <TextBlock Text="✏ Edit"/>
    </Button>
    ```

1. Add a corresponding click event method to `MainWindow.xaml.cs` in the `#region Event Handlers` section.

    ```csharp
    private void btnEditRuleStart_Click(object sender, RoutedEventArgs e)
    {
    
    }
    ```

1. Build the solution to confirm that the code still builds
    1. Select View --> Terminal to open a terminal window.
    1. Change your directory to `Starter\WPF` by entering `cd Starter\WPF` and press Enter.
    1. Enter `dotnet build` and press Enter.

## Create event handlers for the btnEditRuleApply and btnEditRuleCancel buttons

You also need to create event handlers for applying and canceling a rule. Here you add a click event for each of the two buttons in `MainWindow.xaml` and a code-behind click event for each in `MainWindow.xaml.cs`.

1. Locate the `btnEditRuleApply` button in the ToolBar code of `MainWindow.xaml`.

1. Add this click event `Click="btnEditRuleApply_Click"` to the `btnEditRuleApply` button, as shown.

    ```csharp
    <Button x:Name="btnEditRuleApply"  Click="btnEditRuleApply_Click" Visibility="Collapsed">
        <TextBlock Text="✔ Apply"/>
    </Button>
    ```

1. Add the code-behind method for the event.
    1. Open the `MainWindow.xaml.cs` to the Event Handlers region.
    1. Add the following event for the `btnEditRuleApply` button.

    ```csharp
    private void btnEditRuleApply_Click(object sender RoutedEventArgs e)
    {

    }
    ```

1. Locate the `btnEditRuleCancel` button in the ToolBar code of `MainWindow.xaml`.

1. Add this click event `Click="btnEditRuleCancel_Click"` to the `btnEditRuleCancel` button, as shown.

    ```csharp
    <Button x:Name="btnEditRuleCancel"  Click="btnEditRuleCancel_Click" Visibility="Collapsed">
        <TextBlock Text="✔ Apply"/>
    </Button>
    ```

1. Add the code-behind method for the event.
    1. Open the `MainWindow.xaml.cs` to the Event Handlers region.
    1. Add the following event for the `btnEditRuleCancel` button.

    ```csharp
    private void btnEditRuleCancel_Click(object sender RoutedEventArgs e)
    {

    }
    ```

## Add a handler for btnEditAnt Button

The next button you need to add a click event for is `btnEditAnt`. First locate the button in `MainWindow.xaml`, then add the click event method in the `MainWindow.xaml.cs` file.

1. Add a click event to `btnEditAnt`, as shown here.

    ```csharp
    <Button x:Name="btnEditAnt" Click="btnEditAnt_Click">
        <TextBlock Text="🐜 Ant"/>
    </Button>
    ```

1. Add the click event handler method to the `MainWindow.xaml.cs` file.

    ```csharp
    private void btnEditAnt_Click(object sender, RoutedEventArgs e)
    {
    
    }
    ```

## Add handler for btnEditCellColor Button

The next button you need to add a click event for is `btnEditCellColor`. First locate the button in `MainWindow.xaml`, then add the click event method in the `MainWindow.xaml.cs` file.

1. Add a click event to `btnEditCellColor`, as shown here.

    ```csharp
    <Button x:Name="btnEditCellColor" Click="btnEditCellColor_Click">
        <TextBlock Text="🎨 Cell Color"/>
    </Button>
    ```

1. Add the click event handler method to the `MainWindow.xaml.cs` file.

    ```csharp
    private void btnEditCellColor_Click(object sender, RoutedEventArgs e)
    {
    
    }
    ```

## Add handler for btnBackToGame Button

The next button you need to add a click event for is `btnBackToGame`. First locate the button in `MainWindow.xaml`, then add the click event method in the `MainWindow.xaml.cs` file.

1. Add a click event to `btnEditCellColor`, as shown here.

    ```csharp
    <Button x:Name="btnBackToGame" Click="btnBackToGame_Click">
        <TextBlock Text="🎨 Cell Color"/>
    </Button>
    ```

1. Add the click event handler method to the `MainWindow.xaml.cs` file.

    ```csharp
    private void btnBackToGame_Click(object sender, RoutedEventArgs e)
    {
    
    }
    ```

1. Enter Ctrl-S and press Enter to save your work.

## Check your work

1. Select View --> Terminal to open a terminal window.

1. Change directory to `Starter\WPF`, if you aren't already in it.

1. Enter `dotnet build`.

If your code builds, congratulations on a job well done! If not, go back through the exercise and repeat the steps. You may have missed a step.