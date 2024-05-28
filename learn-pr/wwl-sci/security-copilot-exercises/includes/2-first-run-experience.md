The organization you work for wants to increase the efficiency and capabilities of its security analyst to improve security outcomes. In support of that objective, the office of the CISO determined that deploying Microsoft Copilot for Security is a key step towards that objective. As the Security administrator for your organization, you are tasked with setting up Copilot.

In this exercise, you'll walk through the first run experience. 

- You have a global administrator role within Microsoft Entra.
- You'll provision Microsoft Entra with one security compute unit (SCU), to start.

> [!NOTE]
> The environment for this exercise is based on a simulation, generated from pre-determined screen captures of the actual product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script are not be supported.

### Exercise

> [!NOTE]
> It is recommended that you open the exercise environment in a separate browser window so that you can simultaneously view the instructions and the exercise environment.

Using the exercise environment, follow the exercise steps that are listed.

[![Button to launch exercise environment.](../media/security-copilot-launch-exercise-button-v2.png)]()

#### Task: Set role permissions

Before users can start using Copilot, admins need to provision and allocate capacity. To provision capacity:

- You must have an Azure subscription.
- You need to be an Azure owner or Azure contributor, at a resource group level, as a minimum.

In this task, you walk through the process of ensuring you have the appropriate role permissions. This starts by enabling access management for Azure resources.

Why is this needed? As a Global Administrator in Microsoft Entra ID, you might not have access to all subscriptions and management groups in your directory. Microsoft Entra ID and Azure resources are secured independently from one another. That is, Microsoft Entra role assignments don't grant access to Azure resources, and Azure role assignments don't grant access to Microsoft Entra ID. When you elevate your access, you are assigned the User Access Administrator role in Azure at root scope (/). This allows you to view all resources and assign access in any subscription or management group in the directory. For details, see [Elevate access to manage all Azure subscriptions and management groups.](/azure/role-based-access-control/elevate-access-global-admin).

Once you have user access, you can then assign yourself the necessary access to provision SCUs for Copilot.

1. You'll start by enabling Access management for Azure resources. To access this setting:
    1. Make sure you are on the browser tab for **Microsoft Entra**.
    1. Select **Overview** from the left navigation panel.
    1. Then select the **Properties** tab from the main window.
    1. Enable the toggle switch for **Access management for Azure resources**.

1. Now that you can view all resources and assign access in any subscription or management group in the directory, assign yourself the Owner role for the Azure subscription.
    1. Select the **Azure browser tab** to access the Azure portal.
    1. Select **Subscriptions** then select the **???? Verify the subscription name for the simulation???**
    1. Select **Access control (IAM)**.
    1. Select **Add**, then **Add role assignment**.
    1. From the Role tab, select **Privileged administrator roles**.
    1. Select **Owner**.
    1. Select **+ Select members**.
    1. Select **??? Which user ???**.
    1. Select **Allow user to assign all roles except privileged administrator roles, Owner, UAA, RBAC (Recommended)**.
    1. Select **Review + assign**.

As an owner to the Azure subscription, you'll now be able to provision capacity within Copilot.

#### Task: Provision capacity

In this task, you go through the steps of provisioning capacity for your organization. There are two options for provisioning capacity:

- Provision capacity within Copilot for Security (recommended)
- Provision capacity through Azure

For this exercise, you provision capacity through Copilot for Security. When you first open Copilot for Security (https://securitycopilot.microsoft.com), a wizard guides you through the steps in setting up capacity for your organization.

1. Open the browser tab for **Microsoft Copilot for Security**.
1. Follow the steps in the Wizard, select **Get started**.
1. On this page, you set up your security capacity.

    ***For this simulation, the input values are auto-populated by selecting the right arrow key on your keyboard.***
    
    1. Use the right arrow key to enter your Azure subscription
    1. Select Create a new resource group then use the right arrow key to enter the resource group name.
    1. Use the right arrow key to enter the capacity name
    1. Select a region for the Prompt evaluation location.
    1. You can choose whether you want to select the option, "If this location has too much traffic, allow Copilot to evaluate prompts anywhere in the world (recommended for optimal performance).
    1. Capacity region is set based on location selected.
    1. Use the right arrow key to populate Security compute units field with the value of 1.
    1. Select the box, "I acknowledge that I have read, understood, and agree to the Terms and Conditions.
    1. Select Continue (on bottom right).

1. Once the SCU is provisioned, the next page in the wizard is to allocate that capacity. Select the drop-down and select the capacity that was configured.
1. The next screen is where you can select options to help improve Copilot. You can select the toggle based on your preferences.
1. In the next page, you're informed of the default roles that can access Copilot (you’ll add users in a subsequent exercise). Select continue.
1. You're now ready to explore and start using Copilot. The next unit will focus on exploring the core functionality of the standalone experience.

In this exercise, you successfully provisioned Copilot for Security.
