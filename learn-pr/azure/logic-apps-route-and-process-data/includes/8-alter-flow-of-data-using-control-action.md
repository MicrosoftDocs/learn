OBJECTIVE	•	Alter the flow of data using a Control Action
ENABLEMENT TASK(S) OR UNIT DETAILS	 -----Motivation-----
Azure Logic Apps supports the use of conditional statements. This means that instead of data flowing in a linear way, you can have your app make decisions based off dynamic data. For example, in our shoe example, when the Detect Sentiment generates a Score, we would want to perform a different Action depending if the Score represented a positive or negative piece of content.

-----Information presented in this unit-----
•	Describe what a Control Action is.
•	List the different types of Control Actions with some common examples.
•	Discuss what a parallel branch is and how it differs from a Control Action. For example, a parallel branch does not allow you to alter the flow of data, rather, it allows you to copy the data and do another Action at the same time.

-----How to do the task-----
•	Explain that a Detect Sentiment Score value of .5 or higher is positive and less than .5 is negative 
•	Explain how to use the Condition Action. For example, how to perform AND and OR expressions, and how to nest conditions.
•	Explain how to add actions to the true and false sections of the Condition Action.
