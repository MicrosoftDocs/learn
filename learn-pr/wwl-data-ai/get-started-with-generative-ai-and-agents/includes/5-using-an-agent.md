**Publishing** an agent promotes it from a saved development asset to a managed Azure resource with a stable endpoint. Once published, you can share the agent with teammates, your organization, or customers—without exposing your Foundry project or source code. You can publish an agent through the Foundry portal, which 

![Screenshot of publishing agent in the Foundry portal.](../media/publish-agent.png)
![Screenshot of agent after it is published in the Foundry portal with the endpoint information.](../media/agent-published.png)

Publishing an agent gives you a stable endpoint to integrate the agent in code. You can use an agent from a client application by using the **Foundry Projects SDK** to connect to the project and call it from a client using the **Project API**.

The Project API enables you to:
- Integrate agents into web apps, bots, or backend workflows
- Orchestrate multi‑step tasks
- Pass structured inputs or tool calls
- Run agents at scale with your Foundry deployments

#### Create a lightweight Python client application for an agent

To call the agent programmatically using Foundry’s Project API, you need the `agent-id` of your published agent. You can find the `agent-id` in the Playground view of the agent when you select the *code* view and open the *.env variables*.  

![Screenshot of the agent id that can be found with the environment variables.](../media/agent-id.png) 

Let's take a look at the code view of the agent in Python: 

```python
# Before running the sample, install the packages:
#    pip install --pre azure-ai-projects>=2.0.0b1
#    pip install azure-identity

from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

myEndpoint = "https://<resource>.services.ai.azure.com/api/projects/<resource-name>"

project_client = AIProjectClient(
    endpoint=myEndpoint,
    credential=DefaultAzureCredential(),
)

myAgent = "learning-agent"
# Get an existing agent
agent = project_client.agents.get(agent_name=myAgent)
print(f"Retrieved agent: {agent.name}")

openai_client = project_client.get_openai_client()

# Reference the agent to get a response
response = openai_client.responses.create(
    input=[{"role": "user", "content": "Tell me what you can help with."}],
    extra_body={"agent": {"name": agent.name, "type": "agent_reference"}},
)

print(f"Response output: {response.output_text}")

```

You can evaluate an agent the same way as a model—testing reasoning steps, tool use, and orchestration quality.
In production environments, model behavior can drift. Foundry supports continuous evaluation to monitor relevance, safety, accuracy, cost, and token efficiency. 

## Managing costs  

A Foundry agent itself is free; the real cost comes from what it uses, mainly:
- The models it calls
- The tools it invokes
- The data services it connects to
- The storage and compute resources its workflows require
- The deployment configuration of underlying model endpoints

|**Cost Factor**|**Description**|
|-|-|
|Model tokens| Input/output tokens consumed by the agent| 
|Tools invoked|For example: File Search, Code Interpreter, Deep Research, Bing grounding, Logic Apps| 
|Foundry Tools used| For example: Azure Speech, Content Understanding|
|Storage|Vector database, document storage, indexes|
|Deployment settings|For example: pay-as-you-go|
|External knowledge connections|Fabric, SharePoint, etc.|

The more complex and data-rich your agent, the higher the cost. Three of the main cost drivers of a model are:

- Billing model (pay‑as‑you‑go vs. provisioned throughput)
- Deployment option (Standard, Serverless API, Managed Compute)
- Model and workload characteristics (token usage, throughput needs, latency targets)

If your workload is spiky, unpredictable, or low volume, use Serverless API (pay‑as‑you‑go). Serverless charges only for actual usage (tokens), ideal for irregular traffic. Deployments are regional only and scale automatically.

If your workload is steady, high‑volume, or has strict latency needs, use Provisioned Throughput (PTU). PTUs reserve dedicated processing capacity and guarantee predictable latency. PTUs can lead to substantial cost savings for high throughput workloads.

Agentic AI powers cutting edge AI solutions are automating and accelerating business processes every day. With Microsoft Foundry, you can develop scalable secure agents using the latest models and technologies. This module is just the start of your journey.