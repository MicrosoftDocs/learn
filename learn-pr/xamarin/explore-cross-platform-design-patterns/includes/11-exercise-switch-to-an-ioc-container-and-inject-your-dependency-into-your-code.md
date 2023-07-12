[!include[](../../includes/xamarin-not-maintained.md)]

In this final exercise, you'll replace the patterns you used in the previous exercises with a dependency injection (DI) or IoC container pattern. The container will supply both the QuoteLoader and the text to speech engine as part of the constructor. 

This exercise is a continuation of the previous exercise. Use your existing solution as the starting point for these steps. To start from here, open the completed solution from the previous **exercise2** > **final** folder in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

## Add the IoC container

1. In the **exercise3** > **assets** folder, you'll find a `SimpleContainer` class. This class is a simple implementation of an IoC container that allows you to register and create types. Add it to your .NET Standard library.

    > [!NOTE]
    > This example is deliberately simplified so you can grasp the concepts and trace through the code. For nonsample applications, consider using a real IoC container.

1. Examine the code. It has three methods of interest to us:

    | Method | Description |
    | --- | --- |
    | `Register` | This method is used to register known abstractions with the container. You register a creator _function_ with the abstraction type so it can be created. Or you just pass the implementation type if it has a default constructor. This method allows the container to resolve interfaces to types like a service locator does. You could also use a service locator for this purpose if you wanted to. |
    | `FactoryFor<T>` | This method is used to create a factory method that will create the `T` type. It returns a `Func<T>` where the implementation goes through the container to generate the type. This method can be used to create factory methods so consumers don't have to have a reference to the container itself. |
    | `Create` | This method is used to create types. If the type is registered, the associated registration method is used. Otherwise, if the type has a public default constructor, the constructor will be used to create the object. If the type doesn't have a public default constructor, the code will pick the first public constructor and attempt to create each of the required parameters by recursively calling `Create`. Then it will construct the final object passing each of the parameters. If it can't create the given type, the code returns `null`. |

## Update the QuoteManager constructor with the IQuoteLoader dependency

Next change the code in the `QuoteManager` class to inject the `IQuoteLoader` dependency as a constructor parameter.

1. Open `QuoteManager` and add a new parameter to the constructor of type `IQuoteLoader`. Assign the passed parameter to a field. Remove the existing code that uses the factory pattern.
1. Make the constructor `public` so you can create it externally.
1. Change the static `Instance` property to an automatically implemented property with a private `Set`. Remove the existing `Lazy` field. Then assign the `Instance` property in the constructor. Here, enforce the singleton pattern by adding a check to ensure the property won't be set more than once. 

    ```csharp
    public class QuoteManager
    {
        public static QuoteManager Instance { get; private set; }

        readonly IQuoteLoader loader;
        public IList<GreatQuoteViewModel> Quotes { get; private set; }

        public QuoteManager(IQuoteLoader loader)
        {
            if (Instance != null) {
              throw new Exception("Can only create a single QuoteManager.");
            }
            Instance = this;
            this.loader = loader;
            Quotes = new ObservableCollection<GreatQuoteViewModel>(loader.Load());
        }
        ...
    }
    ```

## Create and register the QuoteLoader abstraction with the IoC container

Finally, create the container in each of your platform-specific projects. Register the `IQuoteLoader` implementation with the container. Then use the container to create your `QuoteManager` so that it properly "injects" the required constructor parameters. You'll repeat the same basic steps in each project (iOS and Android).

1. Open the file that sets up the factory that locates the `IQuoteLoader` implementation. In iOS, this file is **AppDelegate.cs**. Android uses **MainActivity.cs**.
1. Add a new `SimpleContainer` field to the application-level class. Then instantiate the container.
1. Remove the current factory registration code. Remember, the code is in `FinishedLaunching` in iOS. It's in `OnCreate` in Android.
1. Register the `IQuoteLoader` abstraction with the platform-specific implementations by using the container's `Register<T, TImpl>` method.
1. Use the container's `Create` method to create the `QuoteManager` instance. Assign it to the field you're using now.
1. Run the application on one of the supported platforms and make sure it all still works. Try putting a breakpoint into the `QuoteManager` constructor to see the injected parameter. Look at the call stack to see how you got it.

### iOS implementation

```csharp
// AppDelegate.cs
[Register("AppDelegate")]
public partial class AppDelegate : global::Xamarin.Forms.Platform.iOS.FormsApplicationDelegate
{
readonly SimpleContainer container = new SimpleContainer();

public override bool FinishedLaunching(UIApplication uiApplication, NSDictionary launchOptions)
{
    container.Register<IQuoteLoader, QuoteLoader>();
    container.Create<QuoteManager>();

    ServiceLocator.Instance.Add<ITextToSpeech, TextToSpeechService>();

    global::Xamarin.Forms.Forms.Init();

    LoadApplication(new App());

    return base.FinishedLaunching(uiApplication, launchOptions);
}
}
```

### Android implementation

```csharp
// MainActivity.cs
[Activity(Label = "@string/app_name", Icon = "@mipmap/icon", Theme = "@style/MainTheme", MainLauncher = true, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation)]
public class MainActivity : global::Xamarin.Forms.Platform.Android.FormsAppCompatActivity
{
    readonly SimpleContainer container = new SimpleContainer();

    protected override void OnCreate(Bundle savedInstanceState)
    {
        TabLayoutResource = Resource.Layout.Tabbar;
        ToolbarResource = Resource.Layout.Toolbar;

        base.OnCreate(savedInstanceState);

        container.Register<IQuoteLoader, QuoteLoader>();
        container.Create<QuoteManager>();

        ServiceLocator.Instance.Add<ITextToSpeech, TextToSpeechService>();

        Xamarin.Essentials.Platform.Init(this, savedInstanceState);
        global::Xamarin.Forms.Forms.Init(this, savedInstanceState);

        LoadApplication(new App());
    }
    ...
}
```

## Update the QuoteManager constructor with the ITextToSpeech dependency

The container is being used to create the `QuoteManager` with a passed `IQuoteLoader` to load the quotes. The `QuoteManager` also uses the `ITextToSpeech` implementation that your service locator finds.

1. Open the `QuoteManager` and create a new field of type `ITextToSpeech`.
1. Add a new parameter to the constructor of type `ITextToSpeech`. Assign the passed parameter to the field you created in the previous procedure.
1. Remove the existing code that uses the service-locator approach in the `SayQuote` method.

    Your `QuoteManager` class should look something like this code:

    ```csharp
    public class QuoteManager
    {
        private IQuoteLoader loader;
        private ITextToSpeech tts;
        ...

        public QuoteManager(IQuoteLoader loader, ITextToSpeech tts)
        {
            if (Instance != null)
            {
                throw new Exception("Can only create a single QuoteManager.");
            }
            Instance = this;

            this.loader = loader;
            this.tts = tts;
            Quotes = new ObservableCollection<GreatQuoteViewModel>(loader.Load());
        }

        ...

        public void SayQuote(GreatQuoteViewModel quote)
        {
            if (quote == null)
                throw new ArgumentNullException("No quote set");

            if (tts != null)
            {
                var text = quote.QuoteText;

                if (!string.IsNullOrWhiteSpace(quote.Author))
                    text += $" by {quote.Author}";

                tts.Speak(text);
            }
        }
    }
    ```

## Update platform-specific code

1. Open the file that sets up the factory that locates the `IQuoteLoader` implementation. In iOS, this file is **AppDelegate.cs**. Android uses **MainActivity.cs**.
1. Register the `ITextToSpeech` abstraction with the proper platform-specific implementations by using the container's `Register<T, TImpl>` method.
1. Remove the service-locator registration.

    Your `FinishedLaunching` method should now look like this code:

    ```csharp
    public override bool FinishedLaunching(UIApplication uiApplication, NSDictionary launchOptions)
    {
        container.Register<IQuoteLoader, QuoteLoader>();
        container.Register<ITextToSpeech, TextToSpeechService>();
        container.Create<QuoteManager>();

        global::Xamarin.Forms.Forms.Init();

        LoadApplication(new App());

        return base.FinishedLaunching(uiApplication, launchOptions);
    }
    ```

    Your `OnCreate` method should now look like this code:

    ```csharp
    protected override void OnCreate(Bundle savedInstanceState)
    {
        TabLayoutResource = Resource.Layout.Tabbar;
        ToolbarResource = Resource.Layout.Toolbar;

        base.OnCreate(savedInstanceState);

        container.Register<IQuoteLoader, QuoteLoader>();
        container.Register<ITextToSpeech, TextToSpeechService>();
        container.Create<QuoteManager>();

        Xamarin.Essentials.Platform.Init(this, savedInstanceState);
        global::Xamarin.Forms.Forms.Init(this, savedInstanceState);

        LoadApplication(new App());
    }
    ```

## Run the application

1. Build and run the application on as many implementations as you can.
1. Set some breakpoints and trace through the IoC container to see how it finds the implementation and creates the service.

In this exercise, you've taken an existing application and used a DI container to loosely couple dependencies together.

You can view the completed solution in the **exercise3** > **final** folder of your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].
