

A lifecycle management policy is a collection of rules in a JSON document. Each rule definition within a policy includes a filter set and an action set. The filter set limits rule actions to a certain set of objects within a container or objects names. The action set applies the tier or delete actions to the filtered set of objects:

```json
{
  "rules": [
    {
      "name": "rule1",
      "enabled": true,
      "type": "Lifecycle",
      "definition": {...}
    },
    {
      "name": "rule2",
      "type": "Lifecycle",
      "definition": {...}
    }
  ]
}
```

A policy is a collection of rules:

| Parameter name | Parameter type | Notes |
|--|--|--|
| `rules` | An array of rule objects | At least one rule is required in a policy. You can define up to 100 rules in a policy. |


Each rule within the policy has several parameters:

| Parameter name | Parameter type | Notes | Required |
|--|--|--|--|
| `name` | String | A rule name can include up to 256 alphanumeric characters. Rule name is case-sensitive. It must be unique within a policy. | True |
| `enabled` | Boolean | An optional boolean to allow a rule to be temporarily disabled. Default value is true if it's not set. | False |
| `type` | An enum value | The current valid type is Lifecycle. | True |
| `definition` | An object that defines the lifecycle rule | Each definition is made up of a filter set and an action set. | True |


## Rules

Each rule definition includes a filter set and an action set. The filter set limits rule actions to a certain set of objects within a container or objects names. The action set applies the tier or delete actions to the filtered set of objects.

The following sample rule filters the account to run the actions on objects that exist inside `container1` and start with `foo`.

* Tier blob to cool tier 30 days after last modification
* Tier blob to archive tier 90 days after last modification
* Delete blob 2,555 days (seven years) after last modification
* Delete blob snapshots 90 days after snapshot creation

```json
{
  "rules": [
    {
      "name": "ruleFoo",
      "enabled": true,
      "type": "Lifecycle",
      "definition": {
        "filters": {
          "blobTypes": [ "blockBlob" ],
          "prefixMatch": [ "container1/foo" ]
        },
        "actions": {
          "baseBlob": {
            "tierToCool": { "daysAfterModificationGreaterThan": 30 },
            "tierToArchive": { "daysAfterModificationGreaterThan": 90 },
            "delete": { "daysAfterModificationGreaterThan": 2555 }
          },
          "snapshot": {
            "delete": { "daysAfterCreationGreaterThan": 90 }
          }
        }
      }
    }
  ]
}
```

## Rule filters

Filters limit rule actions to a subset of blobs within the storage account. If more than one filter is defined, a logical AND runs on all filters. Filters include:

| Filter name | Filter type | Is Required |
|--|--|--|
| blobTypes | An array of predefined enum values. | Yes |
| prefixMatch | An array of strings for prefixes to be match. Each rule can define up to 10 prefixes. A prefix string must start with a container name. | No |
| blobIndexMatch | An array of dictionary values consisting of blob index tag key and value conditions to be matched. Each rule can define up to 10 blob index tag condition. | No |

## Rule actions

Actions are applied to the filtered blobs when the run condition is met.

Lifecycle management supports tiering and deletion of blobs and deletion of blob snapshots. Define at least one action for each rule on blobs or blob snapshots.

| Action | Base Blob | Snapshot | Version |
|--|--|--|--|
| tierToCool | Supported for blockBlob | Supported | Supported |
| enableAutoTierToHotFromCool | Supported for blockBlob | Not supported | Not supported |
| tierToArchive | Supported for blockBlob | Supported | Supported |
| delete | Supported for blockBlob and appendBlob | Supported | Supported |

> [!NOTE]
> If you define more than one action on the same blob, lifecycle management applies the least expensive action to the blob. For example, action `delete` is cheaper than action `tierToArchive`. Action `tierToArchive` is cheaper than action `tierToCool`.

The run conditions are based on age. Base blobs use the last modified time to track age, and blob snapshots use the snapshot creation time to track age.

| Action run condition | Condition value | Description |
|--|--|--|
| daysAfterModificationGreaterThan | Integer value indicating the age in days | The condition for base blob actions |
| daysAfterCreationGreaterThan | Integer value indicating the age in days | The condition for blob snapshot actions |
| daysAfterLastAccessTimeGreaterThan | Integer value indicating the age in days | The condition for a current version of a blob when access tracking is enabled |
 | daysAfterLastTierChangeGreaterThan | Integer value indicating the age in days after last blob tier change time | This condition applies only to `tierToArchive` actions and can be used only with the `daysAfterModificationGreaterThan` condition.
