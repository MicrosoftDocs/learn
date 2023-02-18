Software developers and operations professionals strive to create working software systems that satisfy the needs of the organization. However, sometimes their short-term objectives are at odds, which can result in technical issues, delays, and downtime. 

DevOps is a concept that combines philosophies and practices to facilitate technical teams as they work toward common goals. To accomplish this alignment, organizations employ practices and processes that automate the ongoing development, maintenance, and deployment of software systems. The aim is to expedite the release of software changes, ensure the ongoing deployability of the system and that all changes meet the bar for quality.

When done correctly, DevOps practices and processes touch nearly every aspect of a company and the software development lifecycle, including planning, project management, the collaboration of software developers and operations, and quality assurance teams. Tooling automates and enforces most of the practices and processes, making it both difficult and unnecessary to work around.

DevOps requires a fundamental mindset change from the top down. Organizations can't install software tools or adopt services and hope to get all of the benefits promised by DevOps.

In this module, we'll focus on the Microsoft tools that can help accomplish some of the DevOps objectives. Organizations that aren't ready to fully embrace the power of DevOps can support technical teams in their cloud development activities. If you're interested in learning more about DevOps in general, Microsoft Learn has [several learning paths and modules](/training/browse/?azure-portal=true&terms=DevOps) that can help you.

Microsoft tools enable source-code management, continuous integration and continuous delivery (CI/CD), and automate the creation of testing environments. These tools overlap in functionality, so in this module you'll learn about product options, and when to choose one product over another.

## Product options

At a high level, there are three primary offerings, each of which is aimed at a specific audience and use case, that provide a diverse set of tools, services, programmatic APIs, and more.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWGtHv]

### Azure DevOps Services

Azure DevOps Services is a suite of services that address every stage of the software development lifecycle.

- **Azure Repos** is a centralized source-code repository where software development, DevOps engineering, and documentation professionals can publish their code for review and collaboration.
- **Azure Boards** is an agile project management suite that includes Kanban boards, reporting, and tracking ideas. Azure boards works from high-level epics to work items and issues.
- **Azure Pipelines** is a CI/CD pipeline automation tool.
- **Azure Artifacts** is a repository for hosting artifacts, such as compiled source code, which can be fed into testing or deployment pipeline steps.
- **Azure Test Plans** is an automated test tool that can be used in a CI/CD pipeline to ensure quality before a software release.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWHb6A]

Azure DevOps is a mature tool with a large feature set that began as on-premises server software and evolved into a software as a service (SaaS) offering from Microsoft.

### GitHub and GitHub Actions

GitHub is arguably the world's most popular code repository for open-source software. Git is a decentralized source-code management tool, and GitHub is a hosted version of Git that serves as the primary remote. GitHub builds on top of Git to provide related services for coordinating work, reporting and discussing issues, providing documentation, and more. It offers the following functionality:

- It's a shared source-code repository, including tools that enable developers to perform code reviews by adding comments and questions in a web view of the source code before it can be merged into the main code base.
- It facilitates project management, including Kanban boards.
- It supports issue reporting, discussion, and tracking.
- It features CI/CD pipeline automation tooling.
- It includes a wiki for collaborative documentation.
- It can be run from the cloud or on-premises

Most relevant for this module, GitHub Actions enables workflow automation with triggers for many lifecycle events. One such example would be automating a CI/CD *toolchain*.  

A toolchain is a combination of software tools that aid in the delivery, development, and management of software applications throughout a system's development lifecycle. The output of one tool in the toolchain is the input of the next tool in the toolchain. Typical tool functions range from performing automated dependency updates to building and configuring the software, delivering the build artifacts to various locations, testing, and so on.

With such similarity between many GitHub and Azure DevOps features, you might wonder which product to choose for your organization. Unfortunately, the answer might not be straightforward.

Although both Azure DevOps and GitHub allow public and private code repositories, GitHub has a long history with public repositories and is trusted by tens of thousands of open-source project owners.  GitHub is a lighter-weight tool than Azure DevOps, with a focus on individual developers contributing to the open-source code. Azure DevOps is more focused on enterprise development, with heavier project-management and planning tools, and finer-grained access control.

> [!NOTE]
> Your choices are not limited to Azure DevOps Services or GitHub and GitHub Actions. In practice, you can mix and match these services as needed. For example, you can use GitHub repos with Azure Boards for work item tracking.

### Azure DevTest Labs

Azure DevTest Labs provides an automated means of managing the process of building, setting up, and tearing down virtual machines (VMs) that contain builds of your software projects. This way, developers and testers can perform tests across a variety of environments and builds. And this capability isn't limited to VMs. Anything you can deploy in Azure via an ARM template can be provisioned through DevTest Labs. Provisioning pre-created lab environments with their required configurations and tools already installed is a huge time saver for quality assurance professionals and developers.

Suppose you need to test a new feature on an old version of an operating system. Azure DevTest Labs can set up everything automatically upon request. After the testing is complete, DevTest Labs can shut down and deprovision the VM, which saves money when it's not in use. To control costs, the management team can restrict how many labs can be created, how long they run, and more. 
