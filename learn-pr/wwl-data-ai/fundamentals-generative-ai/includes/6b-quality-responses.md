Developers use several key mechanisms to help improve the performance and trustworthiness of generative AI responses. 

**Grounding Data**: grounding refers to the process of ensuring that a system's outputs are aligned with factual, contextual, or reliable data sources. This can be done in various ways, such as linking the model to a database, using search engines to retrieve real-time information, or incorporating domain-specific knowledge bases. The goal is to anchor the model's responses to these data sources, enhancing the trustworthiness and applicability of the generated content.

**Retrieval-Augmented Generation (RAG)**: RAG augments a language model by connecting it to an organization's proprietary database. This technique involves retrieving relevant information from a curated dataset and using it to generate contextually accurate responses. RAG enhances the model's performance by providing it with up-to-date and domain-specific information, which helps in generating more accurate and relevant answers. RAG is particularly useful for applications where real-time access to dynamic data is crucial, such as customer support or knowledge management systems. 

**Fine-tuning**: Fine-tuning involves taking a pre-trained model and further training it on a smaller, task-specific dataset to make it more suitable for a particular application. This process allows the model to specialize and perform better at specific tasks that require domain-specific knowledge. Fine-tuning is particularly useful for adapting models to domain-specific requirements, improving accuracy, and reducing the likelihood of generating irrelevant or inaccurate responses.

**Security and Governance Controls**: security and governance controls are needed to manage access, authentication, and data usage. These controls help prevent the publication of incorrect or unauthorized information.

## Metrics to measure response quality  

There are many ways to measure response quality. In general, you can think of three dimensions for evaluating and monitoring generative AI. These include: 

- **Performance and quality evaluators**: assess the accuracy, groundedness, and relevance of generated content.
- **Risk and safety evaluators**: assess potential risks associated with AI-generated content to safeguard against content risks. This includes evaluating an AI system's predisposition towards generating harmful or inappropriate content.
- **Custom evaluators**: industry-specific metrics to meet specific needs and goals. 

Today's services such as Azure AI Foundry provide an environment for these types of workflows and more to take place. Next, gain an understanding of how to plan for responsible generative AI use.