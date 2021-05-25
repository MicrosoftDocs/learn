Intune supports several protected Microsoft apps and partner apps that specially incorporate mobile app management capabilities. Intune protected apps are enabled with a rich set of mobile application protection policies. These apps allow you to:

- Restrict copy-and-paste and save-as functions
- Configure web links to open inside the secure Microsoft browser
- Enable multi-identity use and app-level Conditional Access
- Apply data loss prevention policies without managing the user's device
- Enable app protection without requiring enrollment
- Enable app protection on devices managed with third-party EMM tools

To better understand the available protected apps that integrate with Intune, see a list of [Microsoft Intune protected apps](https://docs.microsoft.com/mem/intune/apps/apps-supported-intune-apps?azure-portal=true).

## Create protected apps using tools

Normally to add an app to Intune, you would start from Endpoint Manager and select an app from a list of store apps. Many apps are specifically designed to work with Intune and have extended functionality. These apps are call protected apps. Protected apps incorporate mobile app management capabilities using the Intune App Software Development Kit (SDK) or the App Wrapping Tool for either iOS or Android. You would uses these tools if you are an apps developer.

An example of a protected app that can be managed with Intune is Outlook for iOS and Android. You can use Intune app protection and configuration policies with Outlook for iOS and Android to ensure team collaboration experiences are always accessed with safeguards in place. Organizations can use Azure AD Conditional Access policies to ensure that users can only access work or school content using Outlook for iOS and Android.

