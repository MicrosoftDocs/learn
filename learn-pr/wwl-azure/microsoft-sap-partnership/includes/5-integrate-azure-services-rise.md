

Your SAP landscape running within SAP RISE can easily integrate with other applications on Azure. With the information about [available interfaces](/azure/sap/workloads/rise-integration-network#network-communication-ports-with-sap-rise) to the SAP RISE/ECS landscape, many scenarios with Azure Services are possible.

- Data integration scenarios with Azure Data Factory or Synapse Analytics require a self-hosted integration runtime or Azure Integration Runtime. For details see the next chapter.

- App integration scenarios with Microsoft services using Advanced Business Application Programming (ABAP) with the [ABAP SDK for Azure](https://github.com/microsoft/ABAP-SDK-for-Azure) and the [Microsoft AI SDK for SAP](https://github.com/microsoft/aisdkforsapabap). Installation requires prior setup of [abapGit](https://docs.abapgit.org/user-guide/getting-started/install.html).

- App integration scenarios with Microsoft services using [Azure Integration Services](https://azure.microsoft.com/product-categories/integration/) serving as intermediary to address the desired integration pattern. Consumers like Power Apps, Power BI, Azure Functions, and Azure App Service are governed and secured through [Azure API Management](/azure/api-management/api-management-key-concepts) deployed in the customer environment. This component offers industry standard features such as [request throttling](/azure/api-management/api-management-sample-flexible-throttling), [usage quotas](/azure/api-management/api-management-sample-flexible-throttling#quotas), and [SAP Principal Propagation](/azure/sap/workloads/expose-sap-odata-to-power-query) to retain the SAP backend authorizations with Microsoft 365 authenticated callers. Find the API Management policy for SAP Principal Propagation [here.](https://github.com/Azure/api-management-policy-snippets/blob/master/examples/Request%20OAuth2%20access%20token%20from%20SAP%20using%20AAD%20JWT%20token.xml)

- SAP legacy protocols remote function calls (RFC) support with built-in connectors for Azure Logic Apps, Power Apps, Power BI through the Microsoft on-premises data gateway between the SAP RISE system and Azure service. 

Find a comprehensive overview of all the available SAP and Microsoft integration scenarios [here](/azure/sap/workloads/integration-get-started).

## Integration with self-hosted integration runtime

Integrating your SAP system with Azure cloud native services such as Azure Data Factory or Azure Synapse would use these communication channels to the SAP RISE/ECS managed environment.

The following high-level architecture shows possible integration scenario with Azure data services such as [Data Factory](/azure/data-factory/) or [Synapse Analytics](/azure/synapse-analytics/). For Azure services, either a self-hosted integration runtime (self-hosted IR or IR) or Azure integration runtime (Azure IR) can be used. The use of either integration runtime depends on the [chosen data connector](/azure/data-factory/copy-activity-overview#supported-data-stores-and-formats), most SAP connectors are only available for the self-hosted IR. [SAP Enterprise Central Component (ECC) connector](/azure/data-factory/connector-sap-ecc?tabs=data-factory) is capable of being using through both Azure IR and self-hosted IR. The choice of IR governs the network path taken. SAP .NET connector is used for [SAP table connector](/azure/data-factory/connector-sap-ecc?tabs=data-factoryy), [SAP Business Warehouse (BW)](/azure/data-factory/connector-sap-business-warehouse?tabs=data-factory), and [SAP OpenHub](/azure/data-factory/connector-sap-business-warehouse-open-hub) connectors alike. All these connectors use SAP function modules (FM) on the SAP system, executed through RFC connections. Last if direct database access connects with SAP, along with users and connection path opened, ODBC/JDBC connector for [SAP HANA](/azure/data-factory/connector-sap-hana?tabs=data-factory) can be used from the self-hosted IR as well.

:::image type="content" source="../media/sap-rise-azure-data-factory-synapse.png" alt-text="Screenshot of SAP RISE/ECS accessed by Azure ADF or Synapse.":::


For data connectors using the Azure IR, this IR accesses your SAP environment through a public IP address. SAP RISE/ECS provides this endpoint through an application gateway for use and the communication and data movement is through https.

Data connectors within the self-hosted integration runtime communicate with the SAP system within SAP RISE/ECS subscription and virtual network through the established virtual network peering and private network address only. The established network security group rules limit which application can communicate with the SAP system.

The customer is responsible for deployment and operation of the self-hosted integration runtime within their subscription and virtual network. The communication between Azure PaaS services such as Data Factory or Synapse Analytics and self-hosted integration runtime is within the customer’s subscription. SAP RISE/ECS exposes the communication ports for these applications to use but has no knowledge or support about any details of the connected application or service.

Contact SAP for details on communication paths available to you with SAP RISE and the necessary steps to open them. SAP must also be contacted for any SAP license details for any implications accessing SAP data through any external applications.

Learn more about the overall support on SAP data integration scenario from our [Cloud Adoption Framework](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-choose-azure-connectors) with detailed introduction on each SAP connector, comparison, and guidance. The whitepaper [SAP data integration using Azure Data Factory whitepaper](https://github.com/Azure/Azure-DataFactory/blob/master/whitepaper/SAP%20Data%20Integration%20using%20Azure%20Data%20Factory.pdf) completes the picture.

## On-premises data gateway

Further Azure Services such as [Azure Logic Apps](/azure/logic-apps/logic-apps-using-sap-connector), [Power Apps](/connectors/saperp/), or [Power BI](/power-bi/connect-data/desktop-sap-bw-connector) communicate and exchange data with SAP systems through an on-premises data gateway where required. The on-premises data gateway is a virtual machine, running in Azure or on-premises. The exchange provides secure data transfer between these Azure Services and your SAP systems including the option for runtime and driver support for SAP RFCs.

With SAP RISE, the on-premises data gateway can connect to Azure Services running in customer’s Azure subscription. The VM running the data gateway is deployed by the customer. Following high-level architecture serves as overview, similar method can be used for either service.

:::image type="content" source="../media/sap-rise-on-premises-data-gateway.png" alt-text="Screenshot of SAP RISE/ECS accessed from Azure on-premises data gateway and connected Azure services.":::


The SAP RISE environment here provides access to the SAP ports for RFC and https described earlier. The communication ports are accessed by the private network address through the virtual network peering or VPN site-to-site connection. The on-premises data gateway VM running in customer’s Azure subscription uses the SAP .NET connector to run RFC, BAPI, or IDoc calls through the RFC connection. Additionally, depending on service and way the communication is set up, a way to connect to public IP of the SAP systems REST API through https might be required. The https connection to a public IP can be exposed through SAP RISE/ECS managed application gateway. This high level architecture shows the possible integration scenario. Alternatives to it such as using Logic Apps single tenant and private endpoints to secure the communication and other can be seen as extension and aren't described here in.

SAP RISE/ECS exposes the communication ports for these applications to use but has no knowledge about any details of the connected application or service running in a customer’s subscription.

SAP RISE/ECS exposes the communication ports for these applications to use but has no knowledge about any details of the connected application or service running in a customer’s subscription. Contact SAP for any SAP license details for any implications accessing SAP data through Azure service connecting to the SAP system or database.


## GROW with SAP

GROW with SAP is a bundled set of solutions designed to speed up the move to the S/4HANA Cloud public edition. GROW is tailored for midsize businesses and includes solutions, services, community, and learning access.

SAP GROW features include:

- **Inclusive Offering**: GROW with SAP includes SAP S/4HANA Cloud, public edition, SAP Business Technology Platform, packaged activation services, and expert and user support through SAP Community and the SAP Learning portfolio.

- **Differentiating GROW and RISE**: GROW with SAP isn't a product or software but a bundled set of solutions aimed at accelerating the adoption of S/4HANA public cloud. RISE with SAP is SAP’s digital-transformation-as-a-service offering, designed to help organizations transition their existing SAP ERP systems to the cloud, specifically to SAP S/4HANA Cloud. RISE with SAP includes  software, services, and tools to simplify the migration process, reduce complexity, and accelerate the path to cloud-based solutions.

