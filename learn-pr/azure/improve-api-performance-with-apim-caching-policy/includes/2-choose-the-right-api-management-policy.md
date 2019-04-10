<!-- Guidance on writing the introductory text in a learning unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-learning-unit-introduction-format -->

<!-- Use this syntax for any TODOs or notes to yourself or reviewers -->

<!-- If you have any relevant links to other content (in Learn, Docs or anywhere else), include it only in the Learn More section in the final Summary unit. -->

<!-- Images: all images must be original. Work with the team to submit an image creation request if new art is needed. See here for requirements on screenshots: https://review.docs.microsoft.com/en-us/help/contribute/contribute-how-to-create-screenshot?branch=master -->

<!-- Don't include a summary section in individual units -->

<!-- Don't include a sentence or section to transition to the next unit. The platform will insert the name of the next unit above the navigation button at the bottom -->


## Choosing the right policy

You can use APIM to control many aspects of an already deployed API changing its behaviour via the use of policies. Policies are formed of individual statements which are executed in order.You apply them to either the inbound processing tags to modify requests before they reach the backend or the outbound processing tags to modify the response before it is sent to the client. The backend tag can be used control An on error tag can be added to control what happens when an error occurs .

The policy documents themselves are xml structures which contain configurable policy elements used to control the behaviour of the API.


```xml
<policies>
    <inbound>
        <base />
        <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" downstream-caching-type="none" must-revalidate="true" caching-type="internal" >
            <vary-by-query-parameter>version</vary-by-query-parameter>
        </cache-lookup>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <cache-store duration="seconds" />
        <base />
    </outbound>
    </on-error>
        <base />
    </on-error>
</policies>

For example if you wish to cache a response for a certain amount of time you would first need to choose a scope for the policy ie does it apply to every API, a particular API and all of its operations or a particular operation within an individual API.

You would then add the appropriate policy element to the policy , in this case the cache-lookup  in the inbound tag and the cache-store duration in the outbound tag.

The syntax for the element is the same regardless of the scope chosen.

## Policy Scopes

Policys are evaluated in order of scopes Global, Product, API, Operations.

**The Global Policy Scope**

Choosing the All APIS menu item gives you access to the Global Scope. Policies applied at this level apply to all APIs within the APIM.

![Global All API Scope](../media/GlobalScope.png)

The XML editor is accessed by clicking on the tag symbol **</>**

![Global Scope Editor](../media/GlobalScopeEditor.png)


You can select add policy in either the inbound or outbound processing tag areas to open a wizard to apply policy elements rather than selecting the policy tag **</>** and adding elements directly to the xml structure.the menu 

![Global All API Scope](../media/globalpolicywiz.png)



**The Product Policy Scope**

This is used for configuring various items as well as policies

![Product Scope](../media/ProductsScope.png)


**API Policy Scope**

This scope is for all operations of a particular API

![API Scope](../media/APIscope.png)



**Operation Scope**

This scope is for individual operations of an API

![API Scope](../media/OperationScope.png)


**Some access restriction policy examples**

Check HTTP header is used to check for the existence or a particular value in an HTTP Header.

Limit call rate by subscription this is use to limit the number of calls based on the subscription.

Limit call rate by key  limits the call rate based on the key.

Restrict caller IPs is used to allow or deny calls from specific IPs or ranges of IP adressses.

**Some Advanced policy examples**

Control flow is used to applies policy statements based on a Boolean expression.

Forward request is used to send on or forward a request to a backend server.

Retry this  retries execution of the policy statements enclosed in its scope if and until the condition is met. Execution will repeat at the specified time intervals up until the retry count value is reached
.
Send one way request will enable the sending of a request to a URL without waiting for a response.

Set variable will persist a value in a named variable within the context

**Authentication policies**

Authenticate with Basic this does as it says, it authenticates with Basic Authentication.

Authenticate with client certificate this authenticates with backend services using client certificates

**Caching policies Creating these is the main emphasis of this module**

Get from cache - Perform cache look up and return a valid cached response when available.
Store to cache - Caches response according to the specified cache control configuration.
Get value from cache - Retrieve a cached item by key.
Store value in cache - Store an item in the cache by key.
Remove value from cache - Remove an item in the cache by key.

**Cross domain policies**

Allow cross-domain calls enables your API to be called from Adobe Flash and Silverlite

CORS enables cross-origin resource sharing (CORS) support to an operation within an API or an API to allow  calls acress domains from browser-based clients.
JSONP adds JSON with padding to allow calls  accross domains from JavaScript browser-based clients.

**Transformation policies** 

These can be very useful when a client needs a response or request to be  converted.

Convert JSON to XML and Convert XML to JSON both do a conversion to and from JSON and XML formats

Find and replace string in body this as its name says enables you to find and replace strings in the body.

Mask URLs in content will re-write any links in the response body so that they point to the equivalent link via the gateway.

Set backend service changes the backend service for an incoming request.

Set body is used to set the message body for incoming and outgoing requests.

Set HTTP header adds items to an existing response or request header or can be used to create completely new ones.

Set query string parameter - Adds, replaces value of, or deletes request query string parameter.

Rewrite URL Converts a request URL from its public form to a form expected a particularWeb service
.
Transform XML uses an XSLT template to carry out  XSL transformation to XML in the request or response body.

