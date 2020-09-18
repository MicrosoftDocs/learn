Sometimes you need to require the user to complete an action before navigating away from a page. For example, suppose the user is entering information into a form. You might want them to _save_ or _cancel_ before they leave the page.

A _modal_ page is a page with restricted navigation options: the user must indicate they're finished before moving to a different page. Modal pages are a good option when you need a response from the user.

Modal pages are presented above any existing UI. They block access to the underlying UI until the modal content is dismissed. With modal content, we often provide specific and concrete actions for the user to do.

## Move by using modal pages

In Xamarin.Forms, modal pages are also stored in a stack, similar but independent of the navigation stack. Having a second stack allows us to display multiple pages modally.

Unlike the navigation stack, which requires a `NavigationPage`, the modal stack is always available. We can always present a page modally, regardless of the overall navigation structure of the app.

Let's look at the APIs used to push and pop pages modally. These methods are defined in the `INavigation` interface, and are available on every page's `Navigation` property.

```csharp
public interface INavigation
{
    ...
    IReadOnlyList<Page> ModalStack { get; }
    Task PushModalAsync(Page page);
    Task<Page> PopModalAsync();

    IReadOnlyList<Page> NavigationStack { get; }
    Task PushAsync(Page page);
    Task<Page> PopAsync();
}
```

We use `PushModalAsync` to display a page modally, and `PopModalAsync` to dismiss the modal page.

## Call the modal navigation methods

Here's an example of displaying a modal page. We create a new instance of `EditPage`, and pass it to the `PushModalAsync` method.

```csharp
public class AlarmsPage : ContentPage
{  ...
    async void OnEditClick(...) {
        await Navigation.PushModalAsync(new EditPage());
    }
}
```

Recall that pages displayed modally don't include a navigation bar by default. That means there's no automatic UI, like a back-button, for the user to leave a modal page. It's your responsibility to provide a way to dismiss the modal page. The lack of a back button gives you more control over the navigation flow. For example, you can require the user to make a choice between save and cancel before closing the page.

To dismiss the modal page, call `Navigation.PopModalAsync`.

```csharp
public class EditPage : ContentPage
{
    ...
    async void OnSaveClick  (...) {
        ...
        await Navigation.PopModalAsync();
    }
    async void OnCancelClick(...) {
        ...
        await Navigation.PopModalAsync();
    }
}
```

## Handle device back buttons

There's one last thing to consider. Some devices include hardware or system-provided back buttons. These buttons will dismiss our modal page and bypass the code in our `OnSaveClick` or `OnCancelClick` methods. It may not be obvious to users what will happen when they press this button. Will it save or cancel?

Override a `Page`'s `OnBackButtonPressed` method to help solve this problem. Overriding the method lets us do some work before the page is dismissed. It's up to us decide what should happen. We could implement some default behavior, we could assume the user intends to save any entered data, or we could assume it means cancel. There isn't a "right" answer; it will depend on the app.

```csharp
public partial class EditContactPage : ContentPage
{
    ...
    protected override bool OnBackButtonPressed()
    {
        ...
    }
}
```

Optionally, you can prevent the page from dismissing by returning `true`. In this case, you should provide UI to indicate to the user that you expect them to make an unambiguous selection. Or, you could present a dialog box telling the user what will happen if they choose to leave the page.