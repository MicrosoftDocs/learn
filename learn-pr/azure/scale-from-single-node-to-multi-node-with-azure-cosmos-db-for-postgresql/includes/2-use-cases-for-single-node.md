When Wide World Importers learned about sensor tracking, the company's developers knew that they would start small. When the feature is proven to give the company valuable insights, they could expand and grow. The developers wanted to start with a small relational database, and have a system that was designed for future scale and growth. Azure Cosmos DB for PostgreSQL fits perfectly for this project.

## Azure Cosmos DB for PostgreSQL for a single-node database

If your application's workload fits in 64 vCores, 256 GB of RAM, and 2 TB of storage, you can use a single-node Azure Cosmos DB for PostgreSQL cluster. This size is common for:

- Small production loads
- Test environments
- Development environments

## When to grow to multi-node

As data demands grow, data usage needs to be reviewed and performance adjusted. Azure Cosmos DB for PostgreSQL is built to support growth. When your workload is close to outgrowing the compute resources, storage, and memory that are offered in a single-node environment, it's time to consider growing into a multi-node environment. Another case for moving to a multi-node configuration is when queries are performing slower due to growth. A multi-node environment spreads data storage and query processing over multiple nodes.

## Wide World Importers schema for sensor data

The initial database that Wide World Importers uses for its devices has the following characteristics:

- Sensor types are stored in a `device_types` table. The types include warehouse and delivery truck sensors.
- Sensors are stored in a `devices` table. The `devices` table includes a link to the `device_types` table on `device_type_id` and the device's ID and name.
- Sensors report their data every minute, and the readings are stored in an `events` table. The events include the device ID, sensor readings, and a timestamp. The `events` table is linked to the `devices` table on `device_id`.

:::image type="content" source="../media/normalized-database-erd.png" border="false" alt-text="Diagram that shows the relationships between three tables, and the columns and primary keys in each table.":::

## Multi-node considerations

How did Wide World Importers decide to move to a multi-node configuration? Wide World Importers knew that it was having performance issues as developers ran aggregate queries over a large number of sensor readings. The company's chilly chocolates were gaining in popularity, which meant adding more delivery trucks to its fleet. As Wide World Importers added more trucks, more data was added to the `devices` table. More data meant that more sensor readings were added to the `events` table. Adding more data to a nondistributed database would make queries slower and reduce overall performance for the company and its product.

The ideal environment for the chilly chocolates is between 55 degrees and 60 degrees Fahrenheit, with humidity in the range of 60 percent to 70 percent. If any sensor readings are outside those ranges, management needs to be alerted so that measures can be taken to prevent the chilly chocolates from becoming melted chocolates. Slow-performing queries could lead to delays in notifying management, which could lead to product issues. It was time to look at how the company could improve its performance and query times.

Wide World Importers uses queries to monitor the temperature in trucks and warehouses to ensure that the chilly chocolates are stored and transported in optimal environments. These queries worked fine at a smaller scale when they were testing by using a few routes. However, as sensors are added, the number of readings grows massively. With the amount of data about to increase drastically, it was time to look at these queries and find a better way to get this information at scale. When growth hurts performance, it's time to consider moving from a single-node environment to a distributed, multi-node environment.

Because you want to show the team how they can update their environment, you need to set up a single-node environment to demonstrate the steps for the team's tech leads.
