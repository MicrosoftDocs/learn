The OS is your responsibility. You can continue to use the most current on-premises methods you might employ for compliance, security, application management, basis, and OS management. The systems appear as if they are in your network in all regards. This service is optimized for SAP HANA, so there are areas where you need to work with Microsoft to use the underlying infrastructure capabilities for best results.

HANA Large Instances do not have direct internet connectivity. This limitation will prevent you from registering the operating system instances directly with the OS vendor. As a workaround, you need to use SUSE Linux Enterprise Server Subscription Management Tool or Red Hat Enterprise Linux Subscription Manager, depending on the OS of the HANA Large Instance.

> [!NOTE]
> The OS upgrade is the customer's responsibility, Microsoft operations support can guide you to the key areas to watch out for during the upgrade. You should consult your operating system vendor as well before you plan for an upgrade.

During HLI unit provisioning, the Microsoft operations team installs the operating system. Over time, you are required to maintain the operating system (Example: Patching, tuning, upgrading etc.) on the HLI unit. Before you do major changes to the operating system (for example, Upgrade SP1 to SP2), contact Microsoft Operations team by opening a support ticket to consult. Include in your ticket:

 -  Your HLI subscription ID
 -  Your server name
 -  The patch level you are planning to apply
 -  The date you are planning this change

It is recommended you open this ticket at least one week before the desirable upgrade date, which will let the operations team know about the desired firmware version. For the support matrix of the different SAP HANA versions with the different Linux versions, see [SAP Note \#2235581](https://launchpad.support.sap.com/#/notes/2235581).
