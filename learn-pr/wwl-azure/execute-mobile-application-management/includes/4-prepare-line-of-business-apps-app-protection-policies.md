

You can enable your apps to use app protection policies by using either the Intune App Wrapping Tool or the Intune App SDK.

#### Intune App Wrapping Tool

The App Wrapping Tool is used primarily for internal line-of-business (LOB) apps. The tool is a command-line application that creates a wrapper around the app, which then allows the app to be managed by an Intune app protection policy. When protecting an app provided by an independent software vendor (ISV), it's important to clarify if the ISV will still support the wrapped app. You don't need the source code to use the tool, but you do need signing credentials.

> [!NOTE]
> The App Wrapping Tool does not support apps in the Apple App Store or Google Play Store. It also doesn't support certain features that require developer integration.

Reasons to use the App Wrapping Tool:

 -  Your app doesn't have built-in data protection features
 -  Your app is simple
 -  Your app is deployed internally
 -  You don't have access to the app's source code
 -  You didn't develop the app
 -  Your app has minimal user authentication experiences

#### Intune App SDK

The Intune App SDK is designed mainly for customers who have apps in the Apple App Store or Google Play Store, and want to be able to manage the apps with Intune. However, any app can take advantage of integrating the SDK, even line-of-business apps.

Reasons to use the SDK:

 -  Your app doesn't have built-in data protection features
 -  Your app is complex and contains many experiences
 -  Your app is deployed on a public app store such as Google Play or Apple's App Store
 -  You're an app developer and have the technical background to use the SDK
 -  Your app has other SDK integrations
 -  Your app is frequently updated

#### Apps without app protection policies

When apps are used without restrictions, company and personal data can get intermingled. Company data can end up in locations like personal storage or transferred to apps beyond your purview and result in data loss. The arrows in the preceding diagram show unrestricted data movement between both corporate and personal apps, and to storage locations.

:::image type="content" source="../media/mobile-device-corporate-personal-data-9ff783fc.png" alt-text="Diagram shows unrestricted data movement between both corporate and personal apps, and to storage locations.":::


You can use app protection policies to prevent company data from saving to the local storage of the device. You can also restrict data movement to other apps that aren't protected by app protection policies. App protection policy settings include:

 -  Data relocation policies like Prevent Save As, and Restrict cut, copy, and paste.
 -  Access policy settings like Require simple PIN for access, and Block managed apps from running on jailbroken or rooted devices.

#### Data protection with app protection policies

:::image type="content" source="../media/mobile-device-isolated-corporate-data-8386c158.png" alt-text="Illustration shows the layers of protection that mobile device management and app protection policies offer together.":::


The preceding illustration shows the layers of protection that MDM and app protection policies offer together.

The MDM solution:

 -  Enrolls the device
 -  Deploys the apps to the device
 -  Provides ongoing device compliance and management

App protection policies add value by:

 -  Helping protect company data from leaking to consumer apps and services
 -  Applying restrictions like save-as, clipboard, or PIN, to client apps
 -  Wiping company data from apps without removing those apps from the device

#### Data protection with app protection policies on devices managed by a Mobile Device Management solution

:::image type="content" source="../media/mobile-device-isolated-corporate-data-policy-d6816879.png" alt-text="Diagram illustrates how the data protection policies work at the app level without mobile device management.":::


The preceding diagram illustrates how the data protection policies work at the app level without MDM.

For BYOD devices not enrolled in any MDM solution, App protection policies can help protect company data at the app level. However, there are some limitations to be aware of:

 -  You can't deploy apps to the device. The end user has to get the apps from the store.
 -  You can't provision certificate profiles on these devices.
 -  You can't provision company Wi-Fi and VPN settings on these devices.

#### Data protection with app protection policies for devices without enrollment

:::image type="content" source="../media/mobile-device-isolated-corporate-data-only-a1b0314d.png" alt-text="Illustration shows Data protection with app protection policies for devices without enrollment.":::
