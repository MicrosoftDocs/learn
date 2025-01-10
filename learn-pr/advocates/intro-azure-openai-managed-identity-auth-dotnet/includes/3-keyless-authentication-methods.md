To authenticate the Azure SDK with keyless authentication, we need to provide an authentication method that implements the ``Azure.Core.TokenCredential`` class, of which there are several implementations in the ``Azure.Identity NuGet`` package.

For local development, we can use the ``VisualStudioCredential`` class, which uses the token provided by the account registered in Visual Studio. It does assume that this account has the appropriate RBAC permissions to the resource trying to be accessed.

Alternatively, the ``DefaultAzureCredential`` class can be used, which provides a chain of all ``TokenCredential`` types, attempting to authenticate with each until one provides a token response.

In production, we recommend that a specific credential provided be used, such as ``ManagedIdentityCredential``, or a paired down list of providers, removing ones that aren't relevant or undesired for production. This reduces the complexity of debugging authentication failures, since the provider list is better defined and improves performance by removing the overhead of providers that aren't available.
