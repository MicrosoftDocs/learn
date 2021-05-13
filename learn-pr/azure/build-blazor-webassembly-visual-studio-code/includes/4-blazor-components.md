Now that you have your development environment set up, you'll explore the structure of a Blazor project and learn how to add new pages.

## Blazor project file

Blazor projects target Microsoft .NET 5. Blazor WebAssembly apps are different from Blazor Server apps, which are ASP.NET Core projects.

## Blazor entry point

The entry point for the app is defined in a C# file named Program.cs. When the **Program** class is instantiated and runs, its **Main** method is called.

By default, the **Main** method configures and creates the .NET web application. This object communicates with the host and loads the app's Razor components.

```csharp
public class Program
{
    public static void Main(string[] args)
    {
        CreateHostBuilder(args).Build().Run();
    }

    public static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureWebHostDefaults(webBuilder =>
            {
                webBuilder.UseStartup<Startup>();
            });
}
```


## What is Razor?

Razor is a markup syntax that uses HTML and C# for writing UI components of Blazor web apps.

Razor is based on ASP.NET and designed for creating web apps.

## What are Razor components?

A Razor file defines components that make up a portion of the app UI. Components in Blazor are analogous to user controls in ASP.NET Web Forms.

If you explore the project, you'll see that most files are .razor files.

At compile time, each Razor component is built into a .NET class. The class includes common UI elements like state, rendering logic, lifecycle methods, and event handlers.

## Try the Counter

In the running app, navigate to the Counter page by clicking the Counter tab in the sidebar on the left. The following page should then be displayed. 

![Counter Screenshot](../media/counter.png)

Select the **Click me** button to increment the count without a page refresh. Incrementing a counter in a webpage normally requires writing JavaScript, but with Blazor you can use C#.

You can find the implementation of the Counter component at `Pages/Counter.razor`.

```razor
@page "/counter"

<h1>Counter</h1>

<p>Current count: @currentCount</p>

<button class="btn btn-primary" @onclick="IncrementCount">Click me</button>

@code {
    private int currentCount = 0;

    private void IncrementCount()
    {
        currentCount++;
    }
}
```

A request for `/counter` in the browser, as specified by the `@page` directive at the top, causes the `Counter` component to render its content.

Each time the **Click me** button is selected:

- The onclick event is fired.
- The IncrementCount method is called.
- The currentCount is incremented.
- The component is rendered to show the updated count.