Contoso Shoes needs a way to define user flows and application components as part of its health model design. The goal is to identify potential failure points before they can cause an outage.

The user flow health states are defined as follows:

- List catalog items: Unhealthy when the Catalog API is unhealthy.
- Add comment: Unhealthy when both the Catalog API and background processor are unhealthy.

Application components health states are based on a combination of application metrics (for example, number of exceptions and response time), and service metrics.

Azure service health states are based on a particular resource. For example, DTU utilization is based on Cosmos DB, CPU utilization is based on Web App, and so on.

Each health state is represented by a set of indicators and corresponding thresholds. The format is up to the learner to choose, for example:

| Component | Indicator/metric | Healthy | Degraded | Unhealthy |
| --------- | ---------------- | ------- | -------- | --------- |
| List catalog items user flow | Underlying health state | Front end healthy and Catalog API healthy |
| Add comment user flow | Underlying health state | Front end healthy, Catalog API healthy, and background processor healthy |
| Front end | # of non-20x HTTP responses/min | 0 | 1-10 | > 10 |
| Catalog API | # of exceptions/sec | < 10 | 10-50 | > 10 |
| Catalog API | Avg. processing time | < 150 ms | 150-500 ms | > 500 ms |
| Background processor | Avg. time in queue (ms) | < 200 | 200-1000 | > 1000 |
| Background processor | Avg. processing time (ms) | < 100 | 100-200 | > 200 |
| Background processor | Failure count | < 3 | 3-10 | > 10 |
| Cosmos DB | DTU utilization | < 70% | 70-90% | > 90% |
| Key Vault | Failure count | < 3 | 3-10 | > 10 |
| Event Hubs | Processing backlog length (outgoing/incoming messages) | < 3 | 3-20 |  > 20 |
