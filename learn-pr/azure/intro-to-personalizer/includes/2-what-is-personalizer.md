Azure AI Personalizer allows your applications to select appropriate content to show to users of the application. It uses reinforcement learning to improve the application's decision-making by using two primary APIs, the **Rank** API and the **Reward** API.

In the context of our example e-commerce site for an outdoor clothing company, your web application can use Personalizer to select accessories or similar items to display to the shopper according to what they browse or select. 

Personalizer monitors the user's reaction, such as selecting a recommended item, and generates a reward score. You can use this information to determine if the Personalizer recommendations are performing as you expect.

Given a context and featurized content, the Personalizer Service returns your content in a ranked list. As rewards are sent in response to the ranked list, the reinforcement learning algorithm will improve the model and improve performance of future rank calls.
