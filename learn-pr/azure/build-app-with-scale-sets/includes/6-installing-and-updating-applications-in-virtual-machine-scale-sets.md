<!--Introductory paragraph topic sentence

Summary: A sentence that helps the learner prepare for the upcoming content. This makes sure to set the learner's expectations about what they're going to accomplish.

Scenario sub-task

Summary: A couple of sentences that specifies which section of the overall module scenario will be covered in this unit.

Task the learner will learn to accomplish

Summary: A sentence that describes the content the learner will know by the end of the unit.
 
Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Explanatory paragraph-->

<!--Explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

<!-- Optional knowledge check -->

## Notes from design doc
**Installing and updating applications in virtual machine scale sets**

You need to configure your virtual machines when they start in the scale set and periodically will need to update the application running on your virtual machine. By the end of this unit, you'll understand how to:

*   Use the Azure Custom Script Extension
*   Update a running application on a scale set

Cover the following points:

*   Azure Custom Script Extension

    *   The custom script extension downloads and executes scripts on Azure VMs. Typically this is used for post-deployment configuration, software installation, or any other configuration/management task.
    *   Custom scripts can be hosts on Azure Storage (for example, Blob), GitHub or via the Azure portal at extension runtime.
    *   It can integrate with Azure Resource Manager (ARM) templates, used with the Azure CLI, Powershell, Portal, or REST API.  More information can be found [here](https://docs.microsoft.com/azure/virtual-machines/linux/extensions-customscript)
    *   To use the Custom Script Extension with the Azure CLI, you create a JSON file that defines what files to obtain and commands to execute. Show an example.
    *   Updating an App deployment.

    *   Throughout the lifecycle of a scale set, you may want to deploy an updated version of your application. In the Custom Script Extension, it's possible to reference an updated deploy script and reapply the extension to part or all of your scale set.
    *   When creating a scale set, you can define an upgrade policy. The three modes are

    1.  Automatic.  The scale set makes no guarantees as to the order of the VMs being brought down. Potentially, all VMs could be brought down at the same time, causing a service outage.
    2.  Rolling.  The scale set rolls out the update in batches with an optional pause to minimize or eliminate service outage.
    3.  Manual. When you update the scale set model,  no actions to existing VMs
