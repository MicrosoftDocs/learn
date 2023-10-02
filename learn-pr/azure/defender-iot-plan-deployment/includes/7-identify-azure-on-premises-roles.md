In the previous unit, you determined the best cloud connection options for an OT network sensor.
Now let's look at the user roles you'll need for your automotive manufacturing environment.

## Overview of users and roles in Microsoft Defender for IoT

Microsoft Defender for IoT provides built-in roles for Azure and on-premises for managing user access to on-premises resources.

## Azure roles

Whether you're working in a cloud or on-premises environment, roles must be set up roles in Azure using Azure role-based access control (Azure RBAC).

The following built-in Azure roles are available for Defender for IoT:

- **Security Reader**: Can view all resources, such as values for sites, Defender for IoT settings, and Azure workbooks, but can't make any changes. Can download OT sensor and on-premises management console software, endpoint details, and OT threat intelligence packages.
- **Security Admin**: Has all Security Reader permissions and can also update resources. Also they can onboard OT/enterprise IoT sensors, download sensor activation files, recover on-premises management console passwords, and push OT threat intelligence updates. Security Admins have exclusive permission to onboard an Enterprise IoT plan from Microsoft 365 Defender.
- **Contributor**: Has the same permissions as a Security Admin excluding onboarding an Enterprise IoT plan from Microsoft 365 Defender.
- **Owner**: Has all Contributor permissions plus can create and manage users.
<!-- https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/roles-azure -->
## On-premises roles

Microsoft Defender for IoT provides tools for managing on-premises user access in the on-premises management console.

On-premises roles include:

- **Read-Only**: Has read access permissions for tasks such as viewing and managing alerts and viewing and filtering the device inventory and enterprise map. Read-Only users can access options displayed in the **NAVIGATION** menu on the on-premises management console.
- **Security Analyst**: Has all Read-Only permissions and can generate and view reports and set alert exclusions. They can access options in the on-premises management console **NAVIGATION** and **ANALYSIS** menus.
- **Admin**: Has all Security Analyst permissions and access to all tools, including site building, user and group creation and management, and more.
- **Privileged Support**: Has access to advanced tools for troubleshooting and setup. This user is installed by default and may be used to install other users.
- **Cyberx**: Has access to advanced tools for troubleshooting and setup. This user is installed by default on pre-23.1x version and optionally for higher versions. This user may be used to install other users.
- **Cyberx_host**: This user is installed by default on pre-23.1x version and optionally for higher versions. This user may be used to install other users.

By default, each on-premises management console is installed with the privileged support user, which has access to advanced tools for troubleshooting and setup.

## OT Sensor roles

Microsoft Defender for IoT provides tools for managing on-premises user access in the OT network sensor.

- **Read-Only**: Has read access permissions for tasks such as viewing alerts and devices on the device map. Read-Only users can access options displayed in the **Discover** and **Analyze** menus on the sensor.
- **Security Analyst**: Has all Read-Only permissions and can manage alerts, create alert comments and rules, and manage multiple notifications simultaneously. Security Analysts can access options on the sensor displayed in the **Discover** and **Analyze** menus.
- **Admin**: Has all Security Analyst permissions and access to all tools. This includes map zoom control, user and certificate creation and management, and more.
- **Support User**: Has access to advanced tools for troubleshooting and setup. This user is installed by default and may be used to set up other users. When setting up a sensor for the first time, sign in the support user, create an initial user with an Admin role, and then create extra users for security analysts and read-only users.

## Active Directory

Active Directory can be used to set up Azure user roles and on-premises users on your OT sensors. It's recommended to use Active Directory groups when configuring the same permissions for a large number of on-premises users for managing as a group. For instance, when assigning **Read-Only** permission to a large number of users.
<!-- [https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/manage-users-sensor] -->

Defender for IoT's integration with Active Directory supports LDAP v3 and the following LDAP-based authentication:

**Full authentication**: Retrieving user details (like first name, last name, and email) from the LDAP server.

**Trusted user**: Retrieving only the user password. Other user details retrieved are based on users defined in the sensor.

## Example

An Active Directory Security Analysts group is given access to all your organization's West European automotive and glass production lines, along with a plastics line in one region:
:::image type="content" source="../media/7-security-analysts-diagram.png" alt-text="Diagram of an Active Directory Security Analyst on-premise access path.":::

## Knowledge check
<!--
https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/manage-users-overview
active directory -->

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->

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

<!-- 5. Validation -------------------------------------------------------------------------------------------

    Goal: Enables the learner to evaluate if they completed the exercise correctly. Feedback like this is critical for learning.

    Structure:
        1. A heading of "## Check your work".
        2. An introductory paragraph describing how they'll validate their work at a high level.
        3. Numbered steps (if the learner needs to perform multiple steps to verify if they were successful).
        4. Video of an expert performing the exact steps of the exercise (optional).

    Example:
         "At this point, the app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
