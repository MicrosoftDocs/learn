

For organizations currently using Configuration Manger, there are obviously choices an organization must make with regard to how they'll leverage Endpoint Manager. There's no "correct choice" to transitioning to modern management; organizations must choose which solution within Endpoint Manager best fits the various scenarios they face. Microsoft fully supports Endpoint Manager, and that includes all the capabilities that Intune and Configuration Manager provides.

### Migrate client management to Intune

When an organization has completely moved client devices from legacy OS versions, an organization may consider shifting to managing their clients completely using cloud-based management. Configuration Manager requires a certain level of expertise to maintain the on-premises infrastructure and reducing or eliminating that layer of complexity can simplify administration efforts.

Smaller organizations should consider moving to 100% cloud-based management if:

 -  The OS configuration capabilities provided by Autopilot meet deployment needs.
 -  Applications are modern and relatively simple installs.
 -  There isn't an excessive number of existing legacy applications.
 -  The existing configuration management deployment is relatively simple.
 -  Server management requirements can be accomplished with other tools such as Windows Admin Center.

### Choose workloads within Endpoint Manager

Larger organizations may want to continue using Configuration Manager and leverage co-management in Endpoint Manager. This isn't as much about the number of devices; it's more that enterprise organizations tend to have more complexity in their infrastructure, legacy systems and applications, or requirements that Configuration Manager is best suited to handle.

Enterprise organizations that have been using Configuration Manager for years also have a significant time investment in its existing configuration. For example, an organization can have several hundred application packages and extensive settings and compliance policies. Even if Intune addresses all the needs that Configuration Manager currently manages in an organization, the effort to migrate that to Intune would be significant. Customers shouldn't arbitrarily migrate workloads unless there's a clear value to be gained by shifting those workloads.

However, there may be some workloads where there's a clear value to migrating them. OS deployment is a common example. Image management is typically an ongoing effort that is tedious and time consuming. As most new devices come with Windows 10 or Windows 11, organizations frequently see immediate returns by adopting Autopilot to replace image deployment. Applications, like Office, and new applications can be deployed through Intune (which are typically easier to perform) while existing and complex applications can be deployed with Configuration Manager. The Endpoint Manager Admin Console helps unify the management of the device, while still providing choice as to which underlying technology to use for delivery.
