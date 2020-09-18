# Module design

## Title

Move Azure resources to another resource group

## Role(s)

- Administrator

## Level

- Beginner

## Product(s)

- Azure

## Prerequisites

- Familiarity with Azure resource groups

## Summary

Identify Azure resources that you can move to a different resource group. Use the Azure portal to move resources.

## Learning objectives

1. Identify whether you can move resources
1. Move resources to another resource group

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Identify resources to be moved| Checking production resource group for resource which are in the wrong group | Exercise | 1 | Yes |
| Determine whether resource types can move | Moving development resources out of the production resource group | Knowledge Check | 1 | Combined with resource type limitations subtask |
| Determine whether there are limitations that apply to resource types | Moving development resources out of the production resource group| Knowledge Check | 1 | Combined with resource types that can move subtask |
| Validate that you can move resources | Moving development resources out of the production resource group | Exercise | 1| Yes |
| Create a new resource group | Moving development resources out of the production resource group | Exercise | 2| Combined with move and verify subtasks |
| Move resources by using Azure portal| Moving development resources out of the production resource group | Exercise | 2| Combined with create and verify subtasks |
| Verify that the resources were moved| Moving development resources out of the production resource group | Exercise | 2| Combined with create and move subtasks |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You're the subscription owner for the marketing department at your company. Some resources created for development work were put into the same resource group as a production website. Your department recently had an incident where someone deleted what they thought was a development only resource group. However, they inadvertently deleted some production resources that were in that same resource group. So you've been asked to move development resources out of the resource group with the production resources.

1. **Identify incorrectly assigned resources in Azure**

    Resource Groups
        - Navigating resource groups
        - Using tags to name and identify resources

1. **Exercise - identify incorrectly assigned resources**

    1. Open Azure portal using your own account
    1. Select Resource groups
    1. Apply tags to all resources
    1. Filter the tagged resources to find non-production resources
    1. Keep this portal instance open for later usage

1. **Assess resources that can be moved**

    Check constraints on resources
    - Identify the resource types in the resource group
    - Check the resource types against the approved move list
    - Check the limitation on moving identified resource types

    **Knowledge check**

    - Which one of these resource types cannot be moved?
    - Which one of these resource types can be moved?
    - When would you be able to move a virtual machine?

1. **Validate resources in Azure**

    Preparing to test
    - Obtaining your Access Token
    - Gathering resource Ids from production group

    Test the validity of a move
    - Explain how the portal wont allow invalid options, so testing isn't required
    - How to use the REST API to validate a move, and when to use PowerShell instead of the portal

1. **Move and verify resources between Azure resource groups**

    Create a new resource group
    - Using Resource Groups to create a new resource group

    Move resource items to new resource group
    - Select the resources to be moved
    - Initiating the resource move

    Verify resource items in new resource group
    - Use the new resource groups to confirm the moved resources are present
    - Update the resource id's for any scripts or tools associated with the resource

1. **Exercise - move and verify resources between Azure resource groups**

    1. Using the existing Azure portal, select the resource groups
    1. Create a new resource group called devgroup and provide necessary information
    1. From the production resource group, select all resources to be moved and select move
    1. Confirm the resources to be moved
    1. Track the status of the move through notifications
    1. Open the new resource group and confirm that the resources have been moved
    1. Adjust the resource id of any associated tools and scripts linked to the resource

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?
    - You used Azure portal to identify all resources that were in the production resource group
    - You checked the limitations of each resource and that it could be moved to a new resource group
    - You ran a test validation of the move to confirm the correct resources would move
    - You created a new resource group to hold the dev resources using Azure portal
    - You moved resources from the production resource group to the new resource group and confirmed they were in the new group

## Notes

- What's in "Chunk your content into subtasks" is a rough draft. Please change as needed.
- Users will need to do steps in their own account as you can't create an additional resource group in sandbox.
- To keep things simple and relatively cheap, move virtual machines and the related resources created with a VM.
- Cover related limitations for moving VMs and briefly mention that there are some limitations for other resource types.
- Show steps in Azure portal where you can, otherwise show steps in PowerShell.

## Resources

- [Move resources to new resource group or subscription](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-move-resources?toc=/azure/billing/TOC.json)
- [Limitations](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-move-resources#limitations)


### Review comments

Info from Jonathan: "For a simple demonstration, you can have a base VM template with 1 or 2 additional storage account, and then move the additional storage accounts to another resource group. You can find some VM related templates here: https://azure.microsoft.com/resources/templates/?resourceType=Microsoft.Compute&pageNumber=1&sort=Popular"

- [Linux VM template](https://azure.microsoft.com/resources/templates/101-vm-simple-linux/)
- [Web App with diagnostics logging to Blob Container](https://azure.microsoft.com/resources/templates/301-web-app-diagnostics-logs-blob-container/)

So after thinking about this one @PhilStollery I think we get rid of the exercise part of the validation per Tom and Jonathan's feedback. Keep the conceptual unit - to mention that you can do via REST API and what that high level process is (and why you'd do it this way). But that Azure portal will do the validation for you when you do the move.