Let's start with a few definitions of some of the concepts you'll see in App Center services.

## What is automated user interface testing?

There are several types of tests that can be run against both source code and compiled software. _Automated user interface (UI) testing_ executes a set of commands against a running app to ensure that you receive the expected outcomes. Automated UI testing could be done in the form of running commands with a web, desktop, or mobile application.

In the shoe company example, you may want to ensure that a set of specific steps results in an item being added to the customer's cart. Or you may want to verify the steps involved in searching for a type of product. You may even want to ensure that all the steps that are required to place an order are working correctly.

Test is the service in App Center that runs automated UI testing on native and hybrid mobile apps. These tests run against physical devices in a Microsoft data center and allow you to review the resulting success status, any logged information, and any captured screenshots.

## What is continuous integration?

_Continuous integration_ (CI) is the practice whereby source code is frequently run through various processes to ensure it is in a known working state. CI could mean a set of tests run on a developer's machine, or on a build server, or both. A goal of continuous integration is to improve software quality, specifically by finding issues before they are delivered to the end user.

A continuous integration system can ensure your code builds correctly, can run unit tests, and can execute any number of other tests to make sure the code works as expected. When configured in App Center, the CI service will make sure the app builds and can also execute repeatable automated user interface tests against real mobile devices.

## What is continuous delivery?

_Continuous delivery_ (CD) is the ability to deploy a new version of your app to your users automatically as soon as a new build is ready. When a new feature is added to your app and ready to be sent to testers or all users, it is more reliable to use an automated delivery system. With continuous delivery in place, once the new feature is in the correct location in source control, an automated system can pick up the latest code, build an app deliverable, and make that app available for testers or any number of internal or public app stores.

## What is Visual Studio App Center?

Visual Studio App Center is a collection of several common mobile development and cloud integration services, such as continuous integration, continuous delivery, and automated UI testing. These App Center services can run against iOS, Android, Universal Windows Platform (UWP), and tvOS apps. These apps can be built using several different native and web-based frameworks.

The App Center services allow developers to build, test, and distribute their applications easily. After an app is in use by testers or customers, App Center provides services to monitor usage and issues with apps, and to reach and engage users with push notifications.

If your development process involves the build, test, and distribution services, App Center can handle the steps as soon a developer makes a commit to the desired source control branch. With the code in source control, App Center will build the app for iOS and Android and run integrated UI tests to ensure the app meets expectations. The resulting app can then be deployed automatically to public app stores, such as the Apple App Store or Google Play Store.

When your app uses App Center analytics and diagnostics services, those features can start collecting analytics and diagnostic data as soon as your testers and customers begin using the app. You'll be able to see how your app is used by real customers and to diagnose issues they might encounter.

App Center streamlines app development and release processes into automated workflows, eliminating the potential for missed testing or misconfigured app releases, which may be rejected by app store approval systems.
