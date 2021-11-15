Packaging our Razor Class library delivers a binary deliverable that can be referenced by Blazor projects and the contained components can be used in those projects.

Previously, we created a Razor class library that contains a `Modal` component that delivers a modal dialog window for Blazor applications.  If we would like to share that component for use in other applications, we need to package and place it in a repository or a folder where other developers can acquire it.

In this unit, we are going to update that project and generate a NuGet package.  Finally, we will deploy that NuGet package to our Blazor server application.

## Add package properties to FirstClassLibrary

We will first update the FirstClassLibrary project with properties that will allow it to be packaged for deployment as a NuGet package.  

1. Open the project file for the MyClassLibrary project by either double-clicking on the project in the Visual Studio Solution Explorer or opening `MyClassLibrary.csproj` in Visual Studio Code
1. In the section near the top of the file with the `<PropertyGroup>` tag, add the following content before the closing `</PropertyGroup>` tag:

    ```xml
        <PackageId>My.FirstClassLibrary</PackageId>
        <Version>0.1.0</Version>
        <Authors>YOUR NAME HERE</Authors>
        <Company>YOUR COMPANY NAME</Company>
        <Description>This is a razor component library with a cool Modal window component.</Description>
      </PropertyGroup>
    ```

1. This defines our Razor class library as having package name "My.FirstClassLibrary" and a version of 0.1.0.  You can set your own name and company name appropriately in those two fields.

## Package the Library for reuse

Next, let's run the .NET command at the command line to package the Razor class library so that other applications outside of our solution can reference it.  You could run these same steps in your continuous integration process to package a library and deploy it to NuGet.org, a GitHub repository, or another location for your organization to share.

1. From the command line, in the same folder as the `MyClassLibrary.csproj` file, execute the following:

    ```dotnetcli
    dotnet pack
    ```

1. This will write a file called `My.FirstClassLibrary.0.1.0.nupkg` into your `bin/Debug` folder.

## Add a reference to the NuGet package in the MyServer application

We already referenced the FirstClassLibrary project in our MyServer application since it was in the same folder structure as the web application.  Let's undo that project reference and add a reference to the NuGet package we created.  

These steps are NOT a typical configuration. Library projects residing in the same folders or solution as the applications that want to reference them can reference the project directly as we saw in the previous exercise.  

1. Open the `MyServer.csproj` file by double-clicking on the MyServer project name in Visual Studio or opening that file in Visual Studio Code.
1. Remove the line `<ProjectReference Include="..\FirstClassLibrary\FirstClassLibrary.csproj" />`
1. On the command line, in the same folder as `MyServer.csproj` execute the following:

    ```dotnetcli
    dotnet add package My.FirstClassLibrary -s ..\FirstClassLibrary\bin\Debug
    ```

    This grabs the NuGet package created in the last step and installs a copy in our local NuGet package cache.  It then adds a reference to that package inside of `MyServer.csproj`

## Check your work

Did our new package install properly?  Can we start the FirstServer application and see a modal window when the application starts?

1. Start the MyServer application by pressing F5 in Visual Studio or at the command line in the MyServer folder execute `dotnet run`
1. Navigate a browser to the home page of the MyServer application (typically `https://localhost:5000`)
1. Do you see the 'My first Modal dialog'?  If so, congratulations! You've successfully packaged and deployed the FirstClassLibrary correctly. Applications everywhere can now use your modal window component by referencing your new NuGet package.
