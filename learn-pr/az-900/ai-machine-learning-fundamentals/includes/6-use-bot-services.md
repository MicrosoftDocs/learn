Tailwind Traders has one final opportunity to utilize Microsoft's artificial intelligence service.

## What's the opportunity?

The Customer Service department has long asked for a virtual agent to handle the vast majority of questions they get asked.  As it turns out, no matter how prominent they make the answers to the most frequently asked questions on the website, shoppers are impatient and perceive contact in a chat window as saving them time.

The Customer Service team would want the shopper to feel as though they were interacting with a real human.  When it becomes clear that the virtual agent cannot provide an answer to the question, the chat session should be transfered to a human.

A virtual agent would decrease the amount of time it takes for all shoppers to receive answers.  The virtual agent could answer the vast majority of questions which would free up human customer service agents to provide support for more difficult questions or thorny account related issues.

### Which service should we choose?

Azure Bot Service should be used to implement a virtual agent chat experience.  The Bot Service could benefit from the Frequently Asked Questions page on the website along with thousands of chat sessions that have been stored between shoppers and customer service representatives.  Customer Service supervisors can test and tweak the answers to continue to refine the chat experience.

The ecommerce website developers could explore using pre-built solutions like QnA Maker (part of Cognitive Services) or Power Virtual Agents to expedite implementing the feature.  Also, any Azure Bot Solution would likely implement several Azure Cognitive Services like Language Understanding (LUIS) and possibly Translator to translate from the shopper's language to English and back again.

### Why not use Azure Machine Learning?

While it might be possible to create a chat solution using Azure Machine Learning given that Tailwind Traders does have a lot of historical data to feed into a model, there's already an existing option that is tailored for the chat bot experience.