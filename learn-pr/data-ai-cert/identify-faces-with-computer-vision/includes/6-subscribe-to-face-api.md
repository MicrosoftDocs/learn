To gain access to a Microsoft Cognitive Service API, you must subscribe to a specific service, typically through the Azure portal.

Since the APIs are exposed through REST-based web services, any language that can build and send an HTTP message can use the services. There are two things needed: a **subscription key** and the **endpoint**.

Most Azure Cognitive Services, including the Computer Vision service, requires authorization using a **Subscription Key**. Every web service call to the Computer Vision API requires a subscription key be passed to the service either through a value in the query string or in the request header.

The _endpoint_ is the Internet URL for the service. For applications to use the services, the application must point to the URL specified in the endpoint configuration for that service. The combination of the endpoint and key allows your application to use the service.
