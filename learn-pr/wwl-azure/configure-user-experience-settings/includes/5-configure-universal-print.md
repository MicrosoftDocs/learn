Universal Print is a modern print solution that organizations can use to manage their print infrastructure through cloud services from Microsoft.

Universal Print runs entirely on Microsoft Azure. When it's deployed with Universal Print–compatible printers, it doesn't require any on-premises infrastructure.

### Printers are installed as part of the user profile

Instead of printers being installed as a machine-wide resource (that is, all installed printers are visible to all users who sign in to the VM), each user sees only the printers they install.

### Printers roam with user profiles

When user profiles are configured to roam, printers that the user installs on one VM will be automatically installed on other VMs the user signs into. This behavior also works when users remove printers from their profile.

### Location-based printer search the local device location

Instead of finding printers close to the location of the VM where the user is signed in, location-based printer search will find printers based on the device the user is connecting from. This requires the location override functionality to be enabled.

## Relevant information and caveats

### Location override configuration

To enable location-based printer search using the AVD client location, location services must be configured on all VMs as follows:

1.  Open the Settings app in Windows and go to **Privacy & security**.
2.  In the **App permissions** section, select **Location**.
3.  Enable **Location services**.
4.  Enable **Allow location override**.

### Printer redirection

Printer redirection affects whether the printers installed on the PC the user is connecting from will be available in the remote session. While there's no recommended setting, this configuration affects the printers that will be available to the user in the remote session. Therefore, the admin should decide what the correct configuration is for their users.

#### Configure printer redirection

1.  Go to [https://portal.azure.com](https://portal.azure.com/)
2.  Under Azure services, select **Azure Virtual Desktop**.
3.  Select **Host pools** and select on the host pool you would like to configure.
4.  On the host pool configuration page, select **RDP Properties**, then click on **Device redirection**.
5.  Choose your preferred printer redirection setting.

> [!NOTE]
> Printer redirection affects the default printer behavior. When you choose to have printers on the local computer be available in the remote session, the default printer on the local computer will become the default printer in the remote session.

### Printing preferences and printer properties

Printing preferences are the options the user chooses every time they print. Depending on what the printer supports, this could be things like paper size, stapling, color vs. greyscale, etc. When a user sets their printing preferences defaults, these user preferences roam with the user across different sessions hosts.

Printer properties are the configuration of a printer on a particular PC. These are things like the printer driver, the ports where the printer is installed on this PC, and other printer settings. This configuration is machine-specific, and doesn't roam with the user across session hosts.
