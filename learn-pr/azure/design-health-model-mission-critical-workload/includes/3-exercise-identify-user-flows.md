As Contoso Shoes begins to design its health model, its first step is to review the internal web application that company employees use. Contoso Shoes needs to understand the web application's  architecture, the key Azure services the application uses, and how the Azure services contribute to the overall user experience.

Your task in this exercise is to design the health model structure of an internal web application for Contoso Shoes. The structure consists of multiple layers, as described in [Layered health model](/training/modules/design-health-model-mission-critical-workload/2-what-is-health-modeling#layered-health-model).

## Application

The internal web application that company employees use works like other common e-commerce websites, including the Contoso Shoes store website. In the internal web application, employees can browse a catalog of products, update individual items in the catalog, and interact with other users by creating comments in the application.

The operations team at Contoso Shoes identifies two critical business requirements for the internal web application. Employees who use the internal web application must be able to:

- Interact with the catalog by displaying lists of items and by browsing items.
- Create comments for individual items for other users to see.

The health model should include these two critical operations, at a minimum.

## Architecture

The following diagram shows the architecture of the Contoso Shoes internal web application. When you design your application architecture, ensure that you have a good understanding of the individual components and of their roles in how the system works.

:::image type="content" source="../media/contoso-shoes-architecture.png" border="false" alt-text="Diagram that shows the architecture for the Contoso Shoes application.":::

### Components

The Contoso Shoes internal web application architecture has the following components:

- **Front-end internal web application**: The user interface of this workload, which runs on Azure Web Apps.

  - *Reads*: Catalog API, Azure Blob Storage
  - *Writes*: Requests coming from users, Catalog API

- **Catalog API**: The API layer that the front-end web application uses for data operations on catalog items and comments. It doesn't do any database writes itself. Instead, a message is sent to an event hub to be processed asynchronously. This component is hosted on Azure Functions.

  - *Reads*: Azure Cosmos DB
  - *Writes*: Azure Event Hubs

- **Background processor**: A component that asynchronously processes database updates. The processor doesn't have a public endpoint. This component is hosted on Azure Functions.

  - *Reads*: Azure Event Hubs
  - *Writes*: Azure Cosmos DB

- **Messaging bus**: The messaging bus uses Azure Event Hubs to pass messages between the Catalog API and the background processor.

- **Database**: Data is persisted in Azure Cosmos DB. The Catalog API reads from the database directly. Writes are handled by the background processor. Images are stored in Azure Blob Storage.

- **Secrets**: The application components of this workload use secrets to authorize access. Secrets are stored in Azure Key Vault. The Catalog API and background processor use connection strings to access the database and Azure Event Hubs. The front-end web application uses an API key to call the Catalog API.

- **Monitoring**: Application components send all data measurements to Application Insights, backed with a Log Analytics workspace. The same workspace is used to collect other logs and metrics for this workload. (For this exercise, consider this deployment to be single-stamp.)

## Layered health model structure

As described in [Layered health modeling](/training/modules/design-health-model-mission-critical-workload/2-what-is-health-modeling#layered-health-model), a health model usually has a layered structure. The process of modeling health is a top-down design activity that starts with an architectural exercise to define all user flows and to map dependencies between functional and logical components. The mapping process also implicitly maps the dependencies between Azure resources. For this exercise, our health model has three layers: user flows, application components, and Azure resources.

Identifying user flows and building the health model is a conceptual exercise at this stage. Use pen and paper or a blank document to note the individual layers and to draw the structure.

### User flows

Going from top to bottom in the layered health structure, think about what the *user flows* would be based on what you know about the application. Try to abstract the technical details and Azure services, and look at the user's perspective. What processes are critical? How do your employees use the application to achieve business goals?

You should end up with at least two user flows in the top layer: *list catalog items* and *add comment*. If you can think of more, include them in your health model.

### Application components

After you identify the user flows to include, move down to the middle layer in the health model. Begin by asking questions like, *"Which part of my application makes this flow work?"*, *"Which microservices or components contribute to fulfilling requests in this flow?"*, and *"Will this flow still work if this part fails?*"

The aim is to identify application components on a technical level that contribute to each user flow. These components can be APIs, background workers, microservices, and so on.

This workload has at least three application components that contribute to the two user flows: a front end, a Catalog API, and a background processor.

### Azure resources

The final and bottom layer of the health model contains the Azure resources that the individual application components use. If you look at the architecture diagram and read the component description, it should be clear what those resources are.

> [!NOTE]
> A real-world scenario probably will have more services and have more complicated relationships between them. A key to building a successful health model is to identify which parts are critical and how each component contributes to the overall health of the system.

## Final health model structure

For the final step of this exercise, put the information you gathered in a graphical representation of the health model structure. It should look similar to the following diagram:

:::image type="content" source="../media/layered-health-model.png" border="false" alt-text="Diagram that shows the architecture for this layered health model.":::

From top to bottom, the Contoso Shoes internal web application health model has these layers:

- User flows:

  - **List catalog items**. Dependent on the front-end web application and the Catalog API.
  - **Add comment**. Dependent on the front-end web application, Catalog API, and background processor.

- Application components:

  - **Front-end web application**. Dependent on Blob Storage and the Catalog API.
  - **Catalog API**. Dependent on Azure Cosmos DB, Key Vault, and Event Hubs.
  - **Background processor**. Dependent on Azure Cosmos DB, Key Vault, and Event Hubs.

- Azure resources:

  - **Blob Storage**
  - **Azure Cosmos DB**
  - **Key Vault**
  - **Event Hubs**
