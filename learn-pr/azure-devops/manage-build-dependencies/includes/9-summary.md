The team has really come a long way. They now know how to use Azure Pipelines along with Azure Artifacts to create packages and store them in a place where other teams in the company can use them. DevOps is all about sharing and collaboration. Creating reuseable code and making it available to others is a great way to foster those values.

Most modern applications are going to have dependencies that need to be managed during the build process. There are many package repositories to choose from when finding packages to use or when deciding where to store your packages. You can also host your own repository or use a file share.

Sharing code between teams helps to reduce development time because you're not writing the same code more than once. It also reduces the time for testing since only one codebase needs to be tested. Any improvements made to the shared code will benefit everyone that uses it.

## Learn more

Deciding where to host your package will depend on many factors. For example:

* Will it be public or private?
* Does the host have the features you need?
* Will you need to authenticate access to the package?
* Are there reasons it needs to be hosted on-premises?

You might need to consider the language of the package and the process for accessing it. Here are some resources you'll want to check out when deciding where to host your packages.

* [Deep dive into Azure Artifacts](https://azure.microsoft.com/blog/deep-dive-into-azure-artifacts/?azure-portal=true)
* [NuGet Documentation](https://docs.microsoft.com/nuget/?azure-portal=true)
* [npm documentation](https://docs.npmjs.com?azure-portal=true)
* [Maven documentation](https://maven.apache.org/guides/?azure-portal=true)
* [Chocolatey documentation](https://chocolatey.org/docs?azure-portal=true)