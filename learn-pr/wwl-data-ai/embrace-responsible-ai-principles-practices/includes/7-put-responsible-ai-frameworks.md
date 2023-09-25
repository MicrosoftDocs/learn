As discussed in the previous unit, Microsoft has developed and refined its own internal process to govern AI responsibly. This unit explains how this governance system works in a real situation. While every organization needs its own unique governance frameworks and review processes, we believe that our sensitive use framework can serve as a helpful starting point. One of Microsoft's early steps in our responsible AI governance process was to use a sensitive uses review trigger. The framework helped our internal and customer-facing teams identify when specific use cases need more guidance.

## Microsoft sensitive use case framework

Per our responsible AI governance documentation, we consider an AI development or deployment scenario a "sensitive use" if it falls into one or more of the following categories:

* **Denial of consequential services**: The scenario involves the use of AI in a way that may directly result in the denial of consequential services or support to an individual (for example, financial, housing, insurance, education, employment, or healthcare services).
* **Risk of harm**: The scenario involves the use of AI in a way that may create a significant risk of physical, emotional, or psychological harm to an individual (for example, life or death decisions in military, safety-critical manufacturing environments, healthcare contexts, almost any scenario involving children or other vulnerable people, and so on).
* **Infringement on human rights**: The scenario involves the use of AI in a way that may result in a significant restriction of personal freedom, opinion or expression, assembly or association, privacy, and so on (for example, in law enforcement or policing).

We train our employees to use this framework to determine whether an AI use case should be flagged for further review—whether they’re a seller working with a customer or someone working on an internal AI solution. We also train our Responsible AI Champs for their role as liaison between employees and central governance teams.

## Microsoft sensitive use case review process

The review process for sensitive use cases has three stages: identification, assessment, and mitigation. To better illustrate this process, a real-world case study joins the explanation of each step. In this case study, a customer came to us for a face recognition system.

### Identification

If an employee identifies that a use case falls into one of the three categories (denial of consequential services, risk of harm, or infringement of human rights), they report it. Reporting is done via a central submission tool and then routed to their local Responsible AI Champ, an individual who is responsible for driving awareness and understanding of the company's responsible AI policies, standards, and guidance.

In this case, a law enforcement agency approached us to develop a facial recognition system to augment existing identity verification methods. The scenarios included using facial recognition to check drivers’ identities during traffic stops, to speed up the check-in process in prisons, and to verify prisoners’ identities while moving through the facility. An employee submitted these three use-cases through the central intake tool for responsible AI review.

### Assessment

The Responsible AI Champ, working with the Office of Responsible AI and the Microsoft team involved in the use case, investigates the case to gather the relevant facts, follows a guided process to assess the effect of the proposed system on individuals and society, and reviews past cases to determine if guidance already exists for a similar scenario. If earlier guidance doesn't exist, or if the case requires more expertise and evaluation, the Responsible AI Champ presents the case to the Sensitive Uses Working Group of the Aether Committee.

In this face recognition case, the Responsible AI Champ worked closely with the Office of Responsible AI, the account teams, and the customers to assess the risks. It was decided that all three cases needed to be escalated to the Aether Sensitive Uses Working Group for further input, as they touched on one or more of the sensitive uses of AI.

### Mitigation

The Sensitive Uses Working Group deliberates with a diverse group of experts to provide insight and recommendations for how to address the risks associated with the particular use case. If the situation requires further escalation, cases can rise all the way up to the Aether Committee itself, which directly advises the Senior Leadership Team. Ultimately, the Senior Leadership Team makes decisions on novel, high-impact cases.

>[!NOTE]
> When reviewing sensitive use cases, we recommend bringing together a diverse group of people with varied backgrounds and expertise. It's also important to create an inclusive space where everyone feels comfortable sharing their ideas and perspectives.

Once the case has been reviewed, the Responsible AI Champ works with the Office of Responsible AI to provide advice to the project team on mitigation strategies that align to our responsible AI practices and principles. These mitigation strategies could include technical approaches, employee training and governance approaches, or alterations to the scope of the project. At times, our teams have been advised to not proceed with certain projects because we were unable to deliver them in a way that upholds our principles.

In the use case, the Aether Sensitive Uses Working Group took separate decisions for each of the scenarios. After careful consideration, they determined that we wouldn't support the patrolling scenario to identify "persons of interest," during traffic stops. As the state of the technology and the broader ecosystem weren't sufficiently mature enough to mitigate the harmful consequences for when the technology performs imperfectly, the Aether working group considered this scenario a premature use case. 

We explained the issues to the customer, and they decided not to pursue that scenario.

>[!NOTE]
> **Backed by research**: attempting to identify individuals in uncontrolled environments can infringe on human rights, resulting in improper arrests due to misidentification. Studies have shown that AI is more likely to mistake the identities of women and minorities, which could also lead to those populations being disproportionately detained.<sup>1</sup>

For the in-facility use cases, we decided we could support the design and development of a proof of concept (POC), with safeguards in place to ensure appropriate human control over the solution, and a bi-directional feedback loop between the customer and Microsoft could be established. It was also important that the customer implemented a training program for personnel interacting with the solutions, and that the customer would reengage with Microsoft on deployments beyond these supported scenarios.

## The evolution of responsible AI governance

Now that you’ve seen our process in action, there’s an important point we’d like to reiterate—we are at the beginning of developing AI governance. The processes around AI are evolving rapidly. Going forward, we plan to refine our governance policies as we invest further in AI, and we recommend other businesses do the same. Every organization needs to customize its review process based on its own AI needs and maturity, but hopefully our process can serve as a helpful starting point.

Next, let’s wrap up everything you’ve learned with a knowledge check.
