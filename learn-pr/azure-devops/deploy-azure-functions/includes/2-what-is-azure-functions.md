You follow the Tailspin Space Game web team as they discuss how to best deliver on new marketing requirements driven by management. The team needs to integrate some serverless technology, specifically Azure Functions, into their DevOps process.

Let's check in with the team.

## The new requirements

**Irwin:** Thanks for meeting on such short notice. Things are heating up, and the marketing team has made some promises that could complicate things for all of us. They really like our site. They think the leaderboard can be used to promote the game as we head toward the final launch and beyond. They want to scale it out way beyond what we'd originally planned.

**Mara:** That's great, right? We're on Azure, so we can scale out the service as much as needed.

**Irwin:**  They just want the ability for anyone to integrate leaderboard data into their own applications. They think it would be really cool to have the same leaderboard options on our site, in the game, on gaming-review sites, and even on external blogs and personal sites. One challenge is that the game engine team currently owns the production database that we pull leaderboard data from. They think they should build and own the API moving forward.

**Andy:** Mara, do you have any thoughts?

**Mara:** I'm sure we can come up with something. Here are my notes:

- We need to deliver quickly, so we have to find a solution where we can use our code and skills.
- We need to refactor a small piece of functionality into an independent service.
- We need to minimize administrative overhead in production.
- We need to have massive scale without making a massive commitment.

*The team nods in agreement*.

## It works on my machine

The meeting breaks up. The next morning, Andy excitedly pops into Mara's office for an impromptu chat.

**Andy:** I've got it! I found a solution that meets all of our requirements for the leaderboard API. It's a serverless offering called Azure Functions.

**Mara:** That's great! How long before we have something we can demo?

**Andy:** I have already spiked something out. I forked our GitHub repo and refactored the leaderboard code into a new Azure Functions project. It exposes the leaderboard data via a simple HTTP GET request. I also updated the web site to use that endpoint when requesting the leaderboard, and anyone else can do the same.

**Mara:** This sounds like exactly what we need. I can help extend the existing CI/CD pipeline to support building and deploying it like we do for the main site project.

> [!NOTE]
> In this module, we won't focus on how to connect your app to Azure Functions. If you're interested, you can [review the source code](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web-azure-functions?azure-portal=true). The code uses the [Azure Functions runtime for C#](/azure/azure-functions/functions-dotnet-class-library?azure-portal=true) to read leaderboard data from Azure Functions.

## What is Azure Functions?

**Azure Functions** is a specific offering within the broader spectrum of Azure serverless computing technologies. It provides an easy way for developers to build straightforward functions that exist in a stateless, serverless environment. Functions can be triggered using various methods, such as HTTP requests, changes to data in storage, receipt of a message from a queue, and more. You can learn more about the trigger bindings in [Azure Functions triggers and bindings concepts](/azure/azure-functions/functions-triggers-bindings?azure-portal=true).

The Tailspin team selected Azure Functions for this scenario because it met all their needs:

- We need to deliver quickly, so we have to find a solution where we can use our code and skills.
  - *We can build the solution quickly as an ASP.NET Core application applying code we already have.*
- We need to refactor a small piece of functionality into an independent service.
  - *We can deliver an independent function with no other application surface area to worry about.*
- We need to minimize administrative overhead in production.
  - *Azure Functions removes the need to worry about hosting environments.*
- We need to have massive scale without making a massive commitment.
  - *Serverless technologies have virtually unlimited scale that can automatically ramp up and down faster than virtual machines or app services.*

Azure Functions and other serverless technologies aren't always the right fit for every solution. Later on, we'll discuss where you can find resources to help you select the right technology for the job.
