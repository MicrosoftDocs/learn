intro

## Learning objectives

In this module you will:

- Learn TBD

## Prerequisites

- An introductory knowledge of Azure IoT

## Learn the terminology

tbd





## Cosmos DB

well ordered universe: write at one location, treated as local in many other locations
primary write db, secondary read db
consistency between dbs
Make the decision:
Strong consistency - latency, but consistent. all geo locations see same data until acks from all received by primary
Strong performance - inconsistent data 
Bounded: Set a staleness value at T time, data will be tolerated if its stale up to T minutes, but if it is stale beyond that, it will wait for strong.
Session: clients with access to write db see changes as they are made, all others in sync when all acks received
Prefix: sequence by ??

Multi-api : SQL API, MONGO API, GRAPH API, TABLE API, CASSANDRA APi - all used with CosmosDB

Structure: database, container, documents, json
a container is a collection or a table or a graph

Be choosy on locations - read locations

manual/automatic failover is what?
failover - a hubs operation is moved to a second site (disasters, power outages, hacking)
autofailover - zero downtime - but some risk in handing over control to an auto process
