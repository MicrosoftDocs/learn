In this unit, you'll learn about packaging code to make it easier to share. You'll discover why you should make packages, the kinds of packages you can create, where you can host the packages, and how you can access them when they're hosted. You'll also learn about package versioning.

Codebases are always growing larger and more complex. It's unusual for a team to write all the code that their app uses. Instead, the team includes existing code written by other developers. There can be many of these packages, or dependencies, in an app. It's important to actively manage these dependencies to be able to maintain them properly and make sure they meet security requirements.

Let's check in and see how the team is doing. Andy has called the team together to talk about a potential change to their code that would help out another team.

## Team meeting

**Andy:** Hi everyone. I was chatting with the team that's working on the back end system for _Space Game_. They could use the models we use for the website in a back-end app they plan to write.

**Amita:** What do you mean by models?

**Andy:** As you know, the _Space Game_ website is an ASP.NET Core application. It uses the Model-View-Controller—or MVC—pattern to separate data from how that data is displayed in the user interface. I was thinking we could create a package that contains our model classes so that any app can use them.

**Amita:** What exactly is the goal?

**Andy:** Both of our teams will share the same database. The game sends the database high scores; we read these scores to display on the leaderboard.

**Amita:** That makes sense. How will we create this package?

**Andy:** That's why I wanted to chat with you. We have a few options, and I'm looking for ideas.

**Tim:** I'd love to help, but first I have some questions. I'm new to this and I want to understand how it all works.

## What is a package?

A _package_ contains reusable code that other developers can use in their own projects, even though they didn't write it.

For compiled languages, a package typically contains the compiled binary code, such as .dll files in .NET, or .class files in Java. For languages that are interpreted instead of compiled, such as JavaScript or Python, a package might include source code.

Either way, packages are typically compressed to ZIP or a similar format. Package systems often define a unique file extension, such as *.nupkg* or *.jar*, to make the package's use clear. Compression can help reduce download time and also produce a single file to simplify management.

Packages also often contain one or more files that provide metadata, or information about the package. This metadata might describe what the package does, specify its license terms, the author's contact information, and the package's version.

## Why should I build a package?

There are advantages to building a package as opposed to duplicating the code.

One reason to create a package instead of duplicating code is to prevent _drift_. When code is duplicated, each copy can quickly diverge to satisfy the requirements of a particular app. It becomes difficult to migrate changes from one copy to the others. In other words, you lose the ability to improve the code in ways that benefit everyone.

Packages also group related functionality into one reusable component. Depending on the programming language, a package can provide apps with access to certain types and functions, while restricting access to their implementation details.

Another reason to build a package is to provide a consistent way to build and test that package's functionality. When code is duplicated, each app might build and test that code in different ways. One set of tests might include checks from which another set could benefit.

One tradeoff is that you have another codebase to test and maintain with a package. You must also be careful when adding features. Generally speaking, a package should contain features that benefit many kinds of apps. For example, [Json.NET](https://www.newtonsoft.com/json?azure-portal=true) is a popular NuGet package for .NET that allows you to work with JSON files. Json.NET is open source, so the community can propose improvements and report issues.

When multiple apps can benefit from the same code, the advantages far outweigh the disadvantages. You have just one codebase, just one set of tests, and just one build process to manage.

## How can I identify dependencies?

If the goal is to reorganize your code into separate components, you need to identify those pieces of your app that can be removed, packaged to be made reusable, stored in a central location, and versioned. You might even want to replace your own code with third-party components that are either open source or that you license.

There are many ways to identify the potential dependencies in your codebase. These include scanning your code for patterns of reuse, and analyzing the architecture of your solution. Here are some ways to identify dependencies:

* **Duplicate code**.

    If certain pieces of code appear in several places, that's a good indication that you can reuse the code. Centralize these duplicate pieces of code and repackage them appropriately.

* **High cohesion and low coupling**.

    A second approach is to look for code elements that have a high cohesion to each other and low coupling with other parts of the code. In essence, high cohesion means keeping parts of a codebase that are related to each other in a single place. Low coupling, at the same time, is about separating unrelated parts of the code base as much as possible.

* **Individual lifecycle**.

    Look for parts of the code that have a similar lifecycle that you can deploy and release individually. If this code can be maintained by a separate team, it's a good indication you can package it as a component outside of the solution.

* **Stable parts**.

    Some parts of your codebase might be stable and change infrequently. Check your code repository to find code with a low change frequency.

* **Independent code and components**.

    Whenever code and components are independent and unrelated to other parts of the system, you can potentially isolate them into separate dependencies.

You can use various tools to assist you in scanning and examining your codebase. These range from tools that scan for duplicate code and draw solution dependency graphs to tools that can compute metrics for coupling and cohesion.

## What kinds of packages are there?

Each programming language or framework provides its own way to build packages. Popular package systems provide documentation about how the process works.

You might already be familiar with these popular package systems:

* **NuGet**: packages .NET libraries
* **NPM**: packages JavaScript libraries
* **Maven**: packages Java libraries
* **Docker**: packages software in isolated units called _containers_

## Where are packages hosted?

You can host packages on your own network, or you can use a hosting service. A hosting service is often called a _package repository_ or _package registry_. Many of these services provide free hosting for open-source projects.

Here are some popular hosting services for the package types we just described:

* [NuGet Gallery](https://www.nuget.org/?azure-portal=true)

    NuGet packages are used for .NET code artifacts. These artifacts include .NET assemblies and related files, tooling and, sometimes, metadata. NuGet defines the way packages are created, stored, and consumed. A NuGet package is essentially a compressed folder structure with files in the ZIP format and has the *.nupkg* extension.

* [NPM](https://www.npmjs.com/?azure-portal=true)

    An NPM package is used for JavaScript. An NPM package is a file or folder that contains JavaScript files and a package.json file that describes the metadata of the package. For node.js, the package usually contains one or more modules that can be loaded after the package is consumed.

* [Maven Central Repository](https://mvnrepository.com/repos/central/?azure-portal=true)

    Maven is used for Java-based projects. Each package has a Project Object Model file that describes the metadata of the project, and is the basic unit for defining a package and working with it.

* [Docker Hub](https://hub.docker.com/?azure-portal=true)

    Docker packages are called images, and contain complete, self-contained deployments. Most commonly, a Docker image represents a software component that can be hosted and executed by itself, without any dependencies on other images. Docker images are layered and might be dependent on other images.

A _package feed_ refers to your package repository server. This server can be on the internet or behind your firewall on your network. For example, you can [host your own NuGet feeds](/nuget/hosting-packages/overview?azure-portal=true) by using hosting products such as Azure Artifacts and MyGet. You can also host packages on a file share.

When you host packages behind the firewall, you can include feeds to your own packages. You can also cache packages that you trust on your network when your systems can't connect to the internet.

## What elements make up a good dependency management strategy?

A good dependency management strategy depends on these three elements:

* **Standardization**.

    Standardizing how you declare and resolve dependencies will help your automated release process remain repeatable and  predictable.

* **Packaging formats and sources**.

    Each dependency should be packaged using the applicable format and stored in a central location.

* **Versioning**.

    You need to keep track of the changes that occur over time in dependencies just as you do with your own code. This means that dependencies should be versioned.

## Who can access packages?

Many package feeds provide unrestricted access to packages. For example, you can download [Json.NET](https://www.nuget.org/packages/Newtonsoft.Json/?azure-portal=true) from nuget.org, without the need to sign in or authenticate.

Other package feeds require authentication. You can authenticate access to feeds in a few ways. For example, some kinds of feeds require a username and password. Other feeds require an _access token_, which is typically a long series of characters that identifies who you are and to what resources you have access. You can set access tokens to expire after a given time period.

## How are packages versioned?

The versioning scheme depends on the packaging system you use.

For example, NuGet packages use [Semantic Versioning](https://semver.org/?azure-portal=true).

Semantic Versioning is a popular versioning scheme. Here's the format:

> **Major.Minor.Patch[-Suffix]**

Here is what each of these parameters means:

* A new **Major** version introduces breaking changes. Apps typically need to update how they use the package to work with a new major version.
* A new **Minor** version introduces new features, but is backward-compatible with earlier versions.
* A new **Patch** introduces backward-compatible bug fixes, but not new features.
* The **-Suffix** part is optional and identifies the package as a pre-release version. For example, 1.0.0-beta1 might identify the package as the first beta prerelease build for the 1.0.0 release.

When you reference a package, you do so by version number.

Here's an example of installing a package by using PowerShell and a specific version number:

```powershell
Install-Package Newtonsoft.Json -Version 13.0.1
```

## What happens when the package changes?

When you reference a package from your app, you typically _pin_—or specify—the version of that package you want to use.

Many frameworks let you specify allowable ranges of package versions to install. Some also allow you to specify wildcards, which we call a _floating version_.

For example, in NuGet, version "1.0" means the first version that's equal to or greater than 1.0. "[1.0]" specifies to install version 1.0 only, and not a newer version.

Here are a few other examples:

| This notation: | Selects:                                                                            |
|----------------|-------------------------------------------------------------------------------------|
| (1.0,)         | The first version that's greater than 1.                                            |
| [1.0,2.0]      | The first version that's greater than or equal to 1.0, and less than or equal to 2.0 |
| (1.0,2.0)      | The first version that's greater than 1.0 and less than 2.0                         |
| [1.0,2.0)      | The first version that's greater than or equal to 1.0, and less than 2.0             |

As each maintainer releases a new package version, you can evaluate what's changed and test your app against it. When you're ready, you can update the package's version number in your configuration and submit the change to your build pipeline.

Here's an example of how you might include the Newtonsoft.Json package in your C# application's project (.csproj) file. This example specifies version 13.0.1 of that package:

```xml
<ItemGroup>
  <PackageReference Include="Newtonsoft.Json" Version="13.0.1" />
</ItemGroup>
```
