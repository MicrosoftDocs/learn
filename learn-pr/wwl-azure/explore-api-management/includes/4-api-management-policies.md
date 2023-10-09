
In Azure API Management, policies allow the publisher to change the behavior of the API through configuration. Policies are a collection of Statements that are executed sequentially on the request or response of an API.

Policies are applied inside the gateway that sits between the API consumer and the managed API. The gateway receives all requests and usually forwards them unaltered to the underlying API. However a policy can apply changes to both the inbound request and outbound response. Policy expressions can be used as attribute values or text values in any of the API Management policies, unless the policy specifies otherwise. 

## Understanding policy configuration

The policy definition is a simple XML document that describes a sequence of inbound and outbound statements. The XML can be edited directly in the definition window.

The configuration is divided into `inbound`, `backend`, `outbound`, and `on-error`. The series of specified policy statements is executed in order for a request and a response.

```xml
<policies>
  <inbound>
    <!-- statements to be applied to the request go here -->
  </inbound>
  <backend>
    <!-- statements to be applied before the request is forwarded to 
         the backend service go here -->
  </backend>
  <outbound>
    <!-- statements to be applied to the response go here -->
  </outbound>
  <on-error>
    <!-- statements to be applied if there is an error condition go here -->
  </on-error>
</policies>
```

If there's an error during the processing of a request, any remaining steps in the `inbound`, `backend`, or `outbound` sections are skipped and execution jumps to the statements in the `on-error` section. By placing policy statements in the `on-error` section you can review the error by using the `context.LastError` property, inspect and customize the error response using the `set-body` policy, and configure what happens if an error occurs.

## Policy expressions

Unless the policy specifies otherwise, policy expressions can be used as attribute values or text values in any of the API Management policies. A policy expression is either:

* a single C# statement enclosed in `@(expression)`, or
* a multi-statement C# code block, enclosed in `@{expression}`, that returns a value

Each expression has access to the implicitly provided `context` variable and an allowed subset of .NET Framework types.

[Policy expressions](/azure/api-management/api-management-policy-expressions) provide a sophisticated means to control traffic and modify API behavior without requiring you to write specialized code or modify backend services. 

The following example uses policy expressions and the set-header policy to add user data to the incoming request. The added header includes the user ID associated with the subscription key in the request, and the region where the gateway processing the request is hosted.

```xml
<policies>
    <inbound>
        <base />
        <set-header name="x-request-context-data" exists-action="override">
            <value>@(context.User.Id)</value>
            <value>@(context.Deployment.Region)</value>
      </set-header>
    </inbound>
</policies>
```

## Apply policies specified at different scopes

If you have a policy at the global level and a policy configured for an API, then whenever that particular API is used both policies are applied. API Management allows for deterministic ordering of combined policy statements via the base element.

```xml
<policies>
    <inbound>
        <cross-domain />
        <base />
        <find-and-replace from="xyz" to="abc" />
    </inbound>
</policies>
```

In the previous example policy definition, The `cross-domain` statement would execute first. The `find-and-replace` policy would execute after any policies at a broader scope.

## Filter response content

The policy defined in following example demonstrates how to filter data elements from the response payload based on the product associated with the request.

The snippet assumes that response content is formatted as JSON and contains root-level properties named "minutely", "hourly", "daily", "flags".

```xml
<policies>
  <inbound>
    <base />
  </inbound>
  <backend>
    <base />
  </backend>
  <outbound>
    <base />
    <choose>
      <when condition="@(context.Response.StatusCode == 200 && context.Product.Name.Equals("Starter"))">
        <!-- NOTE that we are not using preserveContent=true when deserializing response body stream into a JSON object since we don't intend to access it again. See details on https://learn.microsoft.com/azure/api-management/api-management-transformation-policies#SetBody -->
        <set-body>
          @{
            var response = context.Response.Body.As<JObject>();
            foreach (var key in new [] {"minutely", "hourly", "daily", "flags"}) {
            response.Property (key).Remove ();
           }
          return response.ToString();
          }
    </set-body>
      </when>
    </choose>    
  </outbound>
  <on-error>
    <base />
  </on-error>
</policies>
```

