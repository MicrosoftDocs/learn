## Abstract

As discussed in the previous unit, Microsoft has been developing and refining its own internal process to govern AI responsibly.

In this unit, we’ll explain how Microsoft leverages a “sensitive uses” review trigger to help our internal and customer-facing teams identify when specific use cases need additional guidance. This is one of the early steps in our responsible AI governance process. We’ve found that it’s highly advantageous to start identifying, assessing, and mitigating responsible AI considerations early in solution design, rather than only as a compliance check at the end of a project.

While every organization will need its own unique governance frameworks and review processes, we believe that our sensitive use framework can serve as a helpful starting point.

## Microsoft sensitive use case framework

Per our responsible AI governance documentation, an AI development or deployment scenario is considered a “sensitive use” if it falls into one or more of the following categories:

* __Denial of consequential services__: The scenario involves the use of AI in a way that may directly result in the denial of consequential services or support to an individual (for example, financial, housing, insurance, education, employment, healthcare services, etc.).
* __Risk of harm__: The scenario involves the use of AI in a way that may create a significant risk of physical, emotional, or psychological harm to an individual (for example, life or death decisions in military, safety-critical manufacturing environments, healthcare contexts, almost any scenario involving children or other vulnerable people, etc.).
* __Infringement on human rights__: The scenario involves the use of AI in a way that may result in a significant restriction of personal freedom, opinion or expression, assembly or association, privacy, etc. (for example, in law enforcement or policing).

We train our employees to use this framework to determine whether an AI use case should be flagged for further review—whether they’re a seller working with a customer or someone working on an internal AI solution. We also train our Responsible AI Champs for their role as liaison between employees and central governance teams.

## Microsoft sensitive use case review process

### Identification

If an employee identifies that a use case falls into one of these three categories, they report it via a central submission tool and it’s routed to their local Responsible AI Champ—an individual who is responsible for driving awareness and understanding of the company’s responsible AI policies, standards, and guidance.

### Assessment

The Responsible AI Champ, working with the Office of Responsible AI and the Microsoft team involved in the use case, investigates the case to gather the relevant facts, follows a guided process to assess the impact of the proposed system on individuals and society, and reviews past cases to determine if guidance already exists for a similar scenario. If previous guidance does not exist, or if the case requires additional expertise and evaluation, the Responsible AI Champ presents the case to the Sensitive Uses Working Group of the Aether Committee (AI, Ethics, and Effects in Engineering and Research).

### Mitigation

The Sensitive Uses Working Group deliberates with a diverse group of experts to provide insight and recommendations for how to address the risks associated with the particular use case. If further escalation is needed, cases can rise all the way up to the Aether Committee itself, which directly advises Microsoft senior leadership.  Ultimately, decisions on novel, high-impact cases are made by company leadership.

When reviewing sensitive use cases, we recommend bringing together a diverse group of people with varied backgrounds and expertise. It’s also important to create an inclusive space where everyone feels comfortable sharing their ideas and perspectives.

Once the case has been reviewed, the Responsible AI Champ works with the Office of Responsible AI to provide advice to the project team on mitigation strategies that align to our responsible AI practices and principles. These mitigation strategies could include technical approaches, employee training and governance approaches, or alterations to the scope of the project. At times, our teams have been advised to not proceed with certain projects because we were unable to deliver them in a way that upholds our principles.

## Responsible AI governance in action: Case study

To better illustrate this process, let’s review a real-world case study where a customer came to us with a potentially sensitive use of AI.

We were approached by a law enforcement agency to develop a facial recognition system to augment existing identity verification methods. The scenarios included using facial recognition to check drivers’ identities during traffic stops, to expedite the check-in process in prisons, and to verify prisoners’ identities while moving through the facility. These three use-cases were submitted through the central intake tool for responsible AI review.

Through many thoughtful discussions, the Responsible AI Champ worked closely with the Office of Responsible AI, the account teams, and the customers to assess the risks. It was determined that all three cases needed to be escalated to the Aether Sensitive Uses Working Group for further input, as they touched on one or more of the sensitive uses of AI.

After careful consideration, we determined that we would not support the patrolling scenario to identify “persons of interest,” during traffic stops. As the state of the technology and the broader ecosystem were not sufficiently mature enough to mitigate the harmful consequences for when the technology performs imperfectly, this scenario was considered a premature use case. In addition, attempting to identify individuals in uncontrolled environments can infringe on human rights, resulting in improper arrests due to misidentification. Studies have shown that AI is more likely to mistake the identities of women and minorities, which could also lead to those populations being disproportionately detained.<sup>2</sup> We explained the issues to the customer, and they decided not to pursue that scenario.

For the in-facility use cases, we determined we could support the design and development of a proof of concept (POC), with safeguards in place to ensure appropriate human control over the solution, and a bi-directional feedback loop between the customer and Microsoft could be established. It was also important that the customer implement a training program for personnel interacting with the solutions, and that the customer would reengage with Microsoft on deployments beyond these supported scenarios.

## The evolution of responsible AI governance

Now that you’ve seen our process in action, there’s an important point we’d like to reiterate—this is just the beginning. AI is still a relatively new field, so it should come as no surprise that the processes around it are evolving rapidly as well. Going forward, we plan on refining our governance policies as we invest further in AI, and we recommend other businesses do the same. Every organization will need to customize its review process based on its own unique AI ambitions, needs, and maturity, but hopefully our process can serve as a helpful starting point.

Next, let’s review some principles, guidelines, and tools available to developers to help them build and deploy AI responsibly.
