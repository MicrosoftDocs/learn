
To create a question answering solution, you can use the REST API or SDK to write code that defines, trains, and publishes the knowledge base. However, it's more common to use the [Language Studio](https://language.azure.com) web interface to define and manage a knowledge base.

To create a knowledge base you:

1. Sign in to Azure portal.
1. Search for **Azure AI services** using the search field at the top of the portal.
1. Select **Create** under the **Language Service** resource.
1. Create a resource in your Azure subscription:
    - Enable the *question answering* feature.
    - Create or select an **Azure AI Search** resource to host the knowledge base index.

1. In Language Studio, select your Azure AI Language resource and create a **Custom question answering** project.

1. Add one or more data sources to populate the knowledge base:
   - URLs for web pages containing FAQs.
   - Files containing structured text from which questions and answers can be derived.
   - Predefined *chit-chat* datasets that include common conversational questions and responses in a specified style.
1. Edit question and answer pairs in the portal.
