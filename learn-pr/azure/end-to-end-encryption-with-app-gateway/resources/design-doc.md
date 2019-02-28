# Module Design

## Title

Encrypt network traffic end-to-end with Azure Application Gateway

## Role(s)

- Solution architect
- Developer

## Level

- Intermediate

## Product(s)

- Azure Application Gateway

## Prerequisites

- Basic understanding of SSL/TLS encryption
- Basic knowledge of PowerShell
- Basic knowledge of networking concepts

## Summary

Secure the traffic from your end user all the way through to your web servers by enabling TLS encryption on Application Gateway.

## Learning objectives

- Implement TLS encryption between your end users and Application Gateway
- Implement TLS encryption between Application Gateway and your web server

## Chunk your content into subtasks

Identify the subtasks of *Encrypt network traffic end-to-end with Azure Application Gateway*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
||||||

## Outline the units

1. **Introduction**

    A retail organization has a new shipping portal they are publishing to allow vendors to ship customer items and track status. This exposes business and customer data, and needs to be encrypted between the user and the back end application to ensure this data is not exposed while transmitted over the network. They have implemented Application Gateway to load balance their traffic, and need to enable TLS encryption between the user and their servers.

2. **Learning-content unit title**

    List the content that will enable the learner to *subtask*:

    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

3. **Knowledge check**

    What types of questions will test *learning objective*?

    - Question type
    - Question type

4. **Exercise - exercise unit title**

    List the steps which apply the learning content from previous unit:

    1. Step
    2. Step
    3. Step

5. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

End-to-end encryption in AppGW - https://docs.microsoft.com/en-us/azure/application-gateway/application-gateway-end-to-end-ssl-powershell

AppGW takes a while to spin up, so for the exercise we may want to kick that off early, go over some concepts, then come back when it's running. We'll also need a server with a basic web site that we can use to test. Don't use VMSS like the example as they are not available in the sandbox environment, just use a single VM.

Suggestion for video might be an overview of the traffic flow and how the encrypted traffic flows through.
