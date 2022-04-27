App Center can build and test your apps, but regardless of how you build or test your app, you can use App Center Distribute to deliver a release to a target audience. If you have pre-release testers, you can distribute the latest alpha or beta release to them in order to gather their feedback. Maybe you have a collection of external users who get pre-release versions of your app for feedback. You can also distribute your release builds to a public app store.

## What is a distribution group?

A _distribution group_ is a collection of users that you can manage together. Distribution groups allow you to configure access to releases for everyone in a distribution group at once. Distribution groups can be private or public, with private being the default.

A private distribution group means that only testers who are invited via email are able to access the releases that are available to that group. Once a tester is part of a private group, that tester will receive new release notification emails. Members of private groups must sign in to their App Center account to access releases.

A public distribution group allows for unauthenticated installs from public links. After a group is named, it can be made public. As with private groups, members of a public group will receive notification emails about new releases. Additionally, a public download link does not require signing in to download the release.

You might have a distribution group for several types of users or stages of development:

* A private group of internal alpha and beta testers
* A private group of internal QA users
* A private group of external beta testers
* A public group of external prerelease users

### What is a shared distribution group

When you use App Center for an organization, you can also add shared distribution groups. A _shared distribution group_ is a distribution group that is used across multiple apps within a single organization, which simplifies permissions and release distribution across several related apps. Shared distribution groups can be either private or public.

For example, you may have an app that is available on iOS and Android. With a shared distribution group, you only need a single distribution group for each type of tester. You wouldn't need to create a group for iOS and a duplicate group for Android. With a single shard distribution group, you wouldn't need to keep multiple groups in sync as users are added or removed.

## Add users to distribution groups

New users can be added to distribution groups by email address. The added user is sent an email to join the group.

Additionally, users can also be added from Azure Active Directory (AAD) groups. First, you link an AAD tenant to your organization's App Center subscription. Once the tenant is linked, you can start adding AAD groups to your App Center distribution groups.

## Manage iOS devices automatically

App Center can manage the device provisioning that is required for iOS development installs. Normally, iOS provisioning is done from the Apple developer portal. You would add either a single device or several devices to a provisioning profile by their device ID (UDID).

With App Center distribution groups, you may want to have these device IDs managed for you. You register your Apple ID credentials and a production certificate, and App Center will manage these device IDs for your. With each release, all devices in a target distribution group will be registered and provisioned. With the devices provisioned, it can re-sign your app to install on any of those distribution group devices.

## Release a build to a distribution group

Once you have a build, whether built by App Center or in your own build system, you'll want to release it to a group for testing. Releases can be done using several possible approaches.

Creating a release can be accomplished from the App Center build configuration by providing the appropriate code-signing certificates and configuration values. With code signing configured, you can enable distribution to one or more distribution groups or app stores.

Additionally, if you create your signed builds from your own build system, you can upload them to App Center yourself. Uploading builds can be done from the **New release** button in the **Distribute** > **Releases** section of an App Center app. You can also upload releases using either App Center command-line interface or App Center API.

When your distribution group users start downloading a release, App Center will count how many installs and unique installs are completed. This data is available from the **Releases** data for each release.

## Release a build to an app store

The new releases you upload can also be distributed to app stores or company distribution portals. For iOS and Android apps, you can distribute your app to the Apple App Store, the Google Play Store, and via company distribution through Microsoft Intune.

For each of these distribution points, you configure App Center with any required signing certificates and authentication or service account details.
