The weather app you maintain uses a weather service that recently announced its closure. You needed to start investigating other weather services. Knowing that changing services means that your data could change, you wanted to swap from using the code-behind to using data binding to update the UI. This way, when you decide which weather service you're going to use, you don't have to worry about the UI being impacted.

The data binding you did in the exercises reduced the code required to update the UI when the data changes. Instead of using the button's event handler to interact with controls on the UI to present the data, you moved to data binding. The weather service's data object was set as the binding context for the page, and controls on the page were bound to properties of that data object. The UI was automatically synchronized with the data, regardless of how the weather service updated.

Imagine the code-behind is affected without data binding. If you renamed a control, changed one control to a different type, or even deleted a control, your code-behind would no longer compile. If the weather service stopped providing a specific field of data, such as humidity, your code would crash when trying to present it in the UI. Users would have the app suddenly stop working, and they wouldn't know what was going on.

Data binding automatically synchronizes the data with the UI. As soon as the weather data changes, anything bound to it also changes. When a UI property type and the data object type don't match, a converter transforms the bound data so that it's presented correctly by the UI. This reduces the code-behind required to maintain the UI. Where the data comes from and how the data was triggered is of no concern for most of your UI. If the humidity was no longer provided on the data object, the data-bound UI would show nothing for the humidity label instead of crashing. That's a much better experience for your users instead of a crashing app.

## Learn more

- [.NET MAUI Documentation](/dotnet/maui)
- [XAML in .NET MAUI](/dotnet/maui/xaml)
- [Data binding in .NET MAUI](/dotnet/maui/fundamentals/data-binding)
