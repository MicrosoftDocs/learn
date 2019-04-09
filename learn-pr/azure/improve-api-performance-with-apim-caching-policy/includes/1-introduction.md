<!-- Introductory text here: motivational scenario and lead-in. No headers above this. See https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master -->


API Management policies are configurable modules that can be attached to APIs to change their behaviors. Policies can do things like cache responses, transform documents and values, call webhooks for notification or audit purposes, and retry requests in the event of transient failures. This module will use policies to enable caching in order to improve API performance under load.

 Suppose you are a developer for a board game company. A product line produced by your company has recently become very popular, and the volume of requests from your retail partners to your inventory API is growing quickly: much faster than the rate that your inventory actually changes. You'd like to be able to respond to requests successfully without incurring load on your API.
 
 ## Learning objectives

In this module, you will:

1. Identify whether or not a policy exists for the desired behavior
1. Choose a policy scope
1. Configure and apply a caching policy in the Azure portal

## Prerequisites

<!-- Bullet list copied from index.yml. If there are no prerequisites, remove this section -->

- Experience with publishing an API in Azure API Management
- Experience with XML syntax
