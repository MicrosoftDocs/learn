A coded UI makes it difficult to manage layout and behavior. It often includes layout and behavioral logic that is tightly coupled. A change in design normally causes a knock-on effect to the rest of our codebase. Maintaining a codebase where there's no clean separation of UI and behavior can be difficult. 

We saw in our exercise how Xamarin.Forms allows us to define our UI using XAML. This separation allows us to focus on behavior logic in our C# code files. Our UI designers can now focus on the UI and our programmers can focus on code. XAML's extensibility allows you to create Xamarin.Forms elements, CLR types, and custom types.

Xamarin.Forms XAML allows you to customize the UI for each platform using `OnPlatform`. Allowing you to make sure your design is making use of OS-specific UI features and looks good on all platforms.

You can make use of the preview support in Visual Studio to see your app's layout rendered and updated as you change the UI. This feature is enabled by the *XAML Previewer for Xamarin.Forms*. For more information, visit the [XAML Previewer for Xamarin.Forms](https://docs.microsoft.com/xamarin/xamarin-forms/xaml/xaml-previewer/?pivots=windows) documentation.

Now that you understand the basics of working with XAML in Xamarin.Forms, you're ready to learn new techniques to help keep your UI uniform across multiple pages and to reduce duplicate XAML.
