You've now learned about pipeline stages, and how you can add a pipeline stage to validate your Bicep code. The next step in building confidence with your deployment is to add another stage to check what will actually be created, updated and deleted in your environment your deployment starts. In this unit you'll learn about using what-if command in a pipeline, and adding approvals to verify its output. 

## The what-if operation

A Bicep file describes the state you want your Azure environment to be in at the end of a deployment. When you deploy your Bicep template, Azure Resource Manager changes your Azure environment to match the state that's described in your Bicep template. When you deploy a Bicep file, it can result in new resources being deployed into your environment, or existing resources being updated. When you run a deployment in complete mode, it can even result in existing resources to be deleted. 

Anytime resources are created, updated or deleted, there's a risk that things could change in a way you didn't expect. It's a good practice to add an extra step to verify what exactly will be created, updated and deleted. This adds a lot of value to your automation process. And when you're deploying to a production environment, it's particularly important to confirm any changes that will happen to your environment. 

Resource Manager provides the what-if operation, which you can run on your Bicep file within your pipeline stage:

:::image type="content" source="../media/5-stages-what-if.png" alt-text="Diagram showing a pipeline that includes Lint, Validate, and Preview stages. The Preview stage executes a what-if operation against Azure." border="false":::

You use the `az deployment group what-if` command from within your pipeline definition to run the what-if step:

:::code language="yaml" source="code/5-what-if.yml" highlight="12-14" :::

The what-if operation doesn't make any changes to your environment. Instead, it describes the resources that will get created, the properties of resources that will be updated, and lists the resources that will be deleted: 

> [!NOTE]
> The command gives you plain text output. If you use the `--no-pretty-print` switch, the output will be a JSON object that your can further automate on if needed. In this module, you'll work with the plain text output.

After you see the output of the what-if operation, you can determine whether to continue on to the actual deployment. This typically involves a human reviewing the output from the what-if command, and then making a decision about whether this is reasonable. Azure Pipelines provides the ability to add a manual approval step by using environments.

## Environments

In Azure Pipelines, you can create a resource called an *environment*. Environments represent the environment to which your solution is deployed. In a future module, you'll learn more about how to deploy to multiple environments.

You use *jobs* to define a sequence of steps within a pipeline stage. When you use environments, you use a special kind of job called a *deployment job*. A deployment job is similar to a normal job, but it provides some extra functionality, including defining the environment that the deployment job uses:

:::code language="yaml" source="code/5-environment.yml" highlight="18-32" :::

Notice that in the YAML definition for a deployment job, there are some key differences from a normal job:

- Instead of beginning with the word `job`, a deployment job is defined as a `deployment`.
- The `environment` keyword specifies the name of the environment to target. In the preceding example, the deployment is tracked against an environment named `MyAzureEnvironment`.
- The `strategy` keyword specifies how Azure Pipelines runs the deployment steps. Deployment strategies support complex deployment processes, especially where you have multiple production environments. In this module, we use the `runOnce` deployment strategy, which behaves similarly to the other jobs that you're already used to.

## Stage checks and approvals

After you create an environment, you can define *checks*. Checks are used to verify conditions that must be met before a pipeline can use the environment. An approval is a type of check that requires a human provide a manual approval. Checks are defined on the environment, not the pipeline. This means that authors of the pipeline YAML file cannot remove or add these approvals and checks. Only the administrators of the resources can manage the approvals and checks on them. In many organizations, the owner of an environment in Azure Pipelines is the person responsible for the environment it deploys to, so this helps to ensure the right people are involved in the deployment process.

### How do checks and approvals work?

Approvals and checks are evaluated just before a pipeline stage begins. When Azure Pipelines is about to run a pipeline stage, it looks at all of the resources that stage uses, including environments. These resources can have checks that need to be satisfied. An approval is one type of check. When you configure an approval check, you assign one or more users who need to approve the continuation of your pipeline.

> [!NOTE]
> Azure Pipelines provides other types of check, too. For example, you can call an API to run some custom logic, control the business hours during which a stage can run, and even query Azure Monitor to ensure a deployment has succeeded. In this module we only discuss approval checks, but we provide links to more information about checks in the summary.

> [!NOTE]
> Agent pools and service connections can also have checks configured on them. You can also use a special step called a manual approval task. However, in this module, we'll focus on environments and the checks associated with them.

After your pipeline begins and reaches a stage that requires an approval check, the pipeline execution pauses. All of the users who have been designated as approvers are sent a message in Azure DevOps and by email. They can inspect the pipeline result, including the changes that the what-if operation detects. Based on the information they see, they then approve or decline the change. If they approve the change, the pipeline resumes. If they decline, or if they don't respond within a configurable timeout period, the stage fails.

:::image type="content" source="../media/5-stages-approval-check.png" alt-text="Diagram showing a pipeline that includes Lint, Validate, Preview, and Deploy stages, with an approval check before the Deploy stage." border="false":::

> [!WARNING]
> The environments feature in Azure Pipelines provides you with the ability to link your deployments to an environment, and then the deployment inherits the approvals and checks defined by the environment owner. However, there's nothing to require that new pipelines use environments. It's important that you and your organization establish good practices to review your pipeline definitions, such as by configuring your repository to require pull request reviews on any changes to your *main* branch by using branch protection policies. You'll learn more about this in a future module.
>
> You can also add approvals and checks to service connections. This ensures that approval is obtained before a deployment can use a service principal's credentials. However, this would also affect your pipeline's ability to run preflight validation and the what-if operation, since they require a service connection too.
