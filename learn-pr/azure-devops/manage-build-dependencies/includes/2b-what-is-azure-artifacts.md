In this unit, you'll get a brief overview about how you can use Azure Artifacts to securely create and manage packages that your apps can consume.

Let's check back in with the team as they decide whether Azure Artifacts is the appropriate way to host their .NET package.

**Mara:** It seems to me that it would make sense for us to host the new Models package in Azure Artifacts. We're all part of the Microsoft Azure DevOps organization already, so authentication would be easier than trying to set it up on a different package manager.

**Andy:** I looked into that before the meeting and it seems straightforward to me. I agree with Mara.

**Amita:** What's Azure Artifacts?

**Andy:** Azure Artifacts is a repository in your Azure DevOps organization where you can manage the dependencies for your codebase. Azure Artifacts can store your artifacts and your binaries. It provides a container, called a *feed*, for groups of dependencies. Developers who have access to the feed can easily consume or publish packages.

## How do I create a package and use it in the pipeline?

**Tim:** So, if I'm understanding right, the app code uses packages from NuGet already. We're going to create our own package and host it in Azure Artifacts. Can you draw out the pieces and how they'll work together? I'm having a hard time picturing the whole process.

**Andy:** Sure. Let's go over the process of creating a package and using it in our Azure DevOps pipeline.

*Andy moves to the whiteboard*.

:::image type="content" source="../media/2-azure-artifacts-whiteboard.png" alt-text="Illustration of a whiteboard diagram showing the steps to create and use a package.":::

### Create the package

First, we need to create a project in Azure Artifacts. :::image type="icon" source="../../shared/media/callout-01.png"::: We can do this from Azure DevOps.

Then, we create a pipeline in Azure Pipelines that connects to the GitHub repo for the package code. Then, the pipeline builds the code, packages it, and pushes the package to Azure Artifacts. :::image type="icon" source="../../shared/media/callout-02.png":::

We need to update the app that consumes this package to point to the Azure Artifacts feed that we created. :::image type="icon" source="../../shared/media/callout-03.png":::

After that, we update the pipeline that creates our app. The update allows us to use our Azure Artifacts feed to pull the new package dependency and build as normal. :::image type="icon" source="../../shared/media/callout-04.png":::

### Update the package

**Tim:** What if someone updates the package?

**Andy:** When you update the package with a new feature or bug fix and run tests to make sure it works correctly, bump up the version number of the package. Then, commit the change. The package pipeline sees the commit and creates a new artifact in Azure Artifacts with the new version number. Don't worry, the old package with the lower version number is still there for apps that depend on that version. This is why you don't typically unlist a package.

Our app might want to use this newer version of the package. In that case, we update the app to reference the newer version and run the tests locally to make sure this new version works with our app. When we're satisfied that everything works, we submit the app change to the pipeline. It builds with the new version of the package dependency.

**Amita:** This sounds like a good plan, and it will help the other team too. It will also keep the code from *drifting*, as you put it. That will help QA as well.

## Include a versioning strategy in your build pipeline

When you use a build pipeline, packages need versions before they can be consumed and tested. However, only after you've tested the package can you know its quality. Because package versions should never be changed, it becomes challenging to choose a certain version beforehand.

Azure Artifacts associates a quality level with each package in its feeds, and distinguishes between prerelease and release versions. Azure Artifacts offers different views on the list of packages and their versions, which separate them based on their quality level. This approach works well with semantic versioning, which is useful for predicting the intent of a particular version. Azure Artifacts also uses a descriptor to include additional metadata from the Azure Artifacts feed. A common use for views is to share package versions that have been tested, validated, or deployed, but hold back packages still under development and not ready for public consumption.

Feeds in Azure Artifacts have three different views by default. These views are added at the moment a new feed is created. The three views are:

* **Release**: The @release view contains all packages that are considered official releases.
* **Prerelease**: The @prerelease view contains all packages that have a label in their version number.
* **Local**: The @local view contains all release and prerelease packages and the packages downloaded from upstream sources.

You can use views to help package-feed consumers to filter between released and unreleased versions of packages. Essentially, views allow a consumer to make a conscious decision to choose from released packages, or opt in to prereleases of a certain quality level.

## Package security in Azure Artifacts

Ensuring the security of your packages is as important as ensuring the security of the rest of your code. One aspect of package security is securing access to the package feeds (where a feed, in Azure Artifacts, is where you store packages). Setting permissions on the feed allows you to share your packages with as many or as few people as your scenario requires.

### Feed permissions

Feeds have four levels of access: Owners, Contributors, Collaborators, and Readers. Each level of access has a certain set of permissions. For example, Owners can add any type of identity—individuals, teams, and groups—to any access level. By default, the Project Collection Build Service is a Collaborator and your project team is a Reader.

### Configure the pipeline to access security and license ratings

There are several tools available from third parties to help you assess the security and license rating of the software packages you use.

Some of these tools scan the packages as they're included in the build or CD pipeline. During the build process, the tool scans the packages and gives instantaneous feedback. During the CD process, the tool uses the build artifacts and performs scans. Two examples of such tools are [Mend Bolt](https://www.mend.io/free-developer-tools/bolt/) and [Black Duck](https://www.synopsys.com/software-integrity/security-testing/software-composition-analysis.html). With Azure DevOps, you use build tasks to incorporate scanning into your pipeline.
