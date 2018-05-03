Team Services is a collection of hosted DevOps services for application developers. *Build* and *Release* are two of the DevOps services in Team Services that help you manage continuous integration and delivery of your applications.

Core components of Team Services include the following:

- **Code**: Team Services hosts source-control repositories when you can commit and push code, track a release across branches, and work toward release milestones.

- **Agents and queues**: To build your code or to deploy your software, you need at least one agent. An agent is installable software that runs one build or deployment job at a time.

    As you add more code and people, you'll eventually need more agents. When your build or deployment runs, the system starts one or more jobs.  

    Team Services supports the following agents:

    - *Hosted agents* are run on the Team Services platform. Microsoft takes care of the maintenance and upgrade of hosted agents.

    - *Private agents* are agents that you set up and manage on your own systems to run build and deployment jobs. When you use private agents, you have more control to install dependent software that you need for your builds and deployments. You can install a private agent on Windows, Linux, or macOS machines. You can also install an agent on a Linux Docker container. After you've installed the agent on a machine, you can install any other software on that machine as required by your build or deployment jobs.

- **Builds**: At the beginning of the build process, the agent downloads files from your remote repository to a local sources directory. You specify the events that will trigger the build, such as a code commit to a Team Services code repository.

    An agent is then used to build your application, based on your code and definitions. Agents perform build tests and generate artifacts to use in the release and deployment phase.
 
- **Release**: A release definition is one of the fundamental concepts in Release Management for Team Services and Team Foundation Services. It defines the end-to-end release process for an application to deploy across various environments.

    To author a release definition, you must specify the artifacts that make up the application and the release process. An artifact is a deployable component of your application. An artifact typically is produced through a CI or build process.

    You define an environment, such as Azure App Service, as the deployment point for your app. When the release process runs, your application is deployed to the defined environment.

- **Deployment groups**: A deployment group is a logical set of deployment target machines that have agents installed on each machine. Deployment groups represent the physical environments, such as "Dev," "Test," "UAT," and "Production." A deployment group is essentially another grouping of agents, much like an agent pool.

    When you author a Team Services release definition, you can specify the deployment targets for a phase by using a deployment group. Using a deployment group makes it easy to define parallel execution of deployment tasks.

Now, let's create a Team Services project!
