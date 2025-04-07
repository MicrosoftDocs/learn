When you package your Razor class library, you have a binary deliverable that other Blazor projects can reference and the components within it can be used in those projects.

In an earlier unit, you created a Razor class library with a modal component that delivers a modal dialog window for Blazor applications. To share that component for use in other applications, you need to package and place it in either a repository or a folder where other developers can acquire it.

In this unit, you update that project and generate a NuGet package. Finally, you deploy that NuGet package to your Blazor server application.

## Add package properties to FirstClassLibrary

Begin by updating the *FirstClassLibrary* project with properties that allow it to be packaged for deployment as a NuGet package.

1. Open the project file for the *FirstClassLibrary* project. Either double-click the project in Visual Studio Solution Explorer or open the **FirstClassLibrary*.csproj* file in Visual Studio Code.
1. Near the top of the file, in the section with the `<PropertyGroup>` tag, add the following content before the closing `</PropertyGroup>` tag:

    ```xml
        <PackageId>My.FirstClassLibrary</PackageId>
        <Version>0.1.0</Version>
        <Authors>YOUR NAME</Authors>
        <Company>YOUR COMPANY NAME</Company>
        <Description>This is a Razor component library with a cool modal window component.</Description>
      </PropertyGroup>
    ```

    This code defines your Razor class library as having `<PackageId>` "My.FirstClassLibrary" and `<Version>` 0.1.0. Enter your own name and company name in those two fields.

## Package the library for reuse

Next, you run the .NET command at the command line to package the Razor class library so that other applications outside your solution can reference it. 

You can run these same steps in your continuous integration process to package a library and deploy it to NuGet.org, a GitHub repository, or another location for your organization to share.

In the same folder as the *FirstClassLibrary.csproj* file, run the following command:

```dotnetcli
dotnet pack
```

This command writes a file named *My.FirstClassLibrary.0.1.0.nupkg* to your *bin/Release* folder.

## Add a reference to the NuGet package in the MyBlazorApp application

You already referenced the *FirstClassLibrary* project in your MyBlazorApp application, because it was in the same folder structure as the web application. 

Now, you undo that project reference and add a reference to the NuGet package that you created earlier.

The following steps *don't* describe a typical configuration. Library projects that reside in the same folders or solution as the applications that want to reference them can reference the project directly, as you saw in the earlier exercise.

1. Open the *MyBlazorApp.csproj* file either by double-clicking the *MyBlazorApp* project name in Visual Studio or by opening the file in Visual Studio Code.
1. In the *MyBlazorApp.csproj* file, remove the following line:

   `<ProjectReference Include="..\FirstClassLibrary\FirstClassLibrary.csproj" />`

1. In the same folder as *MyBlazorApp.csproj*, run the following command:

    ```dotnetcli
    dotnet add package My.FirstClassLibrary -s ../FirstClassLibrary/bin/Release
    ```

    This command grabs the NuGet package that you created earlier, installs a copy in your local NuGet package cache, and then adds a reference to that package in the *MyBlazorApp.csproj* file.

## Check your work

Did your new package install properly? Can you start the FirstServer application and see a modal window when the application starts?

Let's find out:

1. Start the MyBlazorApp application either in Visual Studio, by selecting F5, or in the MyBlazorApp folder, by running the following command:

   `dotnet run`

1. In your browser, go to the home page of the MyBlazorApp application: ``` https://localhost:5000 ```.

   Is the **My first Modal dialog** dialog displayed? If so, congratulations! You successfully packaged and deployed the *FirstClassLibrary* project correctly. Applications everywhere can now use your modal window component by referencing your newly created NuGet package.
