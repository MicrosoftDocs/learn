Designer dynamic content is filtered by data type
Dynamic content is sectioned/grouped by previous triggers/actions, all previous steps are represented

--------------------------------

OBJECTIVE	•	Execute an action
ENABLEMENT TASK(S) OR UNIT DETAILS	-----Motivation-----
Now that we have a Trigger that is detecting an external event, we naturally want to do something in response to that event. With Azure Logic Apps, we can accomplish this with Actions. There is a large list of Actions currently in Azure ranging from text processing, conditional branching, and even integrating with 3rd party services like Slack.

In our specific scenario, we’re going to use the Detect Sentiment Action from Cognitive Services to help us determine if a Tweet about our new shoe is positive or negative.

-----Information presented in this unit-----
•	Formally define what an Action is. Make sure to talk about the different types of Actions and provide some examples.
•	Discuss how data is passed from Trigger to Action or Action to Action. Make sure to discuss when data is generated, it can always be accessed in any future Action.
-----How to do the task-----
•	Describe how to add a new Action that is linked to the Twitter Trigger in the app designer.
•	Describe how to create a Detect Sentiment using Cognitive services.
o	Explain how to configure (e.g. the connection information)
o	Explain what the Text field is for.
o	Discuss the outputted data from the Detect Sentiment (e.g. Score).

