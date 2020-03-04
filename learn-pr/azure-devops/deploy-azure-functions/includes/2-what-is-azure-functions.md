Here you follow the Tailspin team as they discuss how to best deliver on new marketing requirements driven by management. As always, they have the navigate a combination of organizational, business, and technical challenges to deliver their software. In this scenario, the team will need to integrate some serverless technology, specifically Azure Functions, into their DevOps process.

The team has been making great strides in building out their automated processes. However, part of the reality of DevOps is that requirements can be fluid, so the ability to react to change is paramount. Let's check in with the team.

## The new requirements

Irwin, the product manager, has called an urgent meeting with key team members in order to deliver news about some new requirements. 

**Irwin:** Thanks for meeting on such short notice. Things are heating up and the marketing team is starting to make some promises that could make things complicated for all of us.

**Andy:** Well, you've got my attention now!

**Irwin:** They really like our site. They think the leaderboard is something that can be used to promote the game as we head toward the final launch and beyond. They're looking to scale it out way beyond what we had originally planned.

**Mara:** That's great, right? We're on Azure, so we can scale the service out as much as needed.

**Irwin:** Well, it's not that simple. They started off talking about "leveraging" and "synergy" and I sort of zoned out checking email. When I came back around they were asking me to task you with finding the most secure way for us to give anonymous third parties access to our database.

**Tim:** What?!? That's insane! What are they thinking?

**Irwin:** I know, I know. That was my first reaction as well. I probed a bit deeper and it turns out that they really just want the ability for anyone to integrate leaderboard data into their own applications. They think it would be really cool to have the same leaderboard options on our site, from within the game, on gaming review sites run by partners, and even by random players who want to show it on their blogs and personal sites.

**Andy:** So then it's just an API they're after. We already kind of have what we need to expose that, and I'm sure we can make it developer-friendly and scale up using Azure.

**Irwin:** Yes, I know you can. However, there are a few potential challenges we need to work through. The game engine team currently owns the production database we pull leaderboard data from. They think they should build and own the API moving forward. I told them that it's really a better fit for our team, but management isn't sure either way.

**Andy:** How can we show them that we have it under control?

**Irwin:** They're going to give us a week to put a proof of concept in place. However, they said that the final decision of ownership will be made based on the correct organizational structure. As a result, we will need to deliver a solution that is completely decoupled from the web site. Any team should be able to take over the project as a standalone component.

**Tim:** I'm not sure how I feel about this. I'm already spread too thin. I don't know if I have the bandwidth to add managing the infrastructure for yet another site. I'm also concerned about the scale requirements since we probably need to expect unpredictable surges in demand followed by lulls. We won't want to pay for peak demand the entire time.

**Andy:** Mara, do you have any thoughts?

**Mara:** This will take a bit of research, but I'm sure we can come up with something. Here are my notes:

-	We need to deliver quickly, so we have to find a solution where we can leverage our code and skills.
-	We need to refactor a small piece of functionality into an independent service.
-	We need to minimize administrative overhead in production.
-	We need to have massive scale without making a massive commitment.

The team nods in agreement.

**Andy:** Great, Mara and I will meet tomorrow to come up with a plan.

## It works on my machine

The meeting breaks up. The next morning, Andy excitedly pops into Mara's office for an impromptu chat.

**Andy:** I've got it! I found a solution that meets all of our requirements for the Leaderboard API. It's a serverless offering called Azure Functions.

**Mara:** That's great! How long do you think it will take for us to have something we can demo?

**Andy:** I've already spiked something out. I forked our GitHub repo and refactored the leaderboard code into a new Azure Functions project. It exposes the leaderboard data via a simple HTTP GET request. I also updated the web site to now use that endpoint when requesting the leaderboard, and anyone else can do the same.

**Mara:** This sounds like exactly what we need. I can help extend the existing CI/CD pipeline to support building and deploying it like we do for the main site project.

## What is Azure Functions?

**Azure Functions** is one of the specific offerings within the broader spectrum of Azure serverless computing technologies. It provides an easy way for developers to build straightforward functions that exist in a stateless, serverless environment. They can be triggered using a variety of methods, including HTTP requests, changes to data in storage, receipt of a message from a queue, and more. You can learn more about the various trigger and bindings in [this article](https://docs.microsoft.com/en-us/azure/azure-functions/functions-triggers-bindings).

The Tailspin team selected Azure Functions for this scenario because it met all their needs:

- We need to deliver quickly, so we have to find a solution where we can leverage our code and skills.
  - *We can build the solution quickly as an ASP.NET Core application leveraging code we already have.*
- We need to refactor a small piece of functionality into an independent service.
  - *We can deliver an independent function with no other application surface area to worry about.*
- We need to minimize administrative overhead in production.
  - *Azure Functions removes the need to worry about hosting environments.*
- We need to have massive scale without making a massive commitment.
  - *Serverless technologies have virtually unlimited scale that can automatically ramp up and down much faster than virtual machines or app services.*

It's important to note that there are quite a few serverless offerings under the Azure umbrella, and there is some overlap between various services. For a more in-depth review of some key serverless options, including Azure Functions, Microsoft Flow, Azure Logic Apps, and Azure App Service WebJobs, please see [Choose the right integration and automation services in Azure](https://docs.microsoft.com/en-us/azure/azure-functions/functions-compare-logic-apps-ms-flow-webjobs).

Azure Functions are also a great option for microservice solutions like the one the Tailspin team is evolving towards here. To understand the different options for microservices on Azure, including Azure Functions, Kubernetes, and Service Fabric, please see [Choosing an Azure compute option for microservices](https://docs.microsoft.com/en-us/azure/architecture/microservices/design/compute-options).

However, serverless isn't always appropriate for every situation. Stateful applications, for example, are not a good fit for serverless computing. Fortunately, Azure provides many different compute offerings that cover virtually every cloud scenario. For help finding the right one for your application, please see [Choose an Azure compute service for your application](https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/compute-decision-tree).
