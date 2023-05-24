

The importance of keeping apps updated can't be overstated, as it plays a crucial role in maintaining digital products' security, stability, and overall user experience. Regular updates ensure that users enjoy the most current and optimized version of the app and protect them from potential cyber threats, as updates often include critical security patches that safeguard user data and privacy. Moreover, outdated apps may become incompatible with evolving operating systems or other software components, which could lead to performance issues or even application crashes. Users can benefit from an optimal digital experience while safeguarding their devices and personal information by prioritizing app updates.

The information below will teach you to efficiently update Microsoft Store Apps using Intune, ensuring your team stays productive and secure with the latest features and enhancements.

## App update

Apps that are deployed from the Microsoft Store are automatically kept up to date to the latest version of the app. For this feature to work properly for UWP apps, the Turn off Automatic Download and Install of updates shouldn't be enabled.

## Microsoft Store Win32 apps

> [!IMPORTANT]
> Win32 apps that are in the Microsoft Store are currently in preview. Not all Win32 apps will be available or searchable. The Win32 apps that are in preview will be identifiable with Win32 and a banner.
> Third party vendors or publishers that add Win32 apps to the Microsoft Store are responsible for hosting their own content in their respective infrastructure. If your devices are behind a firewall, please reach out to application owner to understand and confirm network requirements.
### Intune management of Microsoft Store Win32 apps
When a Microsoft Store Win32 app is published to a device as **Required**, but it's already installed (either manually or via the [Microsoft Store for Business](/mem/intune/apps/windows-store-for-business)), Intune will take over the management of the application.

For available Microsoft Store Win32 apps, and UWP apps, the end user must click **install** in the Company Portal before Intune takes over the management of the application. Intune won't attempt to re-install the app.

The Microsoft Store supports Win32 app types including .exe and .msi installers. These apps have external content sourcing hosted by the app publisher. Based on their installer definition in the store, each Win32 app supports either User or System context installation.For related information, see [Traditional desktop apps in the Microsoft Store on Windows](https://developer.microsoft.com/microsoft-store/desktop-apps).

## Microsoft Store UWP apps

In addition to the user context, deploying Universal Windows Platform (UWP) apps from the updated Microsoft Store app in the system context is possible. When a provisioned .appx app is deployed this way, it will automatically install for every user who logs in. If a particular end user decides to uninstall the user context app, it will continue to appear as installed due to its provisioning. Moreover, the app must not be pre-installed for any users on the device. As a general guideline, we recommend avoiding mixing install contexts during app deployment.

## Store group policies restrictions

Some **Store Group Policies** may affect app deployments from the Microsoft Store.

The following table provides details about how app deployment may be affected by **Store Group Policies**:

|Store Group Policies|Desired setting|
|-----|-----|
|Store\Disable all apps from the Microsoft Store|Not configured or Enabled. Set to Enabled if wish to prevent end users from blocking the scenario.|
|Not configured or Enabled. Set to Enabled if wish to prevent end users from blocking the scenario.|Not configured or Disabled. Set to Disabled if you need to prevent end users from blocking the scenario.|
|Desktop App Installer\Enable App Installer Microsoft Store Source|Not configured or Enabled. Set to Enabled if you need to prevent end users from blocking the scenario.|
|Desktop App Installer\Enable App Installer|Not configured or Enabled. Set to Enabled if you need to prevent end users from blocking the scenario.|
|Store\Turn off the Store application|Not configured or Disabled. Set to Disabled if you need to prevent end users from blocking the scenario.|

> [!NOTE]
> If you would like to block installation of arbitrary applications from the Store application by the end user without blocking the Intune and Windows Package Manager store integration, set Store\Only display the private store within the Microsoft Store to Enabled.