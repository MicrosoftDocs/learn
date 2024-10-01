Through *Apprentice mode*, Azure AI Personalizer can begin its learning process by looking at the choices made by your app's current logic and mimic its decisions. You're able to use metrics from the Azure portal or API to help you understand how well it matches your apps current logic (also referred to as the *baseline policy*).

When your Azure AI Personalizer resource is able to match your app's existing logic around 75-85% of the time, you'll then change its learning behavior from Apprentice mode to *Online mode*. In Online mode, your AI Personalizer will change to return the best actions in the Rank API based on the underlying model and will learn to start to make better decisions than your baseline policy.

## Configure Apprentice mode

To enable Apprentice mode, you go to the Setup page for your AI Personalizer resource in the Azure portal:

:::image type="content" source="../media/configure-apprentice-online-behavior.png" alt-text="A screenshot showing how to configure apprentice mode.":::

You then select the **Apprentice mode** option for the learning mode.

## Configure your app to call the Rank and Reward APIs

To enable your app to use AI Personalizer, it needs to call the Rank and Reward APIs. To do this:

1. In your app's existing logic, you'll add a call to the Rank API where you currently determine a list of actions and features. Ensure that the chosen action by your app's existing logic is the first item in this list.
1. You change your app's code to show the action associated with the **Reward Action ID** that is returned in the Rank API response.

1. Next, you'll use your app's existing business logic to calculate the reward for the selected action. A valid reward value ranges between 0 to 1.
1. You then send the reward to the Reward API. You need to send the reward within the **Reward wait time period** you've configured earlier, otherwise the default reward will be logged by AI Personalizer.

## Evaluate Apprentice mode then switch to Online mode

In the Azure portal, you go to the Monitor page for your AI Personalizer resource where you're able to view the following evaluation metrics:

:::image type="content" source="../media/evaluation-metrics.png" alt-text="A screenshot of the evaluation metrics available." border="false":::

- **Baseline – average reward**: Average reward of the application’s default business logic (baseline).
- **Personalizer – average reward**: Average of total reward your AI Personalizer could potentially have reached.
- **Reward achievement ratio over most recent 1000 events**: A ratio that represents the Baseline and Personalizer reward.

Once your Reward achievement ratio has reached around 75-85%, you're ready to change your AI Personalizer resource to use Online mode. You do this on the Setup page, by selecting the **Online mode** option in place of the **Apprentice mode** option you selected previously.