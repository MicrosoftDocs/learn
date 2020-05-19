In this section, we'll take a closer look at redundancy and fault tolerance in datacenter design.

## Datacenter redundancy

The following video covers some important aspects of datacenter redundancy:
<br>
> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4pFk7]

## Datacenter tier classifications

Datacenters can be classified based on reliability. In order to understand the four different tiers, as specified in the [TIA-942](http://www.tiaonline.org/standards/) standard, you must first know what is meant by the word _reliable_. Reliability is most frequently measured in uptime, or availability. A service that is 100% reliable is extremely difficult to guarantee, and, therefore, no companies will make that claim in their service-level agreement (SLA) to a customer. But if they did, it would be available to users every second of every year.

| Tier | Name | Availability (%) | Downtime per year |
|--|--|--|--|
| 1 | Basic | 99.671 | 28 hr, 49.37 min |
| 2 | Redundant components | 99.741 |22 hr, 41.3 min |
| 3 | Concurrently maintainable | 99.982 |1 hr, 34.5 min |
| 4 | Fault tolerant | 99.995 | 26.3 min |


Tier 1 has non-redundant components, such as power, cooling, and network connections, which can lead to downtime for maintenance in addition to single points of failure (SPOFs). (Service is disrupted if a single part of the overall system has a problem.) Tier 2 still has a single path for power and cooling but adds redundancy, such as a UPS and a generator. Tier 3 adds multiple paths for power (multiple UPSs and PDUs from the source to the rack) and cooling (for example, several CRACs feeding raised floors). Tier 3 allows for no interruptions from planned maintenance. Tier 4 is similar to tier 3, but all paths must be redundant and can continue operations at full capacity with at least one unplanned outage (for example, losing main power or network provider, UPS failure, AC outage).

Even a tier-4 datacenter could incur downtime due to multiple simultaneous outages.

$$ Percentage\ of\ availability\ in\ year = \frac{total\ time\ service\ is\ available}{total\ time\ in\ a\ year} $$

The percentage of availability can be measured in hours, minutes, or seconds. Downtime is calculated as:

$$ Downtime = \left(1 - availability\ in\ a\ year\right) \times total\ time\ in\ a\ year $$

For example, the calculation for the downtime that a tier-4 datacenter should achieve is as follows:

$$ 1 - 0.99995 \times 60\ min \times 24\ hr \times 365\ days = 26.28\ min $$
<br>
***
