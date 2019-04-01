<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u02_data_centers\_u02_m02_components_and_design\x-oli-workbook_page\_u02_m02_6_redundancy_and_fault_tolerance.xml -->
##  Data Center Redundancy
The following video (Video 2.5) covers some important aspects of data center redundancy:

> [!VIDEO https://youtube.com/embed/Vh6RfwiRxNY]

##  Data Center Tier Classifications
Data centers can be classified based on reliability. In order to understand the four different tiers, as specified in [TIA-942](http://www.tiaonline.org/standards/) standard, you must first know what is meant by the word _reliable_. Reliability is most frequently measured in uptime, or availability. A service that is 100% reliable is extremely difficult to guarantee, and, therefore, no companies will make that claim in their service-level agreement (SLA) to a customer. But if they did, it would be available to users every second of every year.

| _Tier_| _Name_| _Availability (%)_| _Downtime/Year_|
|--|--|--|--|
|1|Basic|99.671|28 hr, 49.37 min|
|2|Redundant components|99.741|22 hr, 41.3 min|
|3|Concurrently maintainable|99.982|1 hr, 34.5 min|
|4|Fault tolerant|99.995|26.3 min|

Tier 1 has non-redundant components, such as power, cooling, and network connections, which can lead to downtime for maintenance in addition to single points of failure (SPOFs) (service is disrupted if a single part of the overall system has a problem). Tier 2 still has a single path for power and cooling but adds redundancy, such as UPS and a generator. Tier 3 adds multiple paths for power (multiple UPS and PDUs from the source to the rack) and cooling (e.g., several CRACs feeding raised floors). Tier 3 allows for no interruptions from planned maintenance. Tier 4 is similar to tier 3, but all paths must be redundant and can continue operations at full capacity with at least one unplanned outage (e.g., losing main power or network provider, UPS failure, AC outage).

Even a tier 4 data center could incur downtime due to multiple simultaneous outages, as occurred for Amazon <!-- <link href="http://gigaom.com/2012/06/29/some-of-amazon-web-services-are-down-again/"> (added citation ~C Lallier) -->during a large thunderstorm in Virginia.

Percentage of availability in year =Total time service is availableTotal time in a yearThe percentage of availability can be measured in hours, minutes, or seconds. Downtime is calculated as:

Downtime=1minusavailabilityinayeartimestotaltimeinayearFor example, the calculation for the downtime that a tier 4 data center should achieve is as follows:

1minus0.99995times60 min times24 hr times365 days =26.28 min