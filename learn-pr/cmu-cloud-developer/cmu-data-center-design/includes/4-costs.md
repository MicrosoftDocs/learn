Organizations have to deal with capital expenses and operating expenses for their IT projects. For new companies with an anticipated need for many servers, or for existing companies that have outgrown their existing infrastructure, a decision must be made to build a new datacenter, expand existing facilities, or migrate some (or all) of their IT services to a cloud provider. With rising energy costs, companies with existing (but outdated) datacenters would also consider building a new datacenter or retrofitting the existing ones with new power/cooling. Many scenarios, such a retrofit, might cause unacceptable downtime, so companies would instead choose to go to a new location and migrate servers/services from the old location to a new datacenter. In any of the above scenarios, a detailed cost analysis would be helpful in making the decision (and likely required before any budgetary approvals).

Prices fluctuate often. The intent of this section is not to give you the tools to do an entire cost analysis on your own, but rather to help you understand the types of expenses that go into building a datacenter.

## Capital expenditure

Capital expenditure (CapEx) for datacenters includes upfront planning, cost of property and construction, facilities equipment (power, HVAC, safety, and security), and IT equipment (servers, network switches, initial network connectivity). These expenses usually occur only once.

**Upfront planning**: Upfront planning design costs account for a significant portion of CapEx. This typically includes feasibility and impact studies, architectural design, engineering design, project management costs, and contingency costs. A Forrester research<sup>[1][^1]</sup> study estimates these costs to range from 20% to 25% of the total cost for a typical datacenter.

**Property costs**: A principal expense incurred in building datacenters is the cost of property. This, of course, varies significantly depending on location. Organizations typically have the option of either constructing a building from scratch or repurposing an existing building to be a datacenter.

When an organization is building from scratch, many costs, such as the real estate transaction, consultant, brokerage, and building permits, apply in addition to the actual cost of building the datacenter "shell," which could include excavation, grading, roadways, utility connections, and physical security. Reed Construction Data has estimates for the United States that are typically between 200 to 300 dollars per square foot, depending on the type of building and labor.

Many organizations opt to repurpose existing buildings, particularly those that have been abandoned, such as factories or mills. Google's [Hamina datacenter](http://www.google.com/about/datacenters/locations/hamina/) in Finland was repurposed from an old paper mill. [Barcelona Supercomputing Center](https://www.bsc.es/discover-bsc/the-centre/history) is an example of an old chapel repurposed as a datacenter site.


Leasing a building or subleasing space in a building can also be done, shifting this capital expense to an operating expense.

**Facilities equipment**: Some heavy equipment is often installed during the construction phase. After the building shell is complete, datacenter-specific facilities can be built. The equipment is then procured and commissioned. We'll take a look at the equipment in a later module. The equipment includes cooling (CRACs, chillers, condensers, water tanks), electrical equipment (power distribution, generators, transformers, UPSs, automated transfer switch), and fire detection and suppression systems (FM-200).

Estimates for the cost of HVAC and electrical equipment are approximately 7,000 to 20,000 dollars per kilowatt of IT load.<sup>[1][^1]</sup> In addition, fire suppression systems costs can range from 20,000 to 60,000 dollars for a typical datacenter spanning several thousand square feet.

**IT equipment and connectivity**: Once the datacenter facility is ready, equipment can be moved in and installed. Typically, this involves purchasing rack-mountable servers and networking and rack power distribution equipment. In larger datacenter environments, it is becoming increasingly popular to roll out fully containerized servers with integrated power, cooling, and network management. IT equipment costs can vary widely depending on the size and configuration of the hardware.

In addition to IT equipment, the datacenter needs to have a dedicated network connection in order for it to be accessible to the organization that is using it. Network service providers typically charge an upfront average of 10,000 dollars per mile to install and commission fiber to a datacenter.<sup>[1][^1]</sup>

## Operating expenditure

Operating expenditure (periodically recurring) for datacenters typically includes electrical power, staffing, cooling/HVAC, internet uplink, maintenance, taxes, and/or leasing.

<!-- Revised introduction text for link to table7.4.cfm -->
One of the biggest operating expenses in running a datacenter is the power. It can account for approximately 70% to 80% of the overall cost of running a datacenter.<sup>[1][^1]</sup> Electrical utility charges to industrial sectors (which differ from residential pricing) can vary significantly from state to state or country/region to country/region. In the United States, the [Energy Information Administration (EIA)](http://www.eia.gov/electricity/data.cfm#sales), an entity within the US Department of Energy, publishes regular reports on power costs broken down by state and sector. The [International Energy Agency (IEA)](https://www.iea.org/data-and-statistics) publishes energy data for other countries/regions as well. It's important to note that the cost of power has been rising over the past few years<sup>[2][^2]</sup>, as shown in [this chart](http://www.eia.gov/electricity/annual/html/table7.4.cfm). Because power forms a large percentage of operating expenses and total cost of ownership (TCO), large datacenters tend to be placed in regions with cheaper sources of power, whenever possible.

**Staffing**: Even though datacenters can house thousands of servers, they are relatively efficient in terms of number of personnel per server. However, datacenters still need a number of operational staff, such as 24/7 security and an on-site engineering staff. In countries/regions in which labor is expensive, this cost will end up being the second-largest recurring expense after power. These costs can run into hundreds of thousands of dollars per year, depending on the location and staffing levels.

<!-- Revised introduction text for link to table7.4.cfm -->
**Cooling**: Cooling costs also amount to a significant portion of datacenter expenses. According to a study by the American Society of Heating, Refrigerating, and Air Conditioning Engineers (ASHRAE), datacenter cooling consumes 42% of the total power drawn by traditional, inefficient datacenters.<sup>[3][^3]</sup> Many organizations are now paying attention to new techniques to reduce the amount of power required to keep a datacenter cool. [ASHRAE](https://www.ashrae.org/) has also published thermal guidelines for datacenter designers to plan and correctly configure cooling systems to maximize efficiency.

**Connectivity**: In addition to upfront installation and commissioning costs, network connectivity is usually charged monthly or quarterly from a service provider. The fee is typically in the range of several hundred or thousand dollars per month, based on the bandwidth and reliability guarantees of the connection.<sup>[1][^1]</sup>

**Maintenance**: Purpose-built datacenters also incur significant maintenance overheads in order to keep the facility running smoothly and to minimize downtime. This cost could be 3% to 5% of the initial construction costs.<sup>[1][^1]</sup> In addition, facilities equipment may need periodic replacement or repair. For example, UPS batteries are replaced once in 5 years, on average. 

**Taxes and/or leasing**: Building permits are required for building new datacenter shells or significantly altering an existing building's structure. Organizations also need to pay some form of annual property tax on the property owned. This cost, like others, can vary considerably from region to region. Average taxes are estimated to be 70 dollars per square foot in the United States.<sup>[1][^1]</sup> If you are leasing a property, many of these taxes are included in the monthly price of your lease. 
<br>
***

### References

1. _Rachel Dines, et al. (2011). [Build or Buy? The Economics of Data Center Facilities Forrester Research - PDF](https://www.anixter.com/content/dam/Suppliers/Viavi%20Solutions/Data%20Centre%20Case%20Studies.pdf)_
2. _U.S. Energy Information Administration.  (May 7, 2014). [Annual Energy Outlook 2014](http://www.eia.gov/electricity/)_
3. _Barroso, Luiz André, and Hölzle, Urs.  (2009). [The Datacenter as a Computer: An Introduction to the Design of Warehouse-Scale Machines](https://dl.acm.org/doi/10.5555/2534500)_

[^1]: <https://www.anixter.com/content/dam/Suppliers/Viavi%20Solutions/Data%20Centre%20Case%20Studies.pdf> "Rachel Dines, et al. (2011). *Build or Buy? The Economics of Data Center Facilities Forrester Research* PDF"
[^2]: <http://www.eia.gov/electricity/> "U.S. Energy Information Administration. (May 7, 2014). *Annual Energy Outlook 2014*"
[^3]: <https://dl.acm.org/doi/10.5555/2534500> "Barroso, Luiz André, and Hölzle, Urs. (2009). *The Datacenter as a Computer: An Introduction to the Design of Warehouse-Scale Machines*"
