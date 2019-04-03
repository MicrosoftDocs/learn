<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u02_data_centers\_u02_m02_components_and_design\x-oli-workbook_page\_u02_m02_5_power_efficiency.xml -->
##  Server Utilization

As you recall from the introduction unit, multiple servers are virtualized and consolidated onto fewer physical hosts to increase utilization and decrease energy costs. This improvement is helpful, but the demand for IT-related services in organizations continues to grow, as does the number of Web-based startup companies, which have a higher proportional demand for IT equipment. 

> [!VIDEO https://youtube.com/embed/bkjdGO0jz3E]

_Video 2.4: Data center efficency._


To see why server utilization is important, let us discuss power consumption when a server is idle (the CPUs are not doing anything, but the HDDs are spinning, and RAM and I/O devices still consume power) versus when the server is at maximum load (when all CPUs are at 100% utilization).

To estimate the power consumption ( `P`) at a specific utilization ( `n`%) use the following formula:
<!-- TODO fix
<formula><m:math display="block" xmlns:m="m"><m:mrow><m:mi>P</m:mi><m:mi mathsize="small">n</m:mi><m:mtext fontfamily="Times New Roman" mathsize="small"></m:mtext><m:mo>=</m:mo><m:mo stretchy="false">(</m:mo><m:mi>P</m:mi><m:mi mathsize="small">max</m:mi><m:mtext fontfamily="Times New Roman" mathsize="small"></m:mtext><m:mo>minus</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>P</m:mi><m:mi mathsize="small">idle</m:mi><m:mtext fontfamily="Times New Roman" mathsize="small"></m:mtext><m:mo stretchy="false">)</m:mo><m:mo lspace="4px" rspace="4px">times</m:mo><m:mfrac><m:mi>n</m:mi><m:mn>100</m:mn></m:mfrac><m:mo lspace="4px" rspace="4px">+</m:mo><m:mi>P</m:mi><m:mi mathsize="small">idle</m:mi><m:mtext fontfamily="Times New Roman" mathsize="small"></m:mtext></m:mrow></m:math></formula>
-->


Through empirical measurements, this approximation is accurate to within ±5% across utilization rates.

If an organization wants to decrease its overall monthly operating expenses, it has to do so both inside the rack and outside the rack, and to minimize the latter, you must first understand power usage effectiveness (PUE).
##  Power Usage Effectiveness (PUE)

As we have read earlier, a data center draws a significant amount of power, from kilowatts to several megawatts. The cost of power is a significant element of the operating expenses of a data center and hence contributes to the total cost of ownership (TCO). As companies are offering more Web-based services, which are housed at a data center, the cost of power becomes an important element in the cost of offering services on the Web. Furthermore, some projections claim that data center related emissions will triple by 2020. These economic and environmental factors have accelerated the interest in measuring and improving the energy efficiency of data centers.

The power drawn by a data center is shared between the IT equipment and the support equipment, such as the power distribution and cooling facilities. Data center energy efficiency can be thought of as the ratio of the energy delivered to the IT equipment to the total energy delivered to the data center. Clear and standardized efficiency metrics are needed to help data centers to understand their energy efficiency, identify areas for improvement, and perform comparisons over time.

The [Green Grid](http://www.thegreengrid.org/) consortium has developed the PUE and its inverse, the data center infrastructure efficiency (DCIE). The PUE is simply the ratio of the total power entering the data center divided by the power used by the IT equipment. PUE measures how efficiently the power is delivered to the IT equipment in the data center.
<!-- TODO fix
<formula><m:math display="block" xmlns:m="m"><m:mrow><m:mtext fontfamily="Times New Roman">PUE </m:mtext><m:mo>=</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mfrac><m:mtext>total data center power</m:mtext><m:mtext>total IT equipment power</m:mtext></m:mfrac></m:mrow></m:math></formula>
-->


If a data center's PUE is 3.0, then the data center facilities (e.g., power distribution, cooling) utilizes 2 units of energy for every unit delivered to the IT equipment. The lower the PUE, the more efficient the data center facilities. An ideal PUE is 1.0, which would indicate 100% efficiency, meaning that all the power drawn by the data center was delivered to the IT equipment.

In 2007, the Lawrence Berkeley National Labs (LBNL) ran an energy study for 25 data centers (see Figure 2.19). The best PUE, 1.14, resulted in about 87% of the site energy reaching the IT equipment, while in the worst case (PUE 3.0), only 33% makes it to the IT equipment.
![Figure 2.19: PUE of 25 data centers studied by LBNL (Lawrence Berkeley National Labs, 2007).](../media/PUE_25_data_centers.png)

_Figure 2.19: PUE of 25 data centers studied by LBNL_ ([Lawrence Berkeley National Labs](http://hightech.lbl.gov/documents/DATA_CENTERS/GSAgovEnergyCard_03_09.pdf))


The PUE allows companies to identify areas for improvement, address these areas, and monitor the progress in PUE over time. Google publishes quarterly PUEs for their actual data centers, as shown in Figure 2.20. Because Google's data centers are mostly in the northern hemisphere, the average PUE typically rises in the summer because they require increased use of the cooling equipment.
![Figure 2.20: PUE data for all large-scale Google data centers.](../media/PUE_data_large-scale.png)

_Figure 2.20: PUE data for all large-scale Google data centers._


Google improves the efficiency of its data centers using five methods.<!-- <link href="http://www.google.com/about/datacenters/efficiency/external/" >link</link> changed to citation ~C Lallier --> First, they accurately measure and record the PUE as often as possible. Second, they design good air containment to limit the mixing of hot and cold air. Third, they increase the cold air temperatures because equipment manufacturers allow their equipment to run within aisles at higher temperatures. Fourth, they utilize free cooling whenever possible. This possibility is determined by the geographical location of their data centers and the number of hours per year that allow the use of cool ambient air, evaporating power, and large thermal reservoirs. Fifth, they minimize power distribution losses by eliminating several power conversion steps. The lowest recorded PUE to date at a Google data center is 1.08, which is around 92% efficiency.

PUE simply measures the efficient use of power. Understanding the energy contributors to PUE is important to improve data center design practices. However, PUE is not sufficient as the only measure because it does not account for the load on the IT equipment. If PUE is low, but the IT equipment is not doing useful work, then the data center is losing money. Some recent practices include utilizing a TCO metric that accounts for the cost of the server, which is the total cost of energy that it will consume while running a specific workload over its lifespan. Using this approach, data centers will utilize application-specific optimizations, which will lead to more effective use of the data center equipment.
##  PDU Branches (Optional Reading)

In an earlier module, you were introduced to a PDU, or power distribution unit. You also learned about inefficiencies related to multiple conversions. This section shows you the advantages of using three-phase power and some common pitfalls to avoid when choosing the size and number of PDUs. This section is optional reading as it goes into specific details concerning electrical engineering

There are several types of power distribution: rack level, row level, and room level. All of them have an input electrical feed and provide one or more branch circuits, with each branch protected by a circuit breaker (a safety device that will "trip" if there is an overload, stopping the flow of electricity). The difference with row-level PDUs is that they typically take a higher voltage and output to a lower voltage using a transformer (transformers generate heat, so you will also find cooling fans inside a row-level PDU).
![Figure 2.21: Row-level and rack-level PDUs.](../media/PDUs.png)

_Figure 2.21: Row-level and rack-level PDUs._


Three-phase power (often denoted with Greek letter phi [3Φ]) is how AC electricity is generated and transmitted, with each phase a sine wave that is 120 degrees apart. It is not common to have three-phase power in homes, but it is common in industrial buildings and a requirement in any modern data center. It is important to keep each phase as evenly loaded as possible. You should not plug all servers into one branch before going on to the next—stagger them instead. The important thing to know is that the total power that can be handled by a three-phase circuit is greater than that of a single phase (1Φ) for each copper wire (same thickness/gauge).

|Phase|1Φ|3Φ|
|--|--|--|
|Power Equation|<br><!-- TODO fix<br><m:math display="inline" xmlns:m="m"><m:mrow><m:mi>W</m:mi><m:mtext fontfamily="Times New Roman"></m:mtext><m:mo>=</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>V</m:mi><m:mtext fontfamily="Times New Roman"></m:mtext><m:mo lspace="2px" rspace="2px">times</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>I</m:mi></m:mrow></m:math><br>-->|<br><!-- TODO fix<br><m:math display="inline" xmlns:m="m"><m:mrow><m:mn>3</m:mn><m:mtext fontfamily="Times New Roman"></m:mtext><m:mo lspace="2px" rspace="4px">times</m:mo><m:mfrac><m:mrow><m:mi>V</m:mi><m:mi mathsize="small">line</m:mi><m:mtext fontfamily="Times New Roman" mathsize="small"></m:mtext><m:mo lspace="3px" rspace="3px">times</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>I</m:mi><m:mi mathsize="small">line</m:mi></m:mrow><m:msqrt><m:mn>3</m:mn></m:msqrt></m:mfrac></m:mrow></m:math><br>-->|
|Wires Needed|Hot, Neutral, Ground|Phase1, Phase2, Phase3, Neutral, Ground|
|Watts/Wire|1.0x|1.8x|


For example, given V = 120 volts and I = 15 amps, then single-phase power = 1800W per three wires; and given Vline = 208 volts and Iline = 15 amps, then three-phase power = 5410W per five wires. (Recall that it is only the current/amps that determines how thick the copper has to be.)

Knowing the maximum power of any branch is important for choosing the number and size of PDU(s) to power your IT equipment. U.S. electric code states that the line current should not exceed 80% of the rating of the breaker (or fuse).

|Label (Amps)|15|20|30|50|70|
|--|--|--|--|--|--|
|80% derated limit|12|16|24|40|56|


It is rare for a server to actually consume the number of watts that their power supply is rated. For example, a PSU is labeled as 975W, but the server might only consume 650W at maximum capacity. For this reason, it is useful to take power measurements of each new model of server at various loads (idle, 25%, 50%, 75%, 100%) before putting it into production.

When designing a redundant system, it is common to have multiple independent paths from the power source to the IT equipment. You can think of redundant power (and cooling) systems like hard drives in RAID. Recall that in a RAID1 mirror, you withstand a drive failing, but you also lose half your capacity, which is analogous to _2N_ redundancy—you cannot load a single component (e.g., UPS, generator, PDU) greater than 50% of its original capacity. While in RAID5, you still withstand a single drive failure, but you get higher utilization of individual drives, which is what _N+1_ redundancy is like for power and HVAC equipment. The remaining (working) units have to absorb the workload of the failed unit.

For example, you have a 100kW load and desire to have redundant UPS. In a 2N system, you have two UPS, each capable of powering 100kW, but their normal load would be 50kW each. If you use three UPS units instead, each could be smaller and capable of handling 50kW each but having a normal load of 33kW. In this case, the utilization is higher (66% instead of 50%), so the UPS would also run more efficiently.

Although blade chassis and some larger 4U/5U servers have N+1 power supplies, most servers and network equipment are designed with 2N redundant power supplies. For this reason, in a traditional data center, you would run two independent power feeds to each rack. This way, if you lose power in one feed, the other can take over. You must be cautious, however, because when one of the two feeds fail, the other one gets double the load. Incorrect assumptions often lead to overloading a branch circuit, which goes unnoticed in normal conditions. Then when there is a single failure, it has a cascading effect, overloading the remaining branches and tripping the breakers. This single failure leads to some or all servers in a rack losing power completely.

### References

1. _Google (). Efficiency: How Others Can Do It http://www.google.com/about/datacenters/efficiency/external/_