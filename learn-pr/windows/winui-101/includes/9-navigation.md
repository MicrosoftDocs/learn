Most game apps don't just start the game, they open to a main Menu. In this section, you learn how to navigate from one page to another. The MainWindow will point to the Menu page where the user can select from different options. When the user select to start the game, the page changes to the GamePage, where we have the core gameplay at. Since the new Menu page has minimum functionality, instead of using the MVVM you'll use code behind for a different developer experience.

## View

1. In the Solution Explorer, **right click** on the **Pages Folder** > **Add** > **New Item....**  
2. In the Add New Item dialog, select **WinUI** in the template list on the left-side of the window
3. Select the **Blank Page (WinUI 3) template**
4. Name the file **MenuPage.xaml**
5. **Click Add**
6. In the `Page element`, **remove**:

```xaml
Background="{ThemeResource ApplicationPageBackgroundThemeBrush}">
```

7. Replace the `Grid` element with the following code:

```xaml
<Page.Background>
    <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
        <GradientStop Offset="0.0" Color="{StaticResource GradientStop1}" />
        <GradientStop Offset="0.5" Color="{StaticResource GradientStop2}" />
        <GradientStop Offset="1.0" Color="{StaticResource GradientStop3}" />
    </LinearGradientBrush>
</Page.Background>

<Grid>

    <!-- Title -->
    <TextBlock Text="SnowPal" Style="{StaticResource TitleTextStyle}" />

    <!-- Menu Buttons -->
    <StackPanel HorizontalAlignment="Center" VerticalAlignment="Center" Spacing="20">
        <Button Content="New Game" Style="{StaticResource MenuButton}" Click="NewGame_Click"/>
        <Button Content="Leaderboard" Style="{StaticResource MenuButton}" Click="Leaderboard_Click"/>
        <Button Content="Options" Style="{StaticResource MenuButton}" Click="Options_Click"/>
        <Button Content="Credits" Style="{StaticResource MenuButton}" Click="Credits_Click"/>
        <Button Content="Exit" Style="{StaticResource MenuButton}" Click="Exit_Click"/>
    </StackPanel>
</Grid>
```

The `Page.Background` creates a gradient background with white, light blue, and light green. The Grid contains 5 buttons that use Click events to the code behind (`MenuPage.xaml.cs`)

8. In the Solution Explorer, open `MenuPage.xaml.cs`

> [!NOTE]
> If you don't see `MenuPage.xaml.cs`, click on the drop-down arrow next to `MenuPage.xaml` to display `MenuPage.xaml.cs`

9. Under the `MenuPage()` constructor, add the following methods:

```csharp
private void NewGame_Click(object sender, RoutedEventArgs e)
{
    // Navigate to the GamePage
    Frame.Navigate(typeof(GamePage));
}

private void Leaderboard_Click(object sender, RoutedEventArgs e)
{
    // TODO: Navigate to the Leaderboard page
}

private void Options_Click(object sender, RoutedEventArgs e)
{
    // TODO: Navigate to the Options page
}

private void Credits_Click(object sender, RoutedEventArgs e)
{
    // TODO: Navigate to the Credits page
}

private void Exit_Click(object sender, RoutedEventArgs e)
{
    Application.Current.Exit();
}
```

These methods are the code behind event handlers. Currently the `NewGame_Click` uses `Frame.Navigate()` to navigate to the GamePage, which is where the game itself is played, the `Exit_Click` closes the application and the other 3 don't currently do anything.

10. In the Solution Explorer, open `MainWindow.xaml.cs`
11. In the MainWindow constructor, replace the `MenuPage` with `GamePage`

```csharp
MainFrame.Navigate(typeof(MenuPage));
```

12. On the title bar, **click** on **Debug**, **click** on **Start Debugging** OR on your keyboard press **F5** key

You should see something like this:

:::image type="content" source="../media/9-navigation/main-menu.png" alt-text="Screenshot of game's main menu.":::

In this section, you successfully created a main menu page (`MenuPage.xaml`) with a visually appealing gradient background and added navigation buttons. You also implemented event handlers in the code behind (`MenuPage.xaml.cs`) to navigate to the game page (GamePage) and exit the application.
