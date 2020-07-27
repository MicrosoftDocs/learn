Microsoft maintains its commitment to providing high-quality products and services by adhering to comprehensive operational policies, standards, and practices. **Service-Level Agreements** (SLAs) capture the specific terms that define Azure's performance standards. These formally document our agreement to our customers, similar to privacy or licensing agreements.

+ SLAs describe Microsoft's commitment to providing Azure customers with certain performance standards.
+ Individual Azure products and services each have their own SLA.
+ SLAs also specify what happens if a service or product fails to perform to the governing SLA's specification.

Performance targets for Azure services may be expressed in terms of uptime or connectivity rates.

Azure services provisioned using a *Free* or *Shared* tier of that service may not have an SLA. Also, free products such as Azure Advisor do not typically have a SLA. 
For a full list of the SLAs for the individual Azure services, visit [Service Level Agreements](https://azure.microsoft.com/support/legal/sla/?azure-portal=true) 


## Performance targets range from 99.9 percent to 99.99 percent

A typical SLA specifies a performance-target commitment for an Azure product or service that ranges from 99.9 percent ("three nines") to 99.99 percent ("four nines"). This target can apply to the percentage of time that a product or service is successfully operational (known as **uptime**), or to how fast a service must respond to a request.

<div style="background:yellow;">
TODO: Introducing response times is too complicated - can we drop? Leads to unfamiliar jargon like latency.
</div>

For example, the SLA for the Azure Database for MySQL service guarantees 99.99 percent uptime.  
The Azure Cosmos DB (Database) service SLA offers 99.99 percent uptime, which includes low-latency commitments of less than 10 milliseconds on DB read operations and less than 15 milliseconds on DB write operations.

## SLA downtime estimates


The following table lists the potential downtime (when services are unavailable) allowed for various SLA levels over different durations. These amounts are cumulative, meaning the duration of multiple different service outages would be combined:

| SLA percentage | Downtime per week | Downtime per month | Downtime per year |
| --- | --- | --- | --- |
| 99 |1.68 hours |7.2 hours |3.65 days |
| 99.9 |10.1 minutes |43.2 minutes |8.76 hours |
| 99.95 |5 minutes |21.6 minutes |4.38 hours |
| 99.99 |1.01 minutes |4.32 minutes |52.56 minutes |
| 99.999 |6 seconds |25.9 seconds |5.26 minutes |

> [!NOTE]
> The Azure product or service must be unavailable for a reason that is within Microsoft's area of responsibility as the cloud service provider. 

<div style="background:yellow;">
TODO: Add example of what does NOT apply, to note above.
</div>

## Service Credits

SLAs also describe how Microsoft will respond if an Azure product or service fails to perform to its governing SLA's specification. For example, customers may have a discount applied to their Azure bill, as compensation for an under-performing Azure product or service. 

The first column in the table below shows monthly uptime percentage SLA targets for one single Azure Virtual Machine. The second column shows the corresponding service credit amount you would receive (as a percentage of your monthly cost), if the *actual* uptime is less than the specified SLA target for that month.

| Monthly Uptime Percentage | Service Credit Percentage|
| --- | --- |
| < 99.9 |10 |
| < 99 |25 |
| < 95 |100 |

Now we have explored how Service Level Agreements are structured, lets take a look at some other factors that Tailwind Traders needs to consider, that might impact those SLA performance targets.