A [SLA](https://azure.microsoft.com/support/legal/sla/summary?azure-portal=true) defines performance targets for an Azure product or service.  The performance targets that a SLA defines are specific to each Azure product and service.

For example, performance targets for some Azure services are expressed in terms of uptime or connectivity rates.

## Performance targets range from 99.9 percent to 99.99 percent

A typical SLA specifics performance-target commitments that range from 99.9 percent ("three nines") to 99.99 percent ("four nines"), for each corresponding Azure product or service. These targets can apply to such performance criteria as uptime, or response times for services.

For example, the SLA for the Azure Database for MySQL service guarantees 99.99 percent uptime.  The Azure Cosmos DB (Database) service SLA offers 99.99 percent uptime, which includes low-latency commitments of less than 10 milliseconds on DB read operations and less than 15 milliseconds on DB write operations.

## SLA downtime estimates


The following table lists the potential cumulative downtime for various SLA levels over different durations:

| SLA percentage | Downtime per week | Downtime per month | Downtime per year |
| --- | --- | --- | --- |
| 99 |1.68 hours |7.2 hours |3.65 days |
| 99.9 |10.1 minutes |43.2 minutes |8.76 hours |
| 99.95 |5 minutes |21.6 minutes |4.38 hours |
| 99.99 |1.01 minutes |4.32 minutes |52.56 minutes |
| 99.999 |6 seconds |25.9 seconds |5.26 minutes |

## Service Credits

SLAs also describe how Microsoft will respond if an Azure product or service fails to perform to its governing SLA's specification.

For example, customers may have a discount applied to their Azure bill, as compensation for an under-performing Azure product or service. The table below explains this example in more detail.

The first column in the table below shows monthly uptime percentage SLA targets for a single instance Azure Virtual Machine. The second column shows the corresponding service credit amount you receive, if the *actual* uptime is less than the specified SLA target for that month.

| Monthly Uptime Percentage | Service Credit Percentage|
| --- | --- |
| < 99.9 |10 |
| < 99 |25 |
| < 95 |100 |

> [!div class="checklist"]
> * Azure does not provide SLAs for many services under the *Free* or *Shared* tiers. Also, free products such as Azure Advisor do not typically have a SLA.
