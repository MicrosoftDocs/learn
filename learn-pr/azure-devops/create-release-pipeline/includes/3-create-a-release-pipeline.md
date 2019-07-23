Andy and Mara are going to create a simple CD pipeline to demo to the rest of the team. The pipeline will be a POC that they'll improve on and expand as they learn more and get feedback from Tim and Amita. They're sitting in a conference room, ready to get started.

"I've never build a CD pipeline before," Andy says. "Have you?" It's new to me, too," Mara answers. 

"Given we're both newbies," Andy says, "I was thinking that we already have a working automated pipeline--our build pipeline. We could start with that." Mara laughs. "Great minds. We could probably adapt the build .yml file. But what do we need to turn our build pipeline into a simple CD pipeline?"

## What makes up a simple pipeline

Andy says, "Here's what I think we need to start." He makes a list on the whiteboard:

* An artifact
* A trigger
* At least one stage 
* Tasks for each stage

"The artifact will be the .zip file we already create in the build pipeline. The trigger can also stay the same. When there's a change in version control, the pipeline starts."

## What is a stage

"I think that's a great start and pretty straightforward," Mara says. "Lets define a *stage* as a major division in a pipeline. Every stage is independent of every other stage. We could have a stage that builds the app, another that runs some tests, there's lots of possibilities. But we want to keep it simple so what about two stages?" She writes on the board:

* Build stage -- builds the artifact
* Deploy stage -- installs the artifact???

"Those could be the stages and the tasks for each stage. The question is, where should we deploy the artifact?"

## What are some deployment options

"At a really high level," Andy says, "do you want to deploy on premises or to Azure?" "I vote for the cloud," Mara says. "It'll be super fast and easy to set up a POC." 

"I agree," Andy says. "Here are a few cloud options to consider." He makes a list:

* VM
* Azure App Service
* Container

"I know containers are really popular right now," Mara says. Compared to VMs, they're lightweight in terms of resouces. I also know that they're easy to replace and scale up. They're interesting but I'm nervous about learning about two new technologies at once. I'd rather just concentrate on building the pipeline."

"I'm with you," says Andy. "That leaves VMs or Azure App Services." I think VMs would be a better choice if we were moving some line-of-business app that needed it's own particular environment to the cloud. We're not doing anything that big." 

"That leaves Azure App Service," Mara says. "That would be my choice. It's designed to work with Azure DevOps and it comes with a lot of advantages. It's a platform-as-a-service (PaaS) environment for web apps so it takes a lot of the burden off of us. We wont' have to worry about infrastructure and we get a lot of benefits, like security, load balancing, and autoscaling."

## How to gain visibility

"Great," Andy says. "Did we forget anything?"

"We got some visibililty into the build pipeline by adding a dashboard that shows build history. I don't want to lose that insight. Let's add a dashboard that keeps track of our release history." 

**NOTE-is this what the dashboard will do?**

"You got it," Andy says.

## Summary

Andy and Mara are ready to start. They're going to:

* Use the existing build platform as the basis of the CD pipeline
* Have a build stage that creates the artifact
* Have a deploy stage that installs the artifact to Azure App Service
* Have a dashboard that shows the release history









