In this exercise, you experiment with a custom plugin. You start by checking the owner settings for who can add and manage their own custom plugins and who can add and manage custom plugins for everyone in the organization. Once you have configured the owner settings, you upload the manifest file for a basic custom plugin. Uploading the manifest adds the plugin capability to Copilot. Once the plugin is added, you validate that is shows up as a system capability and start using it.

The creation of the plugin manifest is outside the scope of this content, but you can obtain more information by visiting [Create your own custom plugins](/copilot/security/custom-plugins). You can also view the contents of the manifest file used in this exercise and other sample manifest files by visiting [Microsoft plugin samples](https://github.com/Azure/Copilot-For-Security/tree/main/Plugins/MSFT_Plugin_Samples)

> [!NOTE]
> The environment for this exercise is based on a simulation, generated from pre-determined screen captures of the actual product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script are not be supported.

### Exercise

> [!NOTE]
> It is recommended that you open the exercise environment in a separate browser window so that you can simultaneously view the instructions and the exercise environment.

Using the exercise environment, follow the exercise steps that are listed.

#### Task: Update owner settings for custom plugins

In this task, you configure Copilot so that Copilot owners and contributors can add and manage their own custom plugins and for everyone in the organization. 

1. Select the **Home menu** (hamburger) icon

1. Select **Owner settings**.

1. Under Plugins for Copilot for Security,
    1. Set "Who can add and manage their own custom plugins" to **Contributors and owners**.
    1. Set "Who can add and manage custom plugins for everyone in the organization" to **Contributors and owners**.
    1. Exit owner settings and return to the landing page.


#### Task: Upload the manifest for your custom plugin

In this task, you upload the manifest file for a sample custom plugin. You can view the contents of the manifest file at [Get Latest Emails By Recipient](https://github.com/Azure/Copilot-For-Security/blob/main/Plugins/MSFT_Plugin_Samples/KQL/KQL_DefenderExample.yaml).

1. From the prompt bar on the Copilot landing page, select the **sources** icon.

1. On the Manage sources window, scroll down until you get to the Custom plugins. Select the **sources** icon displayed on the far right of where it says Custom. This opens the Add a plugin window.

1. In the Add a plugin window, ensure the setting for Who can use this plugin is set to **Just me**.

1. For this exercise, select **Copilot for Security Plugin** as this is the type of your custom plugin.

1. Enter the file name, **KQL_DefenderExample.yaml** to simulate the file upload then select **Add**.

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

In this exercise, you enabled a custom plugin by uploading the manifest file for the plugin and then tested the capability supported by the plugin.
