FSLogix enhances and enables a consistent experience for Windows user profiles in virtual desktop computing environments. FSLogix isn't limited to virtual desktop environments, but could be used on physical desktops where a more portable user experience is desired.

Here are a few things that FSLogix provides:

 -  Roam user data between remote computing session hosts.
 -  Minimize sign in times for virtual desktop environments.
 -  Optimize file I/O between host/client and remote profile store.
 -  Provide a local profile experience, eliminating the need for roaming profiles.
 -  Simplify the management of applications and 'Gold Images'.

FSLogix provides customers with both ease of configuration and various levels of flexibility. This can lead to limitless configuration options of which, can have unintended consequences. FSLogix can be a complex solution with various dependencies on other systems and infrastructure. We recommend that you engage with resources who have the following skill set or have these skills inherently:

 -  Identity and Authentication.
 -  Storage design and architecture.
 -  Active Directory, Microsoft Entra ID, or Microsoft Entra ID Domain Services.
 -  Windows Deployment (Server or Desktop).
 -  Application Compatibility.
 -  FSLogix provides unique integration and advantages when used in an [Azure Virtual Desktop](/azure/virtual-desktop/) environment.

## Key capabilities

 -  Redirect user profiles to a [storage provider](/fslogix/concepts-fslogix-terminology). Mounting and using the profile from a storage provider eliminates delays often associated with solutions that copy profiles to and from a network location.
 -  Redirect only the portion of the profile that contains Office data by using an [ODFC](/fslogix/concepts-fslogix-terminology)[container](/fslogix/concepts-fslogix-terminology). The ODFC container allows an organization already using an alternate profile solution to enable Microsoft 365 applications in multisession desktop environments.
 -  Applications use the user's profile as if it were on the local disk. FSLogix uses a filter driver to virtualize and [redirect](/fslogix/concepts-fslogix-terminology) the profile at the file system level. Applications are unaware the profile is on the network. Obscuring the redirection is important because many applications can't work properly with a profile stored remotely.
 -  [Profile](/fslogix/concepts-fslogix-terminology) containers used with [Cloud Cache](/fslogix/concepts-fslogix-cloud-cache) to provide [high availability](/fslogix/concepts-container-high-availability) and [disaster recovery](/fslogix/concepts-container-recovery-business-continuity) profile solutions.
 -  [Application Rule Sets](/fslogix/tutorial-application-rule-sets) manage access to an application, font, printer, or other items. Access can be controlled using users, groups, IP Addresses, and other criteria. Application Rule Sets significantly decrease the complexity of managing large numbers of gold images.
