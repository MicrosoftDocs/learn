To understand how Personalizer works, consider the concept of reinforcement learning. You may recall experiments showing a cat or dog learning how to get a treat by activating some mechanism. In a sense, we consider that a reinforcement learning concept. Applied to artificial intelligence, reinforcement learning is considered a *closed-loop* model. The term refers to a model where the actions influence later inputs. The model learns behaviors to use based on feedback collected from its use.

To explore reinforcement learning further, consider an interaction with a web site.

1. The user is viewing a product on an e-commerce site. The **Rank** API takes in the user information, context, and features.
1. The Personalizer service performs evaluation of the data it receives.
1. The Personalizer service returns a *rank* response, which results in a set of products that's displayed to the user.
1. When the user selects an item (action), it generates a reward score that's passed to the **Reward** API. Personalizer uses this information to train the model for future actions.

Personalizer uses this model to *learn* how to map the appropriate item to display, based on a user's actions to that item. The learning is realized when the reward score is highest. In other words, if a user is currently viewing hiking shoes on a web site, Personalizer might also display a suggestion for hiking socks and shoe laces. If users choose the socks item but not the laces item, the socks item will have a higher reward score.

## Terminology

Consider the following terms:

- *Learning loop* - a Personalizer resource created for each part of your application.
- *Model* - the unit that captures all data learned about user behavior, getting training data from the combination of the arguments you send to **Rank** and **Reward** calls, and with a training behavior determined by the Learning Policy.

## Modes

Personalizer has two primary modes:

- **Online mode** - The default learning behavior for Personalizer, where your learning loop uses machine learning to build the model that predicts the top action for your content.
- **Apprentice mode** - A learning behavior that helps warm-start a Personalizer model to train without impacting the applications outcomes and actions.

## Selecting the best item

The selection of the *best* item is accomplished by using the collective behavior and reward scores that have been accumulated across all users. An item is considered an action, and can be a product, a recommended movie, or a news article recommendation, for example. Personalizer evaluates features related to actions and context.

- Action features provide metadata about that action. For example, if socks is the action (item), features might include foot, comfort, shoe accessories, cushioning, etc.
- Context features can include a user's previous shopping history, their environment (mobile device or desktop browser), or the category they're shopping in (hiking, walking, swimming, etc.).

## Ranking

The Personalizer service will use a **Rank** call when working with action and context features. The **Rank** call considers the action and its features, along with the context features, to help select the top action item to display. The **Rank** call returns the ID of the best content item (action) to show to the user, in the **Reward Action ID** field. The action shown to the user is chosen with machine learning models that try to maximize the total number of rewards over time.

## Scenarios

Consider the scenario in the following table to understand the process.

| Content Type | Action with features | Context features | Returned Reward Action ID (item displayed) |
|---|---|---|---|
| Products | 1. Socks (foot, cushioning, shoe accessories) | Device being used, user's spending habits, shopping category | 1. Socks |
| | 2. Laces (shoes, boots, enclosure) |  
| | 3. Gaiters (wet weather, rain, protection)|

## Interaction flow

The following diagram shows the flow of an application's interaction with Personalizer.

:::image type="content" source="../media/personalization-how-it-works.png" alt-text="Application flow diagram with Personalizer.":::

The preceding image depicts the following action sequences:

1. User interacts with the site or application.
   1. User information, context plus features, and actions to choose plus features are sent to the **Rank** API.
   1. The Personalizer service will:
      1. decide whether to exploit the current model or
      1. explore new choices for the model.
1. The Personalizer service returns a *rank* response, in the form of a *reward action ID*.
    1. Your system presents that content and determines a reward score based on your own business rules.
1. Your system returns the reward score to the learning loop using the following sequence:
    1. When Personalizer receives the reward, the reward is sent to the event hub.
    1. The rank and reward are correlated.
    1. The AI model is updated based on the correlation results.
    1. The inference engine is updated with the new model.
