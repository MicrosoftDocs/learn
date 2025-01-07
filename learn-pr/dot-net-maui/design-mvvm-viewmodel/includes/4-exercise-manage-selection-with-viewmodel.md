For our exercise, we'll briefly leave behind the example of the human resources app. Instead we'll work with an application that lists movies. The app already has a couple of pages and viewmodels that have some basic bindings. The two pages are a list page and a detail page. We'll modify the selection logic so that the `ListView` and the detail page use the same viewmodel property.

[!include[](../../../includes/dotnet9-sdk-version.md)]

## Open the starter solution

1. Clone or download the [exercise repo](https://github.com/MicrosoftDocs/mslearn-dotnetmaui-mvvm1).

    > [!NOTE]
    > It is best to clone or download the exercise content to a short folder path, such as _C:\dev\_, to avoid build-generated files exceeding the maximum path length.

1.  Navigate to the _part4-exercise1_ folder and open the _MovieCatalog.sln_ solution in Visual Studio or the folder in Visual Studio Code.
1.  Build and run the project to make sure it works. On the screen displayed, you'll see a list of movies. Select one of the movies listed and the app navigates to a detail page.

## Examine the code

Take a few minutes to examine how the viewmodels and views are structured. If you're familiar with XAML and data-binding, it should all look familiar, but it's structured using the MVVM pattern.

There's a `MovieListViewModel` that serves dual duty as the app's overall viewmodel and as the viewmodel for the `MoviesListPage`. This viewmodel contains a list of movies loaded from the model, which is a _json_ file included in the project. The other viewmodel is `MovieViewModel`, and represents a single movie. It also serves dual duty: provide data for the rows in the list page and as the `BindingContext` for the `MovieDetailPage`.

## Add selection support

The `MoviesListPage` is the page that's first shown when the app runs. The `ListView` on the page is bound to the collection of `MovieViewModel` instances provided by the overall viewmodel, `MovieListViewModel`. When you select on one of the movies in the view, the `ItemTapped` event navigates to the `MovieDetailPage`, passing the `BindingContext` of the item, which is a movie, to the constructor of the view. The `MovieDetailPage` sets the viewmodel that was passed as the `BindingContext` of the page.

Instead, let's update the app to have the `MovieDetailPage` read the selected movie from the overall app's viewmodel.

1.  In the **Solution Explorer** window, open the _ViewModels\\MovieListViewModel.cs_ file.
1.  Add the following code to the `MovieListViewModel` class:

    ```csharp
    private MovieViewModel _selectedMovie;
    
    public MovieViewModel SelectedMovie
    {
        get => _selectedMovie;
        set => SetProperty(ref _selectedMovie, value);
    }
    ```

1.  Next, open the _Views\\MoviesListPage.xaml_ file.
1.  Locate the `ListView` element, and add the `SelectedItem` attribute:

    ```xaml
    <ListView ItemsSource="{Binding Movies}" SelectedItem="{Binding SelectedMovie, Mode=OneWayToSource}" Margin ... >
    ```

    This attribute binds the selected item of the list to the new property in the viewmodel.

1.  Open the code-behind file for the view, _Views\\MoviesListPage.xaml.cs_.
1.  Replace the `ListView_ItemTapped` event handler code with the following code:

    ```csharp
    private async void ListView_ItemTapped(object sender, ItemTappedEventArgs e)
    {
        await Navigation.PushAsync(new Views.MovieDetailPage());
    }
    ```

    The `MovieDetailPage` no longer accepts the movie in the constructor, instead, the new constructor reads the app's main viewmodel. 

1.  Open the _Views\MovieDetailPage.xaml.cs_ file and change the constructor to the following code:

    ```csharp
    public MovieDetailPage()
    {
    	BindingContext = App.MainViewModel.SelectedMovie;
    	InitializeComponent();
    }
    ```
    
    This code sets the binding context of the view to the selected movie.

1.  Run the app and verify that the code works as intended.
