Initiatives work alongside policies in Azure Policy. An *initiative definition* is a set of policy definitions to help track your compliance state for meeting large-scale compliance goals.

Even if you have a single policy, we recommend using initiatives if you anticipate increasing your number of policies over time.

Applying an initiative definition to a specific scope is called an *initiative assignment*.

## Initiative definitions

Initiative definitions simplify the process of managing and assigning policy definitions by grouping sets of policies into a single item.

For example, you can create an initiative named *Enable Monitoring in Azure Security Center* to monitor security recommendations from Azure Security Center.

Under this example initiative, you would have the following policy definitions:

 -  Monitor unencrypted SQL Database in Security Center. This policy definition monitors unencrypted SQL databases and servers.
 -  Monitor OS vulnerabilities in Security Center. This policy definition monitors servers that don't satisfy a specified OS baseline configuration.
 -  Monitor missing Endpoint Protection in Security Center. This policy definition monitors servers without an endpoint protection agent installed.

## Initiative assignments

Like a policy assignment, an *initiative assignment* is an initiative definition assigned to a specific scope.

Initiative assignments reduce the need to make several initiative definitions for each scope.

Scopes can range from a management group to a resource group. You can assign initiatives in the same way that you assign policies.

You can read more about policy definition and structure at [Azure Policy definition structure](/azure/governance/policy/concepts/definition-structure).
