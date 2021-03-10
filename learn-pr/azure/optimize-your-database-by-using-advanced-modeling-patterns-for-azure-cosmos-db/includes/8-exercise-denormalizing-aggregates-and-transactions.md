In this exercise we will create a new sales order and update the 'salesOrderCount' property in the customer container using Transactional Batch.

**To Do: Will complete this when the exercise is written**

    - Describe the flow here:
        - Query the customer container for a customer id and return the customer object and all their sales orders. Inspect the value for 'salesOrderCount'.
        - Also show how when querying for multiple entities we deserialize into a dynamic type and then inspect the 'type' property to determine which POCO to deserialize our data into.
        - Start a new sales order by doing a point read for a customer that will create a new sales order for.
        - Call customer.salesOrderCount++ to increment its value.
        - Create a new sales order object and add a couple of products to it.
        - Call transactional batch with an insert for the new sales order and update on the customer.
        - Query the customer container again using the first query to see the updated 'salesOrderCount' value and the newly added sales order.
        - Optionally, can also show how this works if the customer cancels the sales order by showing Transactional Batch with an update and delete.
