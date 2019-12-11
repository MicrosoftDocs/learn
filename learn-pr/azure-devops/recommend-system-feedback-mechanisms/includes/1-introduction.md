Copied from ILT

## Introduction
The ultimate goal of DevOps is to increase the speed and quality of software services, something every IT organization needs. But how can the parties involved in DevOps accelerate delivery if they don't understand what they deliver or know the people to whom they deliver? Despite great advancements in delivery, quality service still begins with understanding the needs of users.

Unsatisfied customers are probably costing you a lot of money. The first step to overcoming this is to admit that you have room for improvement. The second step is to measure customer satisfaction to find out where you currently stand.

Engaging customers throughout your product lifecycle is a primary Agile principle. Empower each team to interact directly with customers on the feature sets they own.

- Continuous feedback: Build in customer feedback loops. These can take many forms:
  - Customer voice: Make it easy for customers to give feedback, add ideas, and vote on next generation features.
  - Product feedback: In-product feedback buttons are another way to solicit feedback about the product experience or specific features.
  - Customer demos: Regularly scheduled demos that solicit feedback from your customers can help shape next generation products and keep you on track to build applications your customers want to consume.
- Early adopter programs: Such programs should be developed with the idea that all teams may want to participate as some point. Early adopters gain access to early versions of working software which they then can provide feedback. Oftentimes, these programs work by turning select feature flags on for an early adopter list.
- Data-driven decisions: Find ways to instrument your product to obtain useful data and that can test various hypotheses. Help drive to an experiment-friendly culture that celebrates learning.

## The inner loop

It's not clear who coined the term “inner loop” in the context of software engineering, but within Microsoft at least the term seems to have stuck. Many of the internal teams that I work with see it as something that they want to keep as short as possible - but what is the inner loop?

Definitions

The easiest way to define the inner loop is the iterative process that a developer performs when they write, build, and debug code. There are other things that a developer does, but this is the tight set of steps that are performed over and over before they share their work with their team or the rest of the world.

![A drawing of the design build test loop](../media/1-inner-loop.png)

Exactly what goes into an individual developer's inner loop will depend a great deal on the technologies that they are working with, the tools being used and of course their own preferences. If I was working on a library my inner loop would include coding, build, test execution & debugging with regular commits to my local Git repository. On the other hand if I was doing some web front-end work I would probably be optimized around hacking on HTML & JavaScript, bundling and refreshing the browser (followed by regular commits).

![A drawing of the design build test loop](../media/1-inner-loop-2.png)

In reality most codebases are comprised of multiple moving parts and so the definition of a developer's inner loop on any single codebase might alternate depending on what is being worked on.

### Understanding the Loop

The steps within the inner loop can be grouped into three broad buckets of activity - experimentation, feedback collection and tax. If we flick back to my library development scenario I mentioned earlier, there are four steps I mentioned and how I would bucket them.

- Coding (Experimentation)
- Building (Feedback Collection)
- Testing / Debugging (Feedback Collection)
- Committing (Tax)
Of all the steps in the inner loop, coding is the only one that adds customer value. Building and testing code are important, but ultimately we use them to give the developer feedback about the what they have written to see if it delivers sufficient value (does the code even compile, and does it satisfy the requirements that we've agreed etc).

Putting committing code in the tax bucket is perhaps a bit harsh, but the purpose of the bucket is to call out those activities that neither add value, or provide feedback. Tax is necessary work, if its unnecessary work then it is waste and should be eliminated.

![A drawing of the design build test loop](../media/1-inner-loop-3.png)

### Loop Optimization

Having categorized the steps within the loop it is now possible to make some general statements:

- You want to execute the loop as fast as possible and for the total loop execution time to be proportional to the changes being made.
- You want to minimize the time feedback collection takes, but maximize the quality of the feedback that you get.
- You want to minimize the tax you pay by eliminating it where it isn't necessary on any particular run through the loop (can you defer some operations until you commit for example).
- As new code and more complexity is added to any codebase the amount of outward pressure to increase the size of the inner loop also increases (more code means more tests which in turn means more execution time and a slow execution of the inner loop).

If you have ever worked on a large monolithic codebase it is possible to get into a situation where even small changes require a disproportionate amount of time to execute the feedback collection steps of the inner loop. This is a problem and you should fix it.

There are a number of things that a team can do to optimize the inner loop for larger codebases:

1. Only build and test what was changed.
1. Cache intermediate build results to speed up full builds.
1. Break up the code-base into small units and share binaries.

How you tackle each one of those is probably a blog post in their own right. At Microsoft, for some of our truly massive monolithic codebases we are investing quite heavily in #1 and #2 - but #3 requires a special mention because it can be a double edged sword and if done incorrectly and can have the opposite of the desired impact.

### Tangled loops

To understand the problem we need to look beyond the inner loop. Let's say that our monolithic codebase has an application specific framework which does a lot of heavy lifting. It would be tempting to extract that framework into a set of packages.

To do this you would pull that code into a separate repository (optional, but this is generally the way it is done), then setup a separate CI/CD pipeline that builds and publishes the package. This separate build and release pipeline would also be fronted by a separate pull-request process to allow for changes to be inspected before the code is published.

When someone needs to change this framework code they clone down the repository, make their changes (a separate inner loop) and submit a PR which is the transition of the workflow from the inner loop to the outer loop. The framework package would then be available to be pulled into dependent applications (in this case the monolith).

![A drawing of the design build test loop](../media/1-inner-loop-4.png)

Initially things might work out well, however at some point in the future it is likely that you'll want to develop a new feature in the application that requires extensive new capabilities to be added to the framework. This is where teams that have broken their codebases up in sub-optimal ways will start to feel pain.

If you are having to co-evolve code in two separate repositories where a binary/library dependency is present then you are going to experience some friction. In loop terms - the inner loop of the original codebase now (temporarily at least) includes the outer loop of the framework code that was previously broken out.

Outer loops include a lot of tax such as code reviews, scanning passes, binary signing, release pipelines and approvals. You don't want to pay that every time you've added a method to an class in the framework and now want to use it in your application.

![A drawing of the design build test loop](../media/1-inner-loop-5.png)

What generally ends up happening next is a series of local hacks by the developer to try and stitch the inner loops together so that they can move forward efficiently - but it gets pretty messy quick and you have to pay that outer loop tax at some point.

This isn't to say that breaking code up into separate packages is an inherently bad thing - it can work brilliantly, you just need to make those incisions carefully.

### Closing Thoughts

There is no silver bullet solution that will ensure that your inner loop doesn't start slowing down, but it is important to understand when it starts happening, what the cause is and work to address it.

Decisions such as how you build, test and debug, to the actual architecture itself will all impact how productive developers are. Improving one aspect will often cause issues in another.

## Integration between Azure DevOps and Teams

This is a lab
