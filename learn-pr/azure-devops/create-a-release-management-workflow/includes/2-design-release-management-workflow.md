The entire Tailspin web team is gathered together. Amita and Tim are watching Andy and Mara demo their POC pipeline. They see that the artifact gets built and deployed to Azure App Service. The dashboard gives them the release history.

"OK," Tim says. I get the idea of an automated pipeline. It's great and I like how easy it is to deploy to Azure but my question is where do we go from here?"

"Right," Amita says. We need to add some other pieces. There's no place for test, for example. 

"And we need a place where we can show new features to management. I can't send anything to production without their okay," Tim adds.

"Absolutely," Andy says. "Now that we're all up to speed on what a CD pipeline does, what do we need to do to make this a pipeline that actually suits our needs?"

"I think it's whiteboard time," Mara says. **NOTE--add a series of whiteboard sketches that show the pipeline as it evolves.**

## What are deployment stages

Mara continues. "It's clear we need to add at least two more stages. One is where Amita can test the app, so that's the test stage. Another is where we can demo the release to management to get their approval. Let's call that the pre-production stage."

"I think we need to add one more," Andy says. "We need a dev stage, which will be the first stop for the artifact after it's built. That's where the unit and quality tests Mara and I have put in place can happen. 

"Also, let's make clear that a *release* is a package that holds a versioned set of artifacts created by a release pipeline. A release includes all the information you need to carry out all the tasks and actions in the release pipeline, such as what to do for each stage (or environment). Releases are *deployed* to stages. 

"Got it," Mara says. So the deployment stages for our release will be:

Build > Dev > Test > Preproduction (**Make it a drawing**)

"Is this going to be hard to do?" Amita says. "It seems like a lot of work."

"I don't think it will be too bad," Mara says. "Every stage is separate from every other stage. Stages are discrete environments where we deploy the app. Each stage has its own set of tasks. What happens in the test stage, for example, stays in the test stage.

"Every stage also has it's own environment. For example, in our pipeline, during the build stage, the environment is the build agent. When we deploy the app to a different stage, such as test or production, the environment can be something else. It could be a VM, a container, or a managed service like Azure App service, which is what we're using. 

"Finally, we only ever test one release at a time. We never change releases in the middle of the pipeline. We use the same release in the dev stage as in the production stage and every release has its own version number. If the release breaks in one of the stages, we fix it and build it again with a new version number. That new release then goes through the pipeline from the very beginning.

### What is a deployment slot

"Speaking of environments," Andy says, "since we're using Azure App Service, we can take advantage of its <i>deployment slots</i>. Deployment slots are running apps that have their own host names. 

We can create a slot for each stage in our pipeline. We could have a slot for dev, a slot for test and a slot for pre-production. If, at some point, we extend the pipeline to have a production stage, we could have a slot for that. That would be where we run the live app. 

I know I'm getting a bit ahead of myself, but with slots we could deploy new features without any downtime. We could swap an application and its configuration between two deployment slots. Basically we'd be swapping the IP addresses of the two slots.

"Food for thought," says Tim.

## How do changes move from one stage to the next?

Tim says, "My question is how do we move from one stage to the next? It seems like the dev stage automatically gets the output of the build stage and that's fine for you two but automatic deployments won't work for me, and I don't think they work for Amita either. We need control." He looks at Amita.

"I agree," she says. "I run manual tests and I don't know how long they'll take. And Tim has to wait for approval from management before anything goes to production."

"We can give you all the control you need," Andy says. Let's figure out a <i>release cadence</i>, which defines when and how often we deploy to each stage. Then, we can use <i>triggers</i> to implement the cadence. 

### How to define a release cadence
"When and how often do we want the app deployed, taking each stage separately?" Andy asks. We already automatically trigger a build whenever there's a change in version control. I think we want to keep that, don't we Mara?" She nods.

"Okay, and I'm fine with automatically deploying to Dev whenever there's a successful build." 

"Works for me, says Mara.

"Now, says Andy, what about when we send something to test? That means it's passed all of the unit and quality tests." He looks at Amita.

"I think I'd like to see a build once a day. Maybe it can be there when I get come in. Can we do that?"

"Sure," Andy says. Why don't we deploy to test during off-hours? Let's say we send you a build every day at 3AM.

"Great. Can I control when I deploy the release to the pre-production phase?"

"You can," says Andy. "I think you need manual control for that. A deployment happens only when you say so."

"I'm feeling better," Amita says. 

### How to use triggers to implement a release cadence

"In Azure Pipelines," Mara says, we can use triggers to implement our release cadence. Here are our choices," she says, listing them on the board.

* A manual trigger
* A scheduled trigger
* A continuous deployment trigger 

"A manual trigger is where people deploy a release by hand. A scheduled trigger starts a deployment at a specific time. A continuous deployment trigger is where an event triggers a deployment.

 "I think we need a continuous deployment trigger to move from build to dev. To move from dev to test, let's use a scheduled trigger that sends the release to test at 3AM. Finally, we can use a manual trigger to send the release to pre-production.

Mara adds the triggers to the whiteboard.

**NOTE--add updated pipeline**

Amita says, "I like this. I don't even have to pick up the release by hand anymore and install it. It'll be all ready for me."

"And remember," Andy says, "if we want to make things more automated later on, we can always do it. Nothing's written in stone. The pipeline evolves as we improve and learn more."

### What are release approvals and release gates

Tim clears his throat. "What about me? I still need some way to deploy the app to my production environment and that depends on management signing off on new features. Those triggers won't work."

Andy says, "I see your point. We need to do some more research on this and we're not deploying to production from the pipeline yet. I think what you're looking for is a <i>release approval</i> and maybe a <i>release gate</i>.

"With a release approval attached to a stage, the pipeline deployment stops until someone signs off, like our management. We could enable a manual deployment approval to move from pre-production to production.

"For quality control, we could use gates. A gate would let us automatically  collect health signals from external services and then promote the release only when all the signals are successful at the same time."

"I'm interested in that," says Mara. Let's talk aobut it later."

## What release management tools can I use?

"There's just one more thing I want to talk about, Andy says. We need to agree on our release management tool. Let's make sure the tool we choose:

* Supports our version control system
* Supports multiple pipeline stages
* Makes it easy for us to create the tasks for each stage
* Supports triggers
* Supports approval and gates
* Is easy to extend

"There are a lot of options out there. A few I know about are Jenkins, Circle CI, GitLabs Piplines, and Azure DevOps Pipeline.

"Jenkins is open source and on-prem unless we use a third party. It's got a lot of plug-ins and many companies use it. I don't know if we can use it for approvals and quality gates. Circle CI can be cloud-based or on prem. I think we would need to customize it. GitLab Pipelines is a part of GitLab, which is a single application for the entire software development lifecycle. It might be bigger than we want right now. My vote is Azure DevOps Pipeline."

"I'll take it," says Mara. It's worked great for us so far and we don't have to learn another new technology."

"I agree," says Tim. "This is ambitious enough for me." 

"Ditto," says Amita. "Let's stick with what we know works."

