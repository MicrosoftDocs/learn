Most modern applications are going to have dependencies that need to be managed during the build process. There are many package repositories to choose from when finding packages to use or when deciding where to store your packages. You can also host your own repository or use a file share. Our team chose to use an Azure Artifacts feed to share some code with another team in their organization. 

Sharing code between teams helps to reduce development time because you're not writing the same code more than once. It also reduces the time for testing since only one codebase needs to be tested. And any improvements made to the shared code will benefit everyone that uses it.

## Learn more

Deciding where to host your package will depend on many factors. For example, will it be public or private? Does the host have the features you need? Will you need to authenticate? Are there reasons it needs to be hosted locally? Not to mention the language for the package and the process for accessing it. Here are some links to documentation you'll want to check out when deciding where to host your packages.

* [NuGet Documentation](https://docs.microsoft.com/nuget/?azure-portal=true)
* [Deep dive into Azure Artifacts](https://azure.microsoft.com/en-us/blog/deep-dive-into-azure-artifacts/?azure-portal=true)
* [npm documentation](https://docs.npmjs.com?azure-portal=true)
* [Maven documentation](https://maven.apache.org/guides/?azure-portal=true)
* [Chocolaty documentation](https://chocolatey.org/docs?azure-portal=true)