# Module Design

## Title

Improve the performance of an API by adding a caching policy in Azure API Management

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- Azure
- Azure API Management

## Prerequisites

- Experience with publishing an API in Azure API Management

## Summary

API Management policies are configurable modules that can be attached to APIs to change their behaviors. Policies can do things like cache responses, transform documents and values, call webhooks for notification or audit purposes, and retry requests in the event of transient failures. This module will use policies to rate-limit API consumers in order to control load.

## Learning objectives

1. Identify whether or not a policy exists for the desired behavior
1. Choose a policy scope
1. Configure and apply a caching policy in the Azure portal

## Chunk your content into subtasks

Identify the subtasks of *Improve the performance of an API by adding a caching policy in Azure API Management*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---------|-------------------------------------------------------------------|----------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
|         |                                                                   |                                                          |                                                  |                                                                                                                                |

## Outline the units

1. **Introduction**

    You are a developer for a board game company. A product line produced by your company has recently become very popular, and the volume of requests from your retail partners to your inventory API is growing quickly: much faster than the rate that your inventory actually changes. You'd like to be able to respond to requests successfully without incurring load on your API.

*Add additional units. Examples*

1. *Learning content unit*

    *{List the content that will enable the learner to carry out a subtask.}*

1. *Knowledge check or exercise unit*

    *{List the steps of the exercise, or describe the knowledge check questions.}*

1. Summary

    *{How did you solve the scenario problem with the knowledge learned in the module?}*

## Notes

- This module uses caching as a vehicle for introducing policy more generally. The prerequistes only assume the most basic of knowledge around publishing an API in APIM.