<!-- Guidance on writing the introductory text in a learning unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-learning-unit-introduction-format -->

<!-- Use this syntax for any TODOs or notes to yourself or reviewers -->

<!-- If you have any relevant links to other content (in Learn, Docs or anywhere else), include it only in the Learn More section in the final Summary unit. -->

<!-- Images: all images must be original. Work with the team to submit an image creation request if new art is needed. See here for requirements on screenshots: https://review.docs.microsoft.com/en-us/help/contribute/contribute-how-to-create-screenshot?branch=master -->

<!-- Don't include a summary section in individual units -->

<!-- Don't include a sentence or section to transition to the next unit. The platform will insert the name of the next unit above the navigation button at the bottom -->
Many firms need to optimize access to and serving of Web pages. Caching enables you to serve an already constructed page or response without having to create it again.

As the developer at a Board Game company you need to investigate the various types of tags and attributes that can be used in a caching policy at caching 
 
## Write a caching policy

The **cache-lookup policy** is placed in the inbound tag it must have a corresponding **cache-store policy** in the outbound tag

To do this first Add an inbound Policy selecting cache responses

![Add website URL](../media/cacheinbound.png)

set the number of seconds to cache the operation for.

![Add website URL](../media/cachesetduration.png)

You will note a corresponding **cache-store** policy has been created in the outbound tag


![Add website URL](../media/cachein-out.png)


Access to the editor can now be gained. Note the sets of snippets available on the right hand side.

![Add website URL](../media/cacheeditorview.png)

**A policy statement template**

``` xml
<cache-lookup vary-by-developer="true | false" vary-by-developer-groups="true | false" caching-type="prefer-external | external | internal" downstream-caching-type="none | private | public" must-revalidate="true | false" allow-private-response-caching="@(expression to evaluate)">
  <vary-by-header>Accept</vary-by-header>
  <!-- should be present in most cases -->
  <vary-by-header>Accept-Charset</vary-by-header>
  <!-- should be present in most cases -->
  <vary-by-header>Authorization</vary-by-header>
  <!-- should be present when allow-private-response-caching is "true"-->
  <vary-by-header>header name</vary-by-header>
  <!-- optional, can repeated several times -->
  <vary-by-query-parameter>parameter name</vary-by-query-parameter>
  <!-- optional, can repeated several times -->
</cache-lookup>

```

You can add items to a policy template

```xml
<policies>
    <inbound>
        <base />
        <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" downstream-caching-type="none" must-revalidate="true" caching-type="internal" >
            <vary-by-query-parameter>version</vary-by-query-parameter>
        </cache-lookup>
    </inbound>
    <outbound>
        <cache-store duration="seconds" />
        <base />
    </outbound>
</policies>
```

## Elements in a document

1. **Cache-lookup** is the root elemt and must be present. 

1. **vary-by-header** caches responses per value of specified headerch i.e. Accept, Accept-Charset, Accept-Encoding, Accept-Language. Not required

1. **vary-by-query-parameter** caches responses per value of the query parameters  specified. They can be single or multiple seperated by semiscolon. If no parameters are specified  all used. Not required.

## Attributes in a document

1. The **allow-private-response-caching** when set to true enables the caching of requests that contain an Authorization header.

1. The **caching-type**	if set to internal  uses the API Management cache. If set to external it uses an external Azure Cache for Redis in Azure API Management.

1.The  **prefer-external** will use external cache if configured or internal cache if an external cache is not configured

1. The **downstream-caching-type**can be set to either none, private or public.

1. The **must-revalidate** attribute turns on or off the must-revalidate cache control directive in gateway responses.

1. The **vary-by-developer** attribute when set to true caches responses per subscription key.

1. The **vary-by-developer-groups**	attribute when set to true caches responses per user group.


By using combinations of the above elements and attributes caching policies are constructed.

