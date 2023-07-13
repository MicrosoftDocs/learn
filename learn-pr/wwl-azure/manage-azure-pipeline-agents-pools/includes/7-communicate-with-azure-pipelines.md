The agent communicates with Azure Pipelines to determine which job to run and reports the logs and job status.

The agent always starts this communication. All the messages from the agent to Azure Pipelines over HTTPS depend on how you configure the agent.

This pull model allows the agent to be configured in different topologies, as shown below.

:::image type="content" source="../media/agent-machine-behind-firewall-cc762a93.png" alt-text="Diagram that shows an agent on an on-premises machine behind a firewall is using port 443 to access an Azure pipeline.":::


Here's a standard communication pattern between the agent and Azure Pipelines.

The user registers an agent with Azure Pipelines by adding it to an agent pool. You must be an agent pool administrator to register an agent. The identity of the agent pool administrator is needed only at the time of registration. It isn't persisted on the agent or used to communicate further between the agent and Azure Pipelines.

Once the registration is complete, the agent downloads a listener OAuth token and uses it to listen to the job queue.

Periodically, the agent checks to see if a new job request has been posted in the job queue in Azure Pipelines. The agent downloads the job and a job-specific OAuth token when a job is available. Azure Pipelines generate this token for the scoped identity specified in the pipeline. That token is short-lived and is used by the agent to access resources (for example, source code) or modify resources (for example, upload test results) on Azure Pipelines within that job.

Once the job is completed, the agent discards the job-specific OAuth token and checks if there's a new job request using the listener OAuth token.

The payload of the messages exchanged between the agent and Azure Pipelines are secured using asymmetric encryption. Each agent has a public-private key pair, and the public key is exchanged with the server during registration.

The server uses the public key to encrypt the job's payload before sending it to the agent. The agent decrypts the job content using its private key. Secrets stored in build pipelines, release pipelines, or variable groups are secured when exchanged with the agent.
