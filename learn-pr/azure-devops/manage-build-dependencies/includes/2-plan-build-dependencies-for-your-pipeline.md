In this unit, you'll learn about packaging code to make it easier to share. You'll discover why you should make packages, what kinds of packages you can create, where you can host the packages, and how you access them when they are hosted. You'll also learn about package versioning, as well as Azure Artifacts.

First, let's check in and see how the team is doing. Andy has called the team together to talk about a potential change to their code that would help out another team.

**Andy:** Hi everyone. I was chatting with the team who's working on the back end system for _Space Game_. They could use the models we use for the website in a back end app they plan to write.

**Amita:** What do you mean by models?

**Andy:** As you know, the _Space Game_ website is an ASP.NET Core application. It uses the Model-View-Controller, or MVC, pattern to separate data from how that data is displayed in the user interface. I was thinking we could create a package that contains our model classes so that any app can use them.

**Amita:** What exactly is the goal?

**Andy:** Both of our teams will share the same database. The game sends the database high scores; we read these scores to display on the leaderboard.

**Amita:** That makes sense. How will we create this package?

**Andy:** That's why I wanted to chat with you. We have a few options, and I'm looking for ideas.

**Tim:** I'd love to help, but first I have some questions. I'm new to this and I want to understand how it all works.

## What is a package?

A _package_ contains reusable code that other developers can use in their own projects, even though they didn't write it.

For compiled languages, a package typically contains the compiled binary code, such as .dll files in .NET, or .class files in Java. For languages that are interpreted instead of compiled, such as JavaScript or Python, a package might include source code.

Either way, packages are typically compressed to ZIP or a similar format. Package systems will often define a unique file extension, such as .nupkg or .jar, to make the package's use clear. Compression can help reduce download time, and also produces a single file to make management simpler.

Packages also often contain one or more files that provide metadata, or information, about the package. This metadata might describe what the package does, specify its license terms, the author's contact information, and the package's version.

## Why should I build a package?

There are advantages to building a package as opposed to duplicating the code.

One reason to create a package instead of duplicating code is to prevent _drift_. When code is duplicated, each copy can quickly diverge to satisfy the requirements of a particular app. It becomes difficult to migrate changes from one copy to the others. In other words, you lose the ability to improve the code in ways that benefit everyone.

Packages also group related functionality into one reusable component. Depending on the programming language, a package can provide apps with access to certain types and functions, while restricting access to their implementation details.

Another reason to build a package is to provide a consistent way to build and test that package's functionality. When code is duplicated, each app might build and test that code in different ways. One set of tests might include checks that another set could benefit from.

One tradeoff is that with a package, you have another codebase to test and maintain. You must also be careful when adding features. Generally speaking, a package should contain features that benefit many kinds of apps. For example, [Json.NET](https://www.newtonsoft.com/json?azure-portal=true) is an extremely popular NuGet package for .NET that enables you to work with JSON files. Json.NET is open source, so the community can propose improvements and report issues.

When multiple apps can benefit from the same code, the advantages far outweigh the disadvantages. You have just one codebase, just one set of tests, and just one build process to manage.

## What kinds of packages are there?

Each programming language or framework provides its own way to build packages. Popular package systems provide documentation about how the process works.

You might already be familiar with these popular package systems:

* **NuGet**: packages .NET libraries
* **Maven**: packages Java libraries
* **npm**: packages JavaScript libraries
* **Chocolatey**: packages Windows applications
* **RubyGems**: packages Ruby libraries

## Where are packages hosted?

You can host packages on your own network, or you can use a hosting service. A hosting service is often called a _package repository_ or _package registry_. Many of these services provide free hosting for open source projects.

Here are popular hosting services for the package types we just described:

* **NuGet**: [nuget.org](https://www.nuget.org?azure-portal=true)
* **Maven**: [apache.org](https://www.apache.org?azure-portal=true)
* **npm**: [npmjs.com](https://www.npmjs.com?azure-portal=true)
* **Chocolatey**: [chocolatey.org](https://chocolatey.org?azure-portal=true)
* **RubyGems**: [rubygems.org](https://rubygems.org?azure-portal=true)

A _package feed_ refers to your package repository server. This server can be on the internet or behind your firewall on your network. For example, you can [host your own NuGet feeds](https://docs.microsoft.com/nuget/hosting-packages/overview?azure-portal=true) by using hosting products, such as Azure Artifacts and MyGet. You can also host packages on a file share.

When you host packages behind the firewall, you can include feeds to your own packages. You can also cache packages that you trust on your network when your systems can't connect to the internet.

## Who can access packages?

Many package feeds provide unrestricted access to packages. For example, you can download [Json.NET](https://www.nuget.org/packages/Newtonsoft.Json/?azure-portal=true) from nuget.org, without the need to sign in or authenticate.

Other package feeds require authentication. You can authenticate access to feeds in a few ways. For example, some kinds of feeds require a username and password. Other feeds require an _access token_, which is typically a long series of characters that identify who you are and what resources you have access to. Access tokens can be set to expire after a given time period.

## How are packages versioned?

The versioning scheme depends on the packaging system you use.

For example, NuGet packages use [Semantic Versioning](https://semver.org/?azure-portal=true).

Semantic Versioning is a popular versioning scheme. Here's the format:

> **Major.Minor.Patch[-Suffix]**

Here is what each of these parameters means:

* A new **Major** version introduces breaking changes. Apps typically need to update how they use the package to work with a new major version.
* A new **Minor** version introduces new features, but is backward compatible with earlier versions.
* A new **Patch** introduces backward compatible bug fixes, but not new features.

The **-Suffix** part is optional and identifies the package as a pre-release version. For example, 1.0.0-beta1 might identify the package as the first beta pre-release build for the 1.0.0 release.

When you reference a package, you do so by version number.

Here is an example of installing a package by using PowerShell and a specific version number.

```powershell
Install-Package -Name "Json.NET" -Version 12.0.2
```

## What happens when the package changes?

When you reference a package from your app, you typically _pin_, or specify, the version of that package you want to use.

Many frameworks enable you to specify allowable ranges of package versions to install. Some also enable you to specify wildcards, which we call a _floating version_.

For example, in NuGet, version "1.0" means the first version that's equal to or greater than 1.0. "[1.0]" specifies to install version 1.0 only, and not a newer version.

Here are a few other examples:

| This notation: | Selects:                                                                            |
|----------------|-------------------------------------------------------------------------------------|
| (1.0,)         | The first version that's greater than 1.                                            |
| [1.0,2.0]      | The first version that's greater than or equal to 1.0, and less than or equal to 2.0 |
| (1.0,2.0)      | The first version that's greater than 1.0 and less than 2.0                         |
| [1.0,2.0)      | The first version that's greater than or equal to 1.0, and less than 2.0             |

As each maintainer releases a new package version, you can evaluate what's changed and test your app against it. When you're ready, you can update the package's version number in your configuration, and submit the change to your build pipeline.

Here's an example of the package dependencies from our Tailspin-SpaceGame-Web project file. In this project, we depend on packages such as Newtonsoft.Json, and you can see that we specify version 12.0.1 of that package.

```xml
<ItemGroup>
  <PackageReference Include="Newtonsoft.Json" Version="12.0.1" />
</ItemGroup>
```

## What is Microsoft Azure Artifacts?

**Mara:** It seems to me it would make sense for us to host the new Models package in Azure Artifacts. We're all part of the Microsoft Azure DevOps organization already, so authentication would be easier than trying to set it up on a different package manager.

**Andy:** I looked into that before the meeting and it seems straightforward to me. I agree with Mara.

**Amita:** What's Azure Artifacts?

**Andy:** Azure Artifacts is a repository in your Azure DevOps organization where you can manage the dependencies for your codebase. Azure Artifacts can store your artifacts and your binaries. It provides a container, called a *feed*, for groups of dependencies. Developers who have access to the feed can easily consume or publish packages.

## How do I create a package and use it in the pipeline?

**Tim:** So if I am understanding right, the app code uses packages from NuGet already. We're going to create our own package and host it in Azure Artifacts. Can you draw out the pieces and how they'll work together? I'm having a hard time picturing the whole process.

**Andy:** Sure. Let's go over the process of creating a package and using it in our Azure DevOps pipeline.

Andy moves to the whiteboard.

![Whiteboard diagram showing the steps to create and use a package](../media/2-azure-artifacts-whiteboard.png)

### Create the package

First, we need to create a project in Azure Artifacts. ![Callout 1](../../shared/media/callout-01.png) We can do this from Azure DevOps.

Then, we create a pipeline in Azure Pipelines that connects to the GitHub repo for the package code. Then the pipeline builds the code, packages it, and pushes the package to Azure Artifacts. ![Callout 2](../../shared/media/callout-02.png)

We need to update the app that consumes this package to point to the Azure Artifacts feed that we created. ![Callout 3](../../shared/media/callout-03.png)

After that, we update the pipeline that creates our app. The update enables us to use our Azure Artifacts feed to pull the new package dependency, and build as normal. ![Callout 4](../../shared/media/callout-04.png)

### Update the package

**Tim:** What if someone updates the package?

**Andy:** When you update the package with a new feature or bug fix, and run tests to make sure it works correctly, bump up the version number of the package. Then, commit the change. The pipeline for the package sees the commit, and creates a new artifact in Azure Artifacts with the new version number. Don't worry, the old package with the lower version number is still there for apps that depend on that version. For this reason, you don't typically unlist a package.

Our app might want to use this newer version of the package. In that case, we update the app to reference the newer version, and run the tests locally to make sure this new version works with our app. When we're satisfied that everything works, we submit the app change to the pipeline. It builds with the new version of the package dependency.

**Amita:** This sounds like a good plan, and it will help the other team too. And it will keep the code from *drifting*, as you put it. That will help QA as well.

**Mara:** Great! If it's settled, I'll move the code for the package into its own repository.

**Andy:** I'll get started on setting up the Azure Artifacts feed.
