You've successfully created your web app and published it to Azure, but what happens when you want to make changes? Visual Studio will remember where the app is published, which makes updating and changing your app a two-click process.

## Explore the project structure

We've created an ASP.NET web app in Visual Studio, and now you will need to edit and customize your website. Let's explore the project structure to see what Visual Studio has created for us.

### Dependencies

Dependencies include the ASP.NET internals to get your app up and running. Unless you are adding specific third-party packages, you won't need to spend much time in this folder.

### Properties

The properties folder contains configuration data for where you are hosting your web app. If you expand the **PublishProfiles** folder now, you should see the URL for the Alpine Ski Hill site. Each publishing profile is an .xml file containing publishing configuration information, such as the Azure address that Visual Studio uses to upload your files.

### wwwroot

The wwwroot file contains all of your static assets for your site, such as the .css, .js, images, and .lib files. When you are ready to style and add more functionality to your site, you will work in here.

### Pages

The **Pages** folder includes _**Razor**_ templates for the pages of your site.
Razor is a syntax that is built up around HTML, which has special conventions for displaying data and executing logic on your site.

Each page in your site is represented with two code files:

- The first is a `.cshtml` file, which is the Razor markup file. This file includes your display HTML and some C# logic.

- The second file is a `.cs` file, which is the C# code-behind that includes `PageModel` class. This file allows you to intercept HTTP requests and do some processing on that request before passing off any data to the Razor file.

### appsetting.json

This is a configuration file for ASP.NET.

### bundleconfig.json

The bundleconfig.json is preprocessing configuration. This file is making your .css and .js files smaller when they are published.

### Program.cs and Startup.cs

Program.cs and Startup.cs configure and launch your web host for your site.

## Introduction to Razor templates

We will want to make some basic changes to our website. In order to do this, you will need to have a basic understanding of how to leverage the Razor templates to customize your web app.

## What is Razor?

Razor is an ASP.NET syntax used to create dynamic web pages with C#. When a server reads a Razor page, the C# code is run before it renders the HTML. This allows you to generate dynamic content quickly.

Razor uses `@` directives to tell ASP.NET how to process a page.

For example, take a look at the code in the `Contact.cshtml` page:

```aspx-csharp
@page
@model ContactModel
@{
    ViewData["Title"] = "Contact";
}
<h2>@ViewData["Title"]</h2>
<h3>@Model.Message</h3>
...
```

- The `@page` directive is telling ASP.NET to process this file as a Razor page.
- The `@model` directive is telling ASP.NET to tie this Razor page with a C# class called `ContactModel`.

Razor also uses the `@` symbol to transition between code and HTML. If you look at the snippet above, you'll notice `@{ ... }`. This is a **Razor code block**. It's code which is _executed but not rendered_.

To render the output of a code statement, we use the `@` in front of a C# expression. We have two examples of that in the code block above in the `<h2>` and `<h3>` tags.

Creating and publishing a website are just the first steps in creating a good website. Once you start to add content, you'll need to update your site. Once you've initially published your site to Azure, you can update at any time.
