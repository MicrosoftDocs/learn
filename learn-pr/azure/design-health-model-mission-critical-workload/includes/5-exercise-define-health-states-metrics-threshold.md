Contoso Shoes needs a way to define user flows and application components as part of its health model design. The goal is to identify potential failure points before they can cause an outage.

For this module, the health states for two user flows in the health model are defined as follows:

- List catalog items user flow:
  - Healthy: When both the front-end web application and the Azure Data Catalog Rest API are healthy
  - Unhealthy: When the Azure Data Catalog Rest API is unhealthy

- Add comment user flow:
  - Healthy: When the front-end web application, the Azure Data Catalog Rest API, and the background processor are all healthy
  - Unhealthy: When both the Azure Data Catalog Rest API and the background processor are unhealthy

Application components health states are based on a combination of application metrics (for example, number of exceptions and response time) and service metrics.

Azure service health states are based on a particular resource. For example, DTU utilization is based on Azure Cosmos DB, CPU utilization is based on Azure App Service, and so on.

Each health state is represented by a set of indicators and corresponding thresholds. The format is up to the learner to choose, for example:

| Component | Indicator/metric | Healthy | Degraded | Unhealthy |
| --------- | ---------------- | ------- | -------- | --------- |
| List catalog items user flow | Underlying health state | Front end healthy and Data Catalog API healthy |
| Add comment user flow | Underlying health state | Front end healthy, Data Catalog API healthy, and background processor healthy |
| Front-end web application | # of non-20x HTTP responses/min | 0 | 1-10 | > 10 |
| Azure Data Catalog API | # of exceptions/sec | < 10 | 10-50 | > 10 |
|  | Avg. processing time | < 150 ms | 150-500 ms | > 500 ms |
| Background processor | Avg. time in queue (ms) | < 200 | 200-1000 | > 1000 |
|  | Avg. processing time (ms) | < 100 | 100-200 | > 200 |
|  | Failure count | < 3 | 3-10 | > 10 |
| Azure Cosmos DB | DTU utilization | < 70% | 70-90% | > 90% |
| Azure Key Vault | Failure count | < 3 | 3-10 | > 10 |
| Azure Event Hubs | Processing backlog length (outgoing/incoming messages) | < 3 | 3-20 |  > 20 |
| Azure Blob Storage | TBD | TBD | TBD |  TBD |
