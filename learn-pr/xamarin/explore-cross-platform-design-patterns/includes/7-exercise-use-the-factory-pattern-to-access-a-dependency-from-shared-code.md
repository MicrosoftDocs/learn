In this exercise, you'll take an existing Xamarin.Forms project and pull sharable code into the project's .NET Standard library. You'll use the [factory pattern](http://www.oodesign.com/factory-pattern.html) to instantiate dependencies. Doing so allows you to isolate the platform-specific code to read and write the storage file that displays quotes.

## Explore the application

Open the starter solution from the **exercise1** > **start** folder in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

[!include[](../../../includes/android-windows-path-length-warning.md)]

Let's explore how to run the Great Quotes application.

1. Run the application on any platform. The application displays a list of great quotes.
1. Select an item from the list to see the full quote on a new detail page.
1. Edit the quote on a modal edit page by selecting the edit icon on the toolbar. When you finish editing, close the modal page. The updated information appears on the detail page.
1. Close the application and reopen it. All edits should be available.

Now that you've seen how the application works, let's have a look at the code.

1. The solution is a typical Xamarin.Forms application that targets Android and iOS. It shares code by using a .NET Standard library.
1. Quotes are saved in an XML file that's stored in a platform-specific location.
1. The `QuoteLoader` class in each platform's head project is responsible for loading and saving quotes.
1. In the shared code, the application uses three ContentPages (`QuoteListPage`, `QuoteDetailPage`, and `EditQuotePage`).
1. In the shared code, the `MainViewModel` class is responsible for supporting the ContentPages. `MainViewModel` is set as the BindingContext for each page.
1. `QuoteDetailPage` uses a `SaveQuotes` method on `MainViewModel`.
1. `MainViewModel` invokes an action delegate that is passed into the `MainViewModel` constructor. The delegate is invoked in the `SaveQuotes` method.
1. `MainViewModel` has a dependency on `QuoteLoader`. It relies on the constructor-passed delegate that points to the `QuoteLoader` instance `Save` method.
1. Because `QuoteLoader` can be instantiated only in platform-specific code, both `QuoteLoader` and `MainViewModel` are instantiated in the Android `MainActivity` class and the iOS `UIApplicationDelegate` class, respectively.
1. The `MainViewModel` instance is then passed as a constructor parameter into the Xamarin.Forms `App` class.
1. The `App` class sets `static MainViewModel GreatQuotesViewModel` from the `MainViewModel` constructor parameter. In each ContentPage, `GreatQuotesViewModel` is referenced as the BindingContext described earlier.

Looking at the structure of the application, you might see room for improvement for both code structure and code sharing. You'll modify the application's structure in the following sections.

## Add an abstraction

Your first step is to create an abstraction for the QuoteLoader code you're using. If you try to directly add either of the platform classes to the .NET Standard library, it won't compile. The classes have dependencies against specific file APIs that aren't available in the shared profile. The platforms differ slightly in how they handle local files and where they store files on the device. For each platform, you'll need a unique approach to load your quotes.

1. Open the **QuoteLoader.cs** file in your platform-specific project (iOS or Android). In each project, this file is in the **Data** folder. Examine the methods and implementation:
    - **Load** is used to load quotes from a file.
    - **Save** is used to save an existing collection of quotes back to the same file.
1. Create a new interface to represent `QuoteLoader` independent of the platform. You'll use an interface here, but you could use an abstract base class instead. Place the interface in the .NET Standard library because it will be shared across all projects.
    - Name the interface `IQuoteLoader`.
    - Define the `Load` and `Save` methods just as they're defined in your platform project.

    ```csharp
    using GreatQuotes.ViewModels;
    ...
    public interface IQuoteLoader
    {
        IEnumerable<GreatQuoteViewModel> Load();
        void Save(IEnumerable<GreatQuoteViewModel> quotes);
    }
    ```

1. Make your platform-specific implementation of `QuoteLoader` implement the `IQuoteLoader` interface. You don't need to change any code because the signatures for the `Load` and `Save` methods should already be in the existing class.

    ```csharp
    public class QuoteLoader : IQuoteLoader
    ```

1. Build and run the application to make sure it still works properly.

## Add a factory

Next you'll use the factory pattern to create the property implementation of the `IQuoteLoader` that you'll use in the .NET Standard library code.

1. In the .NET Standard library, create a new static class named `QuoteLoaderFactory`. This static class will represent the factory you'll use to create your platform-specific implementation of `IQuoteLoader`.
1. Add a single static property named **Create** that's of type `Func<IQuoteLoader>`. You'll later set this property to create a new `IQuoteLoader`.

Here's how your code should look for the factory:

```csharp
public static class QuoteLoaderFactory
{
    // This must be assigned to a method which creates a new quote loader.
    public static Func<IQuoteLoader> Create { get; set; }
}
```

## Add a QuoteManager class

In both platform-specific projects, the code that loads and saves the quotes is _almost_ identical. The platform-specific projects currently use the `QuoteLoader` classes directly, but you want to push this common code into your shared code (the .NET Standard library). Move the management of the `GreatQuote` collection into shared code so that every platform locates the data the same way.

1. Create a new `QuoteManager` class in the .NET Standard library.
1. Add a private constructor.
1. Create a static `Instance` property to expose a single copy of `QuoteManager`. You can use the built-in `Lazy<T>` type to implement this pattern. Or just create the object the first time the property is accessed. The goal is to have a public, static property to get to a single known instance of the object.

    ```csharp
    public class QuoteManager
    {
       static readonly Lazy<QuoteManager> instance = new Lazy<QuoteManager>(() => new QuoteManager());

       public static QuoteManager Instance { get => instance.Value; }

       private QuoteManager()
       {
       }
    }
    ```

1. Get an `IQuoteLoader` object by using the `QuoteLoaderFactory.Create` delegate. Assign it to a field of your class. Remember, you have a delegate assigned to a property, and you can call it like a method.

    ```csharp
    IQuoteLoader loader;
    ...
    private QuoteManager()
    {
       loader = QuoteLoaderFactory.Create();
    }
    ```

1. Add a public `IList<GreatQuoteViewModel>` property called `Quotes` to expose the loaded quotes.
1. In the constructor, assign the property to a new `ObservableCollection<GreatQuoteViewModel>` instance by using the `Load` method from the `IQuoteLoader` field. Remember to include `using System.Collections.ObjectModel` to reference the type `ObservableCollection`.
1. Finally, add a new public instance method named `Save`. This public instance method uses the `loader.Save()` method to save the collection of quotes.

Your final version of QuoteManager should look like this code:

```csharp
using System.Collections.ObjectModel;
using GreatQuotes.ViewModels;
...
public class QuoteManager
{
    static readonly Lazy<QuoteManager> instance = new Lazy<QuoteManager>(() => new QuoteManager());

    private IQuoteLoader loader;

    public static QuoteManager Instance { get => instance.Value; }

    public IList<GreatQuoteViewModel> Quotes { get; set; }

    private QuoteManager()
    {
        loader = QuoteLoaderFactory.Create();
        Quotes = new ObservableCollection<GreatQuoteViewModel>(loader.Load());
    }

    public void Save()
    {
        loader.Save(Quotes);
    }
}
```

## Use the QuoteManager class

The next step is to use the new shared `QuoteManager` class and assign the factory. `QuoteManager` will be the object that takes responsibility for managing everything that relates to quotes. But you still want to save quotes from `MainViewModel`. That's why `QuoteManager` is a dependency on `MainViewModel`.

1. Open `MainViewModel`.
1. Delete the field `saveQuotes` and remove the **Action** parameter from the class constructor.
1. Remove the code that invoked the **Action** in the `SaveQuotes` method.
1. To the class, add a read-only field of type `QuoteManager`. Name it `quoteManager`.
1. Inside the class constructor, use the `QuoteManager.Instance` property to assign a value to the field `quoteManager`.
1. In the class constructor, use `quoteManager.Quotes` to assign a value to the `Quotes` property. To make the assignment work, you'll have to convert the collection to `ObservableCollection<GreatQuoteViewModel>`.
1. To save all quotes, use the `quoteManger.Save()` method in the `SaveQuotes` method.

Your `MainViewModel` class should look something like this code:

```csharp
public class MainViewModel : BaseViewModel
{
    private readonly QuoteManager quoteManager;

    public MainViewModel()
    {
        quoteManager = QuoteManager.Instance;
        Quotes = quoteManager.Quotes as ObservableCollection<GreatQuoteViewModel>;
    }

    public ObservableCollection<GreatQuoteViewModel> Quotes { get; set; }

    public GreatQuoteViewModel ItemSelected { get; set; }

    public void SaveQuotes()
    {
        quoteManager.Save();
    }
}
```

## Update platform-specific code

The last step is to clean up the platform-specific classes and the Xamarin.Forms application class.

1. Open the application-level class that loaded the quotes. That class would be **AppDelegate.cs** for iOS or **MainActivity.cs** for Android.

1. From the platform-specific code, remove the `GreateQuotesViewModel` property and the code that instantiates `QuoteLoader` and `GreateQuotesViewModel`. Remove the line that looks like this code:

    ```csharp
    public MainViewModel GreateQuotesViewModel { get; private set; }
    ```

    Also remove these lines of code:

    ```csharp
    var quoteLoader = new QuoteLoader();
    GreateQuotesViewModel = new MainViewModel(() => quoteLoader.Save(GreateQuotesViewModel.Quotes))
    {
        Quotes = new ObservableCollection<GreatQuoteViewModel>(quoteLoader.Load())
    };
    ```

    Remember that each project contains this code in a different file:
    - iOS: **AppDelegate.cs**
    - Android: **MainActivity.cs**

1. Assign the `QuoteLoaderFactory.Create` property of your factory class to a method that creates a new platform-specific `QuoteLoader` class (for example, something that implements `IQuoteLoader`).
    - You can use any delegate assignment style you prefer - lambda, anonymous method, or a regular C# method defined in your class.
    - In the iOS project, add this code into the `FinishedLaunching` override.
    - In the Android project, add this code into the `OnCreate` override.

    Here's an example that uses a delegate:

    ```csharp
    QuoteLoaderFactory.Create = () => new QuoteLoader();
    ```

1. Clean up the instantiation of the Xamarin.Forms application class. You no longer need to instantiate `MainViewModel`.

    Your code should now look like this:

    ```csharp
    LoadApplication(new App());
    ```

1. Update the constructor of the `App` class and remove the `MainViewModel` parameter.

1. Set the `GreatQuotesViewModel` property to a new instance of `MainViewModel`.

    Your final constructor code should look like this:

    ```csharp
    public App()
    {
        InitializeComponent();
        GreatQuotesViewModel = new MainViewModel();
        MainPage = new NavigationPage (new QuoteListPage());
    }
    ```

1. Update the `OnSleep` method to directly use the `QuoteManager` save method. The application class shouldn't have a dependency on `MainViewModel`. 

    Your method should look like this:

    ```csharp
    protected override void OnSleep()
    {
        QuoteManager.Instance.Save();
    }
    ```

## Run the application

Build and run the application to verify that it loads and saves quotes properly. Try adding a breakpoint to the `QuoteManager` class where it gets the quote loader. Trace through it to see it jump from the cross-platform (shared) code into each platform-specific project.

You can view the completed solution in the **exercise1** > **final** folder of your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].
