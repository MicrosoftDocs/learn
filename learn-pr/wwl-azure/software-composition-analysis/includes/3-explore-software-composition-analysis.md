
Two crucial areas of the Secure DevOps pipeline are Package management and Open-Source Software OSS components.

## Package management

Just as teams use version control as a single source of truth for source code, Secure DevOps relies on a package manager as the unique source of binary components.

Using binary package management, a development team can create a local cache of approved components and a trusted feed for the Continuous Integration (CI) pipeline.

In Azure DevOps, **Azure Artifacts** is an integral part of the component workflow for organizing and sharing access to your packages. Azure Artifacts allows you to:

 -  Keep your artifacts organized. Share code easily by storing Apache Maven, npm, and NuGet packages together. You can store packages using Universal Packages, eliminating keeping binaries in Git.
 -  Protect your packages. Keep every public source package you use (including packages from npmjs and NuGet .org) safe in your feed where only you can delete it and it's backed by the enterprise-grade Azure Service Level Agreement (SLA).
 -  Integrate seamless package handling into your Continuous Integration (CI)/ Continuous Development (CD) pipeline. Easily access all your artifacts in builds and releases. Azure Artifacts integrates natively with the Azure Pipelines CI/CD tool.

For more information about Azure Artifacts, visit the webpage. [What are Azure Artifacts?](/azure/devops/artifacts/overview)

### Versions and compatibility

The following table lists the package types supported by Azure Artifacts. The availability of each package in *Azure DevOps Services* is also displayed.

The following table details the compatibility of each package with specific versions of the Azure DevOps Server, previously known as *Team Foundation Server* (TFS).

| **Feature** | **Azure DevOps Services** | **TFS**                       |
| ----------- | ------------------------- | ----------------------------- |
| NuGet       | Yes                       | TFS 2017                      |
| npm         | Yes                       | TFS 2017 update one and later |
| Maven       | Yes                       | TFS 2017 update one and later |
| Gradle      | Yes                       | TFS 2018                      |
| Universal   | Yes                       | No                            |
| Python      | Yes                       | No                            |

Maven, npm, and NuGet packages can be supported with teams of any size from public and private sources. Azure Artifact comes with Azure DevOps, but the extension is also available from the Visual Studio Marketplace.

:::image type="content" source="../media/azure-devops-artifacts-highlighted-c6041d93.png" alt-text="Screenshot of Azure DevOps with Artifacts highlighted in the menu pane.":::


> [!NOTE]
> After publishing a particular package version to a feed, that version number is permanently reserved.

> [!NOTE]
> You can't upload a newer revision package with that same version number or delete that version and upload a new package with the same version number. The published version is immutable.

## The Role of OSS components

Development work is more productive because of the wide availability of reusable Open-source software (OSS) components.

This practical approach to reuse includes runtimes, which are available on Windows and Linux operating systems such as Microsoft .NET Core and Node.js.

However, OSS component reuse comes with the risk that reused dependencies can have security vulnerabilities. As a result, many users find security vulnerabilities in their applications because of the Node.js package versions they consume.

OSS offers a new-concept-called *Software Composition Analysis (SCA) to address these security concerns*, shown in the following image.

:::image type="content" source="../media/secure-devops-workflow-895bcdec.png" alt-text="Screenshot of an image of the workflow for safely creating open-source dependencies.":::


When consuming an OSS component, whether you're creating or consuming dependencies, you'll typically want to follow these high-level steps:

1.  Start with the latest, correct version to avoid old vulnerabilities or license misuse.
2.  Validate that the OSS components are the correct binaries for your version. In the release pipeline, validate binaries to ensure accuracy and keep a traceable bill of materials.
3.  Get notifications of component vulnerabilities immediately, correct them, and redeploy the component automatically to resolve security vulnerabilities or license misuse from reused software.
