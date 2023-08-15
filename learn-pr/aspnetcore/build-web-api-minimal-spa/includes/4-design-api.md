Connect the front-end app to data in order to developer the UI. 

## Connect to a back-end API

You have a front-end app. What do you need to think about for the back-end application? Well, you're either:

- **Working against mocked data.** During the development phase, you can work independently, as a standalone team. But you still want to build out the application and at least emulate that you're working with an API.
- **Talking to a real API.** If you're in this phase, the back-end team has built the API, and now you want to connect it to your front-end.

## Mock an API

As you build your front-end app, you know that a back-end team will be done building the API at some point. Do you wait for the back-end team to finish, before you build the corresponding view? There are different approaches you can take here:

- **Build a vertical:** In this approach, you work closely with the person building the back-end API. You build your front-end part, and then the back-end developer builds their part. When both parts work, you have a _full vertical_, and you can continue to the next feature. This approach is viable, but it does force the teams to be very in sync.

- **Mock the data:** This approach has fewer requirements for close coordination between teams. In this scenario, the front-end developer negotiates with the back-end team, about what the response from the back-end API looks like. When you agree, you start creating mock data, static files that the front-end team uses instead. The front-end team can now move at any desired development speed. At some point, you do need to synchronize with the back-end team, to ensure that the back-end API was built according to what you agreed on.

### Use correctly formatted JSON

The `json-server` library creates a RESTful API for you, from a static JSON file. You give `json-server` a syntactically-correct JSON file that looks like the following example:

```json
{
  "pizza": [
      { "id": 1, "name": "Margherita", "description": "Tomato sauce, mozzarella, and basil" },
      { "id": 2, "name": "Pepperoni", "description": "Tomato sauce, mozzarella, and pepperoni" },
      { "id": 3, "name": "Hawaiian", "description": "Tomato sauce, mozzarella, ham, and pineapple" }
  ]
}
```

You may notice that this JSON uses double quotes for the property names. In JavaScript, you can use single quotes, double quotes, or no quotes for property names, but when using JSON outside of JavaScript, the syntax must be correct with double quotes.

### Use the json-server library

To use `json-server`, you use an executable `npx` that comes with your Node.js installation. You start your mock API by calling the executable `npx`, the name of the package `json-server`, and the name of the static file containing your API data. Here's an example:

```bash
npx json-server --watch db.json --port 5000
```

### How does this work?

At this point, your mocked API starts to be served on a certain port (for example, "5000"). Furthermore, you can interact with it as though it were a real API. It supports requests like the following:

```output
GET    /pizza
GET    /pizza/1
POST   /pizza
PUT    /pizza/1
PATCH  /pizza/1
DELETE /pizza/1
```

If you make any requests toward this mocked API and change data, the static file _db.json_ would change.

### What about the front-end app?

Because this mocked API works exactly like a real API, you can make requests to it in your front-end code with a browser-native request object, **fetch** . For example:

```javascript
fetch("http://localhost:5000/pizza")
  .then(response => response.json())
  .then(data => console.log(data)) // outputs mocked data 
```

### Use a proxy

Use a proxy to make requests toward the mocked API. 

The **Vite** framework provides `vite.config.js` which allows you to configure how the app is run including the proxy. 

    :::code language="javascript" source="../code/vite.config.js" highlight="8-11":::

    * **PORT**: The port is set to 3000, a common port number used for front-end apps..

If your front-end framework doesn't provide a proxy mechanism with its local server, you need to provide one. A standard way to set up a proxy is to set the `proxy` property in the _package.json_ with an entry like the following:

```json
"proxy": "http://localhost:5000"
```

Instead of making requests toward `http://localhost:5000/pizza`, you can now make them toward `/pizza`, which resolves to `http://localhost:5000/pizza` when you make requests. 

## Talk to a real API

After the real API is finished, you should have the front-end app make requests toward that API, instead of the mocked API. Doing so helps ensure that everything is working as it should.

However, when you first try to talk to your real back-end API, you might get an error that looks something like the following:

```output
Access to fetch at http://localhost:5000 from origin 'http://localhost:3000' has been blocked by CORS policy...
```

This error tells you that the front-end app isn't allowed to call the back-end API, because the front-end app comes from a different place than the back-end API is residing. This difference includes both the domain name and the port of each app. The good news is that you can fix this error by implementing CORS on the back-end API.  

## CORS

CORS is a protocol that allows a back-end API to accept requests from domains (and ports) other than the one it's currently running on. This is a security feature.

Suppose the calling client makes a request toward a back-end API, and starts by sending a preflight request by using the `OPTIONS` verb. Essentially, the calling client is asking the back-end API what it can perform toward a resource. The back-end API can approve or deny the request, at which point the actual request (such as `GET` or `POST`) goes through. Imagine the following flow below:

```output
client> OPTIONS, can I do POST on /pizza?
server> you can do GET on /pizza
client> receives a deny response at this point
```

Another more successful attempt might look like the following:

```output
client> OPTIONS, can I do GET on /pizza
server> you can do GET on /pizza
client> receives data from back end
```

### Configure CORS on the server

In this example app, the API and front-end app are both hosted from the same IP (`localhost`) but are served from different ports: 

- The API is served from port 5000
- The front-end app is served from port 3000

The CORS configuration is the responsibility of the server. How that's configured depends on the runtime the server is using. Here's how you can do it in your .NET Core _Program.cs_ file:

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

The code snippet shows how to add a policy to an API that includes an allowlist of domains that are allowed to communicate with the API. In this example, the domain http://example.com is added to the allowlist. If you want to allow all domains, you can use * as the allowlist, which means that all possible domains are allowed.

The UseCors() method can be used to offer more granular control over which HTTP verbs are allowed for specific routes.
