The agent communicates with Azure Pipelines to determine which job to run and reports logs and job status. The agent always initiates this communication, with all messages sent to Azure Pipelines over HTTPS.

This pull model allows agents to be configured in different network topologies, including behind firewalls and in secure environments.

:::image type="content" source="../media/agent-machine-behind-firewall-cc762a93.png" alt-text="Diagram that shows an agent on an on-premises machine behind a firewall is using port 443 to access an Azure pipeline.":::

## Communication workflow

Here's the standard communication pattern between agents and Azure Pipelines:

### 1. Agent registration

- You register an agent with Azure Pipelines by adding it to an agent pool.
- You must be an agent pool administrator to register an agent.
- The administrator identity is only needed during registration, not for ongoing communication.

### 2. Token exchange

- After registration, the agent downloads a listener OAuth token.
- This token is used to monitor the job queue for new work.

### 3. Job processing

- The agent periodically checks for new job requests in the Azure Pipelines job queue.
- When a job is available, the agent downloads both the job and a job-specific OAuth token.
- Azure Pipelines generates this short-lived token for the pipeline's scoped identity.
- The agent uses this token to access resources (like source code) or modify resources (like uploading test results).

### 4. Job completion

- After completing the job, the agent discards the job-specific OAuth token.
- The agent returns to monitoring for new jobs using the listener OAuth token.

## Security measures

- **Asymmetric encryption:** All message payloads between agents and Azure Pipelines use asymmetric encryption for security.
- **Key exchange:** Each agent has a public-private key pair, with the public key shared during registration.
- **Payload protection:** The server encrypts job payloads using the agent's public key before transmission.
- **Decryption:** The agent decrypts job content using its private key.
- **Secrets protection:** Secrets stored in build pipelines, release pipelines, or variable groups remain secure during agent communication.
