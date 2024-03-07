In this module, you explored the major Azure Digital Twins API operations as part of a solution to digitally represent a city energy grid.

After configuring the API collections in Postman, you used the Import Jobs API to populate an Azure Digital Twins graph with models, twins, and relationships to represent city grid entities. You used the Models and Digital Twins API to verify and update the graph, and the Query API to further validate and explore it. Finally, you used the Endpoints control plane API and Event Routes API to prepare the graph for IoT data to propagate through it.

Using the Azure Digital Twins built-in capabilities for creating models, devices, and connections between them has given you a central destination for device data that's intuitively organized like your real world environment. This can be used to give stakeholders and operators a quick, all-up view of the energy grid components in the city and how they connect to each other. Later, you can send IoT data into this graph in order to gather queryable insights and build dashboards to track what is happening with the city's energy flow.

[!INCLUDE [Instructions to clean up Azure Digital Twins resources](../../includes/clean-up-azure-digital-twins.md)]

You might also want to delete the [Postman](https://web.postman.co/) account that you created in Unit 2.