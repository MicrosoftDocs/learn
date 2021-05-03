<!-- 1. Topic sentence(s) ---------------------------------------------------------------

    Goal: briefly state that this unit will define the product.

    Heading: none

    Example: "Let's start with a few definitions and a quick tour of the core features of Logic Apps. This overview should help you see whether Logic Apps might be a good fit for your work."
-->
Let's start with a quick tour of Azure API Management, including what it is and what are its core features. This overview should help you decide whether Azure API Management is worth looking into as a solution reducing your company's API complexity.

<!-- 2. Background-concept definitions (optional) ----------------------------------------

    Goal:
        Define any needed underlying concepts or terms the learner must know to understand the product.
        Repeat this pattern multiple times if multiple concepts are needed.

    Heading:
        "## What is <concept>?"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "<concept> is..." (ensure this is a definition, do not give use cases like "<concept> lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        (Note: the product "Logic Apps" implements business processes in the cloud; therefore, "business process" is a background concept.)
        Heading: "What is a business process?
        Lead sentence: "A business process or _workflow_ is a sequence of tasks that produce a specific outcome. The result might be a decision, some data, or a notification...."
-->

## What is API lifecycle management?

*API lifecycle management* is the process of administering an API through its complete lifespan, from its design and creation to its obsolescence and retirement from use. Here, we assume your APIs have already been designed, coded, and deployed, so we don't deal with your APIs from their beginnings. Instead, here we concentrate on the rest of the API lifecycle, which includes the following management tasks:

* Providing API documentation, testing, and code samples
* Onboarding and offboarding users
* Handling API subscriptions and the distribution of subscription keys
* Implementing API revisions in a controlled and safe way
* Managing multiple versions of an API
* Implementing API access controls, such as authentication and call rate limits
* API reporting for usage, errors, and so on
* Analytics for both your company and for the developers who use the APIs

<!-- 3. Define the product -------------------------------------------------------------

    Goal:
        Give a formal and precise definition of the product.

    Heading:
        "## <product> definition"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "<product> is..." (ensure this is a definition, do not give use cases like "<product> lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "Azure Logic Apps definition"
        Lead sentence: "Azure Logic Apps is a cloud service that automates the execution of your business processes."
-->

## Azure API Management definition

Azure API Management is a cloud service that gives you a platform for publishing, securing, maintaining, and analyzing all your company's APIs. It's important to note that Azure API Management does *not* host your actual APIs. Your APIs remain where they were originally deployed. Instead, Azure API Management acts as a kind of façade or front end

:::image type="content" source="../media/2-what-is-azure-api-management.png" alt-text="Diagram showing multiple APIs all using the Azure API Management gateway, which routes each call to the appropriate backend server. The diagram also shows the Azure API Management administrative interface and developer portal.":::

<!-- 4. Solve the scenario -------------------------------------------------------------

    Goal:
        At a high level, describe how the <product> solves one of the customer tasks in your <scenario>.
        Avoid teaching how to actually do the work (you're not teaching how-to-use in this module).

    Heading:
        "## How to <solve scenario>"

    Pattern:
        1. H2 heading.
        2. Lead sentence that summarizes how the <product> solved the <scenario>.
        3. Additional text as needed (typically 1-2 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "How to implement a Twitter monitor"
        Lead sentence: "To implement a Twitter monitor, you map each task to a Logic Apps component and connect them with conditional logic."
-->

## How to <solve scenario

TODO: Add your lead sentence
TODO: Add your additional text
TODO: Add your visual element

<!-- 5. Additional content (optional, as needed) ------------------------------------------------

    Goal:
        The section is a catch-all for any information not covered in the sections above.
        Repeat the pattern here as many times as needed.

    Possible topics:
        - Key feature(s).
        - Example use case in addition to the scenario.
        - High-level of how practitioners use the product (e.g. there's an API and a web UI to support multiple use cases).
        - Business value (e.g. it lets you do something that would be difficult to achieve without <product>).

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote (image preferred).

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple topic -->

## H2 heading

Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

<!-- Pattern for complex topic -->

## H2 heading

Strong lead sentence; remainder of paragraph.
Visual (image, table, list, code sample, blockquote)

### H3 heading

Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)

### H3 heading

Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->