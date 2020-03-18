It's our job to update the detail content when the user makes a selection from the drawer. In this unit, we'll see how to write that code.

## Coordinate page changes

Your master-detail page will coordinate between master and detail. It's common to expose an event on `Master`. Because `MasterDetailPage` holds the instance of the `Master` page, it can subscribe to the event and respond appropriately. The typical pattern is:

1. The user makes a selection.
1. The `Master` page notifies `MasterDetailPage`.
1. `MasterDetailPage` updates the `Detail` content based on the user's selection.

![An illustration that shows a conference app's MasterDetailPage instance, with arrows indicating its coordination between drawer menu item selection and detail pages](../media/3-coordinate-detail-page-changes.png)

It's common to define `enum` to indicate which page the user selects from the master view.

## Update detail page with menu selection

Several steps are required to update the displayed content when the user selects a menu item.

1. Create an `enum` instance to describe the list of pages. This enumeration will allow the master page to notify the subscriber without needing to pass a complex object. For the conference app example, we might have an enumeration like this:

    ```csharp
    public enum PageType
    {
       Sessions,
       Speakers,
       Activities,
       Rooms,
       Map
    }
    ```

1. Publish the event from our menu page class. Pass an `enum` value as the event argument.

    ```csharp
    public partial class ConferenceMenuPage : ContentPage
    {
        ...
        public event EventHandler<PageType> PageSelected;

        public ConferenceMenuPage()
        {
            btnSessions.Clicked += (s, e) => PageSelected?.Invoke(this, PageType.Sessions);
            btnSpeakers.Clicked += (s, e) => PageSelected?.Invoke(this, PageType.Speakers);
            btnActivities.Clicked += (s, e) => PageSelected?.Invoke(this, PageType.Activities);
            btnRooms.Clicked += (s, e) => PageSelected?.Invoke(this, PageType.Rooms);
            btnMap.Clicked += (s, e) => PageSelected?.Invoke(this, PageType.Map);
        }
    }
    ```

1. In `MasterDetailPage`, subscribe to the page-selection event.

    ```csharp
    public class ConferenceMasterDetailPage : MasterDetailPage
    {
        ...
        public ConferenceMasterDetailPage()
        {
            var master = new ConferenceMenuPage();
            master.PageSelected += OnPageSelected;

            this.Master = master
            ...
        }
    }
    ```

1. In your handler, create the appropriate detail page for the `enum` value. Nest your page within a `NavigationPage` instance and then update the `Detail` property.

    ```csharp
    public class ConferenceMasterDetailPage : MasterDetailPage
    {
        ...
        void OnPageSelected(object sender, PageType pageType)
        {
            Page page;

            switch (pageType)
            {
                case PageType.Sessions: page = new SessionsPage(); break;
                case PageType.Speakers: page = new SpeakersPage(); break;
                case PageType.Activities: page = new ActivitiesPage(); break;
                case PageType.Rooms: page = new RoomsPage(); break;
                case PageType.Map: page = new MapPage(); break;
            }

            Detail = new NavigationPage(page);
            ...
        }
    }
    ```

1. If you're displaying the master page by using `Popover`, you need to hide the **Master** drawer after the user makes a selection. `MasterDetailPage` has an `IsPresented` property that controls the visibility of the drawer. Setting it to false will hide the drawer.

    ```csharp
    void OnPageSelected(object sender, PageType pageType)
    {
        Page page;
        ...
        Detail = new NavigationPage(page);

        try
        {
            IsPresented = false;
        }
        catch { }
        ...
    }
    ```

    > [!TIP]
    > For some values of `MasterBehavior`, such as `SplitOnLandscape` or `SplitOnPortrait`, if you assign `IsPresented` when the UI is split, it will throw an exception. Wrapping the assignment in a try-catch block will handle these situations without coding special cases for the device idiom or orientation.