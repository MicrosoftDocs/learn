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

For production deployments, we recommend a hub and spoke model, where you create the firewall in its own virtual network. Then you peer that virtual network with virtual networks used by your workloads.

To simplify the setup for this exercise, we'll create a subnet on the same virtual network that the session host is using.

## Create a subnet for Azure Firewall

1. Sign into the Azure portal using the same account you used in the previous exercise unit.
1. Search for or select **Virtual networks**.
1. Select the virtual network that your session host is using.
1. Under **Settings**, select **Subnets** > **+ Subnet** to add a subnet.
1. Enter the following information for the subnet.

    |Field |Value |
    |---------|---------|
    |Name    |  AzureFirewallSubnet    |
    |Address range     |   10.0.1.0/26      |

    Leave the rest of the values as they are.
1. Select **Save**.

## Deploy Azure Firewall

[Deploy firewall](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal#deploy-the-firewall)

1. In the Azure portal, search for **Firewalls**.
1. Select **+ Add** to create a firewall.
1. Enter the following table to configure the firewall.

   |Field |Value  |
   |---------|---------|
   |Subscription     |\<your subscription\>|
   |Resource group     |learn-firewall-rg |
   |Name     |learn-fw|
   |Region     |Select the same location that you used previously|
   |Firewall management|**Use Firewall rules (classic) to manage this firewall**|
   |Choose a virtual network     |**Use existing**: **Test-FW-VN**|
   |Public IP address     |**Add new**<br>**Name**:  **fw-pip**|

5. Accept the other default values, then select **Review + create**.
6. Review the summary, and then select **Create** to create the firewall.

   This will take a few minutes to deploy.
7. After deployment completes, go to the **learn-firewall-rg** resource group, and select the **learn-fw** firewall.
8. Make a note of the firewall private and public IP addresses. You'll use these addresses later.

## Check your work
<!-- Introduction paragraph -->
1. <!-- Step 1 (if multiple steps are needed) -->
1. <!-- Step 2 (if multiple steps are needed) -->
1. <!-- Step n (if multiple steps are needed) -->