Making calls to web resources can result in long wait times for the user. To avoid blocking the user interface (UI) thread, you can access web resources asynchronously.

## Web resources

A web resource is any data or service that's accessible over the internet. This includes web pages, Application Programming Interfaces (APIs), images, videos, and other types of content. Applications retrieve or interact with web resource using standard web protocols such as Hypertext Transfer Protocol (HTTP) or HTTP Secure (HTTPS).

One common use case for accessing web resources is to retrieve data from a remote server or service. This can include fetching JSON or XML data, downloading files, or interacting with web APIs. For example, you might want to access a weather API to get the current weather conditions for a specific location, or you might want to download an image from a URL.

Representational State Transfer (REST) APIs are a popular way to access web resources, as they provide a standardized way to interact with web services using HTTP methods such as GET, POST, PUT, and DELETE. REST APIs are widely used in web development, mobile applications, and cloud services to enable data exchange and integration between different platforms. REST APIs typically return data in JavaScript Object Notation (JSON) format, which is lightweight and easy to parse.

In C#, you can use the `HttpClient` class to make HTTP requests to web resources.

## Use HttpClient for asynchronous API calls

The `HttpClient` class is part of the `System.Net.Http` namespace, which provides classes for sending HTTP requests and receiving HTTP responses. The `HttpClient` class is designed to be used asynchronously, allowing you to make nonblocking calls to web resources.

The `HTTPClient` class includes the following asynchronous methods:

- `GetAsync`: Sends a GET request to the specified URI and returns the response.
- `PostAsync`: Sends a POST request to the specified URI with the specified content and returns the response.
- `PutAsync`: Sends a PUT request to the specified URI with the specified content and returns the response.
- `DeleteAsync`: Sends a DELETE request to the specified URI and returns the response.
- `SendAsync`: Sends an HTTP request message and returns the response.

The following code sample demonstrates how to use the `HttpClient` class to make an asynchronous GET request to a REST API and process the response:

```csharp

// Code that demonstrates the use of asynchronous REST API calls in C#

using System;
using System.ComponentModel;
using System.Net.Http;
using System.Threading.Tasks;
using System.Text.Json;

namespace ConsoleApp
{
    class Program
    {
        static async Task Main(string[] args)
        {
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    // PetStore API endpoint
                    string url = "https://petstore.swagger.io/v2/pet/findByStatus?status=available";
                    HttpResponseMessage response = await client.GetAsync(url);
                    response.EnsureSuccessStatusCode();
                    string responseBody = await response.Content.ReadAsStringAsync();
                    //Console.WriteLine($"Response: {responseBody}");

                    // Deserialize the JSON response into a list of pets
                    var pets = JsonSerializer.Deserialize<List<Pet>>(responseBody);

                    // Iterate through the list of pets and display their details
                    foreach (var pet in pets)
                    {
                        //Console.WriteLine($"Pet ID: {pet.id}, Name: {pet.name}");
                        if (pet.id.ToString().Length > 4)
                        {
                            Console.WriteLine($"Pet ID: {pet.id}, Name: {pet.name}");
                        }
                    }
                }
                catch (HttpRequestException e)
                {
                    Console.WriteLine($"Request error: {e.Message}");
                }
            }
        }
    }
}
public class Pet
{
    public long id { get; set; }
    public string name { get; set; }
    public Category category { get; set; }
    public List<string> photoUrls { get; set; }
    public List<Tag> tags { get; set; }
    public string status { get; set; }
}

public class Category
{
    public long id { get; set; }
    public string name { get; set; }
}

public class Tag
{
    public long id { get; set; }
    public string name { get; set; }
} 

```

In this example, the `HttpClient` class is used to send an asynchronous GET request to the PetStore API. The response is read as a string and deserialized into a list of `Pet` objects using the `JsonSerializer` class. The code then iterates through the list of pets and displays their details. The `using` statement ensures that the `HttpClient` instance is disposed of properly after use, releasing any resources it holds.

The `HttpClient` class is designed to be reused for multiple requests, so it's recommended to create a single instance of `HttpClient` and use it throughout the application. This helps improve performance and resource management by reusing the underlying network connections.

## Summary

In this unit, you learned how to access web resources asynchronously using the `HttpClient` class. You also learned how to make asynchronous API calls to retrieve data from a REST API and process the response. By using asynchronous programming techniques, you can improve the responsiveness of your applications and provide a better user experience.

## Key points

- Web resources can be accessed asynchronously to avoid blocking the UI thread.
- REST APIs provide a standardized way to interact with web services.
- The `HttpClient` class in C# is designed for asynchronous use, allowing nonblocking calls to web resources.
- The `HttpClient` class includes asynchronous methods like `GetAsync`, `PostAsync`, `PutAsync`, `DeleteAsync`, and `SendAsync`.
- A single instance of `HttpClient` should be reused for multiple requests to improve performance and resource management.
