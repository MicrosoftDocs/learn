Whether your app release is in the hands of your testers, or out on an app store in the hands of your customers, you want them to have a reliable experience. App failures are bound to happen, though, and you'll want to know as much as you can about the errors that lead to it. This data can help you find the issue in your code and fix it quickly. That situation is where diagnostics data can help you.

## What is diagnostics?

Diagnostics is determining when an app has an issue and finding the cause of that issue. App Center offers a diagnostic service to help you monitor for app issues. The App Center Diagnostics software developer kit (SDK) allows you to collect the diagnostic information that is needed to find the source of these issues.

## When is data collected?

When you're using the App Center SDK and your app encounters an error that will cause the app the crash, the details are written to local storage before the app unloads. Since your app has encountered an unexpected error, the app is in a state that isn't reliable enough to send the data to App Center. However, when the app is launched by the user again, it will send the diagnostics data to App Center.

> [!NOTE]
> You can configure your app so that users can opt out of the diagnostics data submission process; for example, through a privacy setting.

While your app is running, you can also track specific events. Then, if your app encounters an error that will need to be logged, the data from those events will be available to track the state of your app when the error occurred.

## Collect error data manually

You can rely on the automatic system for gathering details about an app issue. However, if your app has an issue that you want to prevent from crashing your app, you can write code to handle the exception while still submitting the current information to App Center for review. Within your error handling code, like a `try`/`catch` block, you can call a `Crashes.TrackError` method to send the details to App Center without letting your app crash. This manual error data collection is currently only available to apps using the Xamarin, Unity, WPF, and WinForms SDKs.

## Customize collected data

When an app issue occurs, data is automatically gathered for you by the App Center SDK so that it can submit it for review. The SDK will collect basic device information and app execution information. It will also collect information on currently running threads.

To help you diagnose issues that are seen by a specific user, you can also attach a user ID to your crashes and errors using the SDK. By default, App Center assigns a unique ID to each installation of your app that isn't tied to any identifying user information. However, you can associate identifying information within your app to the installation ID using the SDK. For example, you can create an association when a user logs into an account in order to create a unique user ID. After you assign a user ID to the data that you send to App Center, you'll be able to search for crashes tied to a specific user.

To help determine the source of your errors, you can also include attachments to your error details before they are submitted. On some platforms, the SDK will allow you to attach custom information in the form of key-value pairs.

## Review collected diagnostic data

Once your app is collecting diagnostic data and sending it to App Center, you'll want to review this data. The collected data can be viewed from the App Center web portal. Your issue data can be viewed various ways using the filtering and sorting options. Errors that look similar will be grouped automatically by the reason for the error and the location it occurred in your code.

Additionally, you can configure alerts in App Center for your apps. When a new crash group is identified, it can notify people or teams by email.

## Configure data retention

As new data is submitted to App Center, it will store that data for 90 days by default. If you want to shorten the duration, for example if you need to comply with your organization's data retention policies, you can reduce the retention to 28 days.

> [!NOTE]
> Currently you can only configure the data retention period for 90 days or 28 days.

If you wish to retain data for longer periods, you can configure App Center to export data to Azure Blob Storage using the App Center API. By continually exporting older data, you can maintain as much historical data as you wish for later reporting use.
