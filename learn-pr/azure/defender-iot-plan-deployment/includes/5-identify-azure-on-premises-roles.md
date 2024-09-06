In the previous unit, you identified the types of cloud connection options for an OT network sensor.

Now let's look at the user roles you'll need for your automotive manufacturing environment with Defender for IoT.

Microsoft Defender for IoT provides both built-in Azure and on-premises roles for managing user access to Defender for IoT data.

## Azure roles

Teams working with the Azure portal must have roles defined in Azure, using Azure role-based access control (Azure RBAC).

The following built-in Azure roles are available for Defender for IoT:

- **Security Reader**: Can view all resources, such as values for sites, Defender for IoT settings, and Azure workbooks, but can't make any changes. They can download OT sensor and on-premises management console software, endpoint details, and OT threat intelligence packages.
- **Security Admin/Contributor**: Has all Security Reader permissions and can also update resources. Also, they can onboard sensors, download sensor activation files, and push OT threat intelligence updates.

    Security admins have extra permissions for enterprise IoT monitoring, which isn't covered in this module.
- **Owner**: Has all Contributor permissions, plus they can create and manage users.

## OT sensor roles

Some data and data visualizations are currently available only from the OT sensor user interface. To access the sensor, you'll also need to provision users for each sensor with on-premises roles. Provision your sensor users directly or by integrating with Active Directory, including Active Directory groups.

The following roles are available on OT network sensors:

- **Read-Only**: Has read access permissions for tasks such as viewing alerts and devices on the device map.
- **Security Analyst**: Has all Read-Only permissions and can manage alerts, create alert comments and rules, and manage multiple notifications simultaneously.
- **Admin**: Has all Security Analyst permissions and access to all tools. This includes map zoom control, user and certificate creation and management, and more.

The built-in *support* user has access to advanced tools for troubleshooting and setup. The *support* user is the default admin user used to set up the sensor after installation and to set up other users. When setting up a sensor for the first time, sign in as the *support* user, create an initial user with an admin role, and then create extra users for security analysts and read-only users.

### Active Directory integration

Connect your sensors to Active Directory to allow Active Directory users or groups to sign into your sensors. For instance, assign a large number of users to a group with **Read-Only** permissions or create user groups with global access control across Defender for IoT on-premises resources.

Defender for IoT's integration with Active Directory supports LDAP v3 and the following LDAP-based authentication:

- **Full authentication**: Retrieves user details (like first name, last name, and email) from the LDAP server.

- **Trusted user**: Retrieves only the user password. Other user details retrieved are based on users defined in the sensor.

## Example

An Active Directory *Security Analysts* on-premises group is given access to all your organization's West European automotive and glass production lines:
:::image type="content" source="../media/5-security-analysts-diagram.png" alt-text="Diagram of an Active Directory Security Analyst on-premises access path." border="false":::

## Knowledge check
