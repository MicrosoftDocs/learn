Visual Studio Team Services (VSTS) is a collection of hosted DevOps services for application developers. *Build* and *Release* are two of the DevOps services in VSTS that help you manage continuous integration and delivery of your applications.

Core components of VSTS include:

- **Code** - VSTS hosts source control repositories when you can commit and push code, track release across branches, and work toward release milestones.

- **Agents and queues** - To build your code or deploy your software you need at least one agent. As you add more code and people, you'll eventually need more. When your build or deployment runs, the system begins one or more jobs. An agent is installable software that runs one build or deployment job at a time.

    - *Hosted agents* are run on the VSTS platform and Microsoft takes care of the maintenance and upgrades.

    - *Private agent* are set up and managed on your own systems to run build and deployment jobs. Private agents give you more control to install dependent software needed for your builds and deployments. You can install the agent on Windows, Linux, or macOS machines. You can also install an agent on a Linux Docker container. After you've installed the agent on a machine, you can install any other software on that machine as required by your build or deployment jobs.

- **Builds** - At the beginning of the build process, the agent downloads files from your remote repository into a local sources directory. You specify the events that will trigger the buil, such as a code commit to a VSTS code repository.

    An agent is then used to build your application, based on your code and definitions. These agents perform build tests and generate artifacts for use in the release and deployment phase.
 
- **Release** - A release definition is one of the fundamental concepts in Release Management for VSTS and TFS. It defines the end-to-end release process for an application to be deployed across various environments.

    To author a release definition, you must specify the artifacts that make up the application and the release process. An artifact is a deployable component of your application. It is typically produced through a Continuous Integration or a build process.

    You define environment, such as Azure App Service, as the deployment point for your app. When the release process runs, you application is deployed to the defined environment.

- **Deployment groups** - A deployment group is a logical set of deployment target machines that have agents installed on each one. Deployment groups represent the physical environments such as "Dev", "Test", "UAT", and "Production". In effect, a deployment group is just another grouping of agents, much like an agent pool.

    When you author a VSTS release definition, you can specify the deployment targets for a phase using a deployment group. This makes it easy to define parallel execution of deployment tasks.