---
metadata:
  title: 
  description: This unit introduces Azure Digital Twins
  ms.date: 11/4/2020
  author: raniabayoumy
  ms.author: bamut
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Introduction
durationInMinutes: 2
---

[![Graphical representation of a complete Digital Twins business environment](../media/adt-business-env.png)](../media/adt-business-env.png#lightbox)

As companies navigate their business transformations, new use cases are unlocked.

The need to model the whole enterprise is becoming more and more evident. Azure Digital Twins allows companies to create comprehensive models of their complete business, inclusive of the processes, people and products. This gives them a true end to end view of their enterprise.

Think of a customer that is able to model not only their factories, but also their suppliers and resellers, this would allow them to further automate their operations: For example, they could capture the signal from their users’ experience or in-store demand and tie them in real time to the production line to have visibility of the production capacity and capability to meet the demand. They could even take it one step further by closing the loop with supplier of the raw materials that is required to meet the demand in the specific timeline. This also allows better visibility of the product and their traceability.

On the other hand, Azure Digital twins is bridging the gap between the inception and engineering of any products and its operations. With digital twins and simulations, customers can do what-if analysis on their products, testing situations before they even occur. For example, before ordering a whole new part of an expensive asset, customers could simulate the impact of a change in the configuration or a repair. Coupled with AI, this gets us to a true self-healing assets and advanced root cause analysis.

With Azure Digital Twins, customers are empowered to gain insights that drive better products, optimization of operations, cost reduction, and breakthrough customer experiences, across entire environments of all types such as buildings, factories, farms, energy networks, railways, stadiums, cities, etc. with inputs from IoT devices or any business system.

Many industries can benefit by innovating with IoT. Examples of industries includes:

- Manufacturing
- Energy, oil & gas and natural resources
- Retail
- Spaces
- Transportation and logistics

| Industry                                                                   | Segments | Use Cases |
|----------------------------------------------------------------------------|----------|-----------|
| Manufacturing                                                              | <ul><li>Discrete Manufacturing</li><li>Process Manufacturing</li><li>Connected Products</li></ul>            | <ul><li>Autonomic Operations</li><li>Root-cause analysis: Identify root cause of failures by tracing issues through the topology</li><li>What if analysis, simulations<ul><li>Simulate optimization scenarios, spot bottlenecks in the production and dynamically adjust operations to meet output</li><li>Physics Driven Product Simulation Modeling: Digital verification & validation for product R&D; prototyping</li><li>Propose new factory design and design changes to existing lines to unlock additional capacity -  Commissioning and efficient operation of a production line via simulation</li><li>Model-Predictive equipment maintenance via simulations</li><li>Advanced Digital Simulation</li></ul></li><li>Self-healing Assets and Augmented Maintenance</li><li>Support the real time factory operations to increase capacity and throughput</li><li>Respond dynamically to real time changes in supply and demand</li><li>Develop and execute optimized planning strategies</li><li>Monitor and control of factory operations</li><li>Digital twins of manufactured goods: Lifetime tracking from ingredients/parts to product usage monitoring. Examples:<ul><li>What machines / product lines was a product or part processed on?</li><li>Where was it stored?</li><li>Who delivered it?</li><li>Correlations between customer satisfaction and production line / delivery / storage?</li></ul></li></ul> |
| Energy                                                                     | <ul><li>Energy</li><li>Mining & Natural Resources</li><li>Utilities</li><li>Oil & Gas</li></ul>                      | <ul><li>Environmental Quality and Management</li><li>Intelligent and Predictive Grid Management</li><li>Digital Grid Simulation</li><li>Self-healing Assets and Augmented Maintenance</li><li>Recipe/Fuel Blending process optimization with simulation</li><li>Cloud Historian: Industrial decision making via data democratization.</li><li>Energy Output Optimization (wind turbines, etc.)</li><li>**Complex “living” asset model** & traceability and health optimization</li><li>Differentiate renewable energy assets through reduced maintenance & operations costs, and new forecasting & optimization capabilities</li><li>Minimize risks (fire hazards, environmental hazards), and manage warranties costs via simulation for Power Generation, Distribution, Microgrids, Renewables Grid Assets (Transformers, Substations)</li><li>Carbon Twins</li></ul> |
| Retail                                                                     | <ul><li>Retail</li><li>Consumer Packaged Goods</li><li>Supply Chain</li><li>Agriculture</li></ul>            | <ul><li>Inventory Intelligence Across the Value Chain</li><li>Cross-industry Data Pools and Systems of Intelligence</li><li>Autonomous Retail Operations</li><li>**Digital passport** of physical products, being stamped at every stage by stakeholders, from sourcing, manufacturing, consumption to disposal. Decipher following by looking at digital twins:</li><ul><li>What discounts have been applied?</li><li>What batch has been recalled?</li><li>What products on certain instances have been added?</li><li>Which supply chains the products have moved through?</li><li>Where are they located now?</li><li>When was the last packaging updated?</li></ul><li>**E2E Supply  Chain Twins:**</li><ul><li>Sustainability</li><li>Logistics Operations</li><li>Distribution centers</li><li>AI-enabled load and shipment planning</li><li>New process simulation</li><li>Labor productivity, inventory movement and the effectiveness of material handling</li></ul><li>Inventory optimization </li><li>**Model** actual **retail stores** to guide shoppers right to items on the shelf, create models per individual shopper to predict shopping behavior</li><li>Smart warehousing</li><li>Supplier Network Management</li><li>Sustainability, “farm to table” scenarios for creating a digital certificate for goods</li><li>Agriculture Supply Chain Management</li><li>Monitor and control of farming operations</li><li>Livestock health supervision</li></ul> |
| Spaces                                                                      | <ul><li>Architecture</li><li>Engineering</li><li>Construction</li><li>Space Management</li><li>Smart Buildings</li><li>Smart Cities</li></ul>                                                                           | <ul><li>Critical Infrastructure Management and Security/Threat Detection</li><li>Building Management & Operations</li><li>Energy Efficient Buildings</li><li>Occupant Experience & Productivity</li><li>Simulate, visualize, and optimize infrastructure planning</li><li>Critical infrastructure performance optimization</li><li>Manage possible emergencies like major fires, flooding, rainwater pooling or traffic</li><li>Differentiate Real Estate through improved overall maintenance & operations costs and the enablement of new digital experiences</li><li>Energy Management & Building Operations</li><li>Space Management & Optimization</li><li>Occupant Experience & Productivity</li><li>Space Health Management & Air Quality</li><li>Waste Management</li><li>Monitor and control of building operations</li><li>Identify root cause of failures by tracing issues through the topology</li><li>What-if scenario analysis for planning</li></ul> |

## Costumer Examples

[![GE Aviation Digital Group example of using Azure Digital Twins](../media/adt-ge-aviation-example.png)](../media/adt-ge-aviation-example.png#lightbox)

GE Aviation is using Azure Digital Twins to combine data from two disparate systems for creating a living replica of an aircraft. One system keeps track of the performance of an aircraft when it’s in the air. The other system keeps track of everything that happens to an aircraft once it lands on the ground. Currently it’s a very manual process to connect the data from these systems for auditing and tracking purposes.

With the new system in place, GE Aviation will have a living database that tracks the performance of an airplane.

Moving beyond tracking the performance of an aircraft in its current configuration, GE Aviation is using Azure Digital Twins to model and maintain a record of each component and part of the aircraft. They will be able to see previous aircrafts a part was on, the performance of the part on each  aircraft, the maintenance of the part on the previous aircrafts and the performance of the part on the current aircraft.

This new insight into the historical performance of the components of an aircraft will help them identify potential issues, diagnose current issues, and ultimately decrease the cost of maintaining the aircraft.

[![Telstra Purple example of using Azure Digital Twins](../media/adt-telstra-purple-example.png)](../media/adt-telstra-purple-example.png#lightbox)
