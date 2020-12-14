Now that you have learned about the Face API, let’s cover how you will use it. The API is exposed as a REST-based web service. This means that you can send requests using HTTP following a common pattern. You can connect using the HTTP library in your preferred programming language. However, a client SDK is available in several programming languages as well. This is a wrapper over the HTTP calls and will reduce how much code you need to write to work with the Face API. The client SDK is used in this module.

The first step to use the Face API is to subscribe to the service. You will see how to do that through Azure portal in the next exercise. Before you get hands on, let’s cover a few key points around subscribing and consuming from the Face API.

## Subscription key and endpoint

The Face API, like most Cognitive Services, requires authorization with a subscription key (sometimes called an API key). This key should be kept secret to make sure no one else can use your resources. You will include the subscription key for each call to the Face API.

The endpoint is also required to connect to your service. The endpoint is the internet URL for locating the service. The endpoint is often unique, though it depends on how the service is created. Either way, though the value is important it does not to be kept secret like the subscription key.

Together, the endpoint and subscription key allow your application to use your Face API resource.
