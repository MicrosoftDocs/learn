A coded UI makes it difficult to manage layout and behavior. This approach often includes layout and behavioral logic, and results in a tight coupling between the two. A change in the UI design can cause a knock-on effect to the rest of the codebase. Maintaining a codebase where there's no clean separation of UI and behavior can be difficult.

.NET MAUI allows you to define a UI using XAML. This separation lets you focus on behavior logic in your C# code files. The UI designers can now focus on the UI, while programmers can focus on code.

.NET MAUI XAML allows you to customize the UI for each platform using the `OnPlatform` markup extension. This approach lets you design apps that can make use of OS-specific UI features, but that still look good on all platforms.

In this module, you saw how to use XAML to its best effect for designing the UI for a cross-platform app. Specifically, you learned:

- The benefits of using XAML over defining the UI for a .NET MAUI app in C#.
- How to create pages and controls and set their properties using XAML.
- How to handle UI events and wire them up in XAML.
- How to create and use XAML markup extensions.
- How to set platform-specific values in XAML markup.

## Learn more

- [.NET MAUI Documentation](/dotnet/maui)
- [XAML for .NET MAUI](/dotnet/maui/xaml)
