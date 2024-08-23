You've now learned about workflow jobs, and how you can add a workflow job to validate your Bicep code. The next step in building confidence with your deployment is to add another job to check exactly what your deployment will change.

In this unit, you'll learn about using the what-if command in a workflow. You'll also learn about adding environment protection rules so that you have the opportunity to manually verify the command's output before the deployment runs.

## The what-if operation

A Bicep file describes the state that you want your Azure environment to be in at the end of a deployment. When you submit a deployment, Azure Resource Manager changes your Azure environment to match the state described in your Bicep file.

A deployment can result in new resources being deployed into your environment, or existing resources being updated. When you run a deployment in complete mode, it can even result in the deletion of existing resources.

Anytime resources are created, updated, or deleted, there's a risk that things can change in a way you didn't expect. It's a good practice to add an extra step to verify what exactly will be created, updated, and deleted. This verification adds value to your automation process. When you're deploying to a production environment, it's important to confirm any changes that happen to your environment.

Resource Manager provides the what-if operation, which you can run on your Bicep file within your workflow job:

:::image type="content" source="../media/6-jobs-preview.png" alt-text="Diagram of a workflow that includes Lint, Validate, and Preview jobs. The Preview job executes a what-if operation against Azure." border="false":::

The `arm-deploy` action supports triggering the what-if operation by using the `additionalArguments` property:

:::code language="yaml" source="code/6-what-if.yml" highlight="12-20" :::

The highlighted code is equivalent to running the deployment by using Azure CLI, with the `--what-if` argument included.

The what-if operation doesn't make any changes to your environment. Instead, it describes the resources that will be created, the resource properties that will be updated, and the resources that will be deleted.

What-if sometimes shows that a resource will change when actually no change will happen. This type of output is called _noise_. We're working to reduce these problems, but we need your help. [Report what-if problems](https://aka.ms/whatifissues).

After you see the output of the what-if operation, you can determine whether to continue on to the deployment. This step typically involves a human reviewing the output from the what-if command, and then making a decision about whether the identified changes are reasonable. If a human reviewer decides that the changes are reasonable, they can manually approve the workflow run.

To learn more about the what-if command, see the Microsoft Learn module [Preview Azure deployment changes by using what-if](/training/modules/arm-template-whatif/).

## Environments

In GitHub Actions, an _environment_ represents the place where your solution is deployed. Environments provide features that help when you work with complex deployments. In a future module, you'll learn more about environments and their features. For now, we focus on their ability to add required reviewers to your workflow.

You create an environment by using the GitHub web interface. You can create environments when you work with a public GitHub repository, or when you use a GitHub Enterprise account.

After you create an environment, you can reference it in any jobs in your workflow:

:::code language="yaml" source="code/6-environment.yml" range="19-60" highlight="28" :::

> [!NOTE]
> When your deployment workflow's workload identity interacts with Resource Manager within an environment, it needs a federated credential that's configured with the name of the environment. You'll learn more about environments in future modules. When you run the exercises for this module, you'll create the necessary federated credentials.

## Environment protection rules

After you create an environment, you can define _protection rules_. Protection rules are used to verify conditions that must be met before a step can use the environment. The _required reviewers_ protection rule is a type of check that requires a human to provide a manual approval.

Protection rules are defined on the environment, not the workflow. Authors of the workflow YAML file can't remove or add these protection rules. Only the administrators of a repository or the account owner can manage environments and their protection rules.

Environment protection rules help to ensure that the right people are involved in the deployment process.

### How do environment protection rules work?

When you associate an environment with a step, the environment's protection rules are evaluated just before the step begins.

A required reviewer is one type of protection rule. When you configure a required reviewer protection rule, you assign one or more GitHub users who need to approve the continuation of your workflow.

Environments provide other types of protection rules, too. For example, you can restrict the Git branches that can be deployed to specific environments. We discuss only the required reviewers rule in this module, but we provide links to more information about other protection rules in the summary.

After your workflow begins and reaches a step that requires a reviewer, the workflow run pauses. All of the users who are designated as reviewers are sent a message in GitHub and by email.

Reviewers can inspect the workflow logs, such as the changes that the what-if operation detects. Based on this information, they then approve or reject the change. If they approve the change, the workflow resumes. If they reject, or if they don't respond within the timeout period, the job fails.

:::image type="content" source="../media/6-jobs-approval-check.png" alt-text="Diagram of a workflow that includes Lint, Validate, Preview, and Deploy jobs, with an approval check before the Deploy job." border="false":::

## The importance of good practices

The environments feature in GitHub gives you the ability to link your deployments to an environment, and then the deployment inherits the protection rules defined by the administrator of the environment. However, there's nothing to require that new workflows use environments.

It's important for an organization to establish good practices to review your workflow definitions. For example,configure your repository to require pull request reviews on any changes to your _main_ branch by using branch protection rules. You'll learn more about this concept in a future module.

You can also add _secrets_ to an environment. That way, the secret can only be used in a job that also uses the environment. By combining environment protection rules and secrets, you can ensure your workflow security is maintained.
