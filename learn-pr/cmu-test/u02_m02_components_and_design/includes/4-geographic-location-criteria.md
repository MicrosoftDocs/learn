<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u02_data_centers\_u02_m02_components_and_design\x-oli-workbook_page\_u02_m02_3_global_location.xml -->
##  Geographic Location Requirements
For a large multinational corporation, there is a good chance that it already has a number of servers at each of its branch offices and would likely build traditional data centers in the countries in which it is already established. The reason for having equipment closer to the users is for better application responsiveness, which (hopefully) yields higher productivity.

A company whose product is Web based would need to build multiple data centers around the world to provide better service to customers in a wide variety of geographic locations. A common example of this is Web search—Google, Microsoft, and Yahoo! all have large data centers at many sites scattered around the globe. This variety in location provides faster search results to the user, which is a competitive advantage (as long as accuracy is maintained).

A third category of companies that require large data centers are Web hosting providers. They offer server(s) to host the website for companies of various sizes. Small companies might need to have their site hosted in only one location to serve local customers. Large companies might have several different regional sites but would prefer to deal with one hosting company rather than a different one in each region.

An organization in any of the above categories would have similar goals when it comes to picking the location of a new data center. In order to satisfy the facility's needs, it is necessary to locate a data center where there are adequate electrical power suppliers. For the "green" conscious, one might look for an electricity supplier that uses hydroelectric, solar, wind, geothermal, or other renewable energy sources. Regardless of the source of the power, it is desirable to work with a utility company that is willing to negotiate bulk-purchasing agreements, which lock in a specific discounted price per kilowatt hour for several years.

In addition to power, if you want to take advantage of evaporative cooling techniques mentioned earlier in this unit, your data center should be located near an adequate water supply. There are also instances in which you can locate near a lake/reservoir that is naturally cold, use that water as your cold supply, and return it after tempering (lower the temperature by mixing again with cold water from the same source).

For a smaller scale data center, another factor to consider is the cost of real estate and taxes. For a large deployment, however, the cost of the IT and facilities equipment are much higher than the cost of land, and monthly energy costs far outweigh any taxes.

There are also basic logistics that are desirable to have available to support the data center and its life cycle. A supply chain is needed to procure the goods and services, not just servers but all equipment and building materials. There also should be adequate ports/rails/highways to deliver standard shipping containers (40' × 8' × 8'6"; or 12.19m × 2.43m x 2.59m) to your site. Small and medium sized data centers will typically buy servers from companies such as IBM, Dell, or HP, whereas big companies have custom servers, but none of these are manufactured on site and so have to be purchased and delivered. Containerized/modular solutions do more of the manufacturing off site so that installation is faster at the data center. Recycling of raw materials should occur at the end of the life span of the hardware or for failed components, such as hard drives, so recycling availability should also be considered.

##  Weather
Also mentioned in the previous module was economization, or mixing of colder outside air with the hot air expelled from the IT equipment. In Figure 2.16, you will notice different colored bands. In regions of yellow or orange, you could use outside cooling during the colder seasons, and in regions of green and blue, you could likely use outside cooling year round. Regions marked as red could still use outside cooling but for a few months of the year. For example, because of its cold average climate and renewable energy sources, Iceland has a growing data center industry.

![Figure 2.16: Global average temperature map (Wikipedia, 2014).](../media/temperature_map.png)
_Figure 2.16: Global average temperature map (Wikipedia, 2014)._

As you will see in the power usage effectiveness (PUE) section later in this module, the energy utilization will be higher during hot months and lower during cold months. This is due to the efficiency gains from "free cooling" (either using air economizers or naturally cold water.)

The average amount of annual rainfall might be a factor if you are considering using rainwater storage/filtration as a water source for cooling your data center. However, the number of sunny days per year in a particular region might convince you to try solar.

Part of a risk assessment for a particular location would include the frequency of natural disasters in the region, such as floods, hurricanes, tornadoes/cyclones, tsunamis, and earthquakes. As you can see in Figure 2.17, different regions have varying levels of susceptibility to a potentially damaging event.

![(a) Earthquake risk map.](../media/earthquake_risk_map.png)
_(a) Earthquake risk map._

![(b) Flood risk map.](../media/flood_risk_map.png)
_(b) Flood risk map._

![(c) Hurricane risk map.](../media/hurricane_risk_map.png)
_(c) Hurricane risk map._

![(d) Lightening risk map.](../media/lightening_risk_map.png)
_(d) Lightening risk map._

![(e) Tornado risk map.](../media/tornado_risk_map.png)
_(e) Tornado risk map._

![(f) Thunderstorm risk map.](../media/thunderstorm_risk_map.png)
_(f) Thunderstorm risk map._

![(g) Volcano risk map.](../media/volcano_risk_map.png)
_(g) Volcano risk map._

![(h) Wildfire risk map.](../media/wildfire_risk_map.png)
_(h) Wildfire risk map._

Figure 2.17: Natural disaster threat maps ([Global Datavault](http://www.globaldatavault.com/natural-disaster-threat-maps.htm), 2013).<!-- <link href="http://www.globaldatavault.com/natural-disaster-threat-maps.htm" >link</link> --> (Click on each figure for an enlarged view.)

As a cloud user, or cloud provider, it is beneficial to have two (or more) geographically distinct data centers for your services to mitigate risks of natural disaster, excluding large asteroid impacts, of course.

##  Connectivity
As broadband adoption among consumers continues to grow, the effectiveness of cloud computing will increase. You can find trending graphs and current broadband adoption at [Akamai](http://www.akamai.com/html/technology/dataviz5.html).

The Internet relies on fiber optics to send and receive data over long distances. Figure 2.18 shows the relationship between multiple tiers of the Internet, in which tier 1 providers own the actual fiber cables, the network equipment, and the buildings they are housed in; tier 2 providers own large networks as well and peer with (have connections to) other tier 2 providers but also have to lease some connections from tier 1 providers in order to reach the whole Internet; and tier 3 providers are only resellers, which provide connections to end users. A single corporate entity, such as Verizon in the United States, may provide services at all tiers.

![Figure 2.18: Internet connectivity (Wikipedia, 2014).](../media/Internet_connectivity.png)
_Figure 2.18: Internet connectivity (Wikipedia, 2014)._

In order to support a large amount of users, a cloud provider should choose a data center location that is in a city/region that has a tier 2 or tier 1 provider. This will also decrease the latency to global users due to fewer hops (each router is a hop) between the client and the server. A data center's requirement for uplink to the Internet ranges from a few megabits per second to several hundred gigabits per second, and that much bandwidth simply is not yet available everywhere.