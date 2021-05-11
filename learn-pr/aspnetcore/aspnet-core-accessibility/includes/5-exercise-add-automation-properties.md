Let's start implementing the design for the app by creating a new project and specifying some user interface for entering the project name.

## Create a new solution

Create a new ASP.NET Core web app app:

The .NET CLI is the simplest way to create an ASP.NET Core web API. The CLI is pre-installed when you installed the .NET SDK.

In this unit, you'll use the .NET CLI to create a web API locally. You'll also gain an understanding of the resulting project.

## Create and explore a web API project

To set up a .NET project to work with web API, we'll use Visual Studio Code. Visual Studio Code includes an integrated terminal, which makes creating a new project easy. If you don't want to use another code editor, you can run the commands in this module in a terminal.

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named **AccessibleWeb** in the location of your choice, and then click **Select Folder**.

1. Open the integrated terminal from Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command.

    ```dotnetcli
    dotnet new webapp
    ```

    This command creates the files for a basic web API project, along with a C# project file named **AccessibleWeb.csproj** that includes a few pages to get started. 

    You may receive a prompt from Visual Studio Code to add assets to debug the project. Click `Yes` on the dialog.  

    You should now have access to these files.

    ```bash
    -| obj
    -| Pages
      -| Shared
      -| _ViewImports.cshtml
      -| _ViewStart.cshtml
      -| Error.cshtml
      -| Error.cshtml.cs
      -| Index.cshtml
      -| Index.cshtml.cs
      -| Privacy.cshtml
      -| Privacy.cshtml.cs
    -| Properties
    -| appsettings.Development.json
    -| appsettings.json
    -| ContosoPizza.csproj
    -| Program.cs
    -| Startup.cs
    ```

## Create the data entry form

1. Open `Index.cshtml`.
1. Replace the contents of this page with the following markup:  

```razor
@page
@model IndexModel
@{
    ViewData["Title"] = "Home page";
}

<div class="text-center">
    <h1 class="display-4">Welcome</h1>
    <p>We hope you like pizza. That's what we make here.</p>
</div>

<style>
div.button {
  width: 200px;
  height: 50px;
  border-radius: 20px;
  background-color: lightgray;
  text-align: center;
  padding: 10px;
  margin: 50px;
}
</style>


<h1 class="display-6">Join our mailing list</h1>
<p>Sign up to hear about all our special offers!</p>

<form name="CustomerInfo">
<div class="container w-50 p-3">
  <div class="row">
    <div class="col-4 text-primary">
      First Name
    </div>
    <div class="col-8 text-muted">
      <input type="text" id="Name">
    </div>
  </div>
  <div class="row">
    <div class="col-4 text-primary">
      Last Name
    </div>
    <div class="col-8">
      <input type="text" id="Name">
    </div>
  </div>
  <div class="row text-black-50">
    <div class="col-4">
      Phone
    </div>
    <div class="col-8">
      <input type="text" id="Phone">
    </div>
  </div>
  <div class="row text-black-50">
    <div class="col-4">
      Birthday
    </div>
    <div class="col-8">
      <input type="text" id="Birthday">
    </div>
  </div>
  <div class="row text-primary">
    <div class="col-4">
      E-mail Address
    </div>
    <div class="col-8">
      <input type="text" id="E-mail">
    </div>
  </div>
  <div class="button">
    <a href="#" onclick="document.getElementById('CustomerInfo').Submit();">
      Submit Form
      </a>
  </div>
</div>
</form>

<p style="font-size: 30px"><b>All about our wonderful pizza!</b></p>
<p class="bg-light text-muted">We make it fresh every day, sometimes up to two or three times a day!<br><br>We love to make pizza!</p>

<p style="font-size: 30px"><b>Delivery options</b></p>
<p class="bg-light text-muted">There are a few ways we can get the pizza to you:<br>
- Postal mail<br>
- Dog sled<br>
- Drone (experimental!)
</p>
```

## Run the application

Run the application with the screen reader activated on the operating system of your choice. Notice that on some platforms, when you launch the application, all elements will be read by the screen reader. Use touch gestures or a keyboard to navigate through the items on the screen. 

Note:

- `Image` does not have any information as to what it is.
- `Entry` reads back generic information.
- `Button` reads the text of **Submit** out loud.

## Image accessibility

To have the screen reader see the `Image` as an accessible element we must set the `AutomationProperties.IsInAccessibleTree` property to `true`.  Add the following property to the `Image`:

   ```xaml
   AutomationProperties.IsInAccessibleTree="true"
   ```

We can provide additional information as to what the image is when it becomes focused by the screen reader by setting the `AutomationProperties.Name` property. Add the following property to the `Image`:

   ```xaml    
   AutomationProperties.Name="Image of dot net bot"
   ```

When you run the application again you will see that when the image gains focus, "Image of .NET Bot" is read out loud. Notice that we spelled out "dot net bot" to assist the screen reader with proper pronunciation. When setting text that will be read it is best practice to be aware of how the screen reader will read back text. For example, "a11y" which is an abbreviation for accessibility would be read back as "ay eleven why". Setting the label simply to "accessibility" would alleviate the need for any additional automation properties.

## Improve Entry accessibility with LabelBy

The `Entry` currently has no information about what the user should enter. There is a `Label` directly above the `Entry`, which provides the descriptor and can be used as text that the screen reader can read out loud by using the `AutomationProperties.LabeledBy` property. 


1. Add the following properties to the `Entry`:

   ```xaml
   AutomationProperties.LabeledBy="{x:Reference LabelName}"
   AutomationProperties.Name="{OnPlatform iOS='Project name'}"
   ```

2. Setting accessible properties on the `Entry` means that the _Project name_ `Label` doesn't need to be in the accessibility tree. Set the following property on the _Project name_ `Label`:

   ```xaml
   AutomationProperties.IsInAccessibleTree="False"
   ```

When you run the application again, you hear "Project name" read out loud when the `Entry` is in focus.

> [!NOTE]
> We set the `AutomationProperties.Name` on iOS because `AutomationProperties.LabeledByProperty` is not currently supported. You may consider only setting the `AutomationProperties.Name` based on your use case.

## Improve Button descriptors

When the `Button` is in focus, "Submit button" is read out loud by the screen reader. We can provide more context as to what will happen when the user taps the button, by setting the `AutomationProperties.HelpText` property. Add the following property to the `Button`:

```xaml
AutomationProperties.HelpText="Submits project information to backend"
```

When you run the application again, you will hear an improved description of the UI element as well as context for what will happen when it is pressed.

We have now explored the built-in automation properties of ASP.NET Core that enable developers to add more context for on-screen elements that are accessible to screen readers. Next, we will explore accessible content ordering to provide a better experience when a user navigates through elements.
