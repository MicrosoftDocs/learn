The app management lifecycle for Intune and Configuration Manager apps begins when you add an app and it progresses through more phases until you remove the app. To help you get started with app management in Intune, let's take a look at these phases in more detail.

![App management lifecycle in Microsoft Intune.](../media/intro-to-endpoint-manager-20.png)

## Add

The first step when providing apps to your organization is to add the apps to Intune or create the app in Configuration Manager. While you can work with many different app types, the basic procedures are the same. With Intune, you can add different app types, including apps written in-house (line-of-business), apps from the store, apps that are built in, and apps on the web. With Configuration Manager, you can create the app and add requirements that must be met before the app is installed.

## Deploy

After you've added the app to either Intune or Configuration Manager, you can deploy the app. In Intune, you assign the app to users and devices that you manage. Intune makes this process easy, and after the app is deployed, you can monitor the success of the deployment from Intune within the Azure portal. Additionally, in some app stores, you can purchase app licenses in bulk for your company. Intune synchronizes data with these stores, allowing you to deploy and track license usage for these types of apps right from the Intune administration console. In Configuration Manager, you deploy the app to a device collection based on the Windows OS requirements that you select.

## Configure

Intune and Configuration Manager both provide methods to configure app installation and updates. You can configure extra functionality for some apps, for example:

- iOS/iPadOS app configuration policies supply settings for compatible iOS/iPadOS apps that are used when the app is run. For example, an app might require specific branding settings or the name of a server to which it must connect.
- Managed browser policies help you to configure settings for Microsoft Edge, which replaces the default device browser and lets you restrict the websites that your users can visit.
- You can set specific settings for Microsoft Outlook when you install it.
- Configure whether to install certain apps in User or System context.
- Rules to detect if the app is installed, needs to be updated, or has specific installation dependencies.

## Protect

Intune gives you many ways to help protect the data in your apps. The main methods are:

- Conditional Access, which controls access to email and other services based on conditions that you specify. Conditions include device types or compliance with a device compliance policy that you deployed.
- App protection policies work with individual apps to help protect the company data that they use. For example, you can restrict copying data between unmanaged apps and apps that you manage. Or, you can prevent apps from running on devices that have been jailbroken or rooted.

## Retire

Eventually, apps that you deploy become outdated and need to be removed. In Intune, you can uninstall apps by assigning an uninstall intent to a group of users or devices. In Configuration Manager, you can delete an app by first retiring the app. Then, deleting all deployments of the app and removing references to the app by other deployments. Finally, by deleting all of the app's revisions.
