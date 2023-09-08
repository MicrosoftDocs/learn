Razor is a markup syntax for embedding .NET based code into webpages. The Razor syntax consists of Razor markup, C#, and HTML. Razor syntax is similar to the templating engines of various JavaScript single-page application (SPA) frameworks, such as Angular, React, VueJs, and Svelte.

The default Razor language is HTML. Rendering HTML from Razor markup is no different than rendering HTML from an HTML file. The server renders HTML markup in `.cshtml` Razor files unchanged.

## Razor syntax

Razor supports C# and uses the `@` symbol to transition from HTML to C#. Razor evaluates C# expressions and renders them in the HTML output. 

When an `@` symbol is followed by a Razor reserved keyword, it transitions into Razor-specific markup. Otherwise, it transitions into plain HTML. To escape an `@` symbol in Razor markup, use a second `@` symbol. The following code sample would render the value of `@Username` in the HTML output.

Syntax | Output
--- | ---
`<p>@Username</p>` | Renders the value of `@Username` in the HTML output.
`<p>@@Username</p>` | Renders "@@Username" in the HTML output.

HTML attributes and content containing email addresses don't treat the `@` symbol as a transition character. For example, the email addresses in the following code are untouched by Razor parsing:

```html
<a href="mailto:Support@contoso.com">Support@contoso.com</a>
```

## Add code to a page using the `@` character

The following code examples show how the `@` character can be used to implement inline expressions, single statement blocks, and multi-statement blocks:

```html
<!-- Single statement blocks  -->
@{ var myMessage = "Hello World"; }

<!-- Inline expressions -->
<p>The value of myMessage is: @myMessage</p>

<!-- Multi-statement block -->
@{
    var greeting = "Welcome to our site!";
    var weekDay = DateTime.Now.DayOfWeek;
    var greetingMessage = greeting + " Today is: " + weekDay;
}
<p>The greeting is: @greetingMessage</p>
```

The following code sample shows how to use a combination of .NET code and HTML to create the body of a table from a data model. The `@foreach`statement iterates through the `Model.FruitModels` data model and generates a table row containing the fruit name and if it's available.

```cshtml
@* Code is truncated for readability. *@
<tbody>
    @foreach (var obj in Model.FruitModels)
    {
        <tr>
            <td>@obj.name</td>
            <td>@obj.instock</td>
        </tr>
    }
</tbody>
```

## Further reading

To learn more about Razor syntax, visit the following pages:

* [Razor syntax reference for ASP.NET Core](/aspnet/core/mvc/views/razor?view=aspnetcore-7.0&preserve-view=true)
* [Introduction to ASP.NET Web Programming Using the Razor Syntax (C#)](/aspnet/web-pages/overview/getting-started/introducing-razor-syntax-c#the-top-8-programming-tips)
