Microsoft maintains its commitment to providing customers with high-quality products and services by adhering to comprehensive operational policies, standards, and practices. Formal documents called *Service-Level Agreements* (SLAs) capture the specific terms that define the performance standards that apply to Azure.

- SLAs describe Microsoft's commitment to providing Azure customers with specific performance standards.
- There are SLAs for individual Azure products and services.
- SLAs also specify what happens if a service or product fails to perform to a governing SLA's specification.

> [!IMPORTANT]
> Azure does not provide SLAs for most services under the *Free* or *Shared* tiers. Also, free products such as Azure Advisor do not typically have an SLA.

## SLAs for Azure products and services

There are three key characteristics of SLAs for Azure products and services:

1. Performance Targets
1. Uptime and Connectivity Guarantees
1. Service credits

### Performance Targets

An SLA defines performance targets for an Azure product or service. The performance targets that an SLA defines are specific to each Azure product and service. For example, performance targets for some Azure services are expressed as uptime guarantees or connectivity rates.

### Uptime and Connectivity Guarantees

A typical SLA specifies performance-target commitments that range from 99.9 percent ("three nines") to 99.999 percent ("five nines"), for each corresponding Azure product or service. These targets can apply to such performance criteria as uptime or response times for services.

The following table lists the potential cumulative downtime for various SLA levels over different durations:

| SLA % | Downtime per week | Downtime per month | Downtime per year |
| --- | --- | --- | --- |
| 99 |1.68 hours |7.2 hours |3.65 days |
| 99.9 |10.1 minutes |43.2 minutes |8.76 hours |
| 99.95 |5 minutes |21.6 minutes |4.38 hours |
| 99.99 |1.01 minutes |4.32 minutes |52.56 minutes |
| 99.999 |6 seconds |25.9 seconds |5.26 minutes |

For example, the SLA for the Azure Cosmos DB (Database) service SLA offers 99.999 percent uptime, which includes low-latency commitments of less than 10 milliseconds on DB read operations as well as on DB write operations.

### Service Credits

SLAs also describe how Microsoft will respond if an Azure product or service fails to perform to its governing SLA's specification.

For example, customers may have a discount applied to their Azure bill, as compensation for an under-performing Azure product or service. The table below explains this example in more detail.

The first column in the table below shows monthly uptime percentage SLA targets for a single instance Azure Virtual Machine. The second column shows the corresponding service credit amount you receive if the *actual* uptime is less than the specified SLA target for that month.

| MONTHLY UPTIME PERCENTAGE | SERVICE CREDIT PERCENTAGE|
| --- | --- |
| < 99.9 |10 |
| < 99 |25 |
| < 95 |100 |
