In this module, you set up your own private build agent by using a virtual machine that runs on Microsoft Azure.

Although a Microsoft-hosted agent often does everything you need, there are times when you might consider using your own build agent.

There are a few factors to consider when you decide to use a Microsoft-hosted agent rather than use your own. These factors include how much compute power and disk space you need and how much time is required for your builds to run.

When you configure a private build agent, it's yours to configure however you want. As a tradeoff, you also need to keep your system updated with the latest security patches and build tools.

## Learning path summary

Congratulations. You've completed the final module in the _Build applications with Azure DevOps_ learning path. In this learning path, you accomplished a lot, including:

* Setting up a project in Azure Pipelines and publishing build artifacts to the pipeline.
* Implementing a code workflow for the team members that uses Git and GitHub.
* Running automated tests, such as unit and code coverage tests, when the pipeline runs.
* Managing your own packages in the pipeline and connecting them to your applications.
* Using your own build agents when Microsoft-hosted agents don't meet your needs.

The focus of this learning path is on building applications and receiving build artifacts that you can hand off to your QA or operations teams.

## Learn more

For more self-paced, hands-on learning around Azure DevOps, check out [Azure DevOps Labs](https://www.azuredevopslabs.com?azure-portal=true).

To learn more about build agents and agent pools, see the following articles:

* [Azure Pipelines agents](/azure/devops/pipelines/agents/agents?azure-portal=true)
* [Agent pools](/azure/devops/pipelines/agents/pools-queues?azure-portal=true)
* [Self-hosted Linux agents](/azure/devops/pipelines/agents/linux-agent?azure-portal=true)
* [Self-hosted macOS agents](/azure/devops/pipelines/agents/osx-agent?azure-portal=true)
* [Self-hosted Windows agents](/azure/devops/pipelines/agents/windows-agent?azure-portal=true)
* [Container jobs](/azure/devops/pipelines/process/container-phases?azure-portal=true&tabs=yaml)
* [Pool](/azure/devops/pipelines/yaml-schema?tabs=schema#pool) (YAML schema)
* [Build on multiple platforms](/azure/devops/pipelines/yaml-schema/jobs-job-strategy#examples)

### Configure release pipelines

To learn how to configure release pipelines that continuously build, test, and deploy your applications, go to [Deploy applications with Azure DevOps](../../../paths/deploy-applications-with-azure-devops/index.yml?azure-portal=true).

### Create your own VM images

If you're interested in creating your own VM images for use with Azure Pipelines, check out the [azure-pipelines-image-generation](https://github.com/Microsoft/azure-pipelines-image-generation?azure-portal=true) project on GitHub.

### Practice running VMs on Azure

For more hands-on practice working with virtual machines on Azure, check out the [Administer infrastructure resources in Azure](../../../paths/administer-infrastructure-resources-in-azure/index.yml?azure-portal=true) learning path.

We also mentioned how you can use Bicep to automate the process of creating build agents. To learn more about Bicep, see [Fundamentals of Bicep](/training/paths/fundamentals-bicep/?azure-portal=true).
