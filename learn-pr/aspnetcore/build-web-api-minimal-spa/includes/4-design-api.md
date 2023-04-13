If the back end and front end of your app live in two different places, you need to configure something called *cross-origin resource sharing*, or CORS.

## Connect to a back end

You have a front-end app. What do you need to think about for the back-end application? Well, you're either:

- **Working against mocked data.** During the development phase, you can work independently, as a standalone team. But you still want to build out the application and at least emulate that you're working with an API.
- **Talking to a real API.** If you're in this phase, the back-end team has built the API, and now you want to connect it to your front end.

## Mock an API

As you build your front-end app, you know that a back-end team will be done building the API at some point. Do you wait for the back-end team to finish, before you build the corresponding view? There are different approaches you can take here:

- **Build a vertical:** In this approach, you work closely with the person building the back end. You build your front-end part, and then the back-end developer builds their part. When both parts work, you have a _full vertical_, and you can continue to the next feature. This approach is viable, but it does force the teams to be very in sync.

- **Mock the data:** This approach has fewer requirements for close coordination between teams. In this scenario, the front-end developer negotiates with the back-end team, with regard to what the response from the back end will look like. When you agree, you start creating mock data, static files that the front-end team uses instead. The front-end team can now move at any desired development speed. At some point, you do need to synchronize with the back-end team, to ensure that the back end was built according to what you agreed on.

### Use the json-server library

The `json-server` library creates a RESTful API for you, from a static JSON file. You give `json-server` a file that looks like the following example:

```json
{
  "pizzas": [
    { "id": 1, "name": "Cheese Pizza" },
    { "id": 2, "name": "Al Tono" }
  ]
}
```

To use `json-server`, you use an executable `npx` that comes with your Node.js installation. You start your mock API by calling the executable `npx`, the name of the package `json-server`, and the name of the static file containing your API data. Here's an example:

```bash
npx json-server --watch db.json
```

### How does this work?

At this point, your mocked API will start to be served at a certain port (for example, "5000"). Furthermore, you can interact with it as though it were a real API. It supports requests like the following:

```output
GET    /pizzas
GET    /pizzas/1
POST   /pizzas
PUT    /pizzas/1
PATCH  /pizzas/1
DELETE /pizzas/1
```

If you make any requests toward this mocked API and change data, the static file _db.json_ would change. The server would rebuild and relaunch, to reflect the changes.

### What about the front-end app?

Because this mocked API works exactly like a real API, you can make requests to it in your front-end code. For example:

```javascript
fetch("http://localhost:5000/pizzas")
  .then(response => response.json())
  .then(data => console.log(data)) // outputs mocked data 
```

### Use a proxy

To save yourself a few keystrokes, you can define a proxy in your front-end app. Imagine that you're doing requests toward `http://localhost:5000/pizzas`. If you don't want to type out the full domain, you can create a proxy, an alias. To set up a proxy, go to _package.json_, and add an entry like the following:

```json
"proxy": "http://localhost:5000"
```

Instead of making requests toward `http://localhost:5000/pizzas`, you can now make them toward */api/pizzas*. *api* resolves to `http://localhost:5000` when you make requests. It's not mandatory to use proxies, but you might appreciate their convenience.

## Talk to a real API

After the real API is finished, you should have the front-end app make requests toward that API, instead of the mocked API. Doing so helps ensure that everything is working as it should.

However, when you first try to talk to your real back end, you might get an error that looks something like the following:

```output
Access to fetch at http://localhost:5000 from origin 'http://localhost:3000' has been blocked by CORS policy...
```

This error tells you that the front-end app isn't allowed to call the back end, because the front end comes from a different place than the back end is residing. One is running on port 3000, and the other on port 5000. The good news is that you can fix this error by implementing CORS on the back end.  

> [!NOTE]
> When your front end and back end run on the same domain and port, you won't get CORS issues. Configuring CORS is only needed if the front end and back end run on different places.

## CORS

CORS is a protocol that allows a back end to accept requests from domains other than the one it's currently running on. This is a security feature.

Suppose the calling client makes a request toward a back end, and starts by sending a preflight request by using the `OPTIONS` verb. Essentially, the calling client is asking the back end what it can perform toward a resource. The back end can approve or deny the request, at which point the actual request (such as `GET` or `POST`) goes through. Imagine the following flow below:

```output
client> OPTIONS, can I do POST on /pizzas?
server> you can do GET on /pizzas
client> receives a deny response at this point
```

Another more successful attempt might look like the following:

```output
client> OPTIONS, can I do GET on /pizzas
server> you can do GET on /pizzas
client> receives data from back end
```

### Configure CORS on the server

The CORS configuration is the responsibility of the server. How that's configured depends on the runtime the server is using. Here's how you can do it in your _Program.cs_ file:

```csharp
// 1) define a unique string
readonly string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";

// 2) define allowed domains, in this case "http://example.com" and "*" = all
//    domains, for testing purposes only.
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: MyAllowSpecificOrigins,
      builder =>
      {
          builder.WithOrigins(
            "http://example.com", "*");
      });
});
// 3) use the capability
app.UseCors(MyAllowSpecificOrigins);
```

The preceding code shows that a policy is added. As part of the policy, you add the domains that are allowed to talk with the API to an allowlist. In this case, you add `http://example.com` and `*` to your allowlist. Essentially, `*` means that all possible domains are allowed. If you only want specific domains to be allowed, specify only the ones you want.

Lastly, the `UseCors()` method is called. You can offer more fine-grained control than what is shown in the preceding example. You can decide that only certain HTTP verbs, for example, should be allowed for certain routes.
