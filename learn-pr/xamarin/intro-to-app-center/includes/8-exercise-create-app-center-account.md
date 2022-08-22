To get started using Visual Studio App Center, you'll need an App Center account. By following the steps in this exercise, you'll create an App Center account and explore some of the features offered by the App Center portal.

## Navigate to App Center

* In a new browser tab or window, navigate to the [App Center portal](https://appcenter.ms?utm_source=MSLearn).

If you aren't already signed in to App Center, a welcome page describes App Center features, with links to additional pages about pricing, documentation, and support.

## Create an App Center account
Creating an App Center account is free, and App Center allows you to sign in with the following accounts to get started:

    * GitHub account
    * Microsoft personal account
    * Microsoft company or school account
    * Facebook account
    * Google account

1. To create an App Center account, select **Sign in** and register with one of the accounts you have. 

1. Associate your App Center use with that account. 

1. Proceed through whatever authentication system you selected. When you complete authentication with one of the providers, you are redirected to the Visual Studio App Center.

1. When prompted, enter a username you want to use for App Center, or use the suggestion that App Center provides. 

    You'll be able to change your username later from your App Center profile. 

1. Select **Choose username** to continue to the App Center portal.

## Create an app

After signing in, create a temporary app so that we can explore the App Center services.

1. In the top right, select **Add new**, and then select **Add new app** to start creating a temporary app.

    ![Screenshot of Add new button with dropdown showing Add new app option highlighted.](../media/8-app-center-add-new-app.png)

1. Enter an **App name** of your choice.

1. Select any one of the **Release Type** values for this temporary app. Notice the different options available; for example, Alpha, Enterprise, Store, etc.--or you can specify your own custom type.

1. Select the different **OS** options, and notice which platforms and languages are supported. For example, the platform options change between iOS and Android.

1. Select an **OS** value of your choice for this app.fd

1. Select a **Platform** value of your choice.

1. Select **Add new app**.

    ![Screenshot of the new App Center app with arbitrary values entered and chosen.](../media/8-app-center-new-app-form.png)

The navigation menu for App Center presents the various service options available. **Overview** pane displays the workflow for the platform you selected. Because you're creating a new app, **Overview** displays instructions, along with links to additional documentation, for integrating the App Center SDK with the OS and platform you selected for your temporary app.

## Explore the App Center services

Let's explore the services represented in the navigation menu. Select a heading and then click through the App Center services for that section. Selections may vary, based on which OS platform you chose for your temporary app. The following overview of the main headings identifies the menu items available under each section heading.

### Build

* Select **Build** from the menu. Depending on your web browser's window, you may need to select the menu icon at the top left to see the left-hand menu.

  ![Screenshot of the App Center app navigation with Build section selected.](../media/8-app-center-navigation-build.png)

The **Build** section is where you can configure builds of your app's source code. Builds can be started automatically for each commit to a branch, or manually from the App Center portal.

You can configure App Center to retrieve your app's code from several different services, as shown on the build page for this temporary app. Once you've configured a source code service and a repo within it, this page will present the various build configurations you have configured on your branches. You will be able to see the most recent commit to the branch and the status of the most recent build of the code in that branch. If there were any errors during a build, you can click into the specific build and investigate the errors from the build output.

### Test

* Select **Test** from the App Center menu. The **Test** section offers two subsections: **Test runs** and **Device sets**.

  * Creating a **test run** enables you to select the real, physical devices on which to run your tests. After you have created some preferred device sets, you can quickly pick a set of devices. From there, you will be given instructions to install and run the **appcenter-cli** npm package to allow you to run tests on the selected devices on-demand.

  * Creating a **device set** enables you to pre-select representative devices for testing your app. If you know most of your users are on fairly new Android devices, for example, you could pick a few of the most recent Android models. Alternatively, if you create an app specific to iPad tablets, you could pick out several iPad, iPad Mini, and iPad Pro devices. You would give the set of devices a name and be able to reference that set easily for your test runs.

You might also create a device set that represents the devices that seem to produce the most problems for your app's users. A problem device set would enable you to run tests for known issues before releasing a new build, ensuring you haven't introduced any regressions to those users.

### Distribute

* Select **Distribute** from the App Center menu. From the **Distribute** section, you can send previous builds to your distribution groups or directly to an app store. If you've already used Visual Studio App Center, you see have several subsections: **Release**, **Groups**, and **Stores**.

  ![Screenshot of the App Center app navigation showing Distribute and its subsections.](../media/8-app-center-navigation-distribute-release.png)

  * In **Releases** subsection of Distribute, you can distribute a release. You can either upload a build manually or specify which build you want to distribute. 
  
  * You can create distribution groups in **Groups** subsection. You'll be able to pick which release group or app store to send your build to in the new release steps, or in the destinations you set up in the Distribute subsections. For each release you distribute, you will be able to view the distribution group that was used and the download count of that release.

  * In **Groups** subsection of Distribute, you can create and manage your distribution groups. You set up these groups to reach predefined sets of users, such as users who handle app testing or pre-publish approval reviews.

  * Finally, the **Stores** subsection of Distribute has options for setting up links to public app stores to release your app to end users. Connecting to a store allows you to publish your app. For iOS apps, you would set up a connection to the Apple App Store or Intune Company Portal. For Android apps, you would set up a connection to the Google Play Store or Intune Company Portal.

### Diagnostics

* Select **Diagnostics** from the App Center menu. After you have incorporated the App Center SDK into your app, you will be able to view crash information. These data points  reflect crashes reported by your app users. Charts of crash counts and a list of error groups will be available to view.

### Analytics

* Select **Analytics** from the App Center menu. **Analytics** has several subsections: **Overview**, **Events**, and **Log flow**.

  ![Screenshot of the App Center app navigation showing the Analytics section and its sub-sections.](../media/8-app-center-navigation-analytics-overview.png)

  * The **Overview** subsection of Analytics features charts for details about active users and session counts. Charts are available to identify your app's most popular devices, most common geographic locations and user languages, and most popular release versions. Once your app has collected some data, analytics overview will start to look more like the screenshot above.

  * The **Events** subsection of Analytics displays a table of the events that your app has reported, after you have incorporated the App Center SDK into your app. When implemented, you can sort events by overall count, trending movement, number of users, trend in user count, and the average per user.

  * The **Log flow** subsection of Analytics displays real-time events coming in from your app. This log flow data can help you confirm data is coming in correctly from your app after you set it up. If you know a particular event should be showing up, you can use this view to can verify your app is sending event information.
