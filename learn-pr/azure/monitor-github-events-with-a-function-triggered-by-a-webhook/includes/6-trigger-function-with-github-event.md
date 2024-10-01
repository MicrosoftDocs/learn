The GitHub *Gollum* event enables you to listen for wiki updates. When this event occurs, your Azure HttpTrigger function is triggered, and you can parse the payload to retrieve and process the data that was sent.

You've shown your IT department that you can listen for *Gollum* events on your company's GitHub repository by setting up a webhook. You've also demonstrated how Azure Function apps enable you to run code when a function receives a webhook request.

In this unit, we'll examine the payload from the *Gollum* event so we can update our function to parse it correctly.

## Gollum event payload

The payload for the *Gollum* event contains the following items:

- **pages** that were updated. Each page includes the following information:
  - `page_name` Name of the page.
  - `title` Current page title.
  - `action` Action that was performed on the page - created or edited.
  - `html_url` HTML wiki page.
- **repository** information about the repository containing the wiki page, including:
  - `name` Name of the repository.
  - `owner` Details of the owner of the repository.
  - `html_url` Address of the repository.
- **sender** information about the user that raised the event that caused the webhook to fire.

For example, a payload might look like the following code.

```json
"pages": [
    {
        "page_name": "Home",
        "title": "Home",
        "summary": null,
        "action": "edited",
        "sha": "562362bc141b9e2db1fb971e1ecb4fd0b7457f68",
        "html_url": "https://github.com/testrepo/Hello-World/wiki/Home"
    }
],
"repository": {
    ...
    "name": "testrepo",
    ...
    "owner": {
        ...
    },
    "html_url": "https://github.com/...",
    ...
},
"sender": {
    "login": "..."
    ...
}
```

This information is passed as the body of an HTTP POST request. We'll need to update our function logic to parse and process this information correctly.

## Parse information from the Gollum event

Recall that the webhook runs when a specific event occurs. The webhook then sends a request to the URL where your Azure Functions code is set up to listen, using the **URL** for your function. The payload is passed to the Azure Function. Your function can parse the request body to extract the fields from the payload, and take the appropriate actions.

The following example retrieves the repository name from the payload. The event type is available in the *x-github-event* request header. This data is output in the following function response.

```JavaScript
if (req.body.repository.name){
    context.res = {
        body: "Repository is: " + req.body.repository.name + ", Event Type is: " + req.headers['x-github-event']
    };
}
```

In the next exercise, we'll update your function code to be able to handle an incoming **Gollum** event.
