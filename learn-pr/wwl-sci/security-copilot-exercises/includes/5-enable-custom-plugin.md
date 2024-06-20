In this exercise, you experiment with a custom plugin. You start by checking the owner settings for who can add and manage their own custom plugins and who can add and manage custom plugins for everyone in the organization. Once you have configured the owner settings, you upload the file for your custom plugin. Uploading the files adds the plugin capability to Copilot. Once the plugin is added, you validate that is shows up as a system capability and start using it.

The creation of the YAML or JSON plugin manifest file, which describes metadata about the plugin and how to invoke it, is outside the scope of this content, but you can obtain more information by visiting [Create your own custom plugins](/copilot/security/custom-plugins).

> [!NOTE]
> The environment for this exercise is based on a simulation, generated from pre-determined screen captures of the actual product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script are not be supported.

### Exercise

For this exercise, you're logged in as Avery Howard and have the Copilot owner role. You'll work in Microsoft Copilot for Security and will be accessing a GitHub repository to download the sample manifest file for the plugin.

This exercise should take approximately **10** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it is generally recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

#### Before you start

For the purpose of this exercise, you'll be using a sample .yaml file, 'KQL_DefenderExample.yaml'.

1. Select the link **[KQL_DefenderExample.yaml](https://github.com/MicrosoftLearning/SC-5006-Get-started-with-Microsoft-Copilot-for-Security/blob/master/Sample%20files/KQL_DefenderExample.yaml?azure-portal=true)** to access the sample file.

1. Select the **Download raw file ![download raw file icon](../media/raw-file-download-icon-v2.png)** icon.  Save the file on your local computer, as you will need it later.  

   Alternatively, because this is a simulation, you can create the file named 'KQL_DefenderExample.yaml.' Because this is a simulation, the contents of the file you create won't matter. The system capabilities and prompt responses shown in the simulation, however, are based on the actual file.


#### Task: Update owner settings for custom plugins

In this task, you configure Copilot so that Copilot owners and contributors can add and manage their own custom plugins and for everyone in the organization. 

1. Open the simulated environment by selecting this link: **[Microsoft Copilot for Security](https://app.highlights.guide/start/89f9d04d-283c-4788-8214-22e4d5b4b171?link=0&token=40f793d4-2956-40a4-b11a-6b3d4f92557f&azure-portal=true)**.

1. Select the **Home menu** (hamburger) icon

1. Select **Owner settings**.

1. Under Plugins for Copilot for Security,
    1. Set "Who can add and manage their own custom plugins" to **Contributors and owners**.
    1. Set "Who can add and manage custom plugins for everyone in the organization" to **Contributors and owners**.

1. Return to the landing page. Select **Microsoft Copilot for Security** next to the home menu (hamburger) icon.

#### Task: Upload the file for your custom plugin

In this task, you upload the file named, KQL_DefenderExample.yaml, that you downloaded in the 'Before you start' section of this exercise.

1. From the prompt bar on the Copilot landing page, select the **sources** icon.

1. On the Manage sources window, scroll down until you get to the Custom plugins. Select the **sources** icon displayed on the far right of where it says Custom. This opens the Add a plugin window.

1. In the Add a plugin window, ensure the setting for Who can use this plugin is set to **Just me**.

1. For this exercise, select **Copilot for Security Plugin** as this is the format for the .yaml file of your custom plugin.

1. From the upload box that appears, select **Upload file**, then select the file you previously downloaded to your local computer, **KQL_DefenderExample.yaml**

1. On the custom plugins page, the plugin has been added and is enabled. Note the private tag.

1. Select the **Settings** icon. The settings icon shows basic plugin information. Note the name and brief description. This is a basic sample plugin so there are no configuration parameters to configure. If there were API keys or sign-in credentials required for the plugin, this is where they would be configured, like the exercise where you configured the Microsoft Sentinel plugin. Here you can also delete the plugin. Select Cancel to exit the page.

1. Exit the manage sources window.

#### Task:  Test the custom plugin

In this task, you verify the capability enabled by the plugin can be accessed from the prompts icon and you test it.

1. From the prompt bar, select the **Prompts** icon.

1. Select **See all system capabilities**.

1. Scroll down until you get to **My sample Defender KQL** plugin. Listed below the plugin name is the capability (prompt) enabled by the plugin. Select **Get Latest Emails by Recipient** to run the prompt. For future reference you can search by this capability (prompt) name.

1. Enter email address of a user whose email you need to audit: **nosv32@woodgrove.ms**.

1. As with any prompt, you can select the response and pin it the pin board, you can share it, edit it, and more.

#### Review

In this exercise, you enabled a custom plugin by uploading the .yaml file for the plugin and then tested the capability supported by the plugin.
