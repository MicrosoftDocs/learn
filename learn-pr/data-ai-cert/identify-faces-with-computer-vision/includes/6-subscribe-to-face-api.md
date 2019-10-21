To access a Cognitive Services API, you must subscribe to a specific service. Typically, you do that through the Azure portal.

Because the APIs are exposed through REST-based web services, any language that can build and send an HTTP message can use the services. Two things are needed: a _subscription key_ and the _endpoint_.

Most Cognitive Services offerings, including the Computer Vision service, require authorization with a *subscription key*. Every web service call to the Computer Vision API requires a subscription key be passed to the service through a value in either the query string or the request header.

The _endpoint_ is the internet URL for the service. Applications that use the services must point to the URL that the service's endpoint specifies. 

Together, the endpoint and subscription key allow your application to use the services.