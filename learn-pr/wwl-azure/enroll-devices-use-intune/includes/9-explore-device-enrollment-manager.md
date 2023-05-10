

Organizations can use Intune to manage large numbers of mobile devices with a single user account. The device enrollment manager (DEM) account is a special user account that can enroll up to 1,000 devices. Organizations can use Intune to manage large numbers of mobile devices with a single user account. You add existing users to the DEM account to give them the special DEM options. Each enrolled device uses a single license. A DEM account is useful for scenarios where devices are enrolled and prepared before handing them out to the users of the devices. The DEM would enroll the device, log on to the company portal and install the apps required by the user. If the user requires individual configuration such as e-mail profiles, then the user should enroll the device themselves, and DEM shouldn't be used.

Users must exist in the Azure portal to be added as device enrollment managers. For optimal security, the DEM user shouldn't also be an Intune admin. The DEM enrollment method can't be used with these other enrollment methods: Apple Configurator with Setup Assistant, Apple Configurator with direct enrollment, Apple School Manager (ASM), or Device Enrollment Program (DEP).

### Example of a device enrollment manager scenario

A restaurant wants to provide 50 point-of-sale tablets for its wait staff, and order monitors for its kitchen staff. The employees never need to access company data or sign in as users. The Intune admin creates a new device enrollment manager account for the restaurant supervisor. This account is separate from the supervisor's primary account and is used only for enrolling shared devices with Intune. The supervisor can now enroll the 50 tablets devices by using the DEM credentials.

### What can a device enrollment manager do?

Only users in Azure AD can be added as a device enrollment manager.

The DEM user can:

 -  Enroll up to 1000 devices in Intune
 -  Sign in to the Company Portal to get company apps
 -  Configure access to company data by deploying role-specific apps to the tablets

### Limitations of devices that are enrolled with a DEM account

Devices that are enrolled with a device enrollment manager account have the following limitations:

 -  No per-user access. Because devices don't have an assigned user, the device has no email or company data access. VPN configurations, for example, could still be used to provide device apps with access to data.
 -  The DEM user can't unenroll DEM-enrolled devices on the device itself by using the Company Portal. The Intune admin can unenroll.
 -  Only the local device appears in the Company Portal app or website.
 -  Users can’t use Apple Volume Purchase Program (VPP) apps with user licenses because of per-user Apple ID requirements for app management.
 -  (iOS only) If you use DEM to enroll iOS devices, you can't use the Apple Configurator, Apple Device Enrollment Program (DEP), or Apple School Manager (ASM) to enroll devices. This means that you can't put the device in supervised mode and thus won't have access to some configuration options.
 -  (Android only) There's a limit to the number of Android work profile devices that can be enrolled with a single DEM account. Up to 10 Android work profile devices may be enrolled per DEM account. This limitation doesn't apply to legacy Android enrollment.
 -  Devices can install VPP apps if they have device licenses.
 -  An Intune device license isn't required to use DEM.

### Add a device enrollment manager

1.  Sign in to **Microsoft Intune admin center** located at https://intune.microsoft.com.
2.  In the left navigation, select **Devices** \- **Enroll devices** \- **Device enrollment managers**.
3.  Select **Add**. On the **Add User** panel, enter a user principal name for the DEM user, and select **Add**. The DEM user is added to the list of DEM users.

### Permissions for DEM

Global or Intune Service Administrator Azure AD roles are required to:

 -  Complete tasks that are related to DEM enrollment in the Admin Portal
 -  Access all DEM users despite role-based access control (RBAC) permissions being listed and available under the custom User role

A user without the Global Administrator or Intune Service Administrator role assigned, but who has read permissions for the Device Enrollment Managers role, can access only the DEM users they created.
