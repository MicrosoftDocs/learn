The Customer Service team has long asked for a virtual agent to handle the vast majority of questions it gets asked. No matter how prominent it makes the answers to the most frequently asked questions on the website, shoppers are impatient and perceive contact in a chat window as saving them time.

The team wants shoppers to feel as though they're interacting with a real human. When it becomes clear that the virtual agent can't provide an answer, the chat session should be transferred to a human.

Providing a virtual agent would decrease the amount of time it takes for all shoppers to receive answers. The virtual agent could answer most questions, which would free up human customer service agents to provide support for more difficult questions or thorny account-related issues.

## Which service should you choose?

Once again, apply the decision criteria you're now familiar with to find the right product.

First, is Tailwind Traders building a virtual agent that interfaces with humans via natural language?  Yes, it is. Azure Bot Service should be used in this scenario to implement a virtual agent chat experience. Bot Service could benefit from the information on the website's Frequently Asked Questions page, along with thousands of chat sessions that have been stored between shoppers and customer service representatives.  Customer Service supervisors can test and tweak the answers to continue to refine the chat experience.

Even though you've likely found the best option for this scenario, keep applying the decision criteria to see whether any additional options might work.

Second, does Tailwind Traders need a service that can understand the content and meaning of images, video, audio, or translate text into a different language?  Possibly, yes.  In this scenario, Azure Cognitive Services could be used along with Bot Service to build the solution. To expedite implementation, the developers could explore using prebuilt solutions, such as QnA Maker (part of Cognitive Services) or Power Virtual Agents. Also, any Azure Bot solution would likely implement several Azure Cognitive Services, such as Language Understanding (LUIS) and possibly Translator, to translate from the shopper's language to English and back again.

Third, does Tailwind Traders need to predict user behavior or provide users with personalized recommendations? No, it doesn't. Azure Cognitive Services Personalizer is not a good candidate for this scenario.

Finally, will the Tailwind Traders app need to predict future outcomes based on private historical data? No. Although Tailwind Traders *does* have historical data to feed into a model, which would make it possible to use Azure Machine Learning to create a chat solution, another option is already tailored for the chat bot experience.
