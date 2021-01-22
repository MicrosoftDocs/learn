Let's put our knowledge of Text Analytics to work in a practical solution. Our solution will focus on Sentiment Analysis of text documents. Let's set the context by describing the problem we want to tackle.

## Manage customer feedback more efficiently

Social media is active with talk of your company's product. Your feedback email alias is also active with customers eager to share their opinion of your product.

As is the case with any new startup, you live by the mantra of listening to your customers. However, the success of your product has made keeping this promise easier said than done. It's a good problem but a problem all the same.

The team can't keep up with the volume of feedback anymore. They need help sorting the feedback so that issues can be managed as efficiently as possible. As the lead developer in the organization, you have been asked to build a solution.

Let's look at some high-level requirements:

|Requirement  | Details  |
|---------|---------|
|Categorize feedback so we can react to it.     |   Not all feedback is equal. Some is glowing testimony. Other feedback is scathing criticism from a frustrated customer. Perhaps you can't tell what the customer wants in other cases. <br/><br/>At a minimum, having an indication of the sentiment, or tone, of feedback would help us categorize it.     |
|The solution should scale up or down to meet demand.    |   We're a startup. Fixed costs are difficult to justify, and we haven't figured out the exact pattern of feedback traffic. We'll need a solution that can tackle bursts of activity, but cost as little as possible during quiet times. <br/><br/> A serverless architecture billed on a consumption plan is a good candidate in this case.     |
| Produce a Minimal Viable Product (MVP), but make the solution adaptable.    | Today, we want to categorize feedback so we can apply our limited resources to the feedback that matters. If a customer is frustrated, we want to know immediately and start chatting with them. In the future, we'll enhance this solution to do more. One idea for a new feature is to examine key phrases in feedback to detect pain points before they reach critical mass with our customers. Another idea is to automate responses back to customers who are either positive or neutral. Even though they love us, we want them to know we are still listening to their feedback. <br/><br/>A solution that offers a plug-and-play architecture is a good fit here. We could, for example, use queues as a form of factory line. You perform one task, then place the result into a queue for the next part of the system to pick it up and process.   |
|Deliver quickly.     |   We've all heard this one before! Remember, this solution is an MVP, and we want to test it with our scenario quickly. To deliver at speed and with quality will mean writing less code. <br/><br/> Taking advantage of the Text Analytics API means we don't have to train a model to detect sentiment. Using Azure Functions and binding to queues declaratively reduces the amount of code we have to write. A serverless solution also means we don't have to worry about server management.   |

Our proposed solution for each requirement in the preceding table offers a glimpse into how to map requirements to solutions. Let's now see what a solution might look like based on Azure.

## A solution based on Azure Functions, Azure Queue Storage, and Text Analytics API

The following diagram is a design proposal for a solution. It uses three core components of Azure: Azure Queue Storage, Azure Functions, and Azure Cognitive Services.

![Conceptual diagram of a feedback sorting architecture.](../media/proposed-solution.PNG)

The idea is that text documents containing user feedback are placed into a queue that we've named *new-feedback-q* in the preceding diagram. The arrival of a message containing the text document into the queue will trigger, or start, function execution. The function reads messages containing new documents from the input queue and sends them for analysis to the Text Analytics API. Based on the results that the API returns, a new message containing the document is placed into an output queue for further processing.

The result we get back for each document is a sentiment score. The output queues are used to store feedback sorted into positive, neutral, and negative. Hopefully, the negative queue will always be empty! After we've bucketed each incoming piece of feedback into an output queue based on sentiment, you can imagine adding logic to take action on the messages in each queue.

Let's look at a flowchart next to see what the function logic needs to do.

![Flowchart of the logic inside the Azure function to sort text documents by sentiment into output queues.](../media/flow.PNG)

Our logic is like a router. It takes text input and routes it to an output queue based on the sentiment score of the text. We have a dependency on Text Analytics API. While the logic seems trivial, this function will remove the need for people on the team to analyze feedback manually.

## Steps to implement our solution

To implement the solution described in this unit, we'll need to complete the following steps.

1. Create a function app to host our solution.

1. Look for sentiment in incoming feedback messages using the Text Analytics API. We'll use our access key from the preceding exercise and write some code to send the requests.

1. Post feedback to processing queues based on sentiment.

Let's move on to creating our function app.