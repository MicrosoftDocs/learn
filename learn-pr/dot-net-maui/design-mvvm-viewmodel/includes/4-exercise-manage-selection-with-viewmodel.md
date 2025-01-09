For our exercise, we briefly leave behind the example of the human resources app. Instead we work with an application that lists movies. The app already has a couple of pages and viewmodels that have some basic bindings. The two pages are a list page and a detail page. We modify the selection logic so that the `ListView` and the detail page use the same viewmodel property.

[!include[](../../../includes/dotnet9-sdk-version.md)]

## Open the starter solution

1. Clone or download the [exercise repo](https://github.com/MicrosoftDocs/mslearn-dotnetmaui-mvvm1).
1. Download and extract the [Movie List Sample](https://github.com/MicrosoftDocs/mslearn-dotnetmaui-mvvm1/raw/main/part4-exercise-start.zip) project to a temporary folder.
1. Navigate to the *part4-exercise1* folder and open the *MovieCatalog.sln* solution.
1. Build and run the project to make sure it works. You should see a list of movies displayed on the screen. Select one of the movies in the list and the app navigates to a detail page.

## Examine the code

Take a few minutes to examine how the viewmodels and views are structured. If you're familiar with Extensible Application Markup Language (XAML) and data-binding, it should all look familiar, but the structure uses the Model-View-ViewModel (MVVM) pattern.

There's a `MovieListViewModel` that serves dual duty as the app's overall viewmodel and as the viewmodel for the `MoviesListPage`. This viewmodel contains a list of movies loaded from the model, which is a *json* file included in the project. The other viewmodel is `MovieViewModel`, and represents a single movie. It also serves dual duty: provide data for the rows in the list page and as the `BindingContext` for the `MovieDetailPage`.

## Add selection support

The `MoviesListPage` is the first page shown when the app runs. The `ListView` on the page is bound to the collection of `MovieViewModel` instances provided by the overall viewmodel, `MovieListViewModel`. When you select on one of the movies in the view, the `ItemTapped` event navigates to the `MovieDetailPage`, passing the `BindingContext` of the item, which is a movie, to the constructor of the view. The `MovieDetailPage` sets the viewmodel that was passed as the `BindingContext` of the page.

Instead, let's update the app to have the `MovieDetailPage` read the selected movie from the overall app's viewmodel.

1. In the **Solution Explorer** window, open the *ViewModels\\MovieListViewModel.cs* file.
1. Add the following code to the `MovieListViewModel` class:

    ```csharp
    private MovieViewModel _selectedMovie;
    
    public MovieViewModel SelectedMovie
    {
        get => _selectedMovie;
        set => SetProperty(ref _selectedMovie, value);
    }
    ```

1. Next, open the *Views\\MoviesListPage.xaml* file.
1. Locate the `ListView` element, and add the `SelectedItem` attribute:

    ```xaml
    <ListView ItemsSource="{Binding Movies}" SelectedItem="{Binding SelectedMovie, Mode=OneWayToSource}" Margin ... >
    ```

    This attribute binds the selected item of the list to the new property in the viewmodel.

1. Open the code-behind file for the view, *Views\\MoviesListPage.xaml.cs*.
1. Replace the `ListView_ItemTapped` event handler code with the following code:

    ```csharp
    private async void ListView_ItemTapped(object sender, ItemTappedEventArgs e)
    {
        await Navigation.PushAsync(new Views.MovieDetailPage());
    }
    ```

    The `MovieDetailPage` no longer accepts the movie in the constructor, instead, the new constructor reads the app's main viewmodel. 

1. Open the *Views\MovieDetailPage.xaml.cs* file and change the constructor to the following code:

    ```csharp
    public MovieDetailPage()
    {
        BindingContext = App.MainViewModel.SelectedMovie;
        InitializeComponent();
    }
    ```

   This code sets the binding context of the view to the selected movie.

1. Run the app and verify that the code works as intended.
