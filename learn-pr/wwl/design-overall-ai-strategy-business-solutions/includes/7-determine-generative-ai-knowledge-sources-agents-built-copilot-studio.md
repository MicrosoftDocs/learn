## Unit overview

This unit equips solution architects with the expertise required to determine when and how agents built in Copilot Studio should use generative AI and enterprise knowledge sources. Learners will understand the architectural implications of orchestration modes, grounding strategies, retrieval quality, authentication, and governance requirements.

Generative AI in Copilot Studio enhances an agent's ability to answer broad or domain-specific questions by combining foundation model reasoning with enterprise data retrieval. Knowledge sources—including public websites, SharePoint, Dataverse content, OneDrive files, and Azure AI Search—extend the agent's capabilities by supplying contextual grounding information for high-accuracy responses.

## Generative AI in Copilot Studio

Generative AI power is activated primarily through **generative answers**, a capability that allows agents to surface information dynamically without requiring authored topics. This significantly reduces development time by enabling agents to:

- Interpret natural language queries

- Perform multi-source retrieval

- Synthesize answers from enterprise data

- Provide coherent responses grounded in formal or informal knowledge assets 

### Generative orchestration mode

Generative orchestration determines how broadly and deeply the agent can search across available knowledge.

In this mode, Copilot Studio:

- Automatically creates a "Conversational boosting" system topic containing a generative answers node

- Can search up to **25 knowledge sources**, filtered with GPT-based relevance

- May optionally include **general knowledge**, enabling the agent to answer out-of-domain queries when appropriate

This mode is ideal when users expect flexible, conversational, open-domain support rather than rigid topic-based interaction.

Below is a table comparing generative orchestration vs classic orchestration:

| **Behavior** | **Generative orchestration** | **Classic orchestration** |
|---|---|---|
| **Topics** | Topics are selected based on the description of their purpose. | Topics are selected based on matching a user query with trigger phrases. |
| **Child and connected agents** | Child and connected agents are selected based on their description. | Not applicable. |
| **Tools** | The agent can choose to call tools based on their name and description. | Tools can only be called explicitly from within a topic. |
| **Knowledge** | The agent can choose to proactively search knowledge to answer a user's query. | Knowledge can be used as a fallback when no topics match a user's query (or called explicitly from within a topic). |
| **Use of multiple topics, tools, knowledge sources** | The agent can use a combination of topics, tools, and knowledge. | Agent tries to select a single topic to respond to the user, falling back to knowledge if configured. |
| **Asking users for input** | The agent can automatically generate questions to prompt users for any missing information required to fill inputs for topics and tools. | You must use question nodes in topics to author messages prompting the user for any required information. |
| **Responding to a user** | The agent automatically generates a response, using the available information from topics, tools, other agents, and knowledge that it used. | You must use message nodes in topics to author messages responding to the user (or call a tool from a topic). |

For more information, see [advanced generative actions in Copilot Studio](/microsoft-copilot-studio/advanced-generative-actions) 

## Knowledge sources in Copilot Studio

Knowledge sources expand the breadth and depth of enterprise information an agent can reach. 

They can be applied at:

- The **agent level** (global knowledge)

- The **topic level** (specific to a conversation flow)

- A **generative answers node** (primary or fallback retrieval) 

### Supported knowledge sources

Solution architects can leverage the following types:

#### Public website knowledge

- Agents search designated public websites to surface relevant content. Ideal for FAQs, external product information, or publicly available policy materials

#### Uploaded documents

- Documents stored in Dataverse (PDFs, Word, PowerPoint, and more) are indexed for semantic retrieval. Useful when organizations rely heavily on internal documents

#### SharePoint knowledge

- SharePoint URLs can be indexed for enterprise search, allowing agents to retrieve content only users are authorized to access

#### Dataverse knowledge

- Structured tables and relational data allow agents to answer highly specific queries grounded in governed data

#### Enterprise connectors

- Data indexed through Microsoft Search connectors lets agents leverage content from OneDrive, SharePoint, Salesforce, ServiceNow, and more

#### Azure OpenAI-connected data

- Generative answers powered by Azure OpenAI combine your embedded vectors with model reasoning for higher accuracy and deeper contextual understanding.

Authentication is enforced automatically: agents can only surface content the current user is permitted to access.

## Using unstructured data as a knowledge source

Unstructured data—files uploaded from SharePoint, OneDrive, Salesforce, ServiceNow, Confluence, or Zendesk—are ingested into **Dataverse**, indexed, chunked, and converted into vector embeddings.

This provides:

- High-quality semantic search

- Rich grounding for generative answers

- Strong retrieval accuracy for large documents and knowledge bases
  
- Strict permission checks per user at query time

### Architectural constraints

- Maximum **500 knowledge objects** per agent

- Maximum **5 unstructured sources** per agent appearing simultaneously in retrieval

- Automatic background synchronization ensures content freshness 

Unstructured knowledge sources are ideal for teams with large collections of PDFs, PPTX, DOCX, and knowledge-base archives.

## Using Azure OpenAI for generative answers

Azure OpenAI "on your data" enables generative reasoning over enterprise content through classic connections embedded inside generative answer nodes.

This setup:

- Creates a direct connection to an Azure OpenAI resource

- Allows answers synthesized using enterprise embeddings and model reasoning

- Prioritizes node-level knowledge sources over agent-level sources

- Supports advanced configuration such as model selection and prompting parameters 

Azure OpenAI is best for scenarios requiring:

- Complex reasoning

- Domain-specific conversational understanding

- Longform answer generation leveraging enterprise indexed embeddings

## Using Azure AI Search as a knowledge source

Azure AI Search integrates as a powerful index-based information source when vector search or semantic ranking is required.

Capabilities include:

- Retrieval of enterprise vector indexes

- Semantic ranking for high-precision results

- Multiple authentication methods including key-based, certificate-based, or Entra ID-based

- Metadata-based citation mapping through index fields 

- This is the preferred solution when content volume is large and requires:

- Scalable indexing

- Enterprise-grade search relevance

- Vector search for embedding-aligned retrieval

## Selecting the right generative knowledge architecture

Solution architects determine the optimal combination of generative AI and knowledge sources based on:

### Data complexity

- Structured → Dataverse

- Semi-structured → Azure AI Search

- Unstructured → SharePoint/OneDrive/Salesforce KB via Dataverse

### Retrieval precision requirements

- High precision → Azure AI Search with semantic ranking

- Broad domain coverage → Generative orchestration with multiple sources

### Governance & security

- Sensitive documents → Unstructured data with strict permission inheritance

- Cross-domain search → Generative orchestration with filtering

### Performance & latency tolerance

- High throughput → Dataverse + Azure AI Search

- Low complexity Q&A → Public site or classic topic embedding

## References

- [Build your first agent in Microsoft 365 Copilot using Copilot Studio — custom knowledge](/training/modules/build-your-first-agent-microsoft-365-copilot-use-copilot-studio/4-custom-knowledge)

- [Copilot Studio knowledge overview](/microsoft-copilot-studio/knowledge-copilot-studio)

- [Copilot Studio — unstructured data knowledge sources](/microsoft-copilot-studio/knowledge-unstructured-data)

- [Copilot Studio — Azure AI Search knowledge sources](/microsoft-copilot-studio/knowledge-azure-ai-search)

- [Copilot Studio — generative answers with Azure OpenAI](/microsoft-copilot-studio/nlu-generative-answers-azure-openai)