Integrating **Azure AI Foundry Agents** with **Microsoft Fabric data agents** enables organizations to unlock advanced data analysis and conversational AI capabilities. By connecting these two powerful services, you can transform enterprise data into interactive Q&A systems, allowing users to explore and gain insights from their data through natural language conversations.

## Why integrate Azure AI Foundry with Fabric Data Agents?

Integrating these services allows users to **interact with enterprise data** through chat interfaces, making data exploration more intuitive and accessible. This approach helps users quickly uncover **actionable, data-driven insights** to support better decision-making. 

With **Identity Passthrough** (On-Behalf-Of) authorization, all data access is governed by the user’s permissions, ensuring robust enterprise security and compliance. 

The integration also **streamlines** the process of connecting AI agents to enterprise data, reducing both development time and complexity.

## Prerequisites

Before you begin, make sure that:

- You have created and **published** a Fabric data agent endpoint.
- Developers and end users have at least the Azure AI User **RBAC role** assigned.
- Developers and end users have at least **read access** to both the Fabric data agent and its underlying data sources.
- Both the Fabric Data Agent and the Azure AI Foundry Agent are deployed within the **same Azure tenant**.

## How to integrate Azure AI Foundry with Fabric Data Agents?

### 1. Create and publish a Fabric Data Agent

Build your Fabric data agent and publish it to obtain an endpoint. This endpoint will be used to connect with the Azure AI Foundry Agent.

### 2. Configure access and permissions

Ensure all users and developers have the necessary roles and permissions as outlined in the prerequisites.

### 3. Update agent instructions

In Azure AI Foundry, update your agent’s instructions to describe the Fabric data agent and the type of data it provides. For example:
“For customer and product sales related data, please use the Fabric tool.”

### 4. Add the Fabric tool to your agent

In the Azure AI Foundry portal, navigate to your agent’s setup screen.
Under the “Knowledge” section, select “Add” and choose “Microsoft Fabric.”
Follow the prompts to add the Fabric tool. You can only add one Fabric tool per agent.

### 5. Create or select a connection

To connect, you’ll need the workspace-id and artifact-id from your published Fabric data agent endpoint (e.g., `https://<environment>.fabric.microsoft.com/groups/<workspace_id>/aiskills/<artifact-id>`).

Add these values as a new connection, marking them as secret if required.
Once added, you can select from existing connections for future use.

### 6. Test the integration

Once configured, test your agent by sending queries. The agent will determine when to leverage the Fabric data agent and generate responses based on the data the user is authorized to access.