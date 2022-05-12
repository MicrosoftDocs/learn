Engineers from your power utility company regularly make customer visits to repair appliances and perform other electrical maintenance tasks. Part of the app enables the engineer to make notes about the visit. It displays a simple editor  where the engineer can enter the details and save them.

On Android, the app looks like this:

:::row:::
    :::column:::
        :::image type="content" source="../media/5-android-app.png" alt-text="The engineer's app running on Android, showing the editor page":::
    :::column-end:::
    :::column:::
    :::column-end:::
:::row-end:::

You've been asked to add some further features to this page. Before you start, you want to understand how the page has been created, so you look at the source code. You notice that the UI has been created entirely using C# code. While this approach works, it intermingles the code that handles the layout with the code that controls the way in which the UI works. You realize that before long there's a danger of the two aspects of the app becoming locked together, making future maintenance difficult and possibly making the app more fragile as more features are added. You decide to separate the UI design from the UI logic by extracting the C# code that defines the layout from the app and replacing it with a XAML page.

## Review the existing app

1. Clone the [GitHub repository](https://github.com/microsoftdocs/mslearn-dotnetmaui-create-user-interface-xaml) for this exercise locally on your computer.

1. Move to the **exercise1** folder in your local copy of the repository.

1. Open the **Notes.sln** Visual Studio solution file in this folder.

1. In the **Solution Explorer** window, expand the **Notes** project, and open the **MainPage.xaml.cs** file.

1. Review the **MainPage** class defined in this file. The constructor contains the following code that creates the UI:

    ```csharp
    public MainPage()
    {
        var stackLayout = new VerticalStackLayout { Padding = new Thickness(30) };
        this.Content = stackLayout;
                
        var notesHeading = new Label() { Text = "Notes", HorizontalOptions = LayoutOptions.Center, FontAttributes = FontAttributes.Bold };

        editor = new Editor() { Placeholder = "Enter your note", HeightRequest = 100 };
        editor.Text = File.Exists(_fileName) ? File.ReadAllText(_fileName) : string.Empty;

        var buttonsGrid = new Grid() { HeightRequest = 40.0};
        buttonsGrid.ColumnDefinitions.Add(new ColumnDefinition() { Width = new GridLength(1.0, GridUnitType.Auto) });
        buttonsGrid.ColumnDefinitions.Add(new ColumnDefinition() { Width = new GridLength(30.0, GridUnitType.Absolute) });
        buttonsGrid.ColumnDefinitions.Add(new ColumnDefinition() { Width = new GridLength(1.0, GridUnitType.Auto) });
        Grid.SetRow(buttonsGrid, 2);
        mainGrid.Children.Add(buttonsGrid);

        var saveButton = new Button() { WidthRequest = 100, Text = "Save"};
        saveButton.Clicked += OnSaveButtonClicked;
        Grid.SetColumn(saveButton, 0);
        buttonsGrid.Children.Add(saveButton);

        var deleteButton = new Button() { WidthRequest = 100, Text = "Delete" };
        deleteButton.Clicked += OnDeleteButtonClicked;
        Grid.SetColumn(deleteButton, 2);
        buttonsGrid.Children.Add(deleteButton);

        ...
    }
    ```

    The UI comprises a `VerticalStackLayout` containing a `Grid`. The first two rows in the `Grid` contain a `Label` acting as a heading, and an `Editor` into which the user can enter notes. The third row in the `Grid` contains a child `Grid` with three columns. The first column holds the **saveButton** control, the second is a spacer, and the third column has the **deleteButton** control.

    The diagram below illustrates the structure of the UI:

    :::image type="content" source="../media/5-ui-layout.png" alt-text="A diagram of t structure of the UI for the Notes app. It shows a grid with 3 rows. The last row has 2 columns, the rest only have 1. The grid is hosted in a stack layout.":::

    Note the **MainPage** class also contains event-handling methods for the buttons, and some code that initializes the `Editor` control. This code isn't distinguished from the UI definition.

1. Build and run the app on Windows, just to see what it looks like. Return to Visual Studio when you've finished.

## Create a XAML version of the UI

1. Open the **MainPage.xaml** file. The markup in this page represents an empty MAUI content page:

    ```xml
    <ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
                 xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
                 x:Class="Notes.MainPage">

    </ContentPage>
    ```

1. Add a `VerticalStackLayout` control to the content page:

    ```xml
    <ContentPage ...>
        <VerticalStackLayout Margin="30,60,30,30">

        </VerticalStackLayout>
    </ContentPage>
    ```


1. Add a `Label` control to the `VerticalStackLayout`. Set the **Text**, **HorizontalTextAlignment**, and **FontAttributes** properties of this control as shown below:

    ```xml
    <ContentPage ...>
        <VerticalStackLayout ...>
            <Label Text="Notes"
                   HorizontalOptions="Center"
                   FontAttributes="Bold" />
        </VerticalStackLayout>
    </ContentPage>
    ```

1. Add an `Editor` control to the `VerticalStackLayout`:

    ```xml
    <ContentPage ...>
        <VerticalStackLayout ...>
            <Label .../>

            <Editor x:Name="editor"
                    Placeholder="Enter your note"
                    HeightRequest="100" />
        </VerticalStackLayout>
    </ContentPage>
    ```

1. Add a child `Grid` the `VerticalStackLayout`. This `Grid` should have three columns; the first and third are sized automatically, while the second has a width of 30:

    ```xml
    <ContentPage ...>
        <VerticalStackLayout ...>
            <Label .../>

            <Editor .../>

            <Grid ColumnDefinitions="Auto, 30, Auto">

            </Grid>
        </VerticalStackLayout>
    </ContentPage>
    ```

1. Add a `Button` to the first column of the child `Grid`. This is the **Save** button:

    ```xml
    <ContentPage ...>
        <VerticalStackLayout ...>
            <Grid ...>
                <Label .../>
    
                <Editor .../>

                <Grid ...>                    
                    <Button Grid.Column="0"
                            Text="Save" 
                            WidthRequest="100"
                            Clicked="OnSaveButtonClicked" />
                </Grid>
            </Grid>
        </VerticalStackLayout>
    </ContentPage>
    ```

1. Add another `Button` to the third column of the child `Grid`. This is the **Delete** button:

    ```xml
    <ContentPage ...>
        <VerticalStackLayout ...>
            <Grid ...>
                <Label .../>
    
                <Editor .../>

                <Grid ...>                    
                    <Button ... />

                    <Button Grid.Column="2"
                            Text="Delete" 
                            WidthRequest="100"
                            Clicked="OnDeleteButtonClicked" />
                </Grid>
            </Grid>
        </VerticalStackLayout>
    </ContentPage>
    ```

## Remove the layout code from the code-behind file

1. In the **Solution Explorer** window, expand the **MainPage.xaml** node, and open the **MainPage.xaml.cs** file.

1. Remove the **Editor** field from the **MainPage** class.

1. In the **MainPage.xaml.cs** file,  in the **MainPage** constructor, remove all the code that creates the user interface elements, and replace them with a call to the **InitializeComponent** method. Add code that checks whether the file used to store the notes exists, and if so, read the contents and populate the **Text** field of the **Editor** control. The constructor should look like this:

    ```csharp
    public partial class MainPage : ContentPage
    {
        string _fileName = Path.Combine(FileSystem.AppDataDirectory, "notes.txt");

        public MainPage()
        {
            InitializeComponent();

            if (File.Exists(_fileName))
            {
                editor.Text = File.ReadAllText(_fileName);
            }
        }

        ...
    }
    ```

1. On the **Build** menu, select **Rebuild Solution**. Verify that the app builds without any errors.

1. Run the application. It should function exactly as before.

1. If you have time, deploy and run the app using the Android emulator. The app UI should resemble that shown in the image at the start of this exercise.
