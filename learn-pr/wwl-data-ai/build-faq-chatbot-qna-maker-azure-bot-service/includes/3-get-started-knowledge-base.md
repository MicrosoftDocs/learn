You can easily create a question answering solution on Microsoft Azure using **Azure AI Language** service. Azure AI Language includes a **custom question answering** feature that enables you to create a knowledge base of question and answer pairs that can be queried using natural language input. 

## Creating a custom question answering knowledge base

You can use *Azure AI Language Studio* to create, train, publish, and manage question answering projects.

> [!NOTE]
> You can write code to create and manage projects using the Azure AI Language REST API or SDK. However, in most scenarios it is easier to use the Language Studio.

To create a project, you must first provision a **Language** resource in your Azure subscription. 

### Define questions and answers

After provisioning a Language resource, you can use the Language Studio's custom question answering feature to create a project that consists of question-and-answer pairs. These questions and answers can be:

- Generated from an existing FAQ document or web page.
- Entered and edited manually.

In many cases, a project is created using a combination of all of these techniques; starting with a base dataset of questions and answers from an existing FAQ document and extending the knowledge base with additional manual entries.

Questions in the project can be assigned *alternative phrasing* to help consolidate questions with the same meaning. For example, you might include a question like:

> *What is your head office location?*

You can anticipate different ways this question could be asked by adding an alternative phrasing such as:

> *Where is your head office located?*

### Test the project

After creating a set of question-and-answer pairs, you must save it. This process analyzes your literal questions and answers and applies a built-in natural language processing model to match appropriate answers to questions, even when they are not phrased exactly as specified in your question definitions. Then you can use the built-in test interface in the Language Studio to test your knowledge base by submitting questions and reviewing the answers that are returned.
