Once your agent defines its skills and Agent Card, the next step is to host it on a server. Hosting makes your agent accessible to clients and other agents over HTTP, enabling real-time interactions and multi-agent workflows.

Hosting an agent allows it to:

- Expose its capabilities through its **Agent Card**, which clients and other agents can discover.  
- Receive incoming A2A requests and forward them to your **Agent Executor** for processing.  
- Manage task lifecycles, including streaming responses and stateful interactions.  

Effectively, the server acts as a bridge between your agent’s logic and the external world, ensuring it can participate in coordinated workflows.

## Core components of the agent server

To host an agent, you need three essential components working together:

**Agent Card**
- Describes the agent’s capabilities, skills, and input/output modes.  
- Exposed at a standard endpoint (typically `/.well-known/agent-card.json`) so clients and other agents can discover your agent.  
- Can include multiple versions or an "extended" card for authenticated users.

**Request Handler**
- Routes incoming requests to the appropriate methods on your **Agent Executor** (for example, `execute` or `cancel`).  
- Manages the task lifecycle using a **Task Store**, which tracks tasks, streaming data, and resubscriptions.  
- Even simple agents require a task store to handle interactions reliably.

**Server Application**
- Built using a web framework (Starlette in Python) to handle HTTP requests.  
- Combined with an ASGI server (like Uvicorn) to start listening on a network interface and port.  
- Exposes the agent card and request handler endpoints, enabling clients to interact with your agent.

## Set up the A2A agent server

1. Define your agent’s skills and Agent Card.  
1. Initialize a request handler that links your **Agent Executor** with a **Task Store**.  
1. Set up the server application, providing the Agent Card and request handler.  
1. Start the server using an ASGI server (Uvicorn) to make it accessible on the network.  
1. Once running, the agent listens for incoming requests and responds according to its defined skills.

A "Hello World" agent may expose a basic greeting skill. Once hosted, it can respond to any requests sent to its endpoint. A more complex agent can serve multiple skills or an extended Agent Card for authenticated users.

Hosting an A2A agent combines the Agent Card, request handler, and agent executor to make it available for client and agent interactions. This setup ensures tasks are managed correctly and responses are delivered reliably, enabling your agent to participate in multi-agent workflows.