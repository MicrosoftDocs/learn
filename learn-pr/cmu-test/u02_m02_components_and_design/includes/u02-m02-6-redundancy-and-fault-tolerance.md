<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u02_data_centers\_u02_m02_components_and_design\x-oli-workbook_page\_u02_m02_6_redundancy_and_fault_tolerance.xml -->
##  Data Center Redundancy

The following video (Video 2.5) covers some important aspects of data center redundancy:

> [!VIDEO https://youtube.com/embed/Vh6RfwiRxNY]

_Video 2.5: Data center redundancy._

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
<!-- TODO fix
<formula><m:math display="block" xmlns:m="m"><m:mrow><m:mtext fontfamily="Times New Roman">Percentage of availability in
								year </m:mtext><m:mo>=</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mfrac><m:mtext>Total time service is available</m:mtext><m:mtext>Total time in a year</m:mtext></m:mfrac></m:mrow></m:math></formula>
-->


The percentage of availability can be measured in hours, minutes, or seconds. Downtime is calculated as:
<!-- TODO fix
<formula><m:math display="block" xmlns:m="m"><m:mrow><m:mi>Downtime</m:mi><m:mtext fontfamily="Times New Roman"></m:mtext><m:mo>=</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mfenced open="(" close=")"><m:mrow><m:mn>1</m:mn><m:mtext fontfamily="Times New Roman"></m:mtext><m:mo>minus</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>availability</m:mi><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>in</m:mi><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>a</m:mi><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>year</m:mi></m:mrow></m:mfenced><m:mo lspace="2px" rspace="4px">times</m:mo><m:mi>total</m:mi><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>time</m:mi><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>in</m:mi><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>a</m:mi><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>year</m:mi></m:mrow></m:math></formula>
-->


For example, the calculation for the downtime that a tier 4 data center should achieve is as follows:
<!-- TODO fix
<formula><m:math display="block" xmlns:m="m"><m:mrow><m:mn>1</m:mn><m:mo lspace="4px" rspace="4px">minus</m:mo><m:mn>0</m:mn><m:mo>.</m:mo><m:mn>99995</m:mn><m:mtext fontfamily="Times New Roman"></m:mtext><m:mo lspace="2px" rspace="4px">times</m:mo><m:mn>60</m:mn><m:mtext fontfamily="Times New Roman"> min </m:mtext><m:mo lspace="2px" rspace="2px">times</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mn>24</m:mn><m:mtext fontfamily="Times New Roman"> hr </m:mtext><m:mo lspace="2px" rspace="4px">times</m:mo><m:mn>365</m:mn><m:mtext fontfamily="Times New Roman"> days </m:mtext><m:mo fontfamily="Times New Roman">=</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mn>26</m:mn><m:mo>.</m:mo><m:mn>28</m:mn><m:mtext fontfamily="Times New Roman"> min</m:mtext></m:mrow></m:math></formula>
-->


### References

1. _Malik, Om.  (2012). Severe Storms Cause Amazon Web Services Outage http://gigaom.com/2012/06/29/some-of-amazon-web-services-are-down-again/_