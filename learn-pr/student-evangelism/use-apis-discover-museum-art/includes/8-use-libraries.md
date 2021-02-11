It's useful to test an API by sending queries over a browser's URL, complete with a query string populated by an access token. But in a production app, you might need to make a more complicated API call with various data assembled to form a query.

That's why many developers rely on libraries that standardize the process of working with APIs. For JavaScript developers, Axios is an excellent choice. Python programmers might use Requests. Using PowerShell? Try RestMethod.

## Query by using a URL

Say you're passionate about clock radios and are interested in the collection of well-designed examples at the Cooper Hewitt. You take a look at the [museum's API documentation](https://collection.cooperhewitt.org/api/methods/). You see that you can construct a query with your API access token in this format, given that you want paginated results and only results with images: 

`https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.search.collection&access_token=<your access token>&query=clock%20radio&has_images=true&page=1&per_page=100`

The first example that comes up is this slick example from the 1950s:

:::image type="content" source="../media/clock-radio.png" alt-text="Drawing of a slick clock radio from 1957.":::

>[!TIP] 
>[Postman](https://www.postman.com?azure-portal=true) is an excellent tool for testing API endpoints.

Try using a library to call the Cooper Hewitt API by running this code snippet in your local development environment:
::: zone pivot="javascript"

```javascript
var axios = require('axios');

var config = {
  method: 'get',
  url: 'https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.search.objects&query=clock%20radio&page=1&per_page=100&access_token=yourtoken',
  headers: { }
};

axios(config)
.then(function (response) {
  console.log(JSON.stringify(response.data));
})
.catch(function (error) {
  console.log(error);
});
```

::: zone-end

::: zone pivot="python"

```python
import requests

url = "https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.search.objects&query=clock%20radio&page=1&per_page=100&access_token=yourtoken"

payload = {}
headers= {}

response = requests.request("GET", url, headers=headers, data = payload)

print(response.text.encode('utf8'))
```

::: zone-end

::: zone pivot="powershell"

```powershell
$response = Invoke-RestMethod 'https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.search.objects&query=clock%20radio&page=1&per_page=100&access_token=yourtoken' -Method 'GET' -Headers $headers -Body $body
$response | ConvertTo-Json
```

::: zone-end

::: zone pivot="csharp"

```csharp
using System.Net.Http;

HttpClient client = new HttpClient();

HttpRequestMessage request = new HttpRequestMessage(
    method: HttpMethod.Get, 
    requestUri: "https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.search.objects&query=clock%20radio&page=1&per_page=100&access_token=yourtoken"
);

HttpResponseMessage response = await client.SendAsync(request);

if (response.IsSuccessStatusCode)
{
    Console.WriteLine(
        await response.Content.ReadAsStringAsync()
    );
}
```

::: zone-end

By using libraries appropriate to your preferred programming language, you can have more control over how you use APIs from within your code as you script functions based on user interactions like button clicks.

## Write to an endpoint by using a method

Many third-party endpoints like these museum examples don't allow you to write to their databases by using POST. These databases aren't transactional. But you can practice using methods to write to your own data.

Let's return to the `db.json` file you created earlier in this module. You can write data to this database.

Using the terminal, `cd` to the location of your `db.json` file and then enter `json-server --watch db.json`. The server will start on port 3000. You can query it with Postman by using `GET` for your objects collection: `localhost:3000/objects`.

You can write to this collection by setting a header value `'content-type': 'application/json'` and passing through a stringified JSON object:

::: zone pivot="javascript"

```javascript
var axios = require('axios');
var data = JSON.stringify({"id":5,"item":"The Fiancés","artist":"Pierre Auguste Renoir","collection":"Wallraf–Richartz Museum, Cologne, Germany","date":"1868"});

var config = {
  method: 'post',
  url: 'localhost:3000/objects',
  headers: { 
    'content-type': 'application/json'
  },
  data : data
};

axios(config)
.then(function (response) {
  console.log(JSON.stringify(response.data));
})
.catch(function (error) {
  console.log(error);
});
```

::: zone-end

::: zone pivot="python"

```python
import requests

url = "localhost:3000/objects"

payload = "{\n        \"id\": 5,\n        \"item\": \"The Fiancés\",\n        \"artist\": \"Pierre Auguste Renoir\",\n        \"collection\": \"Wallraf–Richartz Museum, Cologne, Germany\",\n        \"date\": \"1868\"\n    }"
headers = {
  'content-type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data = payload)

print(response.text.encode('utf8'))
```

::: zone-end

::: zone pivot="powershell"

```powershell
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("content-type", "application/json")

$body = "{`n        `"id`": 5,`n        `"item`": `"The Fiancés`",`n        `"artist`": `"Pierre Auguste Renoir`",`n        `"collection`": `"Wallraf–Richartz Museum, Cologne, Germany`",`n        `"date`": `"1868`"`n    }"

$response = Invoke-RestMethod 'localhost:3000/objects' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
```

::: zone-end

::: zone pivot="csharp"

```csharp
HttpClient client = new HttpClient();

HttpRequestMessage request = new HttpRequestMessage(
    method: HttpMethod.Post,
    requestUri: "http://localhost:3000/objects"
);

string payload = @"{""id"":5,""item"":""The Fiancés"",""artist"":""Pierre Auguste Renoir"",""collection"":""Wallraf–Richartz Museum, Cologne, Germany"",""date"":""1868""}";

StringContent requestData = new StringContent(
    content: payload, 
    encoding: System.Text.Encoding.UTF8,
    mediaType: "application/json"
);

request.Content = requestData;

HttpResponseMessage response = await client.SendAsync(request);

if (response.IsSuccessStatusCode)
{
    Console.WriteLine(
        await response.Content.ReadAsStringAsync()
    );
}
```

::: zone-end

You can use your personal database and API endpoint to try other operations. Try using your chosen library to GET, POST, and even DELETE items from your collection.
