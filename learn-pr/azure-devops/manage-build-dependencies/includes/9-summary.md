The team has really come a long way. They now know how to use Microsoft Azure Pipelines along with Microsoft Azure Artifacts to create packages, and to store them in a place where other teams in the company can use them. Azure DevOps is all about sharing and collaboration. Creating reuseable code and making it available to others is a great way to foster those values.

Most modern apps have dependencies that need to be managed during the build process. There are many package repositories to choose from when you're looking for packages to use, or when you're deciding where to store your packages. You can also host your own repository or use a file share.

Sharing code between and among teams helps to reduce development time because you're not writing the same code more than once. It also reduces the time for testing, because only one codebase needs to be tested. Any improvements made to the shared code benefit everyone who uses it.

## Learn more

Deciding where to host your package depends on many factors. For example:

* Will it be public or private?
* Does the host have the features you need?
* Will you need to authenticate access to the package?
* Are there reasons it needs to be hosted on-premises?

You might need to consider the language of the package and the process for accessing it. Here are some resources to check out when you're deciding where to host your packages:

* [Deep dive into Azure Artifacts](https://azure.microsoft.com/blog/deep-dive-into-azure-artifacts/?azure-portal=true)
* [NuGet Documentation](https://docs.microsoft.com/nuget/?azure-portal=true)
* [npm documentation](https://docs.npmjs.com?azure-portal=true)
* [Maven documentation](https://maven.apache.org/guides/?azure-portal=true)
* [Chocolatey documentation](https://docs.chocolatey.org/en-us/)

## Appendix

The following sections are optional. They provide additional information beyond what's covered in this module.

### More about dependency management

Now that you've got some practical experience with using packages in the pipeline, let's talk about some general principles of dependency management.

Codebases are always growing larger and more complex. It's unusual for a team to write all the code that their app uses. Instead, the team includes existing code written by other developers and there can be many of these packages, or dependencies, in an app. It's important to actively manage these dependencies to be able to maintain them properly and make sure they meet security requirements.

#### Elements of a dependency management strategy

A good dependency management strategy depends on these three elements:

* Standardization.

    Standardizing how you declare and resolve dependencies will help your automated release process remain repeatable and  predictable.
* Packaging formats and sources.

    Each dependency should be packaged using the applicable format and stored in a central location.

* Versioning.

    You need to keep track of the changes that occur over time in dependencies just as you do with your own code. This means that dependencies should be versioned.

#### Identify dependencies

If the goal is to reorganize your code into separate components, you need to identify those pieces of your app that can be removed, packaged to be reusable, stored in a central location, and versioned. You may even want to replace your own code with third-party components that are either open source or that you license.

There are a number of ways to identify the potential dependencies in your codebase. These include scanning your code for patterns of reuse, as well as analyzing the architecture of your solution. Here are some ways to identify dependencies:

* Duplicate code.

    If certain pieces of code appear in several places, that's a good indication that this code can be reused. Centralize these duplicate pieces of code and repackage them appropriately.

* High cohesion and low coupling.

    A second approach is to look for code elements that have a high cohesion to each other and low coupling with other parts of the code. In essence, high cohesion means keeping parts of a codebase that are related to each other in a single place. Low coupling, at the same time, is about separating unrelated parts of the code base as much as possible.

* Individual lifecycle.

    Look for parts of the code that have a similar lifecycle and can be deployed and released individually. If this code can be maintained by a separate team, it's a good indication that it can be packaged as a component outside of the solution.

* Stable parts.

    Some parts of your codebase might be stable and change infrequently. Check your code repository to find code with a low change frequency.

* Independent code and components.

    Whenever code and components are independent and unrelated to other parts of the system, they can potentially be isolated into separate dependencies.

You can use a variety of tools to assist you in scanning and examining your codebase. These range from tools that scan for duplicate code and draw solution dependency graphs to tools that can compute metrics for coupling and cohesion.

#### Types of packages

Earlier in this module, we described some of the formats that are available. Here's more information about them.

* NuGet.

    NuGet packages are used for .NET code artifacts. These artifacts include .NET assemblies and related files, tooling and, sometimes, metadata. NuGet defines the way packages are created, stored, and consumed. A NuGet package is essentially a compressed folder structure with files in the ZIP format and has the *.nupkg* extension. See also, [An introduction to NuGet](https://docs.microsoft.com/nuget/what-is-nuget?azure-portal=true).

* NPM.

    An NPM package is used for JavaScript. An NPM package is a file or folder that contains JavaScript files and a package.json file that describes the metadata of the package. For node.js, the package usually contains one or more modules that can be loaded after the package is consumed. See also, [About packages and modules](https://docs.npmjs.com/about-packages-and-modules?azure-portal=true).

* Maven.

    Maven is used for Java-based projects. Each package has a Project Object Model file that describes the metadata of the project, and is the basic unit for defining a package and working with it. See also, [Apache Maven Project](https://maven.apache.org/?azure-portal=true).

* Docker.

    Docker packages are called images and contain complete, self-contained deployments. Most commonly, a Docker image represents a software component that can be hosted and executed by itself, without any dependencies on other images. Docker images are layered and might be dependent on other images. See also, [Docker](https://www.docker.com/?azure-portal=true).

#### Include a versioning strategy in the build pipeline

When you use a build pipeline, packages need versions before they can be consumed and tested. However, only after you've tested the package can you know its quality. Because package versions should never be changed, it becomes challenging to choose a certain version beforehand.

[Azure Artifacts](https://docs.microsoft.com/azure/devops/artifacts/?view=azure-devops&azure-portal=true) associates a quality level with each package in its feeds, as well as distinguishing between prerelease and release versions. Azure Artifacts offers different views on the list of packages and their versions, which separate them based on their quality level. This approach works well with semantic versioning, which is useful for predicting the intent of a particular version. Azure Artifacts also uses a descriptor to include additional metadata from the Azure Artifacts feed. A common use for views is to share package versions that have been tested, validated, or deployed but hold back packages still under development and not ready for public consumption.

Feeds in Azure Artifacts have three different views by default. These views are added at the moment a new feed is created. The three views are:

* Release. The @release view contains all packages that are considered official releases.
* Prerelease. The @prerelease view contains all packages that have a label in their version number.
* Local. The @local view contains all release and prerelease packages as well as the packages downloaded from upstream sources.

#### Using views

You can use views to help consumers of a package feed to filter between released and unreleased versions of packages. Essentially, views allow a consumer to make a conscious decision to choose from released packages, or opt-in to prereleases of a certain quality level.

### Package security in Azure Artifacts

Ensuring the security of your packages is as important as ensuring the security of the rest of your code. One aspect of package security is securing access to the package feeds where a feed, in Azure Artifacts, is where you store packages. Setting permissions on the feed allows you to share your packages with as many or as few people as your scenario requires.

#### Feed permissions overview

Feeds have four levels of access: Owners, Contributors, Collaborators, and Readers. Each level of access has a certain set of permissions. For example, Owners can add any type of identity-individuals, teams, and groups-to any access level. By default, the Project Collection Build Service is a Contributor and your project team is a Reader.

To learn more about how to configure secure access to package feeds, see [Secure and share packages using feed permissions](https://docs.microsoft.com/azure/devops/artifacts/feeds/feed-permissions?view=azure-devops?azure-portal=true).

#### Configure the pipeline to access security and license ratings

There are several tools available from third parties to help you assess the security and license rating of the software packages you use.

Some of these tools scan the packages as they are included in the build or CD pipeline. During the build process, the tool scans the packages and gives instantaneous feedback. During the CD process, the tool uses the build artifacts and performs scans. Two examples of such tools are [WhiteSource Bolt](https://bolt.whitesourcesoftware.com/?azure-portal=true) and [Black Duck](https://www.blackducksoftware.com/?azure-portal=true). With Azure DevOps, you use build tasks to incorporate scanning into your pipeline.

To learn how to incorporate WhiteSource Bolt into your pipeline, see [Scan open source components for vulnerabilities and license ratings in Azure Pipelines](/learn/modules/scan-open-source/?azure-portal=true).
