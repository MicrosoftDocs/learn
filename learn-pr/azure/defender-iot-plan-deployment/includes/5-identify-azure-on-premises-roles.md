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

## OT sensor roles

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
:::image type="content" source="../media/5-security-analysts-diagram.png" alt-text="Diagram of an Active Directory Security Analyst on-premises access path.":::

## Knowledge check
