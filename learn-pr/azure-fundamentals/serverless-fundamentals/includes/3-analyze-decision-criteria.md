With two viable serverless options, it can be difficult to know which is the best one for the job.  In this unit, we'll analyze the criteria that experts employ when deciding which serverless service to use for a given business need. Understanding the criteria can also help you better understand the nuanced differences between each product.

## Do you need to perform an orchestration across well-known APIs?

As we noted previously, Azure Logic Apps was designed with orchestration in mind, from the web-based visual configurator to the pricing model.  It excels at connecting a large array of disparate services via their APIs to pass and process data through many steps in a workflow.

It's possible to create the same workflow using Azure Functions, but it might take a considerable amount of time researching which APIs to call and how to call them.  Azure Logic Apps has already componentized these API calls so that you only supply a few details and the details of calling the necessary APIs is abstracted away.

## Do you need to execute custom algorithms or perform specialized data parsing and data lookups?

Azure Functions allows you to use the full expressiveness of a programming language in a compact form, allowing you to concisely build complex algorithms, or data lookup and parsing operations.  You would be responsible for maintaining the code, handling exceptions resiliently, and so on.

While Azure Logic Apps has the ability to perform logic (loops, decisions, and so on) if you had a logic intensive orchestration that required a complex algorithm, the implementation of that algorithm might be more verbose and visually overwhelming.

## Do you have existing automated tasks written in an imperative programming language?

If you already have your orchestration or business logic expressed in C#, Java, Python, or other popular programming language, it might be easier to port your code into the body of an Azure Function than re-create it using Azure Logic Apps.

## Do you prefer a visual (declarative) workflow or writing (imperative) code?

Your ultimate choice will really come down to whether you prefer to work in a declarative environment or an imperative environment.  Developers who have expertise in an imperative programming language may prefer to think about automation and orchestration from an imperative mindset.  IT Professionals and business analysts may prefer to work in a more visual low-code/no-code environment.