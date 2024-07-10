In this exercise, swap back to the "movie list" app you worked with in the previous exercise. This time, you'll convert the **Delete** menu's event handler to a command.

## Download and run the sample

[!include[](../../../includes/android-windows-path-length-warning-maui.md)]

To start this exercise module, download the [Movie List Sample](https://github.com/MicrosoftDocs/mslearn-dotnetmaui-mvvm1/raw/main/part6-exercise-start.zip) project. This project displays a list of movies. Clicking on a movie navigates to a detail page with more information about the movie.

1.  Download and extract the [Movie List Sample](https://github.com/MicrosoftDocs/mslearn-dotnetmaui-mvvm1/raw/main/part6-exercise-start.zip) project to a temporary folder.
1.  Navigate to the _part6-exercise2_ folder and open the _MovieCatalog.sln_ solution.
1.  Build and run the project to make sure it works. On the screen displayed, you'll see a list of movies. Right-click on one of the movies listed and the app navigates to a detail page.

## Examine the code
 
Open the **MovieCatalog** solution and open the _Views\\MovieListPage.xaml_ file. The `ListView` presents an item for each movie in the bound `Movies` collection. Each item defines a context menu to delete a movie:

```xaml
<ListView.ItemTemplate>
    <DataTemplate>
        <TextCell Text="{Binding Title}" x:DataType="vm:MovieViewModel">
            <TextCell.ContextActions>
                <MenuItem Text="Delete" IsDestructive="True" Clicked="MenuItem_Clicked" />
            </TextCell.ContextActions>
        </TextCell>
    </DataTemplate>
</ListView.ItemTemplate>
```

When the menu item is clicked, the `MenuItem_Clicked` is invoked and the movie is removed. The binding context of the menu item is the current movie, the `MovieViewModel` class. But the code for removing a movie is on the app's main viewmodel `MovieListViewModel`. The event handler considers this as it gets the menu item's binding context and sends it to the viewmodel's `DeleteMovie` method:

```csharp
private void MenuItem_Clicked(object sender, EventArgs e)
{
    MenuItem menuItem = (MenuItem)sender;
    ViewModels.MovieViewModel movie = (ViewModels.MovieViewModel)menuItem.BindingContext;
    App.MainViewModel.DeleteMovie(movie);
}
```

## Add a command

The first step in converting the event handler to a command is adding the command to the viewmodel. This command accepts a movie and removes it from the collection.

1.  In the **Solution Explorer** window, open the _ViewModels\\MovieListViewModel.cs_ file.
1.  Add the following property to the `MovieListViewModel` class:

    ```csharp
    public ICommand DeleteMovieCommand { get; private set; }
    ```

1.  Next, find the `MovieListViewModel` constructor and instantiate the command:

    ```csharp
    public MovieListViewModel()
    {
        Movies = [];
        DeleteMovieCommand = new Command<MovieViewModel>(DeleteMovie);
    }
    ```

    The `DeleteMovie` method already exists and accepts a `MovieViewModel` parameter. The command wraps that method and exposes it on the viewmodel.

1.  Open the _ViewModels\\MoviesListPage.xaml_ file.
1.  Update the `MenuItem` to binding the `Command` parameter to the `DeleteMovieCommand`. Pass the current binding context as the `CommandParameter`.

    ```xaml
    <MenuItem Text="Delete"
              IsDestructive="True"
              Command="{Binding DeleteMovieCommand, Source={x:Static local:App.MainViewModel}}"
              CommandParameter="{Binding}" />
    ```

    Notice that the `Clicked` event handler was removed from the `MenuItem`.

    The `Source` of the binding context is set to the app's main viewmodel, just like the page itself is. The binding context of the `MenuItem` remains the movie, and that's passed to the `CommandParameter`.

1.  Open the code-behind file for the view, _Views\\MoviesListPage.xaml.cs_, and remove the `MenuItem_Clicked` code.

1.  Run the app and right-click or long-press one of the movies, select **Delete** from the context menu. The movie is deleted from the list.
