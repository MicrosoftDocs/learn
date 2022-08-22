E**X**tensible **A**pplication **M**arkup **L**anguage (XAML) is a markup language that you can use to build your UI instead of C# code. Using XAML, you can split up your UI and behavior code to make both easier to manage.

In this unit, we'll talk about some of the benefits of using markup languages to define your UI. We'll also look at some of the benefits XAML provides to you as a Xamarin.Forms developer.

## What is a markup language?

A *markup language* is a computer language that you can use to introduce various elements in a document. You describe elements using predefined tags. The tags have specific meaning in the context of the domain where the document is used.

For example, you can use Hypertext Markup Language (HTML) to create a webpage that you can display in a web browser. You don't need to understand all the tags that are used in the following example. What's important to see, is that this code describes a document that has the text "Hello **World** !" as content.

```html
<!DOCTYPE html>
<html>
    <body>
        <p>Hello <b>World</b>!</p>
    </body>
</html>
```

You've likely already worked with a markup language. You might have created a webpage using HTML, or you might have modified the Extensible Markup Language (XML) in your Visual Studio project `.csproj` file.

If the file describes a Visual Studio project file, it's most likely an XML file, and will be parsed by the Microsoft build tools.

As you can see, it's common for files that contain markup language to be processed and interpreted by other software tools. This interpretative nature of markup is exactly how XAML is intended to work. However, the software tools that interpret it, help produce app UI.

## What is XAML?

XAML is a declarative markup language created by Microsoft. XAML was designed to simplify the process of creating the UI in applications.

The XAML documents you create contain elements that declaratively describe the application UI elements. Keep in mind that these elements in XAML directly represent the instantiation of objects. Once you've define an element in XAML, you can access it in code-behind files and define behavior using C# code.

## Difference between Xamarin.Forms XAML and Microsoft XAML

Xamarin.Forms XAML is based on the Microsoft 2009 XAML specification. However, the specification defines only the syntax of the language. As with Windows Presentation Foundation (WPF), Silverlight, Universal Windows Platform (UWP), and Windows Workflow Foundation, all of which use XAML, the elements you declare in the XAML will change.

XAML first appeared in 2006, with WPF. If you've been working with Microsoft XAML for a while, the XAML syntax should look familiar.

There are some key differences between Xamarin.Forms XAML and Microsoft XAML. The structure and concepts are similar. However, some of the names of the classes and properties will be different.

## Create a UI by using Xamarin.Forms XAML

The best way to see Xamarin.Forms XAML in action is to look at an example of an existing C# coded `ContentPage` page type. We'll compare it to another page that has the same UI created using XAML.

Let's assume you have the following coded `ContentPage` in your app.

```csharp
namespace Sample
{
    public class MyPage : ContentPage
    {

        Button loginButton;
        StackLayout layout;

        public MyPage()
        {
            layout = new StackLayout
            {
                Children =
                {
                    new Label { Text = "Please log in" },
                    new Label { Text = "Username", TextColor = Color.Black },
                    new Entry (),
                    new Label { Text = "Password", TextColor = Color.Black },
                    new Entry { IsPassword = true },

                }
            };

            loginButton = new Button { Text = "Login" };

            layout.Children.Add(loginButton);

            Content = layout;

            loginButton.Clicked += (sender, e) =>
            {
                Debug.WriteLine("Clicked !");
            };
        }
    }
}
```

The page contains a layout container, two labels, two entries, and one button. The code also handles the `Clicked` event for the button. There are also only a few design properties set on the elements in the page.

Although the page has a simple design, it's a mix of behavior and design in the same page.

Let's look at the same `ContentPage` in XAML:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ContentPage xmlns="http://xamarin.com/schemas/2014/forms"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="Sample.MyPage">
    <ContentPage.Content>
        <StackLayout>
            <Label Text="Please log in" />
            <Label Text="Username" TextColor="Black" />
            <Entry />
            <Label Text="Password" TextColor="Black" />
            <Entry IsPassword="true" />
            <Button Text="Log in" Clicked="LoginButton_Clicked" />
        </StackLayout>
    </ContentPage.Content>
</ContentPage>
```

Here's the associated code-behind file.

```csharp
public partial class MyPage : ContentPage
{
    public MyPage()
    {
        InitializeComponent();
    }

    void LoginButton_Clicked(object sender, EventArgs e)
    {
        Debug.WriteLine("Clicked !");
    }
}
```

The code allows for the separation of design and behavior.

The entire declaration of the UI is contained in a single dedicated source file. It's separate from the UI behavior.

## XAML benefits

As we just saw, using XAML allows us to separate our behavior logic from our UI design. This separation helps us build each independently that will make the entire app easier to manage as it grows. However, there are also two other benefits:

- **Division of labor**
  - Since XAML is a markup language, it doesn't require programming knowledge. Designers can focus on XAML and programmers can focus on writing the code.
- **Tooling friendly**
  - It's possible to use a design tool to create the XAML layout for you. For example, instead of writing the XAML by hand, you can drag and drop controls onto a design surface using a graphical experience.
