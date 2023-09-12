

You have the option of installing Microsoft 365 Apps from Intune using the Microsoft 365 app type. This app type makes it easy and convenient for you to assign Office apps to devices you manage that run Windows client or macOS. You don’t need to download the installation files as they're already present in Intune. You can also install apps for the Microsoft Project Online desktop client and Microsoft Visio Pro for Microsoft 365, if you own licenses for them. The apps that you want are displayed as a single entry in the list of apps on the Intune console.

Be aware of the following limitations and caveats:

 -  If any Office apps are open when Intune installs the app suite, the installation might fail, and users might lose data from unsaved files.
 -  Intune doesn't support installing Microsoft 365 Apps from the Microsoft Store (known as Office Centennial apps) on a device to which you have already deployed Microsoft 365 apps with Intune. If you install this configuration, it might cause data loss or corruption.
 -  Multiple required or available app assignments aren't additive. A later app assignment will overwrite pre-existing installed app assignments. For example, if the first set of Office apps contains Word, and the later one doesn't, Word will be uninstalled. This condition doesn't apply to any Visio or Project applications.

#### Deploy Microsoft 365 Apps with Intune

1.  Sign in to the **Endpoint Administrator admin center**.
2.  Select **Apps**, then select **All Apps**. Select **+ Add**.
3.  In the **Select app type** panel, in the **App type** list, under **Microsoft 365 Apps**, select **Windows 10 and later**.
4.  Choose **Select**. In the **App suite information** tab, configure the following:
    
     -  **Suite Name**: Enter the name of the app suite as it’s displayed in the company portal. Make sure that all suite names that you use are unique. If the same app suite name exists twice, only one of the apps is displayed to users in the company portal.
     -  **Suite Description**: Enter a description for the app suite. For example, you could list the apps you've selected to include.
     -  **Publisher**: Microsoft appears as the publisher.
     -  **Category**: Optionally, select one or more of the built-in app categories or a category that you created. This setting makes it easier for users to find the app suite when they browse the company portal.
     -  **Show this as a featured app in the Company Portal**: Select this option to display the app suite prominently on the main page of the company portal when users browse for apps.
     -  **Information URL**: Optionally, enter the URL of a website that contains information about this app. The URL is displayed to users in the company portal.
     -  **Privacy URL**: Optionally, enter the URL of a website that contains privacy information for this app. The URL is displayed to users in the company portal.
     -  **Developer**: Microsoft appears as the developer.
     -  **Owner**: Microsoft appears as the owner.
     -  **Notes**: Enter any notes that you want to associate with this app.
     -  **Logo**: The Microsoft 365 logo is displayed with the app when users browse the company portal.
5.  Select **Next**. In the **Configure App Suite** tab, you can select the Microsoft 365 apps you wish to include.
    
     -  **Select Office apps**: Select which apps you wish to include in this install.
     -  **Select other Office apps**: Select additional apps such as Project or Visio.
     -  **Architecture**: Choose whether you want to assign the **32-bit** or **64-bit** version of Office. You can install the 32-bit version on both 32-bit and 64-bit devices, but you can install the 64-bit version on 64-bit devices only.
     -  **Update Channel**: Choose how Office is updated on devices. You can choose from:
        
         -  Current Channel (Preview)
         -  Current Channel
         -  Monthly Enterprise Channel
         -  Semi-Annual Enterprise Channel (Preview)
         -  Semi-Annual Enterprise Channel
     -  **Remove other versions**: Choose whether you want to remove pre-existing Office .MSI apps from end-user devices. The installation won’t succeed if there are pre-existing .MSI apps on end-user devices. The apps to be uninstalled aren't limited to the apps selected for installation in Configure App Suite, as it will remove all Office (MSI) apps from the end user device. When Intune reinstalls Office on your end user's machines, end users will automatically get the same language packs that they had with previous .MSI Office installations.
     -  **Use shared computer activation**: This is used for activating Microsoft 365 apps when multiple users use the same device.
     -  **Accept the Microsoft Software License Terms on behalf of users**: Choose if you wish to accept, which hides the prompt from end users.
     -  **Install background service for Microsoft Search in Bing**: If you decide to deploy this extension, it sets Bing as the default search engine for Google Chrome and provides easier access to Microsoft Search capabilities. If Bing is already the default search engine, the extension doesn't get installed.
     -  **Languages**: Office is automatically installed in any of the supported languages that are installed with Windows on the end user's device. Select this option if you want to install additional languages with the app suite. You can deploy additional languages for Microsoft 365 Apps apps managed through Intune. The list of available languages includes the Type of language pack (core, partial, and proofing).
6.  Continue configuring the profile, assigning the profile to users, devices or groups. Review the settings and select **Create** to complete the profile.
