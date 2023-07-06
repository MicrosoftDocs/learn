
The following private package sources will give you a starting point for finding the most relevant feeds.

## Private

Private feeds can be used where packages should be available to a select audience.

The main difference between public and private feeds is the need for authentication.

Public feeds can be anonymously accessible and optionally authenticated.

Private feeds can be accessed only when authenticated.

There are two options for private feeds:

 -  **Self-hosting** Some of the package managers are also able to host a feed. One can host the required solution to offer a private feed using on-premises or private cloud resources.
 -  **SaaS services** A variety of third-party vendors and cloud providers offer software-as-a-service feeds that can be kept private. It typically requires a consumption fee or a cloud subscription.

The following table contains a non-exhaustive list of self-hosting options and SaaS offerings to host private package feeds for each type covered.

| **Package type** | **Self-hosted private feed** | **SaaS private feed**                                                   |
| ---------------- | ---------------------------- | ----------------------------------------------------------------------- |
| NuGet            | NuGet server                 | Azure Artifacts, MyGet                                                  |
| npm              | Sinopia, cnpmjs, Verdaccio   | npmjs, MyGet, Azure Artifacts                                           |
| Maven            | Nexus, Artifactory, Archivia | Azure Artifacts, Bintray, JitPack                                       |
| Docker           | Portus, Quay, Harbor         | Docker Hub, Azure Container Registry, Amazon Elastic Container Registry |
| Python           | PyPI Server                  | Gemfury                                                                 |
