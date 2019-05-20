In this module, you set up your own private build agent using a virtual machine running on Azure.

Although a Microsoft-hosted agent will often do everything you need, there are times when you might consider using your own build agent.

There are a few factors to consider when choosing a Microsoft-hosted agent versus bringing your own. These factors include how much compute power and disk space you need and how much time your builds require to run.

When you configure a private build agent, that agent is yours to configure however you need. As a tradeoff, you'll also need to keep your system updated with the latest security patches and build tools.

The Tailspin web team finished their experiment with private build agents. Let's check in to hear their results.

**Tim**: Mara and I were able to bring up a build agent running on an Azure virtual machine! The build runs quickly, and we get the same results as using a Microsoft-hosted agent. But does a private build agent bring any benefits to this project?

**Andy**: I agree it was a good experiment. But for now I don't see any benefit from using our own agent. The Microsoft-hosted agents seem to do everything we need for now. But if we discover we need more build time, storage, or memory, it's good to know we have the option of using our own build agent.

**Tim**: I could see some of the other teams benefiting from this, especially the teams that develop the games. I know some games can require several hours to do a full build. Processing all those game assets also requires lots of CPU, memory, and disk space.

**Mara**: Good point, Tim. Because we set up that build configuration on a Git branch, those changes are isolated from the main sources. We can leave the build agent running a bit longer while you demo this to the other teams.

**Tim**: Sounds good. Thanks for your help here. This was all relatively easy to set up. And now I know little bit more about how virtual machines work on Azure!

## Learning path summary

Congratulations. You've completed the final module in the _Build applications with Azure DevOps_ learning path. In this learning path, you accomplished a lot, including:

* Setting up a project in Azure Pipelines and publish build artifacts to the pipeline
* Implementing a code workflow among team members using Git and GitHub
* Running automated tests, such as unit and code coverage tests, when the pipeline runs
* Scanning for potential security vulnerabilities and related issues in both your code and third-party components you use
* Managing your own packages in the pipeline and connect them to your applications
* Using your own build agents when Microsoft-hosted agents don't meet your needs

The focus of this learning path is on building applications and receiving build artifacts that you can hand off to your quality or operations teams.

You can automate the handoff process by deploying build artifacts to running infrastructure automatically when the build process successfully completes. Check back soon with Microsoft Learn &mdash; we're working on additional learning paths that cover deployment, automation, and monitoring topics, all using Azure DevOps.

## Learn more

Check out the documentation to learn more about build agents and agent pools. Here are a few resources to start with.

* [Azure Pipelines agents](https://docs.microsoft.com/azure/devops/pipelines/agents/agents?view=azure-devops&azure-portal=true)
* [Agent pools](https://docs.microsoft.com/azure/devops/pipelines/agents/pools-queues?view=azure-devops&azure-portal=true)
* [Container jobs](https://docs.microsoft.com/azure/devops/pipelines/process/container-phases?view=azure-devops&tabs=yaml&azure-portal=true)
* [Pool](https://docs.microsoft.com/azure/devops/pipelines/yaml-schema?view=azure-devops&tabs=schema#pool&azure-portal=true) (YAML schema)
* [Create a multi-platform pipeline](https://docs.microsoft.com/azure/devops/pipelines/get-started-multiplatform?view=azure-devops&azure-portal=true)

### Create your own VM images

If you're interested in creating your own VM images for use with Azure Pipelines, check out the [azure-pipelines-image-generation](https://github.com/Microsoft/azure-pipelines-image-generation?azure-portal=true) project on GitHub.

### Practice running VMs on Azure

For more hands-on practice working with virtual machines on Azure, check out [Core Cloud Services - Introduction to Azure](/learn/modules/welcome-to-azure?azure-portal=true) from the [Azure fundamentals](/learn/paths/azure-fundamentals?azure-portal=true) learning path.

We also mentioned how you can use Azure Resource Manager templates to automate the process of creating build agents. To learn more about Resource Manager templates, see [Build Azure Resource Manager templates](/learn/modules/build-azure-vm-templates?azure-portal=true).