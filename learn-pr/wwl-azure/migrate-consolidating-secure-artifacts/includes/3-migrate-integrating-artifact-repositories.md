While you can continue to work with your existing artifact repositories in their current locations when using Azure Artifacts, there are advantages to migrating them.

## NuGet and other packages

Azure Artifacts provides hosted NuGet feeds as a service.

Using this service, you can often eliminate the dependencies on on-premises resources such as file shares and locally hosted instances of NuGet.Server.

The feeds can also be consumed by any Continuous Integration system that supports authenticated NuGet feeds.

## Walkthroughs

For details on how to integrate NuGet, npm, Maven, Python, and Universal Feeds, see the following walkthroughs:

 -  [Get started with NuGet packages in Azure DevOps Services and TFS](/azure/devops/artifacts/get-started-nuget).
 -  [Use npm to store JavaScript packages in Azure DevOps Services or TFS](/azure/devops/artifacts/get-started-npm).
 -  [Get started with Maven packages in Azure DevOps Services and TFS](/azure/devops/artifacts/get-started-maven).
 -  [Get started with Python packages in Azure Artifacts](/azure/devops/artifacts/quickstarts/python-packages).
 -  [Publish and then download a Universal Package](/azure/devops/artifacts/quickstarts/universal-packages).
