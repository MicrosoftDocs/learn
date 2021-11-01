To create a QnA Maker solution, you can use the REST API or SDK to write code that defines, trains, and publishes the knowledge base. However, it is more common to use the [QnA Maker portal](https://www.qnamaker.ai) to define and manage a knowledge base.

To create a knowledge base:

1. Create an Azure resource in your Azure subscription.
    - To use the _managed_ QnA Maker service: create a **Text Analytics** resource.
	- To use the _non-managed_ QnA Maker service: create a **QnA Maker** resource.

2. In the QnA Maker portal, connect the resource to a new knowledge base.
3. Name the knowledge base.
4. Optionally, populate the knowledge base with existing question and answer pairs:
   - You can import questions and answers from existing web pages or documents.
   - You can add pre-defined "chit-chat" pairs that include common conversational questions and responses in a specified style.
5. Create the knowledge base and edit question and answer pairs in the portal.
