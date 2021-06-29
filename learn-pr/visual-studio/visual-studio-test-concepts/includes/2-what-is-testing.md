# What is Testing?

<!-- 1. Topic sentence(s) ---------------------------------------------------------------

    Goal: briefly state that this unit will define the product.

    Heading: none

    Example: "Let's start with a few definitions and a quick tour of the core features of Logic Apps. This overview should help you see whether Logic Apps might be a good fit for your work."
-->
Let's start by defining testing with some examples before we dive into the concepts.

<!-- 2. Background-concept definitions (optional) ----------------------------------------

    Goal:
        Define any needed underlying concepts or terms the learner must know to understand the product.
        Repeat this pattern multiple times if multiple concepts are needed.

    Heading:
        "## What is (concept)?"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "(concept) is..." (ensure this is a definition, do not give use cases like "(concept) lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        (Note: the product "Logic Apps" implements business processes in the cloud; therefore, "business process" is a background concept.)
        Heading: "What is a business process?
        Lead sentence: "A business process or _workflow_ is a sequence of tasks that produce a specific outcome. The result might be a decision, some data, or a notification...."
-->

## What is testing?

Testing involves a series of test methods that run against your product code and return a pass or fail result based on certain criteria that is asserted. Test results appear in a list of red "x" and green "✔" that make it easy to assess what functionality is working or not at a glance.
![image](../media/test-intro-testlist.png)

<!-- 3. Define the product -------------------------------------------------------------

    Goal:
        Give a formal and precise definition of the product.

    Heading:
        "## (product) definition"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "(product) is..." (ensure this is a definition, do not give use cases like "(product) lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "Azure Logic Apps definition"
        Lead sentence: "Azure Logic Apps is a cloud service that automates the execution of your business processes."
-->

## Test Method definition

Tests are very much like regular methods. They are organized within Test Classes, have method signatures, and accept parameters. They reference and call your product code (another way of saying your non-test code) and compare how it behaves to an expected outcome.
![image](../media/test-intro-TestMethod.png)

One difference between tests and product code is they don't run as part of your app's normal function. So instead of using F5 (or the big green run button at the top of your development environment) to run as you would your app, you choose which tests to run either via a Test Explorer or a number of other helpful editor tools.
![image](../media/test-intro-runtests.png)
![image](../media/test-intro-runtests-testexplorer.png)

<!-- 4. Solve the scenario -------------------------------------------------------------

    Goal:
        At a high level, describe how the (product) solves one of the customer tasks in your (scenario).
        Avoid teaching how to actually do the work (you're not teaching how-to-use in this module).

    Heading:
        "## How to (solve scenario)"

    Pattern:
        1. H2 heading.
        2. Lead sentence that summarizes how the (product) solved the (scenario).
        3. Additional text as needed (typically 1-2 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "How to implement a Twitter monitor"
        Lead sentence: "To implement a Twitter monitor, you map each task to a Logic Apps component and connect them with conditional logic."
-->

## How can tests help prevent regressions in functionality?

Remember the phone number bug from the intro scenario? As soon as new code was added to accept international phone numbers, the function for adding domestic phone numbers broke! A test using domestic phone numbers as input may have caught this behavior change sooner since it would have tested not only the new functionality for international numbers, but also the old functionality for domestic phone numbers. As we implement new code, it may not always occur to us what old scenarios could be impacted by new changes. The phone numbers are a simple example, but imagine apps with hundreds of different input formats and needing to check that code every time. Tests make it easy for all several variations of the old behavior to be checked with a simple test run.
![image](../media/test-intro-phoneNum-example.png)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->