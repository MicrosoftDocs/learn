Now that you've set up messaging for the Spring Petclinic application, the next thing you'll do is configure Azure Event Hubs to receive events.

Event Hubs is a fully managed, real-time data ingestion service that’s simple, trusted, and scalable. Stream millions of events per second from any source to build dynamic data pipelines and immediately respond to business challenges. Keep processing data during emergencies using the geo-disaster recovery and geo-replication features.

:::image type="content" source="../media/azure-event-hubs-coordination-c10e19fa.png" alt-text="Diagram showing how Azure Event Hubs integrate with other Azure services to unlock insights.":::


Azure Event Hubs integrates seamlessly with other Azure services to unlock insights. Allow existing Apache Kafka clients and applications to talk to Event Hubs without any code changes.

## Learning objectives

After completing this module, you'll be able to:

 -  Create an Azure Event Hubs resource.
 -  Configure an existing microservice to send events to Azure Event Hubs.
 -  Update an existing microservice to receive events from Azure Event Hubs.
 -  Locate and review telemetry data.

## Prerequisites

 -  Intermediate-level familiarity with and local installations of the following tools: Git, Java JDK 8 or later, and a Java IDE or text editor.
 -  Basic Git commands, including cloning, committing files, and pushing changes to GitHub.
 -  Intermediate-level familiarity with Azure.

> [!NOTE]
> The instructions provided in this exercise assume that you've successfully completed the previous exercises and are using the same lab environment, including your Git Bash session with the relevant environment variables already set.
> To download the instructions for this module, see [Deploying and Running Java apps in Azure Spring Apps](https://github.com/MicrosoftLearning/Deploying-and-Running-Java-Applications-in-Azure-Spring-Apps) in GitHub.
