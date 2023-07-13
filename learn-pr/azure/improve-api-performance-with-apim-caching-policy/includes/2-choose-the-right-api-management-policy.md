You can use API Management policies to control the behavior of a deployed API without rewriting its code.

In your board game company, you have a set of APIs that enable partner organizations to obtain price estimates, staff members to check stock levels, and customers to place orders. You want to address a particular issue with performance and investigate what else you can achieve with policies.

First, let's look at what you can use policies to do.

## What are policies?

In Azure API Management, administrators can use policies to alter the behavior of APIs through configuration. The primary functionality and behavior of an API is designed by the developers who write the code. However, administrators can use policies to set limits, convert response formats, or enforce security requirements. In this module, we'll concentrate on using policies to set up and control a cache.

Policies are made up of individual statements, which are executed in order. The policy documents are XML structures, which contain elements that you can use to control the behavior of the API.

## When do policies execute?

In Azure API Management, policies execute at four different times:

- **Inbound**: These policies execute when a request is received from a client.
- **Backend**: These policies execute before a request is forwarded to a managed API.
- **Outbound**: These policies execute before a response is sent to a client.
- **On-Error**: These policies execute when an exception is raised.

In the policy XML, there's a separate tag for each of these execution times:

```xml
<policies>
    <inbound>
        <base />
        <check-header name="Authorization" failed-check-httpcode="401" failed-check-error-message="Not authorized" ignore-case="false">
        </check-header>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
        <json-to-xml apply="always" consider-accept-header="false" parse-date="false" />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
```

In this example, you can see that the policy checks inbound requests for a header named **Authorization**. If such a header isn't present, the policy displays an error message.

This policy also translates any outbound responses in JSON format into XML.

## Policy scopes

A policy's scope determines how broadly it will be applied. The following are policy scopes from which you can choose:

- Global
- Product
- API
- Operation

### Global

Policies applied at the global scope affect all APIs within the instance of API Management.

To use the global scope, in your API Management service pane, in the left menu pane, under **API Management**, select **APIs**, and then select **All APIs** in the middle menu pane. Select **+ Add policy** in the **Inbound processing** or **Outbound processing** section to view policies you can add at that scope.

:::image type="content" source="../media/2-global-scope.png" alt-text="Screenshot of the All APIs scope in the portal." :::

From the available choices, make a selection to start a wizard that guides you to add the policy with the correct syntax:

:::image type="content" source="../media/2-global-policy-wizard.png" alt-text="Screenshot of the All APIs scope to add policy in the portal.":::

You can also open the XML editor directly by selecting the tag symbol **</>** in the **Inbound processing**, **Outbound processing**, or **Backend** sections. The policy editor that appears contains default XML content. On the right, select **Show snippets** to find shortcuts that add policies:

:::image type="content" source="../media/2-global-scope-editor.png" alt-text="Screenshot of the All APIs scope editor in the portal.":::

### Product

In API Management, you can assemble one or more APIs into a single product and then manage access to that product as a single entity. Policies applied to the product scope affect all the APIs in that product. APIs in other products are unaffected. When you manage a product in the Azure portal, select the **Policies** pane to add policies through a guided wizard or using the XML policy editor:

:::image type="content" source="../media/2-products-scope.png" alt-text="Screenshot of the product scope editor in the portal.":::

### API

Policies applied at the API scope affect only a single API. To set a policy at the API scope, on the API Management home page, select **APIs**, then select the API you want to manage. Finally, under the **Design** tab, select **All operations**. You can set inbound, outbound, or backend policies that apply to all operations in that API:

:::image type="content" source="../media/2-api-scope.png" alt-text="Screenshot of the API scope in the portal.":::

### Operation

Policies applied at the operation scope affect only one operation within the API. In the example below, the administrator has selected the **GetSpeaker** operation within the **Demo Conference API** and can set inbound, outbound, or backend policies that apply only to that operation:

:::image type="content" source="../media/2-operation-scope.png" alt-text="Screenshot of the operation scope in the portal.":::

## Which order are policies applied in?

You can use the `<base />` tag to determine when policies from a higher scope are applied. For example, consider this policy, applied at the API scope:

```xml
<policies>
    <inbound>
        <base />
        <find-and-replace from="game" to="board game" />
    </inbound>
</policies>
```

Because the `<base>` tag appears above the `<find-and-replace>` tag, Azure API Management applies policies from the global and product scopes first, and then executes the find-and-replace policy.

## Commonly used policies

Let's examine some things you can do with policies in API Management. We'll introduce some of the most commonly used policies, and you can visit the API Management documentation for a complete list and examples.


### Policies for restricting access

There are several policies that you can use to prevent or limit access to an API or its operations. For example:

Use the **Check HTTP header** policy to check for a property in an HTTP header. If the property isn't found, Azure API Management drops the request.

The **Limit call rate by subscription** policy restricts the number of calls that can come from a single API subscription. This policy can ensure that users from one subscription don't use all your bandwidth.

If you want to restrict the number of calls that arrive with a single access key, use the **Limit call rate by key** policy.

To allow or deny calls from specific IP addresses or ranges of IP addresses, use the **Restrict caller IP's** policy. This way to restrict access behaves like the IP address restrictions that you can apply on a firewall.

### Policies for authentication

Several policies enable you to control authentication. For example:

Use the **Authenticate with Basic** policy to enable authentication in plain text. This form of authentication is broadly supported, but remember that you should protect it with SSL encryption; otherwise, a malicious attack can intercept the credentials as they cross the network.

Use the **Authenticate with client certificate** policy to enable clients to authenticate by supplying a client certificate.

### Cross-domain policies

Cross-domain requests are considered a security threat and denied by browsers and APIs. However, they can be desirable for specific operations, and API Management policies let you permit them securely.

Use the **Allow cross-domain calls** policy to permit calls from Adobe Flash and Silverlight. If your API or client apps rely on Cross-Origin Resource Sharing (CORS), use the **CORS** policy to permit them.

Some AJAX code, which runs on the browser, uses JSON with padding to make cross-domain calls securely. Use the **JSONP** policy to permit clients to use this technique.

### Transformation policies

It's often helpful to change the format or content of a response from a managed API. You can do that with several policies. For example:

To convert to and from JSON and XML, use the **Convert JSON to XML** and **Convert XML to JSON** policies. These policies often help to make multiple APIs in a product consistent. They can also remove the need to recode an API when an app expects a response in a specific format.

Sometimes you want to keep a response in XML, but alter its schema. In such cases, use the **Transform XML** policy to apply an XSLT template.

Use **Find and replace string in body** to execute a string substitution. For example, if a brand name has changed, you could use this policy to ensure that the change is reflected in all responses, even if the underlying data still includes references to the old name.

The **Mask URLs in content** policy can rewrite any links in the response body so that they point to a different location. This policy is useful when a website or web API has moved.

Use the **Set body** policy to set the message text for incoming and outgoing requests.

If you want to modify an incoming HTTP request or outgoing response, you can use several different policies. To add items to an existing response or request header, use the **Set HTTP header** policy. If you need to modify the query strings, which appear after the question mark in the URL, use the **Set query string parameter** policy. If a public URL, which a user has requested, must be mapped to a different internal destination, the **Rewrite URL** policy can perform the conversion both inbound and outbound.

### Advanced policies

These policies can be of use in scenarios when you want non-standard behavior.

For example, if you want to apply a policy only when the response passes a specific test, use the **Control flow** policy.

Use the **Forward request** policy to forward a request to a backend server.

To control what happens when an action fails, use the **Retry** policy. Policy statements enclosed in **Retry** will execute repeatedly until a condition is met. Execution will repeat at the specified time intervals up until the retry count value is reached.

The **Send one-way request** policy can send a request to a URL without waiting for a response.

If you want to store a value for use in a later calculation or test, use the **Set variable** policy to persist a value in a named variable.
