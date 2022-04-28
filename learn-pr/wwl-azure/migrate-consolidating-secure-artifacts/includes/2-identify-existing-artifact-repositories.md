An **artifact** is a deployable component of your application. Azure Pipelines can work with a wide variety of artifact sources and repositories.

When you're creating a release pipeline, you need to link the required artifact sources. Often, it will represent the output of a build pipeline from a continuous integration system like Azure Pipelines, Jenkins, or TeamCity.

The artifacts that you produce might be stored in source control, like Git or Team Foundation version control. But you might also be using package management tools when you get repositories.

When you need to create a release, you must specify which version of the artifacts is required. By default, the release pipeline will choose the latest version of the artifacts. But you might not want that.

For example, you might need to choose a specific branch, a specific build version, or perhaps you need to specify tags.

Azure Artifacts are one of the services that's part of Azure DevOps. Using it can eliminate the need to manage file shares or host private package services.

It lets you share code easily by allowing you to store Maven, npm, or NuGet packages together, cloud-hosted, indexed and matched.

Now, while we can do so, there's also no need to store your binaries in Git. You can keep them directly using universal packages. It's also a great way to protect your packages. Azure Artifacts provide universal artifact management from Maven, npm, and NuGet.

And sharing packages, you can easily access all of your artifacts in builds and releases because it integrates naturally with Azure Pipelines and its CI/CD tooling, along with versioning and testing.
