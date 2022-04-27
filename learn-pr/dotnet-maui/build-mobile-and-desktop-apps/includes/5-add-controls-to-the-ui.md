Having used the .NET MAUI template to create the application, the next step is to add the user interface and implement the initial UI logic.

In this unit, you'll learn more about the building blocks of a .NET MAUI application and navigation structures.

## What's in a .NET MAUI project?

To recap, a .NET MAUI project initially contains:

- The **MauiProgram.cs** file that contains the code for creating and configuring the Application object.

- The **App.xaml** and **App.xaml.cs** files that provide UI resources and create the initial window for the application.

- The **MainPage.xaml** and **MainPage.xaml.cs** file that define the layout and UI logic for the page displayed by default in the initial window.

You can add further pages to the app as necessary, and you can create additional classes to implement the business logic required by the app.

A .NET MAUI project also contains a default set of application resources such as images, icons, and fonts, and default bootstrap code for each platform.

## The Application class

The `App` class represents the .NET MAUI application as a whole. It inherits a default set of behaviors from `Microsoft.Maui.Controls.Application`. Recall from the previous unit that it's the `App` class that is instantiated and loaded by the bootstrap code for each platform. The constructor of the `App` class will, in turn, usually create an instance of the `MainPage` class and assign it to the `MainPage` property. It's this code that controls the first screen the user sees.

The App class also contains:

- Methods for handling life-cycle events, including when the app is sent to the background (that is, when it ceases to be the foreground app).

- Events to respond to changes in the modal stack (this is a type of navigation, discussed in another module).

- A property called `Properties`. This is a `PropertyBag` that automatically persists any data added to it.

## Pages

Pages are the root of the UI hierarchy in .NET MAUI. The solution you've seen so far included a class called `MainPage`. This class derives from `ContentPage`, which is the simplest and most common page type. A content page simply displays its contents. .NET MAUI has several other built-in page types, too, including the following:

- `NavigationPage`: This adds the familiar navigation bar to the top of the screen, but more importantly manages a navigation stack. This stack allows the user to navigate backward to previous screens.

- `TabbedPage`: This is the root page used for tab navigation. A tabbed page contains child page objects; one for each tab.

- `FlyoutPage`: This page enables you to implement a master/detail style presentation. A flyout page contains a list of items. When you select an item, a view displaying the details for that item appears.

Other page types are available, and are mostly used for enabling different navigation patterns in multi-screen apps. These patterns are described in another module.

## Views

A content page typically displays a view. A view enables you to retrieve and present data in a specific manner. The default view for a content page is a `ContentView`, which displays items as-is. If you shrink the view, items may disappear from the display until the view is resized. A `ScrollView` enables you to display items in a scrolling window; if you shrink the window you can scroll up and down to display items. A `CarouselView` is a scrollable view that enables the user to swipe through a collection of items. A `CollectionView` can retrieve data from a named data source and present each item using a template as a format. There are many other types of view available as well.

> [!NOTE]
> The `ListView` control is supported for backwards compatibility with Xamarin.Forms apps through Xamarin renderers and **FormsCompatibility** mode. For new applications, use the `CollectionView` control.

## Controls and Layouts

A view can contain a single control such as a button, label, or text boxes. (Strictly speaking, a view is itself a control, so a view can contain another view.). However, a user interface restricted to a single control wouldn't be very useful, so controls are positioned in a layout. A layout defines the rules by which the controls are displayed relative to each other. A layout is also a control, so you can add it to a view. If you look at the default MainPage.xaml file, you'll see this page/view/layout/control hierarchy in action. In this XAML code, the `Grid` element is just another control that enables you to fine-tune the layout of other controls.

```xml
<ContentPage ...>
    <ScrollView ...>
        <StackLayout>
            <Grid ...>
                <Label ... />
                <Label ... />
                <Label ... />
                <Button ... />
                <Image ... />
            </Grid>
        </StackLayout>
    </ScrollView>
</ContentPage>
```

Some of the common controls used to define layouts are:

- `StackLayout`, which lays out controls in a top-to-bottom or left-to-right stack depending on an orientation property. The StackLayout has a property named `StackOrientation`, which you can set to `Horizontal` or `Vertical`. On a tablet or phone, modifying this property in your application code enables you to adjust the display if the user rotates the device:

    :::image type="content" source="../media/5-stacklayout-flow.png" alt-text="The horizontal and vertical orientations for the StackLayout":::

- `AbsoluteLayout`, which lets you set exact coordinates for controls.

- `FlexLayout`, which is similar to `StackLayout` except that it enables you to wrap the child controls it contains if they don't fit in a single row or column. This layout also provides additional options for alignment and adapting to different screen sizes. For example, a FlexLayout control can align its child control to the left, right, or center when arranged vertically. When aligned horizontally, controls can be justified to ensure even spacing. You could use a horizontal `FlexLayout` inside a `ScrollView` to display a horizontally scrollable series of frames (each frame could itself be a vertically arranged `FlexLayout`):

     :::image type="content" source="../media/5-flexlayout-example.png" alt-text="An example of an app running with the FlexLayout rendered to the screen. First an image is rendered, then a title, then a text label. All of those are located within a box.":::

- `Grid`, which lays out its controls according to a column and row location we set. You can define the column and row sizes as well as spans, so grid layouts don't necessarily have a "checkerboard look" to them.

The image below summarizes the key attributes of these common layout types:

:::image type="content" source="../media/5-layout-types.png" alt-text="The layouts most frequently used in a .NET MAUI U I. The stack layout shows 4 boxes arranged vertically. The absolute layout shows 4 boxes arranged on the screen exactly where the developer specified. The Flex Layout shows several boxes laid out on the screen to best make use of the screen area. The Grid layout shows several boxes on the screen laid out in a grid pattern.":::

All controls have properties. You can set initial values for these properties using XAML. In many cases, you can modify these properties in the C# code of your application. For example, the code that handles the `Clicked` event for the **Click me** button in the default .NET MAUI app looks like this:

```csharp
int count = 0;
private void OnCounterClicked(object sender, EventArgs e)
{
    count++;
    CounterLabel.Text = $"Current count: {count}";
}
```

This code modifies the `Text` property of the CounterLabel control in the page. You can even create entire pages, views, and layouts in your code; you don't have to use XAML. For example, consider the following XAML definition of a page:

```xml
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="Phoneword.MainPage"
             BackgroundColor="{DynamicResource PageBackgroundColor}">

    <ScrollView Padding="{OnPlatform iOS='30,60,30,30', Default='30'}">
        <StackLayout>
            <Grid RowSpacing="25" RowDefinitions="Auto,*">

                <Label Text="Current count: 0"
                    Grid.Row="0"
                    FontSize="18"
                    FontAttributes="Bold"
                    x:Name="CounterLabel"
                    HorizontalOptions="Center" />

                <Button Text="Click me"
                    Grid.Row="1"
                    Clicked="OnCounterClicked"
                    HorizontalOptions="Center" />
            </Grid>
        </StackLayout>
    </ScrollView>
</ContentPage>
```

The equivalent code in C# looks like this:

```csharp
public partial class TestPage : ContentPage
{
    int count = 0;
    
    // Named Label - declared globally to the class
    Label counterLabel = new Label()
    {
        Text = "Current count: 0",
        FontSize = 18,
        FontAttributes = FontAttributes.Bold,
        HorizontalOptions = LayoutOptions.Center
    };

    public TestPage()
    {
        this.BackgroundColor = Color.FromRgb(0xff, 0xff, 0xff);

        var myScrollView = new ScrollView()
        {
            Padding = new Thickness(30, 60, 30, 30)
        };

        var myStackLayout = new StackLayout();
        myScrollView.Content = myStackLayout;

        var myGrid = new Grid()
        {
            RowSpacing = 25,
            RowDefinitions = new RowDefinitionCollection()
        };
        myStackLayout.Add(myGrid);
        
        myGrid.RowDefinitions.Add(new RowDefinition()
        {
            Height = GridLength.Auto
        });
        myGrid.RowDefinitions.Add(new RowDefinition()
        {
            Height = GridLength.Star
        });

        Grid.SetRow(counterLabel, 0);
        myGrid.Children.Add(counterLabel);

        var myButton = new Button()
        {
            Text = "Click me",
            HorizontalOptions = LayoutOptions.Center
        };
        Grid.SetRow(myButton, 1);
        myGrid.Children.Add(myButton);
        myButton.Clicked += OnCounterClicked;

        this.Content = myScrollView;
    }

    private void OnCounterClicked(object sender, EventArgs e)
    {
        count++;
        counterLabel.Text = $"Current count: {count}";

        SemanticScreenReader.Announce(counterLabel.Text);
    }
}
```

The C# code is more verbose, but provides additional flexibility enabling you to adapt the UI dynamically.

To display this page when the application starts running, create a new instance of the `TestPage` class in the `App` constructor (in **App.xaml.cs**) and assign it to the `MainPage` property:

```csharp
public partial class App : Application
{
    public App()
    {
        InitializeComponent();

        MainPage = new TestPage();
    }
}
```

## Tuning a layout

It's useful to add a little *breathing space* around a control. Each control has a `Margin` property that's respected by the layouts. You can think of margin as the control pushing others away.

All the layouts also have a `Padding` property that keeps any of their children from getting close to the border of the layout. One way to think of this is that all the controls are in a box, and that box has padded walls.

Another useful whitespace setting the `Spacing` property of `StackLayout`. This is the space between all the children of the layout. This is additive with the control's own margin, so the actual whitespace will be margin plus spacing.
