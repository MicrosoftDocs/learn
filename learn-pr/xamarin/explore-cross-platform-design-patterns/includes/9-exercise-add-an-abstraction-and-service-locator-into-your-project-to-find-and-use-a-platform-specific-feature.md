[!include[](../../includes/xamarin-not-maintained.md)]

In this exercise, you'll define a service to convert text to speech. Then you'll use a service locator to find the implementation of the platform-specific service. The service will allow your users to select a quote and hear the application speak it.

> [!NOTE]
> The Xamarin.Essentials NuGet package includes text to speech functionality. That functionality relies on the same APIs you'll use here, but it doesn't require any platform-specific code.

This exercise is a continuation of the previous exercise. Use your existing solution as the starting point for these steps. To start from here, open the completed solution from the previous **exercise1** > **final** folder in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

## Use an interface to create the text to speech engine's abstraction 

Start by defining your abstraction. You'll have each platform use its text to speech engine to read stored quotes to the user. First you'll define an interface called `ITextToSpeech` with a single method called `Speak`. The interface needs to go in your shared code. You'll place it in the GreatQuotes .NET Standard library.

1. Open the starter project **GreatQuotes.sln** or continue with the previous exercise.
1. Create a new interface source file in the `GreatQuotes` project. Name it **ITextToSpeech.cs**.
1. Make the interface public so it can be used outside the .NET Standard library.
1. Add a method to the interface called `Speak` that returns `void` and takes a single `string` parameter.

    ```csharp
    namespace GreatQuotes
    {
        public interface ITextToSpeech
        {
            void Speak(string text);
        }
    }
    ```

## Add a service locator

Next you'll add a service locator. To save time, add an existing implementation.

1. Find the code in the **exercise2** > **assets** folder. Add the `ServiceLocator` class to the `GreatQuotes` project. Make sure to *copy* the file into the project instead of moving it.
1. Examine the newly added source file. It associates a contract `Type` with an implementation by saving off the registration in a dictionary.
    - A static `Instance` property retrieves the singleton locator object.
    - An `Add` method registers a type with an implementation.
    - The `Resolve<T>` method locates an implementation based on the abstraction.

## Register the abstractions with the service locator

Register your implementations for the text to speech functionality in each of the platform-specific projects.

1. Add implementations of the text to speech engine for each platform. Your **exercise2** > **assets** folder contains two implementations. You'll find one for iOS and one for Android.
1. Add each implementation to the appropriate platform-specific project, based on the name:
    - **TextToSpeechService.Android.cs** goes into the **Android** project.
    - **TextToSpeechService.iOS.cs** goes into the **iOS** project.
1. Feel free to examine the source for each implementation. Make sure the interface is correctly defined and implemented. Then build the projects.

    Use `ServiceLocator` to register each implementation in the platform code against the `ITextToSpeech` interface.

1. To tie the `TextToSpeechService` class to the `ITextToSpeech` interface, use the `Add` method on `ServiceLocator` in the platform-specific project.
    - Register the iOS version in the **AppDelegate.cs** file as part of `FinishedLaunching`.
    - Register the Android version in the **MainActivity.cs** file as part of the `MainActivity.OnCreate` override.

    ```csharp
    ServiceLocator.Instance.Add<ITextToSpeech, TextToSpeechService>();
    ```

## Update the QuoteManager with text to speech behavior

Add support to call the text to speech service in your shared code and invoke it from each platform.

1. Add a method to the shared `QuoteManager.cs` class that will invoke the text to speech service.
1. Name the method `SayQuote` and have it take `GreatQuote` as the parameter.
1. Look up the `ITextToSpeech` abstraction by using the service-locator `Resolve` method.
1. Make sure the returning value isn't `null`. If the value isn't `null`, use the `Speak` method to say the quote and author.

    ```csharp
    public class QuoteManager
    {
        ...
        public void SayQuote(GreatQuoteViewModel quote)
        {
            if (quote == null)
                throw new ArgumentNullException("No quote set");

            ITextToSpeech tts = ServiceLocator.Instance.Resolve<ITextToSpeech>();

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

## Update the QuoteDetailPage with text to speech behavior

1. You'll update `QuoteDetailPage` to allow a user to tap a quote. The text to speech engine will then speak the quote text. In the page's XAML, add `TapGestureRecognizer` to the quote text label and set `NumberOfTapsRequired` equal to one.
1. Set an event handler for the `Tapped` event of `TapGestureRecognizer`.

    Your label's XAML declaration should now look something like this code:

    ```xaml
    <Label Grid.Row="1" Text="{Binding QuoteText}"
            VerticalOptions="Start"
            Style="{DynamicResource BodyStyle}">
        <Label.GestureRecognizers>
            <TapGestureRecognizer NumberOfTapsRequired="1" Tapped="Handle_Tapped" />
        </Label.GestureRecognizers>
    </Label>
    ```

1. You now need to update the `Handle_Tapped` method in the `QuoteDetailPage` class. First consider how you'll structure your code. The `QuoteManager` is a dependency of the `MainViewModel` class and is responsible for managing quotes. `MainViewModel` is available as a static property and already exposes a `Save` method to allow quote saving. We'll follow the same pattern so that quotes can be spoken.
1. Open the `MainViewModel` class and add a method called `SayQuotes`. This method takes `GreatQuoteViewModel` as a parameter. From the method, call the `quoteManager.SayQuote` method and pass the great quote to it.

    Your method should look like this code:

    ```csharp
    public void SayQuotes(GreatQuoteViewModel quote)
    {
        quoteManager.SayQuote(quote);
    }
    ```

1. Finally, in the `Handle_Tapped` method of the `QuoteDetailPage`, reference `App.GreatQuotesViewModel` and call the `SayQuotes` method. Cast the page's `BindingContext` as `GreatQuoteViewModel` and pass it as the method's parameter.

    Your method should look like this code:

     ```csharp
    void Handle_Tapped(object sender, System.EventArgs e)
    {
        App.GreatQuotesViewModel.SayQuotes(BindingContext as GreatQuoteViewModel);
    }
    ```

## Run the application

1. Build and run the application on as many implementations as you can.
1. Set some breakpoints and trace through the service locator to see how it finds the implementation and invokes the service.

You can view the completed solution in the **exercise2** > **final** folder of your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

In this exercise, you used a service-locator pattern to abstract away a platform-specific feature and then to invoke it from shared code.
