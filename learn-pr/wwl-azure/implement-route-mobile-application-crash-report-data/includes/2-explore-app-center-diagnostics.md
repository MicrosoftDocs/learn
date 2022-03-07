App Center Diagnostics is a cloud service that helps developers monitor the health of an application, delivering the data needed to understand what happens when an app fails during testing or in the wild.

The App Center Diagnostics SDK collects information about crashes and errors in your apps.

It uploads them to the App Center portal for analysis by the development team - eliminating the guesswork about what happened in the app when it failed.

## Crashes

Crashes are what happens when a runtime exception occurs from an unexpected event that terminates the app.

These are errors not handled by a try/catch block. When a crash occurs, App Center Crashes records the state of the app and device and automatically generates a crash log.

These logs contain valuable information to help you fix the crash.

## Crash and errors analytics

In-App Center Diagnostics, you can view analytics data generated automatically by App Center to understand when a crash or error occurs in your app.

By default, App Center displays an app's crashes and errors per day in a side-by-side view.

Using the top-left tabs, drill down into Crashes and Errors.

When you do it, the left chart indicates the number of crashes/errors per day, and the right graph shows the number of affected users.

Filter the charts by app version, time frame, and status for a more-focused view.

:::image type="content" source="../media/app-center-diagnostics-30bdcb58.png" alt-text="App Center Diagnostics. Left, and right chart.":::


## Grouping

App Center Diagnostics groups crash and errors by similarities, such as the reason for the issue and where the problem occurred in the app.

For each crash and error group, App Center displays the line of code that failed, the class or method name, file name, line number, crash or error type, and message for you to understand these groups at a glance better.

Select a group to view more information and access a list of complex issues reports and logs.

It allows you to dive even more profound and use our feature set to better understand your app's behavior during a crash or an error.

:::image type="content" source="../media/crash-groups-27369686.png" alt-text="Crash groups":::


## Attachments

In the App Center Diagnostics UI, you can attach, view, and download one binary and one-text attachment to your crash reports.

You can learn to add attachments to your crash reports by reading the SDK Crashes documentation for:

 -  [Android](/appcenter/sdk/crashes/android#add-attachments-to-a-crash-report).
 -  [iOS](/appcenter/sdk/crashes/ios#add-attachments-to-a-crash-report).
 -  [macOS](/appcenter/sdk/crashes/macos#add-attachments-to-a-crash-report).
 -  [React Native](/appcenter/sdk/crashes/react-native#add-attachments-to-a-crash-report).
 -  [Xamarin](/appcenter/sdk/crashes/xamarin#add-attachments-to-a-crash-report).
 -  [Apache Cordova](/appcenter/sdk/crashes/cordova#add-attachments-to-a-crash-report).

Select a crash group, a specific device report, and click on the attachments tab to view and download the attachments.

:::image type="content" source="../media/view-attachments-ef69a46d.png" alt-text="View attachments":::


## Events before a crash

Track events leading up to a crash to capture valuable information about the state of your app.

To define a custom event, check out our [SDK Documentation](/appcenter/sdk/index) for [Android](/appcenter/sdk/analytics/android), [iOS](/appcenter/sdk/analytics/ios), [React Native](/appcenter/sdk/analytics/react-native), [Xamarin](/appcenter/sdk/analytics/xamarin), [UWP](/appcenter/sdk/getting-started/uwp), and [macOS](/appcenter/sdk/analytics/macos).

Select a crash group, a specific device report, and click on the events tab to view events before a crash.

:::image type="content" source="../media/view-events-before-crash-82398c2c.png" alt-text="View events before a crash":::
