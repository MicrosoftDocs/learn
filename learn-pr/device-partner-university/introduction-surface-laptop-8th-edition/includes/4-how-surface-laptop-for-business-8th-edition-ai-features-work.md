As a Copilot+ PC, Surface Laptop for Business (8th Edition) enables on-device AI experiences that help complete repeatable tasks efficiently. Let's learn how to utilize some of these experiences.

## Click to Do

:::image type="content" border="true" source="../media/click-to-do.gif" alt-text="Animation of the Click to Do feature on Microsoft Surface Laptop for Business (8th Edition).":::

Click to Do identifies text and images on your screen that you can take contextual actions with. Click to Do analyzes what's on screen and then you can choose the text or image you want to act on with intelligent actions, powered by on-device AI for privacy and speed. Analysis only begins after you actively engage with Click to Do and ends when you exit. Here's how to use Click to Do on Surface Laptop for Business:

- Enter Click to Do with a press of the **Windows key and a mouse click**, the *Windows key + Q*, or from a **right swipe on the touchscreen**. (Other entry points for Click to Do include the Snipping Tool, search results, and the Start menu).
- When launching Click to Do for the first time, you'll be offered a quick interactive tutorial that shows you how to accomplish tasks faster. You can revisit the tutorial at any time by selecting **"…"**, then **Start tutorial**.
- Highlight text with Click to Do and the following options are available to you:
  - **Copy:** Copies the selected text to the clipboard.
  - **Open with:** Opens the selected text in a text editor like Notepad.
  - **Search the web:** Does a search for the selected text using Microsoft Edge and Bing.
- When highlighting text that is an email address, you can either copy the text or:
  - **Send email:** Uses your default email client to compose a new email to the selected email addresses.
  - **Send a message with Teams:** Opens a Teams message using the selected email address as the recipient.
  - **Schedule a meeting with Teams:** Opens a new Teams calendar invite with the selected email address as an attendee.
- More intelligent text actions are available when your default language is set to English, at least 10 words are selected, and you're signed in with either a Microsoft account or Microsoft Entra account. These actions include:
  - **Summarize:** Briefly outlines the main points of the selected text.
  - **Create a bulleted list:** Creates a bulleted list of key details from the selected text.
  - **Rewrite:** Revises the selected text using either a casual tone, formal tone, or by making grammatical suggestions.
  - **Draft with Copilot in Word:** Sends the selected text to Copilot in Word.
- If you select an image in Click to Do, you're given the following options:
  - **Copy:** Copies the image to the clipboard.
  - **Save as:** Saves the image to a specified location.
  - **Share:** Opens the **share files** option for the image file.
  - **Open with:** Opens the image with an app such as Photos, Snipping Tool, or Paint.
  - **Visual search with Bing:** Does a visual search using Bing in your default web browser.
  - **Blur background with Photos:** Blurs the background with the Photos app.
  - **Erase objects with Photos:** Erases unwanted objects in the image with the Photos app.
  - **Remove background with Paint:** Removes the background of the image with Paint.
- Click to Do is enabled by default on Surface Laptop for Business (Intel). If you do not want to use this feature, this is how to disable it:
  - Open **Settings**, then go to **Privacy & security > Click to Do**.
  - Set the Click to Do setting to **Off** to disable the feature.

## Agent in Settings

:::image type="content" border="true" source="../media/agent-in-settings.png" alt-text="Screenshot of the Agent in Settings feature on Microsoft Surface Laptop for Business (8th Edition).":::

Using natural language, Agent in Settings helps to streamline finding and changing settings. Agent in Settings uses on-device AI to understand your intent, and with your permission, automate and execute the desired task. You're now able to quickly describe what you need help with like, "I want to control my PC by voice" or "my mouse pointer is too small" and Agent in Settings will recommend the steps to resolve it.

Agent in Settings uses a lightweight model called Settings Mu, which is fine-tuned using Settings data to help users quickly find and adjust system settings. Some things to know:

- The model runs locally on the device, analyzing a user's query to match with relevant settings already available in the Settings app.
- If the model can't confidently classify a query to a specific setting, standard search results are displayed instead.
- The agent only suggests settings; it doesn't make any changes automatically. The user must explicitly request the agent to make a change.
- If needed, the user can easily undo the change.

Here's how the agent works. Using the search box on the top of the Settings app screen, type the changes you want to implement and the agent will offer a fix. If you choose the fix select **Apply** to implement the change on your behalf. This saves time by not requiring users to search through the Settings app for the change they're looking for. If you want to revert the change select **Undo** to reverse the change.

For administrators, Agent in Settings can be enabled or disabled using a policy setting:

- When the policy setting is enabled, the agent experience isn't available, and search results are limited to statically indexed searches and semantic searches.
- When the policy setting is disabled (default), the agent search experience is available. The agent can provide recommendations and automate tasks based on user input.
