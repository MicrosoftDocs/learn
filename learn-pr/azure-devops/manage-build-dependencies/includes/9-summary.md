The team has really come a long way. They know how to use Azure Pipelines and Azure Artifacts to create packages and store them in a place where other teams in the company can use them. Azure DevOps is all about sharing and collaboration. Creating reusable code and making it available to others is a great way to foster those values.

Most modern apps have dependencies that need to be managed during the build process. There are many package repositories from which to choose when you're looking for packages to use, or when you're deciding where to store your packages. You can also host your own repository or use a file share.

Sharing code between and among teams helps to reduce development time, because you're not writing the same code more than once. It also reduces testing time, because only one codebase needs to be tested. Any improvements made to the shared code benefit everyone who uses it.

## Learn more

Deciding where to host your package depends on many factors. For example:

* Will it be public or private?
* Does the host have the features you need?
* Will you need to authenticate access to the package?
* Are there reasons it needs to be hosted on-premises?

You might need to consider the package's language and the process for accessing it. Here are some resources to check out when you're deciding where to host your packages:

* [Azure Artifacts overview](/azure/devops/artifacts/start-using-azure-artifacts?azure-portal=true)
* [NuGet](/nuget/?azure-portal=true)
* [NPM](https://docs.npmjs.com?azure-portal=true)
* [Maven](https://maven.apache.org/?azure-portal=true)
* [Docker](https://www.docker.com/?azure-portal=true)

To learn more about how to configure secure access to package feeds, see [Manage permissions](/azure/devops/artifacts/feeds/feed-permissions?azure-portal=true).
