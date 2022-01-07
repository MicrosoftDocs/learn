Read the following case study and answer the questions to map a scenario to an HDInsight cluster configuration.

## Case study – AdventureWorks cycles 

AdventureWorks sells bicycles and bicycle parts directly to customers and distributors. The company currently has a single office in the Netherlands. They have been selling bicycles in the United States, Germany, and Spain through a chain of distributors and through online sales on its website. The fulfillment of delivery is done by local distribution centers. 

The company is planning to expand by establishing new offices because the sales growth in these countries has been increasing over the last three years. The locations are:

- Tokyo, Japan 
- Seattle, USA 
- Chicago, USA 
- Berlin, Germany 
- Barcelona, Spain 
- Paris, France 

AdventureWorks has been in a highly competitive market for the last 15 years. They want to become the most innovative bicycle company, providing current and future bicycle owners best in class technology and services. The Research and Development department of AdventureWorks has successfully conceived the next wave of innovative products. They are relying on Data Engineers, AI Engineers, and Data Scientists to assist with both the design and implementation of the solution. 

Given the increased level of sales and expansion at global scale, the existing data infrastructure won't meet the overall business requirements or the future growth that AdventureWorks aspires. The Chief Information and Technology Officers have expressed the desire to abandon existing on-premises systems and move to the cloud to meet the growth expected. This plan is supported by the CFO as there has been a request for replacement hardware as the existing infrastructure comes to its end of life. The CFO is aware the cloud could offer alternatives that are more cost efficient.

As a Senior Data Engineer, you will assist AdventureWorks in solution design and implementation. This will help them to meet business, functional and technical requirements they set forth for growth, expansion, and innovation strategies. You will execute this plan in a way that minimizes operational costs and can be monitored for effectiveness.

In a discovery workshop, you determine the following information:

### Data analysis

The business reporting is currently being provided by a single on-premises database that is configured as a data warehouse. It holds a database named AdventureWorksDW, which is used to provide historical reporting and descriptive analytics. In recent times, that server has been struggling to process the reporting data quickly, your team should ensure that access to the data is restricted.

AdventureWorks would also like to take their data analytics further and start to utilize predictive analytics capabilities. This activity is not currently undertaken. The organization understands that a recommendation or a text analytics engine could be built. They would like you to direct them on what would be the best technology and approach to take in implementing such a solution that is also resilient and performant.

### Social media analysis

In recent years, the marketing department at the organization has run a wide variety of twitter campaigns at various times of the year. They are keen to measure the impact of their work by tracking social media assets such as hashtags during those campaigns. They would like to have the capability of tracking any hashtag of any name.

### Connected bicycle 

AdventureWorks Bicycles can be equipped with an innovative built-in bicycle computer. This computer consists of automatic locking features of the bicycle, as well as operational status. Information captured by this bicycle computer includes:

- Bicycle model, serial number, and registered owner
- Bicycle location (latitude longitude)
- Current status (stationary, in motion)
- Current speed in kilometers per hours
- Bicycle Locked / Unlocked
- Bicycle parts and components information (on electrical bicycles)

First party and third party applications can have access the information of the bicycle computer that must be secure. This information can be used for the integration into mobile applications, real-time display of location, and bike ride sharing information. Furthermore, daily summary data can be saved to flat files. This data includes bicycle model, serial number, registered owner, a summary of the total miles cycled per day, and the average speed.

### Bicycle maintenance services 

Existing bicycle owners can opt in to getting notifications on when their bicycle needs repair, based on:

- Telemetry from electrical bicycle based on sensor data 
- Bicycle usage information coming from the built-in bicycle computers based on average mileage / wear and tear
- This predictive maintenance scenario is a service in which bike owners can opt in, offered as a paid service.

### Questions

Based on the following case study, answer the following questions

---