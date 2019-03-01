# Module Design

## Title

Route and process data automatically using Azure Logic Apps

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- Azure
- Azure portal
- Logic Apps

## Prerequisites

- Basic knowledge of the Azure Logic Apps concepts of connector, trigger, and action
- Experience creating and managing resources using the Azure portal at the beginner level
- Familiarity with programming concepts like conditional statements and loops

## Summary

Define a workflow using built-in triggers, actions, and conditional operators. Your workflow will run automatically when data is available, process the data in the cloud, record results in a database, and send email notifications.

## Learning objectives

1. Construct a workflow model that will solve your business problem
1. Launch your Logic App in response to an external event
1. Apply conditional Logic to filter data and select a processing path
1. Integrate Azure services into your workflow

## Chunk your content into subtasks

Identify the subtasks of *Route and process data automatically using Azure Logic Apps*

| Subtask             | What part of the introduction scenario does this subtask satisfy?              | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|----------------------|-----------------------------------------------------------------------------|----------------------------------------------------------|-----------------------------------------------|--|
| Design a Logic App | Map the business process to the Logic App connectors needed to implement it | Knowledge check                                          | 1                                             |Yes|
| Create your app      | Implement a workflow                                                        | Exercise                                                 | 2                                             |No, combine with "Add a trigger" |
| Add a trigger        | Launches the app, Twitter (Social media)                                    | Exercise                                                 | 2                                             |Yes |
| Execute an action        | Detects sentiment                         | Exercise                                                 | 3,4                                           |Yes |
| Add a control action | Conditional logic to route data to database or to send notification         | Exercise                                                 | 3,4                                           |Yes |
|                      |                                                                             |                                                          |                                               ||

## Outline the units

1. **Introduction**

    Provide a scenario of a real-world job-task that shows how the technology is used in practice (from the module proposal):

    *Suppose you work at an athletic shoe company as the IT expert on the marketing team. You're launching a new basketball shoe created by a celebrity athlete. Previous launches resulted in a social media frenzy as people shared stories and photos of themselves wearing their new shoes. The marketing team wants to monitor hundreds of social media sites, blogs, and websites to determine consumer reaction. There will be more data than you can process manually. You would like a cloud-hosted system that automates monitoring, text analytics, database storage, and email notifications.*

1. **Design Logic Apps for your workflows**

    List the content that will enable the learner to *Design a Logic App*:

    - Describe a business process
        - What is a business process?
        - Examples
        - Transform a business process into a workflow
    - Define Logic Apps
    - Map the steps of a workflow to Logic Apps components
        - Define trigger, action, and connector (these are prereqs so keep this brief)
    - Create a Logic App for the workflow
        - What is the Logic Apps Designer?

1. **Knowledge check**

    What types of questions will test *Construct a workflow model that will solve your business problem*?

    - Predict the outcome of workflows from illustrations of workflows
    - Name portions of a workflow from an image
    - Map the steps of a workflow to Logic Apps components
    
1. **Detect an external event with a trigger**

    List the content that will enable the learner to *Create an app* and *Add a trigger*:

    - How to create a Logic App in the Azure Portal
    - Describe the types of triggers?
        - What is a polling trigger?
        - What is a push trigger?
    - How to configure trigger parameters
        - What are trigger parameters?
    - How to access trigger return values
        - What are trigger return values?
    - How to add a trigger using the Designer
    - How to configure a trigger using the Designer

 
1. **Exercise - Create a social media tracker**

    List the steps which apply the learning content from previous unit:

    1. Create a new Logic App using the Azure portal
    1. Add a Twitter trigger using the Logic Apps Designer
    1. Configure the trigger
    1. Save the app so it is live
    1. Examine matching tweets in the portal
    
1. **Execute an action**

    List the content that will enable the learner to *Execute an action*:

    - Identify the types of actions
        - Actions that let you access external services (definition, examples, when to use)
        - Actions the let you manipulate data internal to your app (definition, examples, when to use)
    - Configure actions
       - Required elements
       - Optional elements
    - How to pass data from a previous step to an action
    - How to add an action in the Designer
    
1. **Exercise - Analyze the content of a Tweet**

    List the steps which apply the learning content from previous unit:

    1. Generate Text Analytics API key
    1. Create the detect sentiment action using the Designer
    1. Configure the action
    1. Save the app so it is live
    1. Examine the results in the portal
    
1. **Alter the control flow in a Logic App**
    
    List the content that will enable the learner to *Add a control action*:

    - Identify the ways the flow of data can be controlled in a Logic App
        - Describe a control action
        - List the types of control actions: condition, branch, loop, etc.
        - Describe the execution model: branch and loop iterations run in parallel
    - How to add a control action using the Logic Apps Designer
    - How to configure a control action using the Designer
    
1. **Exercise - Determine tweet sentiment**

    List the steps which apply the learning content from previous unit:
   
    1. Create a conditional control action to test the sentiment score
    1. Add an "Insert row" action
    1. Add a "Send email" action
    1. Save the app so it is live
    1. Examine the results in the portal

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - Integrated several systems that were never designed to work together
    - Automated a workflow that processed more data than could have been done manually which gives you better data to use in your analytics
    - No coding required
    - Automatic scalability with no server infrastructure or maintenance required