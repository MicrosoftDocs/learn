<!-- TODO: Edit or remove this sentence. It doesn't set the stage for this unit very well -->

<!-- AJM: Done. I haven't removed it because I'm sticking to this guidance (it's the "Topic sentence"): https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-learning-unit-introduction-format -->

If you have a set of microservices, you may want to assemble them into a single, manageable product, such as a web API. The Azure API Management service can help you to do that.

<!-- TODO: Again, I believe we already have our online store microservices as a set of Function Apps. What we're teaching in this module is how to use APIM to expose the functionality for partners to consume. Write the intro from that perspective. -->

<!-- AJM: Fixed -->

In your online store, you have implemented each part of the application as a microservice - one for the product details, one for order placement, and so on. A separate team manages each microservice and each team uses continuous development and delivery to update and deploy their code on a regular basis. You want to find a way to assemble these microservices into a single product and then manage that product centrally.

<!-- TODO: To what does "here" refer to? We don't learn how to do what you claim in this unit. There is nothing procedural here. We need to to briefly introduce the key technologies and then explain the pattern used to produce an API. Currently, this is just a summary of technology we're talking about in the module and doesn't relate to the title of the unit which is "Create a new API in API Management from a Function App" -->

<!-- AJM: Hope that's better? -->

Here, you will learn how Azure API Management can take a role in a serverless architecture, by building complete APIs from individual microservices.

## Serverless architecture and microservices

In recent times, a new approach to the architecture of distributed applications has become more popular: microservices. When you build an application as a collection of microservices, you create many different small services. Each service has a defined domain of responsibility, and is developed, deployed, and scaled independently. This modular architecture results in an application that is easier to understand, improve, and test. It also makes continuous delivery easier because, when you deploy a microservice, you change only a small part of the whole application. 


<!-- TODO: This explanation of serverless needs work. Building microservices in a serverless environment means that the developers of those services don't concern themselves with infra and the services themselves only cost when used. -->

<!-- AJM: Hope that's better? -->

Another complimentary trend in distributed software development is serverless architecture. In this approach, a host organization publishes a set of services that developers can use to run their code. The developers do not have to concern themselves with the supporting hardware, operating systems, underlying software, and other infrastructure. Instead the code is run in stateless computing resources that are triggered by requests. Costs are only incurred when the services execute so you don't pay much for services that are rarely used. 

## Azure Functions
<!-- TODO: Given that you state that a prerequisite of this module is basic knowledge of Azure Functions, we can perhaps trim this section down a bit. -->

<!-- AJM: Done -->

Azure Functions is a service that enables serverless architectures in Azure. You can write functions, without worrying about the supporting infrastructure, in many different languages, including C#, F#, Node.js, Java, and PHP. You can also use libraries from NuGet and the Node Package Manager (NPM) and authenticate users with the OAuth standard from providers such as Active Directory, Facebook, Google, and Microsoft Account.

When you write a function, you choose a template to use, depending on how you want to trigger your code. For example, if you want to execute the function in response to an HTTP request, use the **HTTPTrigger** template. You can use other templates to execute when there are new messages in a queue, new Binary Large Objects (Blobs) in an Azure Storage account, or on a predefined schedule.

When you use Azure Functions, you are charged only for the time that your code runs. 

## Azure API Management

Azure API Management (APIM) is a fully managed cloud service that you can use to publish, secure, transform, maintain, and monitor APIs. It helps organizations publish APIs to external, partner, and internal developers to unlock the potential of their data and services. API Management handles all the tasks involved in mediating API calls, including request authentication and authorization, rate limit and quota enforcement, request and response transformation, logging and tracing, and API version management. APIM enables you to create and manage modern API gateways for existing backend services no matter where they are hosted.

Because you can publish Azure Functions through API Management, you can use them to implement a microservices architecture: Each function implements a microservice. By adding many functions to a single API Management product, you can build those microservices into an integrated distributed application. Once the application is built, you have many facilities that you can use to administer it. For example, you can use API Management policies to implement caching or ensure security requirements. In this module, you will see how to assemble functions in this way.

### APIM Consumption Tier
<!-- TODO: Do you mean the consumption tier of Azure Functions or APIM? I'm not sure why this gets its own section, as if it's a peer technology of everything else -->

<!-- AJM: Fixed. This the APIM consumption tier, which I've made clear, and it's now a H3 section. -->

When you choose a usage plan for API Management, you can choose the consumption tier, because it's especially suited to microservice-based architectures and event-driven systems. For example, it would be a great choice for our online store web API.

This consumption tier is designed and implemented around serverless principles, will allow more customers to enjoy the benefits of API Management, and will become a more organic fit for the emerging breed of applications built using serverless technologies.

The consumption tier uses the same underlying service components as the previous tiers but employs an entirely different architecture based on shared, dynamically allocated resources. It aligns perfectly with serverless computing models. There is no infrastructure to manage, no idle capacity, high-availability, automatic scaling, and usage-based pricing, all of which make it an especially good choice for solutions that involve exposing serverless resources as APIs.

<!-- TODO: This unit falls of a cliff. We need to hook it into what we've learned and what we are going to do next. Perhaps consider outlining the basic steps to expose functionality from a function app as an API and then mention we'll practice that next? -->

<!-- AJM: According to this guidance, learning units should not include a summary: https://review.docs.microsoft.com/en-gb/learn-docs/docs/id-guidance-structure-learning-content?branch=master#rule-use-an-approved-sequence-for-a-learning-content-unit

I think it's OK to say what we'll do next, so I've added this next sentence: -->

In the next unit, we'll create an API Management instance and add a function to it.