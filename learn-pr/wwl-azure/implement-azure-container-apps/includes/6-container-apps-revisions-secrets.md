


Azure Container Apps implements container app versioning by creating revisions. A revision is an immutable snapshot of a container app version. You can use revisions to release a new version of your app, or quickly revert to an earlier version of your app. New revisions are created when you update your application with [revision-scope changes](/azure/container-apps/revisions#revision-scope-changes). You can also update your container app based on a specific revision.

You can control which revisions are active, and the external traffic that is routed to each active revision. Revision names are used to identify a revision, and in the revision's URL. You can customize the revision name by setting the revision suffix.

By default, Container Apps creates a unique revision name with a suffix consisting of a semi-random string of alphanumeric characters. For example, for a container app named *album-api*, setting the revision suffix name to *1st-revision* would create a revision with the name *album-api--1st-revision*. You can set the revision suffix in the ARM template, through the Azure CLI `az containerapp create` and `az containerapp update` commands, or when creating a revision via the Azure portal.

### Updating your container app

With the `az containerapp update` command you can modify environment variables, compute resources, scale parameters, and deploy a different image. If your container app update includes [revision-scope changes](/azure/container-apps/revisions#revision-scope-changes), a new revision is generated.

```bash
az containerapp update \
  --name <APPLICATION_NAME> \
  --resource-group <RESOURCE_GROUP_NAME> \
  --image <IMAGE_NAME>
```

You can list all revisions associated with your container app with the `az containerapp revision list` command. 

```bash
az containerapp revision list \
  --name <APPLICATION_NAME> \
  --resource-group <RESOURCE_GROUP_NAME> \
  -o table
```

For more information about Container Apps commands, visit the [az containerapp](/cli/azure/containerapp) reference.

## Manage secrets in Azure Container Apps

Azure Container Apps allows your application to securely store sensitive configuration values. Once secrets are defined at the application level, secured values are available to container apps. Specifically, you can reference secured values inside scale rules.

* Secrets are scoped to an application, outside of any specific revision of an application.
* Adding, removing, or changing secrets doesn't generate new revisions.
* Each application revision can reference one or more secrets.
* Multiple revisions can reference the same secret(s).

An updated or deleted secret doesn't automatically affect existing revisions in your app. When a secret is updated or deleted, you can respond to changes in one of two ways:

1. Deploy a new revision.
1. Restart an existing revision.

Before you delete a secret, deploy a new revision that no longer references the old secret. Then deactivate all revisions that reference the secret.

> [!NOTE]
> Container Apps doesn't support Azure Key Vault integration. Instead, enable managed identity in the container app and use the Key Vault SDK in your app to access secrets.

### Defining secrets

When you create a container app, secrets are defined using the `--secrets` parameter.

* The parameter accepts a space-delimited set of name/value pairs.
* Each pair is delimited by an equals sign (`=`).

In the example below a connection string to a queue storage account is declared in the `--secrets` parameter. The value for queue-connection-string comes from an environment variable named `$CONNECTION_STRING`.

```bash
az containerapp create \
  --resource-group "my-resource-group" \
  --name queuereader \
  --environment "my-environment-name" \
  --image demos/queuereader:v1 \
  --secrets "queue-connection-string=$CONNECTION_STRING"
```

After declaring secrets at the application level, you can reference them in environment variables when you create a new revision in your container app. When an environment variable references a secret, its value is populated with the value defined in the secret. To reference a secret in an environment variable in the Azure CLI, set its value to `secretref:`, followed by the name of the secret.

The following example shows an application that declares a connection string at the application level. This connection is referenced in a container environment variable.

```bash
az containerapp create \
  --resource-group "my-resource-group" \
  --name myQueueApp \
  --environment "my-environment-name" \
  --image demos/myQueueApp:v1 \
  --secrets "queue-connection-string=$CONNECTIONSTRING" \
  --env-vars "QueueName=myqueue" "ConnectionString=secretref:queue-connection-string"
```

