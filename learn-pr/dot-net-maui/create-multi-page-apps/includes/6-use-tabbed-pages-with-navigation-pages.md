Flyout and tabbed navigation are just two ways of enabling a user to navigate through the data presented by an app. Another technique is to use stack navigation. Each type of navigation is suited towards different types of relationships between pages.

You can use stack navigation in combination with flyouts and tabs. In this unit, we briefly review the differences between tab and flyout navigation and stack navigation, and then learn how to build apps that combine both techniques.

## Review of flyouts and tab navigation

Flyouts and tab navigation provide a useful mechanism for enabling the user to select which page to view at any one time. The user navigates to a page simply by selecting the appropriate tab or flyout item. This form of navigation is useful for data items that have a *peer* relationship with each other. In the astronomy app, the Sun, Moon, and About pages are all peers; there's no direct relationship between them.

However, for hierarchical data, stack navigation might be more appropriate. Stack navigation enables the user to *drill down* a series of pages, where the next page in the stack provides a more detailed view of a selected item on the previous page.

Consider the following scenario:

You've added a new page to the astronomy app that displays astronomical bodies. You want the user to tap on one of those celestial objects and then display information about it. The page listing the astronomical bodies would be best presented in a tab page as a sibling of the moon phase and sunrise pages. The detailed information about the astronomical body is better presented as a series of steps using stack navigation. This mechanism also enables the user to return to the main astronomical bodies page by tapping a back button.

## Navigate with stack navigation

.NET Multi-platform App UI (.NET MAUI) Shell includes a URI-based navigation experience that uses routes to navigate to any page in the app, without having to follow a set navigation hierarchy. In addition, it allows you to navigate backwards without having to visit all of the pages on the navigation stack.

The Shell class defines the following navigation-related properties:

- `BackButtonBehavior`, of type `BackButtonBehavior`, an attached property that defines the behavior of the back button.
- `CurrentItem`, of type `ShellItem`, the currently selected item.
- `CurrentPage`, of type `Page`, the currently presented page.
- `CurrentState`, of type `ShellNavigationState`, the current navigation state of the `Shell`.
- `Current`, of type `Shell`, a type-casted alias for `Application.Current.MainPage`.

Navigation is performed by invoking the `GoToAsync` method, from the `Shell` class.

### Routes

Navigation is performed in a Shell app by specifying a URI to navigate to. Navigation URIs can have three components:

- A _route_, which defines the path to content that exists as part of the Shell visual hierarchy.
- A _page_. Pages that don't exist in the Shell visual hierarchy can be pushed onto the navigation stack from anywhere within a Shell app. For example, a details page isn't defined in the Shell visual hierarchy, but can be pushed onto the navigation stack as required.
- One or more _query parameters_. Query parameters are parameters that can be passed to the destination page while navigating.

When a navigation URI includes all three components, the structure is: //route/page?queryParameters

#### Register routes

Routes can be defined on `FlyoutItem`, `TabBar`, `Tab`, and `ShellContent` objects through their `Route` properties:

```xaml
<Shell ...>
    <FlyoutItem ... 
        Route = "astronomy">
        <ShellContent ...
            Route="moonphase" />
        <ShellContent ...
            Route="sunrise" />
    </FlyoutItem>
    <FlyoutItem>
        <ShellContent ...
            Route="about" />
    </FlyoutItem>
</Shell>
```

To navigate to the `moonphase` route, the absolute route URI is `//astronomy/moonphase`

#### Register detail routes

In the `Shell` subclass constructor, or any other location that runs before a route is invoked, you can explicitly register a route by using the `Routing.RegisterRoute` method for any detail pages that aren't represented in the Shell visual hierarchy.

```csharp
Routing.RegisterRoute("astronomicalbodydetails", typeof(AstronomicalBodyPage));
```

To navigate to the `AstronomicalBodyPage`, one would then invoke:

```csharp
await Shell.Current.GoToAsync("astronomicalbodydetails");`
```


### Backwards navigation

Backwards navigation can be performed by specifying ".." as the argument to the `GoToAsync` method:

```csharp
await Shell.Current.GoToAsync("..");
```

### Passing data

Primitive data can be passed as string-based query parameters when performing URI-based programmatic navigation. Pass the data by appending `?` after a route, followed by a query parameter ID, `=`, and a value:

```csharp
string celestialName = "moon";

await Shell.Current.GoToAsync($"astronomicalbodydetails?bodyName={celestialName}");
```

In this example, the route is *astronomicalbodydetails*, the parameter is *bodyName*, and the value is from the variable `celestialName`.

#### Retrieving data

Navigation data can be received by decorating the receiving class with a `QueryPropertyAttribute` for each string-based query parameter and object-based navigation parameter:

```csharp
[QueryProperty(nameof(AstroName), "bodyName")]
public partial class AstronomicalBodyPage : ContentPage
{
    string astroName;
    public string AstroName
    {
        get => astroName;
        set
        {
            astroName = value;
        }
    }

    ...
}
```

In this example, the first argument for the QueryPropertyAttribute specifies the name of the property that receives the data, with the second argument specifying the parameter ID.
