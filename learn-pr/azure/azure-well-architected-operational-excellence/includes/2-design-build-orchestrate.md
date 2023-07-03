Development and operational practices have evolved over the years to become more seamless and integrated. Modern practices involve organizational shifts and adopting new tooling in order to improve an organization's operational agility. In this unit, you learn some of the key concepts to improving your organization's ability to build and deploy applications.

## DevOps

DevOps is the union of people, processes, and products to enable continuous delivery of value to end users. DevOps focuses on bringing the development and operations functions together and breaking down the existing barriers between them. This combination creates multidisciplinary teams that work together with shared and efficient practices and tools. Essential DevOps practices include agile planning, continuous integration, continuous delivery, and monitoring of applications.

The DevOps culture stresses small, multidisciplinary teams that work autonomously and take collective accountability for how end users experience their software. DevOps teams apply agile practices and include operations in each team's responsibilities. Teams work in small batches that focus on improving the end-to-end delivery of customer value, and they strive to eliminate waste and impediments along the way. There are no silos and no blame games, because each team is mutually accountable.

There are several services and tools available from Microsoft to help an organization adopt and develop DevOps practices. Azure DevOps is a suite of products and tools that teams adopting DevOps practices can use to plan, develop, deliver, and operate their solutions.

Azure Boards is a part of Azure DevOps that helps teams plan and track work. Azure Boards has modern agile tools like Kanban boards, backlogs, dashboards, and scrum boards. These tools help your team get greater visibility into the work that's planned and work that's been delivered.

:::image type="content" source="../media/2-kanban.png" alt-text="Screenshot of a Kanban board on Azure Boards.":::

GitHub is the most widely used platform to build, deliver, and share software. At its core, GitHub is a version-control platform that allows a global community of individuals and teams to collaborate on software-development projects. These projects can be kept private within an organization or shared through public communities of disparate software developers. GitHub also includes features to build and test deployments, track issues, and create custom workflows in your repositories.

Azure DevOps and GitHub integrate together, and organizations that are operating or adopting a DevOps model often use these services together.

## Continuous Integration and Continuous Delivery (CI/CD)

*Continuous Integration (CI)* is the practice of building and testing code every time a team member commits changes to version control. CI encourages developers to share their code and unit tests by merging their changes into a shared version-control repository after every small task completion. Committing code triggers an automated build system to grab the latest code from the shared repository, and then build, test, and validate the full main branch.

CI helps developers to identify bugs earlier, and it improves software quality since code is checked in, built, and verified more frequently. Instead of working on code for a month and discovering numerous issues when changes are eventually checked in. Developers can check in smaller sets of changes and be confident that their code doesn't introduce large volumes of issues into the main branch.

*Continuous Delivery (CD)* is the process to build, test, configure and deploy from a build environment to a production environment. Multiple testing or staging environments create a release pipeline to automate the creation of a new build's infrastructure and deployment. Successive environments support progressively longer-running activities of integration, load, and user-acceptance testing.

Continuous integration and continuous delivery are often combined into a single pipeline known as *CI/CD*. Continuous integration starts the continuous delivery process. then, the CI/CD pipeline stages changes from each successive environment to the next upon successful completion of the tests that are defined at each stage. As a developer, you can check in code and validate that it passes all tests and introduces no new issues into the main branch. Then, you can roll it out to production with the confidence that it doesn't affect the operation of your production environment.

Azure Pipelines is a cloud service you can use to automatically build and test your code project and make it available to others. It works with just about any language or project type, and integrates with GitHub, GitHub Enterprise, Azure Repos, and other version-control systems. Azure Pipelines combines continuous integration (CI) and continuous delivery (CD) to constantly and consistently test and build your code and ship it to any target.

:::image type="content" source="../media/2-agents.jpg" alt-text="Visualization of CI/CD pipeline.":::

You can also use GitHub Actions to build CI/CD capabilities in your GitHub repositories. With GitHub Actions, you can build workflows that are custom automated processes to build, test, package, release, and deploy code.

## Microservices

A microservices architecture consists of services that are small, independent, and loosely coupled. You can deploy and scale each service independently. Microservice architectures are often adopted for new applications that are adopting DevOps practices.

:::image type="content" source="../media/2-microservices-logical.svg" alt-text="Logical diagram of a microservices architecture.":::

A microservice is small enough that a single, small team of developers can write and maintain it. Because services can be deployed independently, a team can update an existing service without rebuilding and redeploying the entire application.

Each service is typically responsible for its own data. Its data structure is isolated, so upgrades or changes to schema aren't dependent on other services. Requests for data are typically handled through APIs and provide a well-defined and consistent access model. Internal implementation details are hidden from service consumers.

Because each service is independent, services can use different technology stacks, frameworks, and SDKs. It's common to see services rely on REST calls for service-to-service communication by using well-defined APIs instead of RPC or other custom communication methods.

Microservice architectures are technology agnostic, but you often see containers or serverless technologies used for their implementation. Continuous deployment and continuous integration (CI/CD) is frequently used to increase the speed and quality of development activities.

## Environment consistency

A key piece of ensuring that you can develop and deploy applications with confidence is making sure that your environments are consistent between development, test, and production. As your CI/CD processes move your code through your environments, any variation risks introducing areas where testing can fail or overlook defects. Through automation, you can spin up and tear down environments as needed, which you can include as part of your CI/CD processes.

Imagine an environment where you're building a .NET Core application, and your test and production environments are running different versions. Your deployment may succeed in your test environment but cause issues in your production environment because it's running a different version of your application. Including your environment definitions as part of your deployment helps ensure that your code is built and deployed on a consistent, end-to-end infrastructure.
