Apps with many top-level pages need a navigation model that makes all pages discoverable without taking up too much screen space. For example, a conference app might have pages for sessions, speakers, activities, rooms, and a venue map. That's five top-level pages that all have equal importance to the user. Drawer navigation is a good fit for this app.

## What is drawer navigation?

The *drawer navigation pattern* uses a master list and a details section to let the user move between pages. The master view is hosted inside a slide-out drawer and presents a list of the app's pages. The content of the selected page is shown in the detail view. In left-to-right languages, the master view appears from the left side of the screen.

Drawer navigation has several benefits:

* The user can directly access all pages of the app.
* The user can find all pages because they're all listed on the drawer menu.
* The navigation UI doesn't take up valuable screen space, which is especially important on small devices.

## Code the drawer menu

In Xamarin.Forms, `MasterDetailPage` hosts your content and implements the sliding-drawer animation. Your master drawer menu presents the list of your app's pages to the user. The **Master** UI is provided as a `Page` class, typically `ContentPage`.

It's up to you to decide what specific UI elements to use and how they're arranged – just like any other content page you create. You can use a grid or stack layout that contains buttons. There are no restrictions on which elements or layouts you use. In practice, developers tend to use `StackLayout` or `ListView`. Here's an example drawer page for our example conference app:

```xaml
<ContentPage Title="Menu">
   <StackLayout>
      <Button Text="Sessions" />
      <Button Text="Speakers" />
      <Button Text="Activities" />
      <Button Text="Rooms" />
      <Button Text="Map" />
   </StackLayout>
</ContentPage>
```

The preceding code assigned a title (`Title`) on the master page. Xamarin.Forms requires the title, or it will throw an exception at runtime.

## Design your content pages

Typically, each top-level detail will be its own `ContentPage` instance. You'll most likely provide a unique content page for each section of your application. Again, what content you display in the detail pages, and how you display it, is up to you.

## Build the drawer navigation

Several steps are required to assemble the user interface for the drawer navigation. Let's see how they apply to the conference app example.

1. Start by creating a class that inherits from `MasterDetailPage`. This class is typically created in code rather than XAML because it doesn't directly define UI elements. The presented UI is contained in the master and detail pages.

    ```csharp
    public class ConferenceMasterDetailPage : MasterDetailPage
    {
    }
    ```

1. Next, in the class's constructor, assign an instance of your master page to the `Master` property. This page will be hosted inside the drawer.

    ```csharp
    public class ConferenceMasterDetailPage : MasterDetailPage
    {
       public ConferenceMasterDetailPage()
       {
          this.Master = new ConferenceMenuPage();
       }
    }
    ```

1. Assign a default detail page to the `Detail` property. This page will be shown to the user at startup. If you don't assign a default page, your app will throw an exception at runtime.

    ```csharp
    public class ConferenceMasterDetailPage : MasterDetailPage
    {
       public ConferenceMasterDetailPage()
       {
          ...
          this.Detail = new SessionsPage();
       }
    }
    ```

1. Wrap the `Detail` page in a `NavigationPage` instance to maintain the navigation bar used for opening and closing the drawer and hosting the title of the current page.

    ```csharp
    public class ConferenceMasterDetailPage : MasterDetailPage
    {
       public ConferenceMasterDetailPage()
       {
          ...
          this.Detail = new NavigationPage(new SessionsPage());
       }
    }
    ```

1. Finally, use an instance of `MasterDetailPage` as your app's main page (`MainPage`).

    ```csharp
    public partial class App : Application
    {
        public App()
        {
            ...
            MainPage = new ConferenceMasterDetailPage();
        }
    }
    ```

> [!TIP]
> `MasterDetailPage` should always be the root page of your application. It shouldn't be hosted within another navigation page type, such as `NavigationPage` or `TabbedPage`. Nesting `MasterDetailPage` within another page isn't supported and might give unexpected results.

## Add a menu icon

Android supports drawer navigation as a default navigation paradigm. This support means Xamarin.Forms uses native controls for drawer navigation on Android.

Drawer navigation isn't provided with UIKit on iOS. The Xamarin.Forms team built a custom iOS UI for drawer navigation. On iOS, we're required to provide a menu icon. With an icon image in place within the iOS project's resources, we set the icon image by using the `IconImageSource` property of `MasterPage`.

```xaml
<ContentPage Title="Menu">
    <ContentPage.IconImageSource>
        <OnPlatform x:TypeArguments="FileImageSource">
            <On Platform="iOS" Value="nav-menu-icon.png" />
        </OnPlatform>
    </ContentPage.IconImageSource>
     ...
</ContentPage>
```

Additionally, you can set the iOS menu icon in code. The icon source can be set in the master page directly or in the detail page. To set the icon source in the detail page, set the `IconImageSource` while configuring the master page and behavior.

```csharp
public class ConferenceMasterDetailPage : MasterDetailPage
{
    public ConferenceMasterDetailPage()
    {
        var master = new ConferenceMenuPage();

        if (Device.RuntimePlatform == Device.iOS)
        {
            master.IconImageSource = ImageSource.FromFile("nav-menu-icon.png");
        }

        this.Master = master;
        ...
    }
}
```
