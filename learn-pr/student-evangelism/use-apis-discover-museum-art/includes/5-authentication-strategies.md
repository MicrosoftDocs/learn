The Metropolitan Museum's API is open to the public and doesn't require authentication. The only request is that users "limit request rate to 80 requests per second." This level of openness is a little unusual for an API. Usually, the organization that manages a publicly facing API requires some kind of access authentication to protect itself from unwanted overuse of the endpoints.

If an API requires authentication, you won't be able to make calls to get data directly via URL calls. Instead, you'll need to use a *request header*, which is an object that's sent with your request and that uses an HTTP call.

> [!Note]
> Always use authentication over a secure HTTPS connection.

## Using HTTP protocols to authenticate

The HTTP protocol provides developers with several authentication strategies, including Basic and Bearer. Basic authentication isn't inherently secure because it requires you to pass a user name and password through a request header directly. Here's an example:

`Authorization: Basic abcdef12345==`

You're more likely to see Bearer authentication. Bearer authentication requires a token, retrieved before the authentication call, that must be passed in the request header:

 `Authorization: Bearer <my-token>`

## Using API keys to authenticate

API keys are common in API architecture. They can show up in various places: passed via body data as JSON, sent through a query string, or sent via a custom header or an authorization header.

Keys are an easy way to form a handshake between your code and an API, but they're not inherently secure. In theory, anyone could use a key if they can intercept it via a network call. 

>[!TIP] 
>It's a good idea to store your API keys in the cloud and access them via a function that calls an environment variable. But that method is out of scope for this tutorial!

## OAuth

Using an API key can easily get complicated, but it's the most common way to authenticate to use an API. Yet another way to authenticate and use an API is via [OAuth](https://oauth.net/2?azure-portal=true). OAuth, particularly version 2, provides a more fine-grained authentication strategy. The user is directed to the API's site and then completes one of many flows allowed by OAuth to enable access. Many scenarios are possible. But OAuth basically enables the creation of an API key and uses the key to authenticate a token that allows limited access to an API for limited operations. In this way, a user can use an [access token](https://www.oauth.com/oauth2-servers/access-tokens?azure-portal=true) in web calls to ensure access to various parts of the API, for specific uses and specific time periods.

API keys are different from access tokens in that keys provide authorization but not authentication. Access tokens provide a more secure way to access sensitive endpoints.  

In the next unit, you'll query an API that uses OAuth 2: the Smithsonian's Cooper Hewitt National Design Museum.