In this part, you folow the Tailspin team as they discuss using a continuous delivery pipeline for feature releases. 

The Tailspin team is starting to feel better about their build process. They’ve got an automated version running on Azure Pipelines, which means the build environment is stable. Amita knows immediately when there’s an artifact for her to test. She’s finding fewer bugs because Andy and Mara have started to add unit tests and code quality tests. Life is looking good. Let's check in with the team.

## Morning meeting

Everyone on the team is in the meeting room waiting for Irwin, the product manager, who says he wants to talk to them. They’re looking forward to telling him about the progress they’ve made. But when Irwin walks in, he doesn’t look happy. He starts talking right away.

**Irwin:** I had a meeting this morning with the execs. They want to know why we’re taking so long to release our games and websites. Our closest competitors get new features and new games out there much faster than we do. We need to speed things up. I’m not just saying this to you. I’m saying it to all the teams. What can we do to help your team deploy faster? *He looks around*. Anyone?

Andy clears his throat.

**Andy:** This is a little sudden but we’re a bit ahead of you. We’ve been automating our build process and that’s been helpful. Maybe now it’s time to extend our automation to how we deploy our apps.

**Irwin:** How do you do this?

**Mara:** We created an automated build pipeline with Azure Pipelines. It builds an artifact that Amita can test. We could also use Azure Pipelines to build a continuous delivery pipeline (CD).

**Irwin:** Which is what?

**Mara:** It’s a pipeline that...

Irwin's mobile beeps. He reads a text and mutters under his breath.

**Irwin:** I'm really sorry but this is urgent. I have to go. Why don't you all figure out this CD business and get back to me--soon.

Andy looks around at his team.

**Andy:** Coffee?

Andy and crew head to the coffee shop to hammer out a plan.

## Discuss continuous delivery

The team is having a meeting over coffee. Irwin, the product manager, has told them they need to start releasing new versions of the web site faster and he's left it up to them to figure out how to do it.

**Andy:** So, as I told Irwin just before he ran off, I think it's time to build a CD pipeline. Automation is the only way to release faster.

Mara nods. Amita and Tim look unhappy.

**Tim:** I don't really know what CD is, but if it means losing control of my production environment, I won't do it.

**Amita:** If it means all the tests are automated, what am I supposed to do? It's not just my job. I don't think we should sacrifice the user experience just to meet some arbitrary deadline.

She starts crumbling her scone into little pieces.

**Andy:** Tim, you won't and Amita, you're right. Let's talk a bit about what continuous delivery (CD) is so we all understand each other. Mara, want to try?

**Mara:** Sure.

## What is continuous delivery?

Continuous delivery (CD) is what makes frequent, reliable delivery of software possible. Let's listen to Mara as she explains it to the team.

**Mara:** To me, CD and DevOps are inseparable. Remember that we defined DevOps as the union of people, process, and products to enable continuous delivery of value to our end users.

CD itself is a set of processes, tools and techniques that makes rapid, reliable and continuous delivery of software possible. So CD isn't only about setting up a pipeline, although that's important. It's about setting up a working environment where:

* We have a reliable and repeatable process for releasing and deploying software.
* We automate as much as possible.
* We don't put off doing something that's difficult or painful. Instead, we do it more often so that we figure out how to make it routine.
* We keep everything in source control.
* We all agree that "done" means “released.”
* We build quality into the process. It's never an afterthought.
* We all are responsible for the release process. No more silos.
* We always try to improve.

We've already put some of these things into place and we all think they've improved how we work. CD is an extension of what we've already started.

## Why do I need continuous delivery?

Continuous delivery helps software teams deliver reliable software updates to their customers on a rapid cadence. This ensures that customers and stakeholders have the latest features and fixes quickly. 

Let's continue to listen in on the team as they talk this out.

**Andy:** Thanks, Mara, we need CD because, as we all know, the world has changed. Releases with new features are happening faster. Updates and bug fixes need to be available right away. It isn't just that management wants this. They're simply reacting to the demands of our customers. If customers can't get what they want from us, they'll go somewhere else.

The old way of doing things, where we were all shut up in our separate silos is too slow and, honestly, it's frustrating for all of us.

We need to work together if we're going to succeed. All of us have seen how automation gives us a reliable, repeatable, faster process for building artifacts. CD will bring those benefits to an entire release pipeline.

Amita, I think your life has gotten better since we added tests to the build pipeline so you weren't getting regression bugs and you also started getting automatic updates on when builds were ready.

Tim, I'm going to ask you to be patient. I know you haven't seen a lot of benefit yet, but I promise you, you will. When you're home on the weekends instead of here because we keep crashing your production environment, you'll be happier. Can I ask you both to give CD a chance?

Amita and Tim look at each other and nod.

**Tim:** Let's get started.

**Andy:** Thanks, everyone. I'm going to propose that Mara and I put together a simple proof of concept (POC) that we can show you. I think everything will be a lot easier to understand if you can see a CD pipeline in action.

Tim laughs.

**Tim:** Don't let me stop you from doing all the work!

**Amita:** Good luck, you two.

The team leaves Andy and Mara to work out the details.

## What continuous delivery tools can I use?

**Mara:** Where do you want to start?

**Andy:** First, we need to agree on our release management tool. Let's make sure the tool we choose:

* Supports our version control system
* Supports multiple pipeline stages
* Makes it easy for us to create the tasks for each stage
* Supports triggers
* Supports approval and gates
* Is easy to extend

**Mara:** Azure DevOps integrates with several other CI/CD solutions. There are a lot of options out there and we don't already have an investment in one. If we did, it would make sense to go with that one. Let's look at the few I know about, Jenkins, Circle CI, GitLab, and Azure Pipelines.

Jenkins is open source and on-prem unless we use a third party. It's got a lot of plug-ins and many companies use it. I don't know if we can use it for approvals and quality gates. Circle CI can be cloud-based or on prem. I think we would need to customize it. GitLab Pipelines is a part of GitLab, which is a single application for the entire software development lifecycle. It might be bigger than we want right now. My vote is Azure DevOps Pipeline.

**Andy:** I like it. It's worked great for us so far and we don't have to learn another new technology.

**Mara:** Great. Let's get started on the pipeline details.

Andy and Mara move to a conference room to plan their continuous deployment pipeline.