
To create a question answering solution, you can use the REST API or SDK to write code that defines, trains, and publishes the knowledge base. However, it is more common to use the [Azure AI Language Studio](https://language.azure.com) web interface to define and manage a knowledge base.

To create a knowledge base:

1. Create an **Azure AI Language** resource in your Azure subscription.
    - Enable the *question answering* feature.
	- Create or select an **Azure Cognitive Search** resource to host the knowledge base index.

2. In Azure AI Language Studio, select the Language resource and create a **Custom question answering** project.
3. Name the knowledge base.
4. Add one or more data sources to populate the knowledge base:
   - URLs for web pages containing FAQs.
   - Files containing structured text from which questions and answers can be derived.
   - Pre-defined *chit-chat* datasets that include common conversational questions and responses in a specified style.
5. Create the knowledge base and edit question and answer pairs in the portal.
