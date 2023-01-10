In this exercise, your task is to design a layered health model for an example application. Start by reviewing the application architecture, the key Azure services the application uses, and how the Azure services contribute to the overall user experience.

## Example application

The example for this exercise is a web application used by Contoso Shoes. The application allows employees to browse a catalog of products, update individual items in the catalog, and interact with other users by creating comments in the application.

The operations team at Contoso Shoes has identified two critical business requirements for this application. Employees must be able to:

- Interact with the catalog by displaying lists of items and by browsing items.
- Create comments for individual items for other users to see.

The health model should at least include those two critical operations.

## Architecture

:::image type="content" source="../media/contoso-shoes-architecture.png" border="false" alt-text="Diagram that shows the architecture for the Contoso Shoes application.":::

### Components

- **Front-end web application**: The user interface of this workload, which runs on **Azure Web Apps**.

  - *Reads from*: Catalog API, Azure Blob Storage
  - *Writes to*: Catalog API

- **Catalog API**: The API layer that the front-end web application uses for data operations on catalog items and comments. It doesn't write to the database. Instead, a message is sent to an event hub to be processed asynchronously. This component is hosted on **Azure Functions**.

  - *Reads from*: Azure Cosmos DB
  - *Writes to*: Azure Event Hubs

- **Background Processor**: A component that asynchronously processes database updates. The processor doesn't have a public endpoint. This component is hosted on **Azure Functions**.

  - *Reads from*: Azure Event Hubs
  - *Writes to*: Azure Cosmos DB

- **Message broker**: The messaging processor uses **Azure Event Hubs** to pass messages between the Catalog API and the Background Processor.

- **Database**: Data is persisted in **Azure Cosmos DB**. The Catalog API reads from the database directly. Writes are handled by the Background Processor. Images are stored in Azure Blob Storage.

- **Secrets**: The application components of this workload use secrets to authorize access. Secrets are stored in **Azure Key Vault**. The Catalog API and Background Processor use connection strings to access the database and Azure Event Hubs. The front-end web application uses an API key to call the Catalog API.

- **Monitoring**: Application components send all data measurements to **Application Insights**, backed with a **Log Analytics workspace**. The same workspace is used to collect other logs and metrics for this workload. 

## Divide the architecture in layers

As described in previous unit, a health model should be a layered structure. The process of modeling health is an architectural exercise to define all user flows, map dependencies between functional and logical components, and also dependencies between Azure resources. 

Identifying user flows and building the health model is a conceptual exercise at this stage. Use pen and paper or a blank document to note the individual layers and to draw the structure.

For this exercise, our health model has three layers: user flows, application components, and Azure resources.

##### User flows

Starting at the top of the architecture, think about the possible *user flows* based on the expected functionality of the application. Try to abstract the technical details and Azure services, and evaluate the flows from a user's perspective. 

- *What processes are critical?*
- *How do the employees use the application to achieve business goals?*

Based on the requirements identified by the operations team, you should have at least two user flows in the top layer: **List catalog items** and **Add comment**.

If you can think of more, include them in your health model.

##### Application components

Move down a layer and evaluate the application components. Begin by asking questions, such as:

- *"Which part of my application makes this flow work?"*
- *"Which microservices or components participate in this flow?"*
- *"Will this flow still work if this part fails?*"

The aim is to identify application components at a technical level that contribute to each user flow. These components can be APIs, background workers, microservices, and so on.

This workload has at least three application components that participate in the two identified user flows: **Front-end**,  **Catalog API**, and a **Background Processor**.

##### Azure resources

The bottom layer contains the Azure resources used by the individual application components. For this exercise, the components and resources are described in the [Components](#components) section. 

> [!NOTE]
> A real-world scenario probably will have more services and have more complicated relationships between them. A key to building a successful health model is to identify which parts are critical and how each component contributes to the overall health of the system.

## Draw the final health model structure

Put the information you've gathered in a graphical representation of the health model structure. It should look similar to this diagram:

:::image type="content" source="../media/layered-health-model.png" border="false" alt-text="Diagram that shows the architecture for this layered health model.":::

From top to bottom, the web application health model has these layers:

##### User flows

  - **List catalog items**. Dependent on the front-end web application and the Catalog API.
  - **Add comment**. Dependent on the front-end web application, Catalog API, and background processor.

##### Application components

  - **Front-end web application**. Dependent on Blob Storage and the Catalog API.
  - **Catalog API**. Dependent on Azure Cosmos DB, Key Vault, and Event Hubs.
  - **Background processor**. Dependent on Azure Cosmos DB, Key Vault, and Event Hubs.

##### Azure resources

  - **Blob Storage**
  - **Azure Cosmos DB**
  - **Key Vault**
  - **Event Hubs**

