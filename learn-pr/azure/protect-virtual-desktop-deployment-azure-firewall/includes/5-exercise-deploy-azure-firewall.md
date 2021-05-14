<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: none

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
TODO: add your topic sentences(s)

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
TODO: add your scenario sub-task
TODO: add your scenario image

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
TODO: describe the end-state

<!-- 4. Chunked steps -------------------------------------------------------------------------------------

    Goal: List the steps they'll do to complete the exercise.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading describing the goal of the chunk
        2. An introductory paragraph describing the goal of the chunk at a high level
        3. Numbered steps (target 7 steps or fewer in each chunk)

    Example:
        Heading:
            "Use a template for your Azure logic app"
        Introduction:
             "When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch."
        Steps:
             "1. In the left navigation bar, select Resource groups.
              2. Select the existing Resource group [sandbox resource group name].
              3. Select the ShoeTracker logic app.
              4. Scroll down to the Templates section and select Blank Logic App."
-->

In this unit, you'll create the firewall in its own virtual network. Then you peer that virtual network with the virtual network used by your Windows Virtual Desktop.

## Create a virtual network and subnet for Azure Firewall

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), search for and select **Virtual networks**.
1. Select **+ New**.
1. Enter the following information.

    |Field |Value  |
    |---------|---------|
    |Subscription     | Your subscription        |
    |Resource group    | learn-firewall-rg        |
    |Name    |   firewallVNet      | 
    |Region     | Same region as your resource group      |

1. Select the **IP Addresses** tab.
1. Under **Subnet name**, select **default**.
1. Enter the following information for the subnet.

    |Field |Value |
    |---------|---------|
    |Name    |  AzureFirewallSubnet    |
    |Address range     |   10.1.0.0/24      |

    Leave the rest of the values as they are.
1. Select **Save**.
1. Select **Review + create** > **Create**.
1. After the deployment is complete, select **Go to resource**.

## Peer virtual networks

1. In the **firewallVNet**, on the left-hand side, select **Peerings**.
1. Select **+ Add**.
1. Enter the following information.

    |Field |Value |
    |---------|---------|
    |Peering link name    |  firewallVNet-hostVNet   |
    |Remote Peering link name     |   remote-firewallVNet-hostVNet      |
    |Subscription     | Your subscription        |
    |Virtual network    | hostVNet       |

    Use the default values for the rest of the fields.

## Deploy Azure Firewall

1. In the Azure portal, search for and select **Firewalls**.
1. Select **+ Add** to create a firewall.
1. Enter the following table to configure the firewall.

   |Field |Value  |
   |---------|---------|
   |Subscription     |Select your subscription|
   |Resource group     |learn-firewall-rg |
   |Name     |learn-fw|
   |Region     |Select the same location that you used previously|
   |Firewall management|Use Firewall rules (classic) to manage this firewall|
   |Choose a virtual network     |Use existing: firewallVNet|
   |Public IP address     |Add new<br>Name:  fw-pip|

    Use the default values for the rest of the fields.

1. Select **Review + create** > **Create**.
1. Wait a few minutes for the firewall to deploy.


## Check your work

At this point, you have a Firewall deployed within it's own virtual network and you've peered that virtual network with the session host virtual network. Let's take a look at the firewall to copy the private and public IP addresses. You need those IP addresses in the next exercise unit.

1. After the deployment is complete, select **Go to resource**.
1. In the center pane, you see **Provisioning state: Succeeded**.
:::image type="content" source="../media/5-firewall-overview-page.png" alt-text="Screenshot that shows the status and ip addresses for the firewall.":::
1. From the right-hand side of the center pane, copy the **Firewall private IP** address.
1. Next to **Firewall public IP**, select **fw-pip**.
1. Copy the **IP address**.
