You've now learned about pipeline stages, how you can add a pipeline stage to validate your Bicep code. The next step in building confidence with your deployment is to add another stage to check what will actually be created, updated and deleted in your environment before you actually run a deployment. 

In this unit you will learn about what-if deployment and stage approvals. 

## The importance of verifying the deployment actions, especially for production 

A Bicep file describes the state you want your environment to be in at the completion of a deployment. When you deploy your Bicep template, Azure Resource Manager changes your Azure environment to match the state that's described in your Bicep template. When you deploy a Bicep file, it can result in new resources being deployed into your environment, or existing resources being updated. When you run a deployment in complete mode, it can even result in existing resources to be deleted. 

Anytime resources are created, updated or deleted , there's a potential risk that things are changing in a way you didn't expect. It's a good practice to add an extra step to verify what exactly will be created, updated and deleted. This adds a lot of value to your automation process. And when you're deploying to a production environment, it's particularly important to confirm any changes that will happen to your environment. 

Resource Manager provides the what-if operation, which you can run on your Bicep file: 

```cli
az deployment group what-if --resource-group RESOURCEGROUP_NAME --template-file deploy/main.bicep -p environmentType=Test
```

The what-if operation doesn't make any changes to your environment. Instead, it describes the resources that will get created, the properties of resources that will be updated, and lists the resources that will be deleted: 

```text
Resource and property changes are indicated with these symbols:
  - Delete
  + Create
  ~ Modify

The deployment will update the following scope:

Scope: /subscriptions/./resourceGroups/ExampleGroup

  ~ Microsoft.Network/virtualNetworks/vnet-001 [2018-10-01]
    - tags.Owner: "Team A"
    ~ properties.addressSpace.addressPrefixes: [
      - 0: "10.0.0.0/16"
      + 0: "10.0.0.0/15"
      ]
    ~ properties.subnets: [
      - 0:

          name:                     "subnet001"
          properties.addressPrefix: "10.0.0.0/24"

      ]

Resource changes: 1 to modify.
```

> [!NOTE]
> The command will give you plain text output. If you use the `--no-pretty-print` switch, the output will be a JSON object that your can further automate on if needed. 

There are 6 different types of changes that the `what-if` operation reports on: 

- **Create**: The resource does not currently exist and will be created.
- **Delete**: The resource already exists, but it not present in the Bicep template and will be deleted. You will only get this change type in case you add the `--mode complete` switch to the `what-if` operation.
- **Ignore**: The resource exists, but is not present in your Bicep template. The resource won't be deployed or modified.
- **NoChange**: The resource exists both in your Azure environment and is defined in your Bicep template. Both are the same and hence no change is needed. 
- **Modify**: The resource exists both in your Azure environment and is defined in your Bicep template. However the property values between the two are different, hence the resource properties will be updated. 
- **Deploy**: The resource exists both in your Azure environment and is defined in your Bicep template. However there is not enough information to determine what will change, hence the tool is reporting a probable redeploy. 

## Stage approvals

After you see the output of the `what-if` operation for a specific environment, you can determine whether to continue to the actual deployment. In your deployment pipeline, you achieve this by using approvals and checks. Approvals and checks can control whether a certain stage should run or not.

In Azure Pipelines, a *service connection* stores the credentials the pipeline uses to access your Azure environment. The owner of a service connection can define approvals and checks that must be satisfied before the service connection can be used. These approvals and checks apply to the pipeline stage that uses the service connection.

For example, you can configure a service connection to include a manual approval check. This means that a pipeline can only use the service connection after a specified user or users have reviewed the changes being deployed and approved it.

Before a stage is allowed to run, all approvals and checks that exist on the resources that it uses need to be satisfied. These approvals and checks are reevaluated at a certain interval. In case they are not satisfied, the stage will not execute. After a configurable timeout period expires, the stage will fail.

> [!NOTE]
> Agent pools can also have approvals and checks configured on them. However, we don't use agent pool approvals in this module. There are other resources in pipelines that can use approvals and checks as well, but these are out of scope for this module. 

Since approvals and checks are defined on the resources that a pipeline uses, editors of the pipeline YAML file cannot remove or add these approvals and checks. Only the administrators of the resources can manage the approvals and checks on them. 

Azure Pipelines supports several different types of approvals and checks. In this module, we only consider approval checks. With an approval check you can assign one or more users who need to approve or decline the continuation of your pipeline. When your pipeline executes and reaches the stage that requires an approval check, execution will halt. All of the users who have been designated as approvers will get a message, both in Azure DevOps and by email. They can inspect the pipeline result, including the changes that the what-if operation detects. Based on the information they see, they then approve or decline the change. If they approve the change, the pipeline will resume execution. If they decline, the stage fails.

> [!NOTE]
> This illustrates the importance of planning your service connections, and service principals, properly. If you need to add an approval check for deployments to a production environment but not to a test environment, it's very important to ensure the two environments use different service connections so that they can have different approval checks configured.