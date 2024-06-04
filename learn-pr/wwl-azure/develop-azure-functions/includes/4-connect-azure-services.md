
Your function project references connection information by name from its configuration provider. It doesn't directly accept the connection details, allowing them to be changed across environments. For example, a trigger definition might include a `connection` property, but you can't set the connection string directly in a `function.json`. Instead, you would set `connection` to the name of an environment variable that contains the connection string.

The default configuration provider uses environment variables that are set in [Application Settings](/azure/azure-functions/functions-how-to-use-azure-function-app-settings?tabs=portal#settings) when running in the Azure Functions service, or from the [local settings file](/azure/azure-functions/functions-develop-local#local-settings-file) when developing locally.

## Configure an identity-based connection

Some connections in Azure Functions are configured to use an identity instead of a secret. Support depends on the extension using the connection. In some cases, a connection string may still be required in Functions even though the service to which you're connecting supports identity-based connections.

> [!NOTE]
> Identity-based connections are not supported with Durable Functions.

When hosted in the Azure Functions service, identity-based connections use a [managed identity](/azure/app-service/overview-managed-identity?toc=/azure/azure-functions/toc.json). The system-assigned identity is used by default, although a user-assigned identity can be specified with the `credential` and `clientID` properties. When run in other contexts, such as local development, your developer identity is used instead.

## Grant permission to the identity

Whatever identity is being used must have permissions to perform the intended actions. This is typically done by assigning a role in Azure RBAC or specifying the identity in an access policy, depending on the service to which you're connecting. 

> [!IMPORTANT]
> Some permissions might be exposed by the target service that are not necessary for all contexts. Where possible, adhere to the **principle of least privilege**, granting the identity only required privileges.
