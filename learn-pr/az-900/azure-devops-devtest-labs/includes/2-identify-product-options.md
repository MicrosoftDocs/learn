Organizations adopt a DevOps practice to align technical teams to work towards a common goal: make available software systems that work well.  To accomplish this, organizations employ processes that seek to automate the ongoing development, maintenance, and deployment of software systems to expedite the release of software changes, ensure the ongoing deployability of the system, and ensure all changes meet a high-quality bar. DevOps practices and processes touch nearly every aspect of the software development lifecycle, including planning, project management, and software developer collaboration with each other, as well as with operations and quality assurance teams.  Tooling automates and enforces most of the practices and processes, making it both difficult and unnecessary to work around.

At the heart of DevOps is source code management, Continuous Integration / Continuous Delivery, and automated testing.  Microsoft offers different tools to address these core DevOps practices.  Sometimes it seems as though these tools overlap in functionality.

## DevOps product options

At a high level, there are three primary offerings, each of which are aimed at a specific audience and use case, and provide a diverse set of tools, services, programmatic APIs, and more.

### Azure DevOps Services

Azure DevOps is a suite of services that address every stage of the Software Development Lifecycle.  

- **Azure Repos** is a centralized source code repository where software development, DevOps, and documentation professionals can publish their code for review and collaboration.
- **Azure Boards** is an agile project management suite that includes Kanban boards, reporting, tracking ideas and work from high-level epics to work items and issues.
- **Azure Pipelines** is a Continuous Integration/Continuous Delivery (CI/CD) pipeline automation tool.
- **Azure Artifacts** is a repository for hosting artifacts (for example, the compiled source code), which can be fed into testing or deployment pipeline steps.
- **Azure Test Plans** is an automated test tool that can be used in a CI/CD pipeline to ensure quality before releasing the software.

Azure DevOps is a mature tool with a large feature set that began its live as on-prem server software and evolved into a software as a service (SaaS) offering from Microsoft.

### GitHub and GitHub Actions

GitHub is arguably the world's most popular code repository for open-source software.  While git is decentralized source code management tool, GitHub is a hosted version of git that serves as the primary remote.  GitHub builds on top of git to provide related services for coordinating work, reporting and discussing issues, providing documentation, and more.  It includes the following functionality:

- Shared source Code repository, including tools that enable developers to perform code reviews by adding comments and questions in a web-view of the source code before it can be merged into the main code base.
- Project management, including Kanban boards
- Issue reporting, discussion, and tracking
- Continuous Integration / Continue Deployment (CI/CD) pipeline automation tooling
- A wiki for collaborative documentation
- Can be run from the cloud or on-prem

Most relevant for this module, GitHub Actions enables workflow automation with triggers for many lifecycle events, for example, automating a Continuous Integration / Continuous Deployment toolchain.  

With so many similar features to Azure DevOps, you might wonder which to choose for your organization.  Unfortunately, the answer to this question may not be straightforward.

While both Azure DevOps and GitHub both allow public and private code repositories, GitHub has a long and trusted history with public repositories and is trusted by tens of thousands of open-source projects.  GitHub is "lighter weight" than Azure DevOps, with a focus on individual developers contributing to open source.  Azure DevOps, on the other hand, is more focused on enterprise development with heavier project management and planning tools, and finer-grained access control.

> [!NOTE]
> It's important to note that you are not limited to choosing either Azure DevOps Services or GitHub and GitHub Actions.  In practice, you can mix and match these services as needed.  For example, you can use GitHub repos with Azure Boards for work item tracking.

### Azure DevTest Labs

Azure DevTest Labs provides an automated means of managing the process of building, setting up, and tearing down Virtual Machines containing builds of your software projects so that developers and testers can perform tests across different environments and builds.  And it's not limited to VMs.  Anything you can deploy in Azure via an ARM template can be provisioned through DevTest labs. Provisioning pre-created lab environments with required configurations and tools already installed is a huge timesaver for quality assurance professionals and developers.

Suppose you need to test a new feature on an old version of an operating system. Azure DevTest Labs can set up everything automatically upon request. Once the testing is complete, DevTest Labs can shut down and deprovision the VM to save money when not in use.  Management can restrict how many labs can be created, how long they run, and so on, to control costs.