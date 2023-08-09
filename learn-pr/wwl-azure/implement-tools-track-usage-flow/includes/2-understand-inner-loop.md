
It isn't clear who coined the term "inner loop" in the context of software engineering, but within Microsoft, at least, the word seems to have stuck.

Many of the internal teams I work with see it as something they want to keep as short as possible - but what is the inner loop?

## Definitions

The easiest way to define the inner loop is the iterative process that a developer does when writing, building, and debugging code.

There are other things that a developer does. It's the right set of steps to be done repeatedly before sharing their work with their team or the rest of the world.

:::image type="content" source="../media/inner-loop-f38b24da.png" alt-text="Diagram showing the code and build Inner Loop, and inner loop in the middle.":::


Exactly what goes into an individual developer's inner loop will depend significantly on the technologies they're working with, the tools used, and their preferences.

If I were working on a library, my inner loop would include coding, building, testing execution & debugging with regular commits to my local Git repository.

On the other hand, if I were doing web front-end work, I would probably be optimized around hacking on HTML & JavaScript, bundling, and refreshing the browser (followed by regular commits).

:::image type="content" source="../media/different-inner-loop-5e065ff3.png" alt-text="Diagram showing different Inner Loops like code, build and test.":::


Most codebases comprise multiple-moving parts, so the definition of a developer's inner loop on any single codebase might alternate depending on what is being worked on.

## Understanding the loop

The steps within the inner loop can be grouped into three broad activity buckets - experimentation, feedback collection, and tax.

If we flick back to the library development scenario I mentioned, I said four steps and how to bucket them.

 -  Coding (Experimentation)
 -  Building (Feedback Collection)
 -  Testing / Debugging (Feedback Collection)
 -  Committing (Tax)

Of all the steps in the inner loop, coding is the only one that adds customer value.

Building and testing code is essential, but ultimately, we use them to give the developer feedback about their writing to see if it delivers sufficient value.

Putting committing code in the tax bucket is perhaps a bit harsh, but the purpose of the bucket is to call out those activities that neither add value nor provide feedback.

Tax is necessary to work. If it's unnecessary work, it's waste and should be eliminated.

:::image type="content" source="../media/understand-loop-c756f050.png" alt-text="Diagram showing code, build, test and commit to helping to understand the Loop.":::


## Loop optimization

Having categorized the steps within the loop, it's now possible to make some general statements:

 -  You want to execute the loop as fast as possible and for the total loop execution time to be proportional to the changes made.
 -  You want to minimize the time feedback collection takes but maximize the quality of the feedback that you get.
 -  You want to minimize the tax you pay by eliminating it where it's unnecessary to run through the loop (can you defer some operations until you commit, for example).
 -  As new code and more complexity is added to any codebase, the amount of outward pressure to increase the size of the inner loop also increases. More code means more tests, which means more execution time and slow execution of the inner loop.

Suppose you have ever worked on a large monolithic codebase. In that case, it's possible to get into a situation where even small changes require a disproportionate amount of time to execute the feedback collection steps of the inner loop. It's a problem, and you should fix it.

There are several things that a team can do to optimize the inner loop for larger codebases:

 -  Only build and test what was changed.
 -  Cache intermediate build results to speed up to complete builds.
 -  Break up the codebase into small units and share binaries.

How you tackle each one of those is probably a blog post.

At Microsoft, for some of our genuinely massive monolithic codebases.

We're investing heavily in `#1` and `#2, but` `#3` requires a special mention because it can be a double-edged sword and can have the opposite of the wished impact if done incorrectly.

## Tangled loops

To understand the problem, we need to look beyond the inner loop. Let us say that our monolithic codebase has an application-specific framework that does much heavy lifting.

It would be tempting to extract that framework into a set of packages.

To do this, you would pull that code into a separate repository (optional, but this is generally how it's done), then set up a different CI/CD pipeline that builds and publishes the package.

A different pull-request process would also front this separate build and release pipeline to inspect changes before the code is published.

When someone needs to change this framework code, they clone down the repository, make changes (a separate inner loop), and submit a PR that transitions the workflow from the inner loop to the outer loop.

The framework package would then be available to be pulled into dependent applications (in this case, the monolith).

:::image type="content" source="../media/outer-loop-09b3065e.png" alt-text="Diagram showing code, build, test and commit in the Outer Loop.":::


Initially, things might work out well. However, at some point in the future, you'll likely want to develop a new feature in the application that requires extensive new capabilities to be added to the framework.

It's where teams that have broken up their codebases in suboptimal ways will start to feel pain.

If you have to coevolve code in two separate repositories where a binary/library dependency is present, you'll experience some friction.

In loop terms, the original codebase's inner loop now (temporarily at least) includes the outer loop of the previously broken-out framework code.

Outer loops include tax, including code reviews, scanning passes, binary signing, release pipelines, and approvals.

You don't want to pay that every time you've added a method to a class in the framework and now want to use it in your application.

:::image type="content" source="../media/tangled-loops-02684f79.png" alt-text="Diagram showing code, build, test, commit and app loops to reference Tangled Loops.":::


What generally ends up happening next is a series of local hacks by the developer to stitch the inner loops together so they can move forward efficiently - but it gets messy quickly. You must pay that outer loop tax at some point.

It isn't to say that breaking code into separate packages is inherently bad - it can work brilliantly; you need to make those incisions carefully.

## Closing thoughts

There's no silver bullet solution to ensure that your inner loop doesn't start slowing down, but it's essential to understand when it starts happening, what the cause is, and work to address it.

Decisions such as how you build, test, and debug the architecture will all impact developers' productivity. Improving one aspect will often cause issues in another.
