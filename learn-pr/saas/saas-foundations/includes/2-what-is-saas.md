Software as a Service (SaaS) is one of the most popular forms of cloud computing, and is used daily by consumers and businesses. SaaS allows organizations to quickly get up and running with apps at minimal upfront cost.

SaaS is a complete software solution that you purchase on a pay-as-you-go basis from a service provider. You rent the use of an app for your organization, and your users connect to the app over the internet, usually with a web browser or mobile app. All the underlying infrastructure, middleware, app software, and app data are in the service provider's datacenter.

The service provider manages the hardware and software, and with the appropriate service agreement, ensures the availability and the security of the app and your data. The idea of success behind the SaaS model is embodied by the term *economies of scale*, also called *subtractive manufacturing*.

This idea isn't new, and means that the more you produce, the higher margins you can achieve. This idea works with software too, as long as you reuse infrastructure and you don't produce customized software for each customer.

![This graph illustrates declining price per unit based on the amount of units produced.](../media/economies-of-scale.png) 


In some cases, dedicated or isolated SaaS service tiers do have their own infrastructure. For example, the Microsoft special offer called Azure Government can be sold only to the government, and because of government security standards and requirements, the infrastructure is fully isolated from the Azure public cloud.

## SaaS business models

There are two high-level business models for SaaS companies:

- Business–to-Business (B2B) companies provides software and services to other businesses.
- Business-to-Consumer (B2C) companies sell and operate software directly to individual consumers.

The main difference is the audience for products. A company might have a product that suits both business and individual consumers, but the audience still has the most direct impact on the company's implemented solution.

Some other differences between B2B and B2C include:

- Pricing models.
- Sales processes.
- Customer service or account management.

Both B2B and B2C models can provide your company with sales and revenue, but you should create a strategy that suits your company best. It's possible to serve both B2B and B2C customers. For example, there are different models of Microsoft Azure subscriptions tailored for enterprise-size customers (Enterprise Agreements) or individual consumers (Pay-As-You-Go). However, when starting with a new solution, it's a good idea to focus on one customer segment to begin with.

As you work on defining the business model for your SaaS solution, you need to identify the market you are targeting. You can then gather more insights about your customers and their problems, so you can define clearer requirements for the tech team that builds your solution.

![Illustration of target market segment definition, including buying behavior, company size and industry, technical requirements, complexity, and geography.](../media/target.png)

## Contoso scenario

This example considers a fictitious UK company, Contoso, that wants to develop a *subscription-based service to generate and improve website designs*. Contoso created an AI model that can generate user interfaces for websites, track the performance of the design over time, and suggest improvements.

The technical capability of this service won't be much different for private users or large corporations, but from a business perspective it makes sense to focus on only one segment at a time. Marketing and business development efforts will be different for individual consumers and business segments, and might bring different technical requirements for the solution itself.

Contoso decided to focus initially on the B2B model, in particular small companies who can't afford their own in-house designers. Contoso found through market and user research that it's mostly lawyers who are willing to pay for these services, where it's important to have attractive design that isn't too complex so AI can provide high-quality service.

The identified market segment looks something like this:

#### Buying behaviors

- Customers search for service online and purchase online.
- Requires free trial for users to try out the design and decide if it's suitable.

#### Company size, industry

- Small size companies.
- Legal industry.

#### Technical requirements

Requirements are simplified for the sake of the example, but here are some ideas:

- Need to be able to collect website usage data and allow analyzing this data to improve the design of the website.
- Due to the collection of sensitive data, have to comply with several regulations, such as UK GDPR.
- Must provide capability for customers to book appointments with lawyers.

#### Complexity

- The AI model was trained on a set of simple landing pages, and can well handle website designs that aren't too complex and are mostly informational or used for booking time slots.
- Complexity of customers' business should be low.

#### Geography 

- Initially, Contoso is focusing on the UK region due to its origins, preferred language, and financial capability of companies providing legal services within the UK.
- In future, after Contoso establishes a stable business within UK region, they'll start going into other markets.

  Each geographical region will bring more challenges in terms of technical delivery of the service as well as overall market strategies and activities. If Contoso decides their next market is Europe, they'll have to create a strategy for marketing the product in countries/regions where English isn't the default language, and account for specifics of the local legal industry.

With a clear understanding of the requirements for the service and which customers to focus on, Contoso understands why SaaS is the preferred model instead of just selling AI-generated designs to customers.
