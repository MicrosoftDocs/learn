WinUI applications benefit from using styles and resource dictionaries to create consistent and maintainable user interfaces. This section explores how to implement these features effectively.

Styles define the visual appearance of controls. You can apply styles in two ways:

1. Inline: Directly on a specific control
2. As a reusable resource: Stored in a resource dictionary

For example, here's a TextBlock with inline styling:

```xaml
<TextBlock 
    Text="SnowPal" 
    Grid.ColumnSpan="2" 
    FontSize="40" 
    HorizontalAlignment="Center" 
    VerticalAlignment="Top" />
```

While inline styles work, they can make XAML code lengthy and complex. For better maintainability, it's preferable to use resource dictionaries.

A resource dictionary is a repository for XAML resources, including styles, templates, and other reusable elements. These dictionaries offer several advantages:

- Centralized management of styles
- Improved consistency across the application
- Enhanced reusability and maintainability

You can define resource dictionaries in:

- Individual page XAML files
- The App.xaml file
- Separate resource dictionary files

The scope of a resource depends on its location:

- Page-level resources: Accessible only within that page
- App-level resources: Available application-wide
When conflicts occur, page-level resources take precedence over app-level ones.

The example code above can look like this with Resource dictionary:

- Resource dictionary, styles.xaml:

```xaml
<Style x:Key="TitleTextStyle" TargetType="TextBlock">
    <Setter Property="FontFamily" Value="Segoe UI"/>
    <Setter Property="FontSize" Value="48"/>
    <Setter Property="FontWeight" Value="Bold"/>
    <Setter Property="HorizontalAlignment" Value="Center"/>
    <Setter Property="VerticalAlignment" Value="Top"/>
    <Setter Property="Margin" Value="0,50,0,0"/>
</Style>
```

- XAML, GamePage.xaml:

```xaml
<TextBlock 
    Text="SnowPal" 
    Style="{StaticResource TitleTextStyle}" 
    Grid.ColumnSpan="2"/>
```

> [!NOTE]
> If you’re a web developer; resource dictionaries in WinUI apps are similar to CSS stylesheets in web development. They provide a centralized way to define and manage reusable styles, templates, and other resources like colors, fonts, and layouts across the entire application. Just as you might use CSS classes or variables to maintain consistency in a website's design, resource dictionaries allow you to achieve the same consistency in a WinUI app.

## View

Create the Resource Dictionary file called Styles:

3. In the Solution Explorer **Right click** on the **project** > **Add** > **New Item....**  

:::image type="content" source="../media/7-style/add-new-item.png" alt-text="Screenshot of Visual Studio adding a new item.":::

4. In the **Add New Item** dialog, select **WinUI**in the template list on the left-side of the window.

5. Select the **Resource Dictionary (WinUI 3)**

:::image type="content" source="../media/7-style/add-style-file.png" alt-text="Screenshot of Visual Studio adding a Resource Dictionary.":::

6. Name the file **Styles.xaml**
7. **Click Add**
8. **Replace** the code with:

```xaml
<ResourceDictionary
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">

    <!-- Define a style for Title TextBlock -->
    <Style x:Key="TitleTextStyle" TargetType="TextBlock">
        <Setter Property="FontFamily" Value="Segoe UI"/>
        <Setter Property="FontSize" Value="48"/>
        <Setter Property="FontWeight" Value="Bold"/>
        <Setter Property="HorizontalAlignment" Value="Center"/>
        <Setter Property="VerticalAlignment" Value="Top"/>
        <Setter Property="Margin" Value="0,50,0,0"/>
    </Style>

    <!-- BUTTONS -->
    <!-- Define a style for Bass Buttons -->
    <Style x:Key="BaseButton" TargetType="Button">
        <Setter Property="FontFamily" Value="Segoe UI"/>
        <Setter Property="FontSize" Value="20"/>
        <Setter Property="Margin" Value="2"/>
    </Style>

    <!-- Define a style for Alphabet Buttons -->
    <Style x:Key="AlphabetButton" TargetType="Button" BasedOn="{StaticResource BaseButton}">
        <Setter Property="Width" Value="48"/>
        <Setter Property="Height" Value="48"/>
        <Setter Property="FontSize" Value="25"/>
    </Style>
    <!-- Define a style for the Menu Buttons -->
    <Style x:Key="MenuButton" TargetType="Button" BasedOn="{StaticResource BaseButton}">
        <Setter Property="Width" Value="200"/>
        <Setter Property="Height" Value="50"/>
    </Style>
    <!-- Define a style for the Popup Buttons -->
    <Style x:Key="PopupButton" TargetType="Button" BasedOn="{StaticResource BaseButton}">
        <Setter Property="HorizontalAlignment" Value="Right"/>
    </Style>

    <!-- TextBlock -->
    <!-- Define a style for TextBlock -->
    <Style x:Key="BaseTextBlock" TargetType="TextBlock">
        <Setter Property="FontSize" Value="24"/>
        <Setter Property="TextWrapping" Value="Wrap"/>
    </Style>

    <!-- Define a style for the Word Display TextBlock -->
    <Style x:Key="LargerTextBlock" TargetType="TextBlock" BasedOn="{StaticResource BaseTextBlock}">
        <Setter Property="FontSize" Value="40"/>
        <Setter Property="HorizontalAlignment" Value="Center"/>
        <Setter Property="VerticalAlignment" Value="Bottom"/>
        <Setter Property="Margin" Value="10"/>
    </Style>

    <!-- Popup -->
    <!-- Define a style for the Popup -->
    <Style x:Key="PopupStyle" TargetType="Popup">
        <Setter Property="VerticalOffset" Value="300"/>
        <Setter Property="HorizontalOffset" Value="800"/>
    </Style>


    <!-- StackPanel -->
    <!-- Define a base Center style for StackPanel  -->
    <Style x:Key="CenterStackPanel" TargetType="StackPanel">
        <Setter Property="HorizontalAlignment" Value="Center"/>
        <Setter Property="VerticalAlignment" Value="Center"/>
        <Setter Property="Spacing" Value="12"/>
    </Style>
    <!-- Define a Horizontal for StackPanel  -->
    <Style x:Key="HorizontalCenterStackPanel" TargetType="StackPanel" BasedOn="{StaticResource CenterStackPanel}">
        <Setter Property="Orientation" Value="Horizontal"/>
    </Style>
    <!-- Define a Vertical for StackPanel  -->
    <Style x:Key="VerticalCenterStackPanel" TargetType="StackPanel" BasedOn="{StaticResource CenterStackPanel}">
        <Setter Property="Orientation" Value="Vertical"/>
    </Style>


    <!-- Image -->
    <!-- Define style for Image -->
    <Style x:Key="ImageStyle" TargetType="Image">
        <Setter Property="HorizontalAlignment" Value="Center"/>
        <Setter Property="VerticalAlignment" Value="Top"/>
        <Setter Property="Margin" Value="10,10,10,10"/>
    </Style>


    <!-- GridView -->
    <!-- Define style for GridView -->
    <Style x:Key="GridViewStyle" TargetType="GridView">
        <Setter Property="HorizontalAlignment" Value="Center"/>
        <Setter Property="VerticalAlignment" Value="Center"/>
        <Setter Property="Margin" Value="10,50,10,10"/>
    </Style>
    <!-- Define style for GridView -->
    <Style x:Key="GridStyle" TargetType="Grid">
        <Setter Property="HorizontalAlignment" Value="Left"/>
        <Setter Property="VerticalAlignment" Value="Top"/>
    </Style>

    <!-- Border -->
    <!-- Define style for Border -->
    <Style x:Key="BorderStyle" TargetType="Border">
        <Setter Property="Padding" Value="20"/>
        <Setter Property="CornerRadius" Value="8"/>
        <Setter Property="Width" Value="500"/>
        <Setter Property="Height" Value="400"/>
        <Setter Property="BorderThickness" Value="2"/>
    </Style>

    <!-- Colors -->
    <!-- Theme Dictionaries -->
    <ResourceDictionary.ThemeDictionaries>
        <!-- Light Theme -->
        <ResourceDictionary x:Key="Light">
            <Color x:Key="GradientStop1">#FFFFFF</Color>
            <Color x:Key="GradientStop2">#ADD8E6</Color>
            <Color x:Key="GradientStop3">#C9E4CA</Color>
        </ResourceDictionary>

        <!-- Dark Theme -->
        <ResourceDictionary x:Key="Dark">
            <Color x:Key="GradientStop1">#1E1E1E</Color>
            <Color x:Key="GradientStop2">#2A2A72</Color>
            <Color x:Key="GradientStop3">#3A3A3A</Color>
        </ResourceDictionary>
    </ResourceDictionary.ThemeDictionaries>

</ResourceDictionary>
```

> [!NOTE]
> The Style.xaml contains styling for elements that will be added later in the module.

The `x:Key` attribute is used to uniquely identify each style within the resource dictionary, allowing developers to reference and apply these styles to specific controls in the application. For example, `x:Key="MyButtonStyle1"` assigns a name to a button style, making it accessible via `{StaticResource MyButtonStyle1}`in the UI XAML. The `TargetType`attribute specifies the type of control the style applies to, such as Button, ensuring that the style settings are relevant to the intended control.

For situations where you want to use similar styles but with a slight variation, you can use inheritance. For example, in this code example, we have a `BaseTextBlock`, which contains all the styling for the TextBlocks. But for a Word Display element, the text should be larger font and centered. So, the `LargerTextBlock` can use the `BasedOn` property with `BaseTextBlock` to inherit all of its styles but uses the larger font and is centered. This style-management approach features reuse and inheritance. These features simplify the process and reduce duplication of styles. This simplification technique leads to consistent controls, while also permitting customization for specific needs.

Add `Styles` Resource Dictionary to `App.xaml`:

9. In the Solution Explorer open `App.xaml`
10. Under ` <!-- Other merged dictionaries here -->` add:

```xaml
<ResourceDictionary Source="Styles.xaml"/>
```

This makes the resources in styles.xaml available throughout your entire application.

Use the Styles in Your UI:

11. In the Solution Explorer open `GamePage.xaml`
12. Replace the grid with the following code:

```xaml

<Grid Background="{ThemeResource ApplicationPageBackgroundThemeBrush}">
    <Grid.RowDefinitions>
        <RowDefinition Height="Auto"/>
        <RowDefinition Height="*"/>
        <RowDefinition Height="Auto"/>
        <RowDefinition Height="Auto"/>
    </Grid.RowDefinitions>
    <Grid.ColumnDefinitions>
        <ColumnDefinition Width="50*"/>
        <ColumnDefinition Width="50*"/>
    </Grid.ColumnDefinitions>

    <!-- Title -->
    <TextBlock Text="SnowPal" Style="{StaticResource TitleTextStyle}" Grid.ColumnSpan="2"/>

    <!-- Drawing -->
    <Image x:Name="Image" Grid.Row="1" Grid.Column="0" Style="{StaticResource ImageStyle}" Source="/Assets/Wide310x150Logo.png"/>

    <!-- Guesses Left Display -->
    <StackPanel Grid.Row="1" Grid.Column="1">
        <StackPanel Style="{StaticResource HorizontalCenterStackPanel}">
            <TextBlock Text="Guesses Left: " Style="{StaticResource BaseTextBlock}"/>
            <TextBlock Text="{x:Bind ViewModel.GuessesLeft, Mode=OneWay}" Style="{StaticResource BaseTextBlock}"/>
        </StackPanel>
    </StackPanel>

    <!-- Alphabet Buttons -->
    <GridView x:Name="AlphabetButtonsGridView" Grid.Row="1" Grid.Column="1" Style="{StaticResource GridViewStyle}" 
          ScrollViewer.HorizontalScrollMode="Enabled"
          ScrollViewer.HorizontalScrollBarVisibility="Auto"
          ScrollViewer.VerticalScrollMode="Disabled"
          ScrollViewer.VerticalScrollBarVisibility="Hidden"
          ItemsSource="{x:Bind ViewModel.Letters}">
        <GridView.ItemsPanel>
            <ItemsPanelTemplate>
                <ItemsWrapGrid Orientation="Horizontal" MaximumRowsOrColumns="5"/>
            </ItemsPanelTemplate>
        </GridView.ItemsPanel>
        <GridView.ItemTemplate>
            <DataTemplate x:DataType="local:GameLetter">
                <Button Content="{x:Bind Character}" IsEnabled="{x:Bind IsAvailable, Mode=OneWay}" Style="{StaticResource AlphabetButton}" CommandParameter="{x:Bind Character}"
                    Command="{Binding ViewModel.LetterGuessedCommand, ElementName=ThisPage}"/>
            </DataTemplate>
        </GridView.ItemTemplate>
    </GridView>

    <!-- Word Display Area -->
    <TextBlock x:Name="Word" Grid.Row="2" Grid.ColumnSpan="2" Text="{x:Bind ViewModel.WordDisplay, Mode=OneWay}" Style="{StaticResource LargerTextBlock}"/>

    <!-- Popup for message -->
    <Grid x:Name="Output" Style="{StaticResource GridStyle}">
        <Popup x:Name="StandardPopup" Style="{StaticResource PopupStyle}" IsLightDismissEnabled="False" IsOpen="{x:Bind ViewModel.PopUpToDisplay, Mode=OneWay}">
            <Border Style="{StaticResource BorderStyle}" BorderBrush="{ThemeResource SurfaceStrokeColorDefaultBrush}" Background="{ThemeResource AcrylicBackgroundFillColorDefaultBrush}">
                <StackPanel Style="{StaticResource VerticalCenterStackPanel}">
                    <TextBlock Text="{x:Bind ViewModel.MessageTitle, Mode=OneWay}" Style="{StaticResource LargerTextBlock}" />
                    <TextBlock Text="{x:Bind ViewModel.MessageContent, Mode=OneWay}" Style="{StaticResource BaseTextBlock}"/>
                    <Button Content="Close" Command="{Binding ViewModel.ClosePopupClickedCommand, ElementName=ThisPage}" Style="{StaticResource PopupButton}"/>
                </StackPanel>
            </Border>
        </Popup>
    </Grid>
</Grid>
```

The code applies various predefined styles to different UI elements, such as TextBlocks, Images, StackPanels, and Buttons, using the `{StaticResource}` syntax. These styles, likely defined in separate resource dictionary files, centralize the styling logic and promote consistency across the application. Theme-aware resources, accessed via {ThemeResource}, are used for elements like the main Grid's background and the Popup's Border, allowing the UI to adapt seamlessly to light or dark themes. By using styles and resource dictionaries, this XAML structure enhances maintainability, enables easy updates to the application's appearance, and ensures a cohesive visual design throughout the user interface. This approach exemplifies best practices in WinUI development, separating design from structure and facilitating efficient UI management.

Now you can Run app in Debug mode by doing the following steps:

13. On the title bar, **click** on **Debug**, **click** on **Start Debugging** OR on your keyboard press **F5** key

You should see something like this:

:::image type="content" source="../media/7-style/game-with-style.png" alt-text="Screenshot of game with styles added.":::

By using styles and resource dictionaries in your WinUI applications, you create more maintainable and visually consistent user interfaces. These powerful tools separate design from structure, allowing for centralized management of styles and easy updates across your entire app. As you continue to develop with WinUI, remember that effective use of styles and resource dictionaries is a key practice for creating professional, scalable applications.
