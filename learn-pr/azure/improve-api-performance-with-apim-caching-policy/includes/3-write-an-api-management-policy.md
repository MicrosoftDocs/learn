<!-- Guidance on writing the introductory text in a learning unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-learning-unit-introduction-format -->

<!-- Use this syntax for any TODOs or notes to yourself or reviewers -->

<!-- If you have any relevant links to other content (in Learn, Docs or anywhere else), include it only in the Learn More section in the final Summary unit. -->

<!-- Images: all images must be original. Work with the team to submit an image creation request if new art is needed. See here for requirements on screenshots: https://review.docs.microsoft.com/en-us/help/contribute/contribute-how-to-create-screenshot?branch=master -->

<!-- Don't include a summary section in individual units -->

<!-- Don't include a sentence or section to transition to the next unit. The platform will insert the name of the next unit above the navigation button at the bottom -->
Many firms need to optimize access to and serving of Web pages. Caching enables you to serve an already constructed page or response without having to create it again.

As the developer at a Board Game company you need to investigate the various types of tags and attributes that can be used in a caching policy at caching 
 
## Write a aching policy

The **cache-lookup policy** is placed in the inbound tag it must have a corresponding **cache-store policy** in the outbound tag

To do this first Add an inbound Policy selecting cache responses

![Add website URL](../media/cacheinbound.png)

set the number of seconds to cache the operation for.

![Add website URL](../media/cachesetduration.png)

You will note a corresponding **cache-store** policy has been created in the outbound tag


![Add website URL](../media/cachein-out.png)


Access to the editor can now be gained. Note the sets of snippets available on the right hand side.

![Add website URL](../media/cacheeditorview.png)




