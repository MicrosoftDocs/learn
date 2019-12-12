Nice job. Your pipeline is taking shape. You and the Tailspin team have moved from a basic proof of concept to a realistic release pipeline. You can use this pipeline to build an artifact and test it before you give it to your users. 

In this module, you learned ways to control how changes move from one stage of a pipeline to the next. Let's review the pipeline you built in this module. This image shows your pipeline's overall shape:

![A whiteboard showing the Build, Dev, Test, and Staging stages](../media/2-add-staging-stage-approval.png)

The _Dev_, _Test_, and _Staging_ stages each deploy the build artifact to their own Azure App Service environment.

* When a change is pushed to GitHub, a _trigger_ causes the _Build_ stage to run. The _Build_ stage produces a build artifact as its output.
* The _Dev_ stage runs only when the change happens in the _release_ branch. You use a _condition_ to specify this requirement.
* The _Test_ stage runs at 3 A.M. each morning. This stage runs only when the _release_ branch contains changes since the last run. You use a _scheduled trigger_ to specify when the _Test_ stage runs.
* The _Staging_ stage runs only after you approve the changes in the _Test_ stage. You add a _release approval_ to the **staging** environment to pause the pipeline until you approve or reject the change.

This pipeline satisfies the requirements of the Tailspin team. Your pipeline's shape and how changes flow through it depend on the needs of your team and of the apps and services that you build.

Although the Tailspin team is improving their release cadence, there's room for more improvement. For example, the _Dev_ stage is the perfect place to integrate the web application with a database server. In the next module, you'll work with the Tailspin team to integrate a database with the _Space Game_ web application. Instead of reading sample data from local files, the app will use a real SQL database that runs on Azure.

## Learn more

In this module, you worked with conditions, triggers, and approvals. Explore these resources to learn more.

* [Conditions](https://docs.microsoft.com/azure/devops/pipelines/process/conditions?view=azure-devops&tabs=yaml&azure-portal=true)
* [Build pipeline triggers](https://docs.microsoft.com/azure/devops/pipelines/build/triggers?view=azure-devops&tabs=yaml&azure-portal=true)
* [Approvals and other checks](https://docs.microsoft.com/azure/devops/pipelines/process/approvals?view=azure-devops&azure-portal=true)

## More build options

Now that you're familiar with making your builds part of an automated pipeline, you might want to think about a few more possibilities.

### Implement a hybrid build process

Implementing (CI/CD) to deploy applications is difficult when your build and operate on-premises applications differently than cloud applications. If this is your situation, consider using [Azure Stack Hub](https://azure.microsoft.com/solutions/architecture/hybrid-ci-cd?azure-portal=true). Azure Stack Hub is a hybrid cloud platform that lets you use Azure services from your company's or service provider's datacenter. 

As a developer, you can build apps on Azure Stack Hub. You can then deploy them to Azure Stack Hub, to Azure, or you can build truly hybrid apps that leverage the connectivity between an Azure Stack Hub cloud and Azure.

### Implement multi-agent builds

You can use multiple build agents to support multiple build machines, either to distribute the load, to run builds in parallel, or to use different agent capabilities. As an example, components of an application might require different incompatible versions of a library or dependency. To learn more, see the [Jobs](https://docs.microsoft.com/azure/devops/pipelines/process/phases?view=azure-devops&tabs=yaml?azure-portal=true) documentation.

### Implement a container build strategy

If you're not using them yet, at some point you'll probably want to include containers in your CI/CD pipeline. Azure provides serveral services that will help you include them in the build process, including: 

* Azure Kubernetes Service (AKS). Kubernetes has quickly become the de facto standard for container orchestration. AKS lets you easily deploy and manage Kubernetes, to scale and run applications, while maintaining strong overall security.

* Azure Container Registry (ACR). This service lets you store and manage container images in a central registry. It provide you with a Docker private registry as a first-class Azure resource.

* Azure Service Fabric. Azure Service Fabric allows you to build and operate always-on, scalable, distributed apps. It can host and orchestrate containers, including stateful containers.

* Azure App Service. Azure Web Apps provides a managed service for both Windows- and Linux-based web applications, and provides the ability to deploy and run containerized applications for both platforms. 

#### Use Docker multi-stage builds

If you're building Docker images and are struggling to optimize your Dockerfiles, while keeping them easy to read and maintain, consider using multi-stage builds, which is a new feature that requires Docker 17.05 or higher on the daemon and client. 

With multi-stage builds, you use multiple `FROM` statements in your Dockerfile. Each `FROM` instruction can use a different base, and each of them begins a new stage of the build. You can selectively copy artifacts from one stage to another, leaving behind everything you don’t want in the final image.

### Integrate Jenkins with Azure Pipelines

As we've mentioned before, Jenkins is a very popular third-party CI tool. We've also mentioned that Azure Pipelines supports integration with Jenkins. You can use Jenkins for CI while gaining several DevOps benefits from an Azure Pipelines release pipeline that deploys to Azure, such as:

* Reuse your existing investments in Jenkins build jobs.
* Track work items and related code changes.
* Get end-to-end traceability for your CI/CD workflow.

A typical approach is to use Jenkins to build an app from source code hosted in a Git repository such as GitHub and then deploy it to Azure using Azure Pipelines. If you want a procedure for integrating the two tools, see [Continuously deploy from a Jenkins build](https://docs.microsoft.com/azure/devops/pipelines/release/integrate-jenkins-pipelines-cicd?view=azure-devops&tabs=yaml?azure-portal=true).
