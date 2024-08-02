Autoscale lets you scale your session host virtual machines (VMs) in a host pool up or down according to schedule to optimize deployment costs.

 -  Azure Virtual Desktop (classic) doesn't support autoscale.
 -  You can't use autoscale and [scale session hosts using Azure Automation and Azure Logic Apps](/azure/virtual-desktop/scaling-automation-logic-apps) on the same host pool. You must use one or the other.
 -  Autoscale is available in Azure and Azure Government.
 -  Autoscale support for Azure Stack HCI with Azure Virtual Desktop is currently in PREVIEW. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

For best results, we recommend using autoscale with VMs you deployed with Azure Virtual Desktop Azure Resource Manager templates or first-party tools from Microsoft.

## To use scaling plans, make sure you follow these guidelines:<br>

 -  Scaling plan configuration data must be stored in the same region as the host pool configuration. Deploying session host VMs is supported in all Azure regions.
 -  When using autoscale for pooled host pools, you must have a configured *MaxSessionLimit* parameter for that host pool. Don't use the default value. You can configure this value in the host pool settings in the Azure portal or run the [New-AzWvdHostPool](/powershell/module/az.desktopvirtualization/new-azwvdhostpool) or [Update-AzWvdHostPool](/powershell/module/az.desktopvirtualization/update-azwvdhostpool) PowerShell cmdlets.
 -  You must grant Azure Virtual Desktop access to manage the power state of your session host VMs. You must have the Microsoft.Authorization/roleAssignments/write permission on your subscriptions in order to assign the role-based access control (RBAC) role for the Azure Virtual Desktop service principal on those subscriptions.
 -  If you want to use personal desktop autoscale with hibernation, you'll need to enable the hibernation feature for VMs in your personal host pool. FSLogix and app attach currently don't support hibernate. Don't enable hibernate if you're using FSLogix or app attach for your personal host pools. For the full list of prerequisites for hibernation, see [Prerequisites to use hibernation](/azure/virtual-machines/hibernate-resume).
 -  If you're using PowerShell to create and assign your scaling plan, you'll need module [Az.DesktopVirtualization](https://www.powershellgallery.com/packages/Az.DesktopVirtualization/) version 4.2.0 or later.
 -  If you are [configuring a time limit policy using Microsoft Intune](/azure/virtual-desktop/autoscale-create-assign-scaling-plan?tabs=portal#configure-a-time-limit-policy-using-microsoft-intune), you will need:
    
    
     -  A Microsoft Entra ID account that is assigned the Policy and Profile manager built-in RBAC role.
     -  A group containing the devices you want to configure.

## Assign the Desktop Virtualization Power On Off Contributor role with the Azure portal

Before creating your first scaling plan, you'll need to assign the *Desktop Virtualization Power On Off Contributor* RBAC role to the Azure Virtual Desktop service principal with your Azure subscription as the assignable scope. Assigning this role at any level lower than your subscription, such as the resource group, host pool, or VM, will prevent autoscale from working properly. You'll need to add each Azure subscription as an assignable scope that contains host pools and session host VMs you want to use with autoscale. This role and assignment will allow Azure Virtual Desktop to manage the power state of any VMs in those subscriptions. It will also let the service apply actions on both host pools and VMs when there are no active user sessions.

## Create a scaling plan

Now that you've assigned the *Desktop Virtualization Power On Off Contributor* role to the service principal on your subscriptions, you can create a scaling plan. To create a scaling plan using the portal:

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  In the search bar, type *Azure Virtual Desktop* and select the matching service entry.
3.  Select **Scaling Plans**, then select **Create**.
4.  In the **Basics** tab, look under **Project details** and select the name of the subscription you'll assign the scaling plan to.
5.  If you want to make a new resource group, select **Create new**. If you want to use an existing resource group, select its name from the drop-down menu.
6.  Enter a name for the scaling plan into the **Name** field.
7.  Optionally, you can also add a "friendly" name that will be displayed to your users and a description for your plan.
8.  For **Region**, select a region for your scaling plan. The metadata for the object will be stored in the geography associated with the region. To learn more about regions, see [Data locations](/azure/virtual-desktop/data-locations).
9.  For **Time zone**, select the time zone you'll use with your plan.
10. For **Host pool type**, select the type of host pool that you want your scaling plan to apply to.
11. In **Exclusion tags**, enter a tag name for VMs you don't want to include in scaling operations. For example, you might want to tag VMs that are set to drain mode so that autoscale doesn't override drain mode during maintenance using the exclusion tag "excludeFromScaling". If you've set "excludeFromScaling" as the tag name field on any of the VMs in the host pool, autoscale won't start, stop, or change the drain mode of those particular VMs.
12. Select **Next**, which should take you to the **Schedules** tab. Schedules let you define when autoscale turns VMs on and off throughout the day. The schedule parameters are different based on the **Host pool type** you chose for the scaling plan.

### Pooled host pools

In each phase of the schedule, autoscale only turns off VMs when in doing so the used host pool capacity won't exceed the capacity threshold. The default values you'll see when you try to create a schedule are the suggested values for weekdays, but you can change them as needed.

To create or change a schedule:

1.  In the **Schedules** tab, select **Add schedule**.
2.  Enter a name for your schedule into the **Schedule name** field.
3.  In the **Repeat on** field, select which days your schedule will repeat on.
4.  In the **Ramp up** tab, fill out the following fields:
    
    
     -  For **Start time**, select a time from the drop-down menu to start preparing VMs for peak business hours.
     -  For **Load balancing algorithm**, we recommend selecting **breadth-first algorithm**. Breadth-first load balancing will distribute users across existing VMs to keep access times fast.
     -  For **Minimum percentage of hosts**, enter the percentage of session hosts you want to always remain on in this phase. If the percentage you enter isn't a whole number, it's rounded up to the nearest whole number. For example, in a host pool of seven session hosts, if you set the minimum percentage of hosts during ramp-up hours to **10%**, one VM will always stay on during ramp-up hours, and it won't be turned off by autoscale.
     -  For **Capacity threshold**, enter the percentage of available host pool capacity that will trigger a scaling action to take place. For example, if two session hosts in the host pool with a max session limit of 20 are turned on, the available host pool capacity is 40. If you set the capacity threshold to **75%** and the session hosts have more than 30 user sessions, autoscale will turn on a third session host. This will then change the available host pool capacity from 40 to 60.
5.  In the **Peak hours** tab, fill out the following fields:
    
    
     -  For **Start time**, enter a start time for when your usage rate is highest during the day. Make sure the time is in the same time zone you specified for your scaling plan. This time is also the end time for the ramp-up phase.
     -  For **Load balancing**, you can select either breadth-first or depth-first load balancing. Breadth-first load balancing distributes new user sessions across all available session hosts in the host pool. Depth-first load balancing distributes new sessions to any available session host with the highest number of connections that hasn't reached its session limit yet.
