**Azure Policy definition** describes resource compliance conditions and the action or effects that take place if those conditions are met. The policy consists of two parts:

- A **condition** that compares a resource property field or a value, accessed by using aliases, to a required value.
- The **effect** determines what happens when the policy rule is evaluated to match the condition. For each new resource, an updated resource, or an existing resource, the effects behave differently.

## Anatomy of a policy definition

You use JSON to create a policy definition that contains the elements shown in the following table.

| Element | Description | Properties or values |
| :----- | :----- | :----- |
| *displayName (string, max 128 characters)* | Used to identify the policy definition. |  |
| *description (string, max 512 characters)* | Provides context for when the definition is used. |  |
| *policyType (read-only string)* | Indicates the origin of the policy definition. This property can't be set, but SDK returns three values which are visible in the portal. | ● Built in: Provided and maintained by Microsoft.<br>● Custom: Custom definitions created by the customer.<br>● Static: Regulatory Compliance policy with Microsoft ownership. |
| *mode (string)* | Configured depending on the target of the policy: an Azure Resource Manager property or a Resource Provider property. | ● Resource Manager Modes:<br>&nbsp;&nbsp;&nbsp;&nbsp;o On All: Evaluates resource groups, subscriptions, and all resource types.<br>&nbsp;&nbsp;&nbsp;&nbsp;o Indexed: Evaluates resource groups, subscriptions, and all resource types.<br>● Resource Provider Modes (limited to Built in policies and fully supported):<br>&nbsp;&nbsp;&nbsp;&nbsp;o Microsoft.Kubernetes.Data<br>&nbsp;&nbsp;&nbsp;&nbsp;o Microsoft.KeyVault.Data<br>&nbsp;&nbsp;&nbsp;&nbsp;o Microsoft.Network.Data<br>● Resource Provider Modes (limited to Built in policies and in preview mode):<br>&nbsp;&nbsp;&nbsp;&nbsp;o Microsoft.ManagedHSM.Data<br>&nbsp;&nbsp;&nbsp;&nbsp;o Microsoft.DataFactory.Data |
| *version (string, optional)* | Built-in policy definitions can host multiple versions with the same definitionID. If no version number is specified, all experiences show the latest version of the definition. |  |
| *metadata (object, optional, max 1,024 characters)* | Stores information about the policy definition. | Common properties (for Built-in policies):<br>● *version (string)*: Tracks details about the version of the contents of a policy definition.<br>● *category (string)*: Determines under which category in the Azure portal the policy definition is displayed.<br>● *preview (Boolean)*: True or false flag that indicates if the policy definition is in preview.<br>● *deprecated (Boolean)*: True or false flag that indicates if the policy definition is deprecated.<br>● *portalReview (string)*: Determines if parameters require review in the portal. |
| *parameters (object, optional)* | Help simplify your policy management by reducing the number of policy definitions. By including parameters in a policy definition, you can reuse that policy for different scenarios by using different values. | Properties:<br>● name<br>● type (String, Array, Object, Boolean, Integer, Float, DateTime)<br>● metadata (description, displayName, strongType, assignPermissions)<br>● defaultValue<br>● allowedValues<br>● schema |
| *policyRule (object)* | The effect of a policy is defined in the *policyRule*. The policy rule consists of the *if and then* blocks.<br>● In the *if* block, you define one or more conditions that specify when the policy applies.<br>● In the *then* block, you define the effect that happens when the *if* conditions result true. |  |



```json
{
  "displayName": "Allowed locations",
  "description": "This policy enables you to restrict the locations your organization can specify when deploying resources. Use to enforce your geo-compliance requirements. Excludes resource groups, Microsoft.AzureActiveDirectory/b2cDirectories, and resources that use the 'global' region.",
  "policyType": "BuiltIn",
  "mode": "Indexed",
  "metadata": {
    "version": "1.0.0",
    "category": "General"
  },
  "parameters": {
    "listOfAllowedLocations": {
      "type": "Array",
      "metadata": {
        "description": "The list of locations that can be specified when deploying resources.",
        "strongType": "location",
        "displayName": "Allowed locations"
      }
    }
  },
    "policyRule": {
      "if": {
        "allOf": [
          {
            "field": "location",
            "notIn": "[parameters('listOfAllowedLocations')]"
          },
          {
            "field": "location",
            "notEquals": "global"
          },
          {
            "field": "type",
            "notEquals": "Microsoft.AzureActiveDirectory/b2cDirectories"
          }
        ]
      },
      "then": {
        "effect": "deny"
      }
    }
  }

```

In the given example, *b2cDirectories* is excluded from the policy logic because its location field isn't a region (it can be "United States," "Europe," "Asia Pacific," or "Australia"). This logic can be enforced with a separate policy.

## Logical operators and conditions (*if* blocks)

The first part of the *policyRule* in an Azure Policy definition is the *if* block. This block defines the conditions for which the policy evaluates the resources. A policy definition can contain several conditional statements. Depending on your evaluation requirements, you might or might not need each statement to be true, and you might only need some of them to be true.

### Logical operators supported in the *if* block

In the *if* condition, you can put different logical operators.

| Operator | Type | Description |
| :----- | :----- | :----- |
| *not* | {condition or operator} | The *not* syntax inverts the result of the condition. |
| *allOf* | [{condition or operator}, {condition or operator}] | The *allOf* syntax (like the logical *and* operation) requires all conditions to be true. |
| *anyOf* | [{condition or operator}, {condition or operator}] | The *anyOf* syntax (like the logical *or* operation) requires one or more conditions to be true. |

The following example shows use of the *allOf* logical operator:

```json
{
  "if": {
    "allOf": [
      {
        "field": "location",
        "notIn": "[parameters('listOfAllowedLocations')]"
      },
      {
        "field": "location",
        "notEquals": "global"
      },
      {
        "field": "type",
        "notEquals": "Microsoft.AzureActiveDirectory/b2cDirectories"
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}
```

### Nested logical operations

Logical operations are optional and can be nested to create complex scenarios.

The following example shows a *not* operation nested in an *allOf* operation:

```json
"if": {
    "allOf": [
      {
        "not": {
          "field": "tags",
          "containsKey": "application"
        }
      },
      {
        "field": "type",
        "equals": "Microsoft.Storage/storageAccounts"
      }
    ]
  },
```

### Conditions

Properties like fields, values, or counts can be evaluated within a condition.

| Condition | Description | Properties or values |
| :----- | :----- | :----- |
| **Fields** | Conditions that evaluate whether the values of properties in the resource request payload meet certain criteria can be formed by using a field expression. | Name, fullName, kind, type, location, ID, identity.type, tags, tags['tagName'], property aliases |
| **Value** | Conditions that evaluate whether a value meets certain criteria can be formed by using a value expression. | |
| **Count** | Conditions that count how many members of an array meet certain criteria can be formed by using a count expression. | Field count, value count. The `current()` function returns the value of the array member that's being evaluated. |

The condition in an Azure Policy assesses whether the evaluated values for the properties, such as Fields, Value, or Count, meets certain criteria. If the result of a function is an error, the policy results in a deny effect. This result can be avoided while testing by disabling *enforcementMode* in the assignment. For more information, see [Enforcement Mode](/azure/governance/policy/concepts/assignment-structure#enforcement-mode).

| Evaluation criteria | Value type |
| :----- | :----- |
| *equals* | stringValue |
| *notEquals* | stringValue |
| *like* | stringValue |
| *notLike* | stringValue |
| *match* | stringValue |
| *notMatch* | stringValue |
| *matchInsensitively* | stringValue |
| *notMatchInsensitively* | stringValue |
| *contains* | stringValue |
| *notContains* | stringValue |
| *In* | ["stringValue1", "stringValue2"] |
| *notIn* | ["stringValue1", "stringValue2"] |
| *containsKey* | keyName |
| *notContainsKey* | keyName |
| *less* | dateValue |
| *less* | stringValue |
| *less* | intValue |
| *lessOrEquals* | dateValue |
| *lessOrEquals* | stringValue |
| *lessOrEquals* | intValue |
| *greater* | dateValue |
| *greater* | stringValue |
| *greater* | intValue |
| *greaterOrEquals* | dateValue |
| *greaterOrEquals* | stringValue |
| *greaterOrEquals* | intValue |
| *exists* | bool |

The following JSON is an example of using conditions:

```json
{
  "if": {
    "allOf": [
      {
        "value": "[resourceGroup().name]",
        "like": "*netrq"
      },
      {
        "field": "type",
        "notLike": "Network/*"
      }
    ]
  },
  "then": {
    "effect": "deny",
    "details": {
      "count": {
        "field": "Microsoft.Network/virtualNetworks/addressSpace.addressPrefixes[*]",
        "where": {
          "value": "[ipRangeContains('10.0.0.0/24', current('Microsoft.Network/virtualNetworks/addressSpace.addressPrefixes[*]'))]",
          "equals": "greater"
        }
      }
    }
  }
}

```

### Policy functions

Functions can be used to introduce extra logic into a policy rule. They're resolved in the policy rule of a policy definition and in the parameter values that are assigned to the policy definitions in an initiative.

The Resource Manager template functions are available to use in a policy rule except a [few policy functions and user-defined functions](/azure/governance/policy/concepts/definition-structure-policy-rule#policy-functions).

The *utcNow()* function is available to use in a policy rule but differs from use in an Azure Resource Manager template (ARM template). Unlike an ARM template, this function can be used outside *defaultValue*. It returns a string set to the current date and time in Universal ISO 8601 DateTime format `yyyy-MM-ddTHH:mm:ss.fffffffZ`.

The following table describes the functions that are only available in policy rules.

| Function | Description |
|----------|-------------|
| `addDays(dateTime, numberOfDaysToAdd)` | ● `dateTime`: [Required] string - String in the Universal ISO 8601 DateTime format 'yyyy-MM-ddTHH:mm:ss.FFFFFFFZ'.<br>● `numberOfDaysToAdd`: [Required] integer - Number of days to add. |
| `Field(fieldName)` | ● `fieldName`: [Required] string - Name of the [field](/azure/governance/policy/concepts/definition-structure-policy-rule#fields) to retrieve.<br>● Returns the value of that field from the resource evaluated by the *If* condition.<br>● `field` is primarily used with `auditIfNotExists` and `deployIfNotExists` to reference fields on the resource that are being evaluated. |
| `requestContext().apiVersion` | Returns the API version of the request that triggered policy evaluation. This value is the API version that was used in the PUT/PATCH request for evaluations on resource creation/update. The latest API version is always used during compliance evaluation on existing resources. |
| `policy()` | Returns the following information about the policy that's being evaluated. Properties can be accessed from the returned object.<br>`"assignmentId": ""`,<br>`"definitionId": ""`,<br>`"setDefinitionId": ""`,<br>`"definitionReferenceId": ""` |
| `ipRangeContains(range, targetRange)` | ● `range`: [Required] string - String specifying a range of IP addresses to check if the *targetRange* is within range.<br>● `targetRange`: [Required] string - String specifying a range of IP addresses to validate as included within the *range*.<br> Returns a *boolean* for whether the *range* IP address range contains the *targetRange* IP address range. Empty ranges or mixing between IP families isn't allowed and results in evaluation failure. |
| `current(indexName)` | Special function that can only be used inside count expressions. |

## Effect types (*then* blocks)

The second part of the *policyRule* in an Azure Policy definition is the *then* block. This block defines the effect that takes place when the policy rule is evaluated to match the condition resources. More than one effect can be valid for a given policy definition. Parameters are often used to specify allowed effect values (*allowedValues*) in such cases so that a single definition can be more versatile during assignment. Resource properties and logic in the policy rule can determine whether a certain effect is considered valid to the policy definition.

| Effect | Description | Type |
| :----- | :----- | :----- |
| *disabled* | The *disabled* effect is a way to deactivate the policy. If a policy definition has *Disabled* as its effect, any assignments of that policy aren't active. This effect is checked first to determine if the policy rule should be evaluated. This flexibility makes it possible to deactivate a single assignment instead of deactivating all of that policy's assignments. | Synchronous evaluation |
| *append* | The *append* effect is used to add more fields to the requested resource during creation or update. It's mostly obsolete because *Modify* can also be used to add fields to the request. | Synchronous evaluation |
| *modify* | The *modify* effect is used to add, update, or remove properties or tags on a subscription or resource during creation or update. It allows Azure Policy to modify requests to Azure Resource Manager by altering fields to ensure compliance. | Synchronous evaluation |
| *deny* | The *deny* effect is used to prevent a resource request that doesn't match defined standards through a policy definition and fails the request. | Synchronous evaluation |
| *denyAction* | The *denyAction* effect is used to block requests based on intended action to resources at scale. Currently, the only supported action is DELETE. | Synchronous evaluation |
| *audit* | The *audit* effect is used to create a warning event in the activity log when you're evaluating a noncompliant resource, but it doesn't stop the request. | Asynchronous evaluation |
| *auditIfNotExists* | The *auditIfNotExists* effect allows the auditing of resources that are related to the resource that matches the *if* condition but doesn't have the properties specified in the details of the *then* condition. | Asynchronous evaluation |
| *deployIfNotExists* | The *deployIfNotExists* policy definition runs a template deployment when the condition is met. It can trigger deployment of a related resource based on the compliance state of the currently evaluated resource. | Asynchronous evaluation |
| *manual* | The *manual* effect allows you to self-attest the compliance of resources or scopes. When a policy definition with *Manual* effect is assigned, you can set the compliance states of targeted resources or scopes through custom attestations. | Manual attestation |

The following list provides general guidance around interchangeable effects:

- *audit*, *deny*, and either *modify* or *append* are often interchangeable.
- *auditIfNotExists* and *deployIfNotExists* are often interchangeable.
- *manual* isn't interchangeable.
- *disabled* is interchangeable with any effect.

Multiple policies can be assigned to a single resource at the same scope or at different scopes. Each policy mostly has a different effect defined. The condition and effect for each policy is independently evaluated. The net result of layering policy definitions is considered **cumulative most restrictive**.
