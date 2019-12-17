TODO: INTRO

## The meeting

TODO: Frame up a team discussion around feedback. The Beta is coming up. Irwin wants the team to consider ...

TODO: Lead in to these points:

- Continuous feedback: Build in customer feedback loops. These can take many forms:
  - Customer voice: Make it easy for customers to give feedback, add ideas, and vote on next generation features.
  - Product feedback: In-product feedback buttons are another way to solicit feedback about the product experience or specific features.
  - Customer demos: Regularly scheduled demos that solicit feedback from your customers can help shape next generation products and keep you on track to build applications your customers want to consume.
- Early adopter programs: Such programs should be developed with the idea that all teams may want to participate as some point. Early adopters gain access to early versions of working software which they then can provide feedback. Oftentimes, these programs work by turning select feature flags on for an early adopter list.
- Data-driven decisions: Find ways to instrument your product to obtain useful data and that can test various hypotheses. Help drive to an experiment-friendly culture that celebrates learning.

## What's the inner loop?

The _inner loop_ is the iterative process that a developer performs when they write, build, and debug code. There are of course other things that a developer does, but the inner loop is the core set of steps that developers perform over and over before they share their work with their team or the rest of the world.

Here's a diagram that illustrates this idea:

TODO: Make smaller; remove border.

![A drawing of the design build test loop](../media/2-inner-loop.png)

Exactly what goes into each developer's inner loop depends on the technologies that they are working with, the tools they use, and their own preferences.

For example, if you're writing a C# library, your inner loop might include coding, building, and testing. If you're doing web development, your inner loop might include coding, bundling, and refreshing your web browser to see your progress.

The following illustrates these two types of inner loops:

![A comparison of two types of inner loops](../media/2-inner-loop-2.png)

Each of these loops might include a fourth step, where you commit and integrate your changes with the team's central repository.

In reality, most codebases consist of multiple moving parts. The definition of a developer's inner loop on any single codebase might vary, depending on what they're working on.

## Which steps in the inner loop add value?

In [Assess your existing software development process](/learn/modules/assess-your-development-process/?azure-portal=true), you and the Tailspin team learned how a value stream map (VSM) can help you analyze your current release cycle process. Like the team's VSM, you can measure your inner loop to see which parts have value to the customer and which parts are eating up time without producing any value.

You can group the steps within the inner loop into three broad categories: *experimentation*, *feedback collection*, and *tax*.

In the example of building a C# library, here's how you might categorize each step:

| Step       | Category            |
|------------|---------------------|
| Coding     | Experimentation     |
| Building   | Feedback collection |
| Testing    | Feedback collection |
| Committing | Tax                 |

Here's a diagram that shows this mapping:

![A drawing of the design build test loop](../media/2-inner-loop-3.png)

Of all the steps in the inner loop, coding is the only one that adds customer value. Building and testing code are important, but ultimately you use these as tools to gain feedback about whether the changes provide sufficient value. For example, does the code compile? Does the feature satisfy the requirements? Does the feature work correctly with other features?

A tax defines work that neither adds value nor provides feedback, but is still necessary. In contrast, you can categorize unnecessary work as waste and then eliminate that work.

## How can I optimize the inner loop?

Now that we've categorized the steps within the inner loop, here are some general statements that we can make:

- The activities within the inner loop should happen as quickly as possible.
- The total loop execution time should be proportional to the changes that you're making.
- Minimize the time it takes collect feedback, but maximize the quality of the feedback that you get.
- Minimize the tax you pay by eliminating it where it isn't necessary. For example, commit your changes only after all tests pass.
- As the size of your codebase grows, so does the size of the inner loop. For example, having more code means you need to run more tests, which in turn slows down the inner loop.

If you've ever worked on a large, monolithic codebase, it's possible to get into a situation where even small changes require a disproportionate amount of time to execute the feedback collection steps of the inner loop.

There is no single solution that ensures that your inner loop doesn't slow you down. But it's important to notice slowdown when it happens, and then address what's causing it.

Here are a few things you can your team can do to optimize the inner loop:

* Only build and test what changed.
* Cache intermediate build results to speed up full builds.
* Break up the codebase into smaller units.

You can gain immediate benefits by implementing the first two recommendations. However, use caution when breaking your codebase into smaller units. When done incorrectly, breaking your codebase into too many small units can have the opposite effect: a tangled loop.

## What are tangled loops?

A _tangled loop_ happens when multiple processes, each with its own inner loop, become dependent on one another.

Say that your monolithic codebase has some set of core functionality that does a lot of the difficult work your application needs to perform. You might separate and package that code into a helper library.

To do this, you would typically move your library code to a separate repository and then set up a CI/CD pipeline that builds, tests, and packages the library. The pipeline might then publish the result to a package server. You would then configure your application to pull that library from the package server.

Development of the library code forms its own inner loop. When you make changes to the library and, for example, submit a pull request to merge your changes, you transition the workflow from the inner loop to the _outer loop_. The outer loop includes anything that depends on your library, for example, your monolithic application.

![Transitioning the workflow from the inner loop to the outer loop](../media/2-inner-loop-4.png)

Initially, you might see some benefits. For example, you might see decreased build times in your application because the library code is already built for you. Eventually, you'll likely need to develop an application feature that requires new capabilities in the library. This is where teams who have incorrectly separated their codebases start to feel pain.

When you evolve code in two separate repositories where a dependency is present, then you'll likely experience some friction. In terms of the inner and outer loops, the inner loop of the original codebase now includes the outer loop of the library code that was previously separated out.

Outer loops can include taxes such as code reviews, security scanning, package signing, and release approvals. You don't want to pay that tax every time you add a function to the library that you want to use in your application.

![A drawing of the design build test loop](../media/2-inner-loop-5.png)

In practice, this situation can force developers to work around processes or code in order to move forward. Such workarounds can build up tax that you'll have to pay at some point.

This doesn't mean that breaking code up into separate packages is a bad thing. You just need to carefully consider the impact your decisions have on the outer loop.

TODO: Any observations from the TS team?