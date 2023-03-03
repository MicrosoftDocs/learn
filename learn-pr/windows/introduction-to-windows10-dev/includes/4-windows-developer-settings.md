Before you can write Windows 10 apps on your computer, there's one more thing to do: enable Developer Mode on the Windows computer you're using to write apps, and on any devices you'll use to test your code. If you've already enabled Developer Mode for a previous project, you can skip this step.

> [!IMPORTANT]
> To enable Developer Mode, you need administrator access. If your device is owned by an organization, this option might be disabled. If you can't activate Developer Mode on your computer, you need to [use a virtual machine](../../../wwl-azure/configure-virtual-machines/index.yml) to develop Windows apps.

Before Developer Mode is enabled, opening a project in Visual Studio opens the **For developers** page in **Settings** or opens the **Enable Developer Mode for Windows 10** window in Visual Studio:

![Screenshot showing the "Enable Developer Mode for Windows 10" window in Visual Studio.](../media/latestenabledialog.png)

In this window, to open the **For developers** page, select the **settings for developers** link.

> [!NOTE]
> To enable or disable Developer Mode, you can go to the **For developers** page at any time. To do so, do either of the following:
> * In Visual Studio, select **Settings** > **Update & Security** tab.
> * In the Cortana search box on the Windows 10 taskbar, type **for developers**.

## Enable Developer Mode

To enable Developer Mode or related settings:

1. In the **For developers** settings pane, choose the level of access that you need.
2. Read the disclaimer for the setting you've chosen, and then select **Yes** to accept the change.

Here's the settings page on the desktop device family:

![Screenshot showing the "For developers" page](../media/devmode-pc-options.png)

## Developer Mode features

When you enable Developer Mode on a desktop computer that's running Windows 10, a package of features is installed. The features include a secure shell (SSH) service that allows remote deployment of apps to your computer, and the Windows Device Portal (WDP). The features are relevant if you enable device discovery on your computer, or if you develop apps for Internet of Things (IoT) applications. If you're developing only Windows apps, you can safely ignore them. For more information, see [enable your device for deployment](/windows/uwp/get-started/enable-your-device-for-development).

### Failure to install

Network or administrative issues might prevent the Developer Mode package from being installed properly, which prevents the use of remote deployment and the WDP. Even in this case, you can test and deploy your app locally by using Visual Studio.

> [!TIP]
> If the Developer Mode package isn't installed correctly, we encourage you to file a feedback request. In the **Feedback Hub** app, select **Add new feedback**, and then choose the **Developer Platform** category and the **Developer Mode** subcategory. We appreciate your feedback, which helps Microsoft resolve the issue you encountered.

## Create a developer account

If you want to submit apps or add-ins to the Microsoft Store, you need a developer account. A developer account has a one-time registration fee with no required renewal, and the account is linked to an existing Microsoft account.

> [!NOTE]
> A developer account is necessary only if you want to distribute your apps in official Microsoft platforms. You can develop Windows apps without one.

To register for a developer account, go to the [registration page](https://developer.microsoft.com/store/register) and select **Sign up.** You're prompted to log in to your Microsoft account (or to create a new one), which you use to sign in to your developer account. Follow the steps to choose your country/region, account type, public publisher display name, and contact information.

For a step-by-step walkthrough of the developer account process and in-depth information about the specific account settings, see [Open a developer account](/windows/uwp/publish/opening-a-developer-account).
