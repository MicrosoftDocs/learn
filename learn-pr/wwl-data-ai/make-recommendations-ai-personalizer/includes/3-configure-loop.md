
Once you've created your Azure AI Personalizer resource, you're able to configure its rewards, along with how it should carry out explorations, data retention, and more.

To configure your learning loop, you go to your Personalizer resource's Setup page:

:::image type="content" source="../media/configure-personalizer.png" alt-text="A screenshot of the Setup page.":::

## Configure rewards

To configure rewards for your loop, you set the following values under Rewards:

:::image type="content" source="../media/configure-rewards.png" alt-text="A screenshot showing the rewards section.":::

- **Reward wait time**
    - Determine how long Azure AI Personalizer should collect reward values for a Rank call from when the first call happens. To decide, you should ask yourself: "How long should Azure AI Personalizer wait for rewards calls?" Any rewards that are received after this time period won't be used for learning, but will be logged.
- **Default reward**
    - If no reward call is received by Azure AI Personalizer during the reward wait time period for  a Rank call, AI Personalizer will assign this default reward. By default, and in most scenarios, this default reward is zero.
- **Reward aggregation**
    - If Azure AI Personalizer received multiple rewards from the same Rank API call, an aggregation method is used. You can choose between sum or earliest. For example, earliest means the earliest score received is used and the rest is discarded. This is useful if you want a unique reward among possibly identical Rank calls.

## Configure exploration

Azure AI Personalizer can find new patterns and adapt itself to your users' behavioral changes over time by exploring alternatives instead of using the underlying trained model's prediction. You choose an appropriate exploration value to determine what percentage of Rank calls should be answered using exploration:

:::image type="content" source="../media/configure-exploration.png" alt-text="A screenshot showing the exploration setting.":::

> [!NOTE]
> When you change this value, it will reset the current Azure AI Personalizer model and retrain it with the last two days of data.

## Configure model update frequency

Next, you configure how often the underlying model should be trained:

 :::image type="content" source="../media/configure-update-frequency.png" alt-text="A screenshot of the update frequency setting.":::

There are different types of update frequencies you can set depending on your needs:

- **1 minute** update frequencies are particularly helpful for debugging, testing, or if you want to a demo.
- Use **15 minute** update frequencies if you want to closely track changes in user behavior. For example, if an app has live product bidding, you can use this type of update frequency to track bidding behavior.
- **1 Hour or more**. For most other scenarios, this type of lower update frequency is effective.

## Configure data management

Under data retention, you determine how many days Azure AI Personalizer should keep data logs. Data logs are used for offline evaluations. These types of evaluations enable you to figure out how effective your Azure AI Personalizer is, so that you can optimize it.

:::image type="content" source="../media/configure-data-management.png" alt-text="A screenshot of the data management section.":::

Whenever you make policy changes to the model, Azure AI Personalizer will take some time to retrain the model using the new settings. You can use the Model training setting to decide how many days of data it should use for retraining.
