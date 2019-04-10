<!-- Guidance on writing the introductory text in a learning unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-learning-unit-introduction-format -->

<!-- Use this syntax for any TODOs or notes to yourself or reviewers -->

<!-- If you have any relevant links to other content (in Learn, Docs or anywhere else), include it only in the Learn More section in the final Summary unit. -->

<!-- Images: all images must be original. Work with the team to submit an image creation request if new art is needed. See here for requirements on screenshots: https://review.docs.microsoft.com/en-us/help/contribute/contribute-how-to-create-screenshot?branch=master -->

<!-- Don't include a summary section in individual units -->

<!-- Don't include a sentence or section to transition to the next unit. The platform will insert the name of the next unit above the navigation button at the bottom -->
You can use APIM to control many aspects of an already deployed API changing its behaviour via the use of policies. There is a need on the Board Gaming site to provide a faster response to requests for the costs of various sizes of board for various games shipped to the uk or other areas of the world. API management can by use of its policies and various elements provide a solution t0 this issue. First lets look at what policies can be used to do.


## What are policies ?
Policies are formed of individual statements which are executed in order. The policy documents themselves are xml structures which contain configurable policy elements used to control the behaviour of the API.

## Where do policies execute ?
Policies execute in specific processing areas within the APMI API section.You apply them to either the inbound processing tags to modify requests before they reach the backend or the outbound processing tags to modify the response before it is sent to the client. The backend tag can be used control An on error tag can be added to control what happens when an error occurs .


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
```

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


**Elements used for restricting access**

These can be useful when you want to stop access or limit the number of times an API can be accessed from a particular source

The **Check HTTP header** element is used to check for the existence or a particular value in an HTTP Header.

The **Limit call rate by subscription**  element is used to limit the number of calls based on the subscription.

The **Limit call rate by key** element  limits the call rate based on the key.

The **Restrict caller IPs** element is used to allow or deny calls from specific IPs or ranges of IP adressses.

**Advanced elements**

These can be of use in scenarios when you want a non standard behaviour of as the result of using the request object or a conditional element introduced into the processing logic 

The **Control flow** element is used to apply policy statements based on a Boolean expression.

The **Forward request** element is used to send on or forward a request to a backend server.

The **Retry** element retries execution of the policy statements enclosed within an if statement  and until a condition is met. Execution will repeat at the specified time intervals up until the retry count value is reached.

The **Send one way request** element enables sending a request to a URL without waiting for a response.

The **Set variable** element will persist a value in a named variable within the context.

**Elements for Authentication**

These provide the ability to enforce Basic Authentication or athentication via client certificates

The **Authenticate with Basic** element as it says, authenticates with Basic Authentication.

The **Authenticate with client certificate** element provides authenticates with backend services using client certificates

**Caching policies elements**

These provide various ways of caching responses and accessing the cache.

The **Get from cache** element performs a cache look up and return a valid cached response when available.

The **Store to cache** elementc aches response according to the specified cache control configuration.

The **Get value from cache** element retrieves a cached item by key.

The **Store value in cache** stores an item in the cache by key.

The **Remove value from cache** element removes an item in the cache by key.

**Cross domain policies elements**

The **Allow cross-domain calls** element enables your API to be called from Adobe Flash and Silverlite

The **CORS** element enables cross-origin resource sharing (CORS) support to an operation within an API or an API to allow  calls acress domains from browser-based clients.

The **JSONP** element adds JSON with padding to allow calls  accross domains from JavaScript browser-based clients.

**Transformation policies** 

These can be very useful when a client needs a response or request to be  converted.

The **Convert JSON to XML** and **Convert XML to JSON** elements both do a conversion to and from JSON and XML formats

**Find and replace string in body** this as its name says enables you to find and replace strings in the body.

The **Mask URLs in content** element is used to re-write any links in the response body so that they point to the equivalent link via the gateway.

The **Set backend service** element changes the backend service being targeted for an incoming request.

The **Set body** element is used to set the message body for incoming and outgoing requests.

The **Set HTTP header** element  adds items to an existing response or request header or can be used to create completely new ones.

The **Set query string parameter** element Adds or  replaces the value of, or deletes request query string parameter.

The **Rewrite URL** element converts a request URL from its public form to a form expected a particularWeb service
.
Transform XML uses an XSLT template to carry out  XSL transformation to XML in the request or response body.

