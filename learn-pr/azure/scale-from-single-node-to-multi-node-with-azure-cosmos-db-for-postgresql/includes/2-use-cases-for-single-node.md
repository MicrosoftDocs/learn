When Wide World Importers heard about sensor tracking, the developers knew that it would start small and grow once proven to be full of insights. They wanted to start with a small relational database and have a system that was designed for future scale and growth. Azure Cosmos DB for PostgreSQL fits perfectly for this project.

## Why Azure Cosmos DB for PostgreSQL as a single node database

In applications when your workload fits in 64 vCores, 256-GB RAM, and 2-TB storage, you can use a single-node Azure Cosmos DB for PostgreSQL cluster. This size is common for:

- Small production loads
- Test environments
- Development environments

## When to grow to multi-node

As data demands grow, data usage needs to be reviewed and performance adjusted. Azure Cosmos DB for PostgreSQL is built to support growth. When your workload nears outgrowing the compute resources, storage, and memory offered in a single-node environment, it's time to consider growing into a multi-node environment. Another case for moving to a multi-node configuration is when queries are performing slower due to growth. A multi-node environment spreads data storage and query processing over multiple nodes.

## Wide World Importers' schema for their sensors data

This is the initial database Wide World Importers started with for their devices:

- Sensor types are stored on a `device_types` table. The types included warehouse and delivery truck sensors.
- Sensors are stored on a `devices` table. The devices table includes a link to the `device_types` table on `device_type_id` and the device's ID and name.
- Sensors report their data every minute, and the readings are stored on an `events` table. The events include the device ID, sensor readings, and a timestamp. The `events` table is linked to the `devices` table on `device_id`.

![Diagram of the relationships between device types, devices, and events. The device_types table has two fields - device_type_id and name. device_type_id is its primary key. The devices table has three fields - device_id, device_type_id, and name. device_id is its primary key. The devices table has a foreign key relationship on device_type_id that references the device_type_id field on the device_types table. The events table has three fields - event_id, device_id, and payload. event_id is its primary key. The events table has a foreign key relationship on its device_id that references the device_id field on the devices table.](../media/normalized-database-erd.png)

## Wide World Importers and multi-node considerations

How did Wide World Importers decide to go multi-node? Wide World Importers knew they were having performance issues as they ran aggregate queries over a large number of sensor readings. Their chilly chocolates were gaining in popularity, which meant adding more delivery trucks to their fleet. As Wide World Importers added more trucks, this meant more data in the `devices` table, which meant a lot more sensor readings in the `events` table. Adding more data to their non-distributed database would hinder that further.

The ideal environment for the chilly chocolates is 55-60 degrees Fahrenheit with humidity in the range of 60-70%. If there are sensor readings outside of those ranges, management needs alerted so that measures can be taken to prevent the chilly chocolates from becoming melted chocolates. Slow-performing queries could lead to delays in notifying management, which could lead to product issues. It was time to look at how they could improve their performance and query times.

They have queries over the trucks' and warehouses' temperatures to ensure that the chilly chocolates were stored and transported in optimal environments. These queries worked fine at a smaller scale when they were testing with a few routes. However, as sensors are added, the number of readings grows massively. With the amount of data about to increase drastically, it was time to look at these queries and find a better way to get this information at scale. When the growth hurts performance, it's time to consider moving from a single-node environment to a distributed, multi-node environment.

As you want to show their team how to update their environment, you need to set up a single-node environment to demo the steps with their tech leads.
