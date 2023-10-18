    * Restate the scenario problem(s) -- Creating a digital representation of an energy grid scenario.
    * Show how you solved the scenario problem(s) -- Used the Azure Digital Twins APIs to create models and twins and connect them into a graph. Used queries to verify the graph, and created endpoints and event routes in preparation for data to flow between twins.
    * Describe the experience without the product -- You would have to write a custom application with custom modeling and custom event handling code.
    * Describe the business impact -- Stakeholders and operators have a quick, all-up view of the energy grid components in the city and how they connect to each other. Later, you can send IoT data into this graph in order to gather insights and build dashboards for what is happening with the city's energy.

## Clean up hands-on resources
In your Cloud Shell, run the following command to delete the resources that you created in the hands-on exercises for this module.
```azurecli
az group delete --name azure-digital-twins-training
```