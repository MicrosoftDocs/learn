# Title

CAF Innovate: use Azure to innovate your applications and give a better experience to your customers

## Role(s)

- auditor
- business analyst
- business owner
- functional consultant
- solution architect
- student
- technology manager

## Level

- Intermediate

## Product(s)

- Cloud Adoption Framework
- Azure Kubernetes Services
- Azure Machine Learning Services

## Prerequisites

- Foundational understanding of cloud adoption 
- Understanding of your organization's products, markets and customers

## Summary

Innovation is a complex topic that encompasses many disciplines. The agility of public cloud allows to quicker innovation cycles and quicker hypothesis verification. Learn how to use Azure cloud technologies to sustain your organization's innovation requirements.

## Learning objectives

1. Understand the innovation cycle
1. Map Azure services to the different phases of the innovation cycle
1. Correlate technologies to business outcomes of innovation

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Taiwind Trader | Continue the story from previous CAF modules | Knowledge check |  | Yes |
| Innovation lifecycle | Understand the innovation lifecycle | Knowledge check | Innovation | Yes |
| Build | Azure technologies that help in the build process | Knowledge check | Build | Yes |
| Infuse your apps with AI | Azure technologies to improve customer experience with AI |  Knowledge check | Building AI features | Yes |
| Measure | Azure technologies that help in the measure process | Knowledge check | Measure | Yes |
| Learn | Azure technologies that help in the learn process | Knowledge check |  | Yes |
| Summary | Recap, links to other modules |  | Continued Learning | Yes |

## Outline the units

1. **Customer Story**

    Tailwind Traders is now facing competitive pressure for its products from startups that have entered the online retail market. Preliminary customer feedback indicates that these new entities offer a much better online experience than Tailwind Traders, and that the online market growth is substantially higher than the brick and mortar business. As a consequence, Tailwind Traders has reprioritized innovation efforts to reshape its digital presence and e-commerce platforms.
    
    One obstacle is the large efforts that the existing applications require to introduce modifications, as well as relatively frequent application outages when changes were deployed. Hence, the change rate has traditionally been quite slow in Tailwind Traders applications. However, the new competitive threats in the e-commerce sector demand a much higher innovation speed, and at the same time guarantee as much uptime as possible.
    
    After migrating the on-premises applications to Azure, Tailwind Traders is aiming at rearchitect them to achieve the required innovation rate that will allow for the company to survive in the new competitive ecosystem.
    
1. **Innovation Lifecycle**

    This content will help the learner to understand the Innovation Lifecycle:

    - Lifecycle
        - Multiple steps, each step should be as short as possible
        - Circular, the information learnt should be leveraged to formulate new hypothesis and trigger new build cycles
    - Build
        - Definition of the hypothesis concept, relationship to business value
        - Tailwind Traders example: introduce Paypal as payment platform in the e-commerce application
    - Measure
        - Get information to validate or negate the hypothesis formulated in the build step
        - Information sources examples
        - Tailwind Traders example: how many users leverage the new payment option
    - Learn
        - If hypothesis is confirmed, continue exploring further options in the same direction
        - If hypothesis is rejected, formulate alternative hypothesis that potentially come up with more business value

1. **Build**

    This content will help the learner to understand the Azure technologies involved in the build process:

    - DevOps
        - Shortening the development and deployment cycles
        - Quicker development cycles does not mean lower application stability
        - Azure DevOps fulfills these promises
    - Monolithic and Microservices architectures
        - Microservices architectures are modular, and allow to innovate of specific parts of the application without affecting other components
        - Example: impact when introducing a new payment method in Tailwind Traders e-commerce application
    - Containers
        - Technology that allows to deploy immutable application components, and allows to test each of the components independently from each other and the underlying platform
        - Azure offers multiple technologies to deploy containerized workloads. For example:
            - Azure Web Applications
            - Azure Container Instances
            - Azure Batch
            - Azure Kubernetes Services
    - Kubernetes
        - Defined as "container orchestration" technology, it allows to deploy a complex ecosystem of container-based microservices application on an elastic platform that can accomodate to changing customer demands.
        - Some attributes of Kubernetes:
            - Self healing
            - Cloud agnostic
            - Linux and Windows workloads
        - Azure Kubernetes Services is a managed Kubernetes cluster that simplifies the management of Kubernetes infrastructure.
        - Azure Red Hat OpenShift is a managed OpenShift cluster running in Azure. OpenShift is an opinionated Kubernetes distribution from Red Hat.
        - With Azure Arc for Kubernetes customers have a single pane of glass to manage Kubernetes clusters running on premises, in Azure or other public clouds.

    **Knowledge check**

    - How do containerized applications help in the innovation lifecycle?
        - Because they help to shorten the deployment cycle (correct)
        - Because they are a cool technology
        - Because they are based on Linux
    - Why are microservices architectures easier to innovate than application monoliths?
        - Because they are modular, so changes can be introduced with lower disruption risk (correct)
        - Because they run on Kubernetes
        - Because they are cloud agnostic
    - Why are Devops processes and tools critical for business innovation?
        - Because they shorten the development cycle while not compromising application stability (correct)
        - Because they are based on new tools
        - Because they enforce new processes
    - What should drive the development of new features in an application?
        - Hypothesis on how to increase business value (correct)
        - Yearly meetings with a closed customer group
        - The opinion of the CIO

1. **Infuse your applications with Artificial Intelligence**

    When evaluating which application features are going to enhance the customer experience and thus increase business value, Artificial Intelligence (AI) is a great asset to improve the interaction with customers and partners:

    - Azure offer different services around Artificial Intelligence:
        - Azure Cognitive Services are pre-built models that do not require machine learning expertise to introduce AI functionality to an application
        - Azure Machine Learning Services facilitate the process of creating custom models, deploying those models to production, and manage different versions of all deployed models across the organization
        - Azure Cognitive Search powers the introduction of knowledge mining and flexible search engines into applications with little effort
        - Azure Bot Services can be used to extend the user interaction, for example by including chat capabilities in web sites
    - For example, if the hypothesis "A recommendation engine would increase cross sales" is formulated, the Azure Cognitive Service Personalizer could be used to enrich the application without the need for data science expertise
    - If the hypothesis were confirmed, the functionality could be enriched with Azure Machine Learning Services (example in (Build a Real-time Recommendation API on Azure)[https://docs.microsoft.com/azure/architecture/reference-architectures/ai/real-time-recommendation])
    - Tailwind Traders is planning to introduce a more flexible, faceted product search engine in their ecommerce platform, as well as a chat-based support agent for customers that have questions around products

    **Knowledge check**

    - What is a requirement to introduce Artificial Intelligence functionality to an application?
        - Identify which functionality might improve customer experience (correct)
        - Hire at least five data scientists
        - Train staff in neural network theory
    - What is one of the main business values of Azure Cognitive Services?
        - Since they are pre-built models, they can be used by applications without the need for machine learning expertise (correct)
        - Azure Cognitive Services cover the whole range of AI needs for all applications
        - Azure Cognitive Services include the creation of models based on Convolutional Neural Networks
    - What Azure service would Tailwind Traders use to incorporate advanced product search capabilities into their application?
        - Azure Cognitive Search (correct)
        - Azure Kubernetes Service
        - Azure Container Instances

1. **Measure**

    This content will help the learner to understand the Azure technologies involved in the measure process:

    - After building the new feature (new payment platform) in the Tailwind Traders e-commerce application, the hypothesis can be validated or rejected: is the customer experience better now?
    - Controlled deployment
        - Feature flags, feature rings and canary deployments allow to release the feature to a limited set of users, to prevent disrupting the experience of the whole customer base
        - Portal options for users to decide if they want to be exposed to new functionality or not puts the user in control of their own experience
    - Application Insights allow to measure if users are reacting positively or negatively to a new feature.
        - Tailwind Traders has released the new payment option to 10% of the users
        - Application Insights shows that the feature is working without incidents
        - However, only 1% of the users with the feature are using the new payment option, so the hypothesis that this feature would bring a significant business value increase has to be rejected

    **Knowledge check**

    - What is the main goal of the Measure stage?
        - Determine if the introduced feature increases the business value as predicted by the hypothesis (correct)
        - Calculate the performance of the new feature in milliseconds
        - Make sure that the new feature runs stable
    - Which is a tool that can deliver actionable information to validate or reject customer hypothesis?
        - Azure Application Insights (correct)
        - Azure Kubernetes Services
        - Azure DevOps

1. **Learn**

    This content will help the learner to understand the Azure technologies involved in the learn process:

    - After validating or rejecting our hypothesis additional data can be gathered to formulate additional hypothesis and restart the innovation cycle
    - Customer interaction is key to perceive in which areas additional value could be delivered, and which innovations would be required.
    - Other feedback mechanisms
        - Allow customers to give feedback easily
        - Send customer surveys (offering the option to opt out). Example: which additional payment options would you like to see in our platform?
        - Build with customer empathy

    **Knowledge check**

    - What should Tailwind Traders do if their initial hypothesis is rejected (introduction of a new payment platform in this example)?
        - Evaluate why the hypothesis was wrong, and whether the hypothesis can be reformulated (correct)
        - Give up on payment platforms and look for business value somewhere else
        - Start a 1-year market analysis to investigate the market of payment platforms
    - What should be the center of the learn process?
        - Business value from our perspective, and the experience from the customer's perspective (correct)
        - The resources that a feature is going to require
        - The information delivered by a specific tool

1. **Summary**

    Tailwind Traders is using Azure to power their innovation engine:

    - Azure DevOps allows Tailwind Traders to introduce application changes frequently and reliably
    - The e-commerce platform has been reengineered into a microservices architecture to facilitate change introduction
    - For this specific application Tailwind Traders decided to containerize each microservice and deploy it on Azure Kubernetes Services
    - Tailwind Traders decided to use Azure technologies to enrich their ecommerce platforms with a chat for customers to provide feedback and ask questions, a modern product search engine and a recommendation engine that suggests additional products to registered users
    - The ecommerce microservices are equipped with Azure Application Insights telemetry, which allows Tailwind Traders to gather utilization usage for new features, to confirm or reject hypothesis about the business value added by each innovation
    - Analysis of the learnt information allows Tailwind Traders to formulate new hypothesis and restart the innovation cycle to keep improving their customer experience

    **Next steps**

    - TODO
