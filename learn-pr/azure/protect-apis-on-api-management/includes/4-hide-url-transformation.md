Organizations may need to adjust the information that an API publishes at short notice. For example, to comply with a change of legislation or address a new security threat.

The Census API example exposes details about the URL from which the API is being called. This information could allow a malicious user to attempt to access the census data by bypassing the API Management gateway and exposing a less secure endpoint. As lead developer, you want to mask these URLs within the response body of the API.

Here, you learn how to use API Management policies that manipulate the content of API response headers and bodies.

## Why transform a response?

The response body of an API call contains the data that is being requested. In the Census API, for example, the response body contains the JSON data for the respondents. You can also see how the body contains URL links to view individual people:

:::image type="content" source="../media/4-links-in-body.png" alt-text="Screenshot of a default HTTP response with the href value highlighted, showing an unmasked URL link.":::

These links are based on the Census API endpoints and need to be masked to show the API Management URLs instead.

To achieve this configuration, create a transformation policy.

> [!NOTE]
> It's best practice to secure the backend API using one of the available mechanisms in API Management. For example, configure it to require a client certificate, and then configure API Management to supply that certificate. In this configuration, no one can call the backend API directly and circumvent your API Management gateway because they don't have a certificate that's recognized by the backend.

## Transformation policy

A transformation policy modifies the content of an API call. Some transformation policies apply to the header and others apply to the body. The following transforms are available:

| Transform | Description |
| ---------|--------- |
| **Convert JSON to XML** | Converts a request or response body from JSON to XML. |
| **Convert XML to JSON** | Converts a request or response body from XML to JSON. |
| **Find and replace string in body** | Finds a request or response substring and replaces it with a different substring. |
| **Mask URLs in content** | Rewrites links in the response body so that they point to the equivalent link through the gateway. |
|**Set backend service** | Changes the backend service for an incoming request. |
|**Set body** | Sets the message body for a request or response. |
| **Set HTTP header** | Assigns a value to an existing response or request header, or adds a new response or request header. |
| **Set query string parameter** | Adds, replaces the value of, or deletes a request query string parameter. |
| **Rewrite URL** | Converts a request URL from its public form to the form expected by the web service. |
| **Transform XML using an XSLT** | Applies an XSL transformation to the XML in the request or response body. |

In the following exercise, you use the **Mask URLs in content** transform to alter the links.
