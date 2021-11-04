Having a front end is an important part. That's what the user will see and interact with. For the app to work all the way, it's going to need a back end. If your back end and front end live in two different places, you need to configure something called CORS, cross origin resource sharing. 

## Connect to a back end

You have a front-end app, so what are the things you need to think about for the back-end application. Well, you are in one of two phases:

- **Working against mocked data**. During development, you are at a point where you can work as a standalone team abut you still want to build out the application and at least emulate that you are working with an API.
- **Talking to a real API**. At this point, the back-end team has built the API, now, you want to connect it to your front end.

## Mock an API

As you build your front-end app, you know that a back-end team sooner or later going to be done building the API. What do you do in the meantime though, do you wait for the back-end team to finish, before you build the corresponding view? The answer is that there are different approaches you can take here:

- **Build a vertical**. In this approach, you work tightly with the person building the back end. You build your front-end part, then the back-end developer build their part. Once both parts work, you have a _full vertical_ and you can continue to the next feature. This approach is definitely a viable one but it does force the teams to be very in sync.
- **Mock the data**. Mocking is another approach, that has fewer requirements on syncing with a team to the same extent. In this scenario, the front-end developer negotiates with the back-end team, what the response from the back end will look like. Once you are in agreement, you start creating mock data, static files that the front-end team uses instead. The front-end team can now move at any desired development speed. At some point you do need to synchronize with the back-end team, to ensure the back end was built according to what you agreed on.

### Use json-server

There's a library called json-server, what it does is that it creates an API for you, a RESTful API and creates that from a static JSON file. You give json-server a file that looks like so for example:

```json
{
  "pizzas": [
    { "id": 1, "name": "Cheese Pizza" },
    { "id": 2, "name": "Al Tono" }
  ]
}
```

To use JSON server, you use an executable `npx` that comes with your Node.js installation. Starting your Mock API is done by calling the executable `npx`, the name of the package `json-server` and the name of the static file containing your API data. Here's an example:

```bash
npx json-server --watch db.json
```

### How would this work?

At this point your mocked API will start to be served at a certain port, for example "5000". Furthermore, you would be able to interact with it, like it was a real API and it would support requests like:

```output
GET    /pizza
GET    /pizza/1
POST   /pizza
PUT    /pizza/1
PATCH  /pizza/1
DELETE /pizza/1
```

What happens *under the hood* is that were you make any requests towards this mocked API and change data, the static file _db.json_ would change and the server would rebuild and relaunch to reflect the changes.

### What about the front-end app?

Because this mocked API works exactly like a real API, you would be able to make request to it in your front-end code, like so for example:

```javascript
fetch("http://localhost:5000/pizza")
  .then(response => response.json())
  .then(data => console.log(data)) // outputs mocked data 
```

### Use a proxy

A proxy is something you can define in your front-end app. What it does for you is that it save you a few keystrokes. Imagine you are doing requests towards "http://localhost:5000/pizza". If you don't want to type out the full domain, can create a proxy, an alias. To set up a proxy, you go to _package.json_ and add an entry like so:

```json
"proxy": "http://localhost:5000"
```

Instead of making requests towards "http://localhost:5000/pizza" can now make request towards "/api/pizza". "api" is then being resolved to "http://localhost:5000" when you make requests. It's not a thing you must use, but it makes typing requests a bit more convenient.

## Talk to a real API

Once the real API is finished, you should have the front-end app make requests towards that API, instead of the mocked API, to ensure everything is working as it should.

However, when you first try to talk to your real back end, you might get an error as the front end makes requests towards the back end. You see an error looking something like so:

```output
Access to fetch at http://localhost:5000 from origin 'http://localhost:3000' has been blocked by CORS policy...
```

What it tells you, is that the front-end app isn't allowed to call the back end, because it sees the front end as coming from a different place than the back end is residing in. Remember how that front end is running on port 3000 and the back end on 5000, that's enough of a difference for it to complain.

The good news is that you can fix it, by implementing CORS on the back end.  

> [!NOTE]
> When your front end and back end run on the same domain and port, you won't get CORS issues. Configuring CORS is only needed if the front end and back end run on different places.

## CORS

CORS is short for cross-origin resource sharing, it's a protocol that allows a back end to accept requests from other domains than it's currently running on. This is a security feature. The idea is that the calling client makes a request towards a back end and start by sending a preflight request using the OPTIONS verb, that essentially is a question towards the back end asking what it can perform towards a resource. At this point, the back end can answer back to the calling client and either approve or deny the request at which point the actual request, being a GET, or POST, for example,  goes through. Imagine the following flow below:

```output
client> OPTIONS, can I do POST on /pizzas?
server> you can do GET on /pizzas
client> receives a deny response at this point
```

Another more successful attempt can look like so:

```output
client> OPTIONS, can I do GET on /pizzas
server> you can do GET on /pizzas
client> receives data from back end
```

### Configure CORS on the server

The CORS configuration is the responsibility of the server. How that's configured depends on the runtime the server is using. For minimal API and .NET Core. This is how it can be done, in your _Program.cs_:

```csharp
// 1) define a unique string
readonly string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";
// 2) define allowed domains, in this case "http://example.com" and "*" = all domains, for testing purposes only
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: MyAllowSpecificOrigins,
      builder =>
      {
          builder.WithOrigins("http://example.com",
                              "*");
      });
});
// 3) use the capability
app.UseCors(MyAllowSpecificOrigins);
```

What's going on above is that a policy is added. As part of the policy, you allowlist the domains that is allowed to talk with the API. In this case, you allowlist "http://example.com" and "*". Essentially "*" means all possible domains would be allowed. If you only want specific domains to be allowed, specify only the ones you want. Lastly the `UseCors()` method is called with applies the policy. You can offer more fine grained control than the above. You can decide that only certain HTTP Verbs should be allowed for certain routes for example.
