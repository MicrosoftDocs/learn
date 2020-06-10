HTTP is a protocol. It's what is used on the web to connect documents via hyperlinks. The idea with HTTP is to work via a request-response pattern. A user requests information and a server responds. That response contains status information but in some cases also a body of information.

The World Wide Web or the *The Web*  for short is an information system. The system contains documents connected via hypermedia links and also other web resources. Any document or web resource is accessible by using a Web Browser or any other type of client or code. This assumes that you are connected to the Web as well. An app built for the Web is a collection of documents and other web resources. In the webs inception developers would hand craft these resources and copy them to a web server connected to the Web. As time passed frameworks were created that helped developers think of their web resources as apps rather than loosely coupled resources. The introduction of frameworks also meant that what developers put out on the Web grew from being a few files to thousands or even millions of files.

So why would you develop something for the Web? The benefits are many:

- Reach, when you build an application for the Web it's reachable through a Uniform Resource Locator, for short URL. A URL is an address pointing to a web resource or document that anyone connected to the Web can reach. Compare this to installing a client application on one computer that only the user of that computer would be able to reach and use.
- Easy install and update, a web application that's been deployed to a Web Server is ready to be accessed by a client. A common form of client is Web Browser. There's usually no need to install or update anything to have your Web Browser consume the Web application.

## Client

A Web Client can come in many forms. The most common type of Web Client is a Web Browser. There's also other types of clients like cURL that has the ability to connect to the Web and communicate over HTTP to ask for a few resources. It's also possible to connect to the Web via code.

## Server

A Web server is a software or hardware with the capability of handling Web requests that is directed at it using HTTP. It's capable of returning information but also process incoming data and create resources from it. The server ends up responding to requests with either a document or another type of web resource. Usually there's a process involved in which an incoming request is translated into a call towards a data source like a  database or API endpoint. The response from the data source is then merged together with HTML markup and returned back to the client. There's also a more static type of process in which an asset like an image or a stylesheet is returned without the involvement of a data source. Both these processes usually exist to a smaller or lesser degree in web app and needs to be handled.

## Headers

Requests and responses can have headers. The headers are used to communicate information on the incoming request but also to communicate information on the outgoing response. For example, a header can specify the desired content type or the size of the incoming data payload so the server knows how much data is being sent across. A response header on the other hand can communicate what type of data is sent back so the client knows how to render it. It can also signal through a status code how the incoming request was received. Through the status code, it can state that a new resource was created on the server side or that the resource was moved for example. Additionally it can also signal a variety of things such as that an error occurred when making the request.

## Content types

The Web isn't just documents. In fact, there are many other types of web resources that can be sent as well as received. There are different content types like text, JSON, images and much more. All these content types mean your app can constitute a rich experience. It's good if the web server can communicate back to the client what type of resource it's sending back from a request so that the client can interpret and render it correctly. A modern web browser is good at figuring out what content is sent from a browser though through a process called *content sniffing*. Even though browsers have this capability it's good if a web application can be as specific as possible in specifying the content type. It's not always that the client is a modern browser.

## Node.js http module

Node.js comes with a built-in http module. It's a fairly small module that is competent in handling most types of requests. It's able to work with important topics such as headers, the URL, and payloads being sent across.

An incoming request usually goes through the following phases:

1. Headers are sent.
1. Headers are read on the server side.
1. Data is sent.
1. Data is read on the server side.
1. A message is sent that there is no more data and connection closes.
1. A response is constructed and transmitted.

The below classes help with managing a request from start to finish:

- **http.Server**, this represents an instance of an HTTP Server. This is what we will work with most to start listening to different events on a specific port and address.
- **http.IncomingMessage**, this is a readable stream created either by `http.Server` or `http.ClientRequest`. You can use it to access things such as status, headers, and data.
- **http.ServerResponse**, this is a stream created internally by the HTTP Server. This class enables you to define what the response should look like in terms of what headers it should have, what the response should be and so on.

### http.Server

The server is an instance that while it's running is capable of handling incoming requests. While it's running, it listens to a specific address and port.

### http.IncomingMessage

This is a stream that you can listen to for information on headers, status, and incoming data. A stream is a construct that represents data that continuously flows through it. It is possible to *listen* to different events that happen to a stream. These events represent state changes. Examples of such events are:

- `data`, this is an event that signals that there is data ready to be processed.
- `error`, this event signals that an error occurred, it usually comes with an error message describing what happened
- `close`, this event signals that there is no more data to be sent in the stream and that is now closing. No more events will be raised after this.

As part of handling a request from start to finish these events can be subscribed to. To subscribe to an event, you would write a piece of code looking roughly like so:

```javascript
stream.on('<name of event>', () => {
  // this is a function handling the event
})
```

### http.ServerResponse

ServerResponse is also a stream. As a server you are not interested to listen to this stream but rather write to it. You can write different types of information to this stream such as headers and content that you want the calling client to receive back from their request.

As soon as you call the method `end()` on the `http.ServerResponse` instance the response is sent back to the client and the connection is thereafter closed.
