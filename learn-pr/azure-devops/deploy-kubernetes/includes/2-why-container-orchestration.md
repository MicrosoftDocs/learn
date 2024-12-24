In this unit, you can follow the Tailspin team as they explore strategies for delivering on a new directive from management. The team examines how Kubernetes can assist in their transition to a microservices architecture.

## The future is smaller

Things are looking up at Tailspin. At a recent management offsite, Andy presented his team's recent successes with Azure DevOps, which were well received. Andy also presented a demo of the team’s recent proof-of-concept project using Docker containers. These demonstrations led to a series of productive conversations on the technical future of the organization. The next day, Andy returns to share the news with the Space Game web team.

**Andy:** Things went really well at my offsite presentation yesterday. Management is impressed with the work we've done so far, and has issued us a special assignment.

**Tim:** Uh oh. I've been around long enough to see a trap like that coming from a mile away.

**Andy:** No, this is a great opportunity for us. Management loved our Docker container demo and wants us to explore adopting a microservices architecture.

**Amita**: Microservices? Like apps for phones and watches?

**Andy**: No, microservices are typical apps, like our web app. The main difference is that instead of building and deploying a single monolithic app, we refactor any components that would be better maintained and managed as autonomous services. We then build those services to be good at what they do and deploy them to operate independently.

**Tim**: I'm not sure I like the sound of that. I'm already dealing with so many services across our environments. I don't know if I want more on my plate.

**Andy**: That's an understandable concern. Fortunately, there are some great tools for managing a multitude of containers in a given environment. We've been asked to spike out a multi-container solution for our web app that is orchestrated using Kubernetes. They also want to know how it will impact our DevOps process.

**Mara**: I've been reading up on Kubernetes. Azure has great support for it through Azure Kubernetes Service, and I know there's pipeline support for it in Azure DevOps.

**Amita**: This process sounds like it's going to get complex. How will it impact testing?

**Mara**: It shouldn't be a significant change. Kubernetes offers a way for us to deploy to different namespaces. This enables us to partition our deployments so that we can have entire environments dedicated to testing versus production. And since they all run in the same cluster and use the same containers, the testing experience should offer what we expect to see in production.

**Amita**: Is it going to be hard to keep track of what environment is where?

**Mara**: No, we can use Azure DevOps environments to do all of that. You'll be able to find out where each service is and how it got there by using the portal. It's all automated through the pipeline, so there will be nothing that we have to manually keep track of. The only concern I have now is how much impact it will have on our development experience to build this.

**Andy**: The good news is that the impact is minimal. Assuming we have our projects set up to build Docker containers, all we need to deploy to Kubernetes are some manifest files that describe the services and their deployments.

**Mara**: Have you thought about what we will refactor out as the second container? I know there have been several teams asking us to make our leaderboard available through a web API.

**Andy**: I'm one step ahead of you. I forked the Docker project last night and refactored the leaderboard data functionality into its own microservice. This leaves us with one container for the website and another for a leaderboard API. Both containers are configured to have their own public endpoints that we can share with anyone who wants to use the site or API, regardless of what technology stack their app uses. If the load grows substantially for either, we can scale its containers independently.

**Mara**: This project sounds awesome! Let's get started on updating the release pipeline.

## What is Kubernetes?

Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. It provides a framework for running distributed systems in a declarative, responsive fashion and can run containers across multiple hosts, providing efficient use of resources and increased reliability.

The Tailspin team selected Kubernetes for this scenario because it met all their needs:

- Complexity of multi-container deployments: Kubernetes is designed, first and foremost, to automate the processes around deploying and maintaining container deployments.

- Consistency across environments and stages: just as containers ensure a consistent deployment for the apps they contain, Kubernetes ensures a consistent deployment for the containers a cluster manages.

- Azure DevOps support: Azure DevOps offers first-class support for working with Kubernetes.

- Ease of development: the impact of Kubernetes on a source project is comparable to that of adding Docker support, which is minimal and limited to declarative configuration.

Adopting Kubernetes drastically simplifies the process of adopting a microservices architecture that makes use of multiple Docker containers.
