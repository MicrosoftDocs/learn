In this exercise, you will configure the application with permissions and use MSAL to access user profile information from the Microsoft Graph (MS Graph) API.

## Add Microsoft Graph permissions to App registration

Web services secured by Azure Active Directory define a set of permissions that provide access to the API functionality and data exposed by that service. Before an application can can access data or act on a user's behalf, it must request these permissions to be approved by the users. These API permissions can be assigned to your app registration from the Azure portal. Here are the steps to assign Microsoft Graph API permissions to your application.

1. In the app's registration screen, click on the **API permissions** blade in the left to add access to the APIs that your application needs.
   - Click the **Add permissions** button and then,

   - Ensure that the **Microsoft APIs** tab is selected.

   - In the *Commonly used Microsoft APIs* section, click on **Microsoft Graph**.

   - In the **Delegated permissions** section, select the **User.Read** in the list.  This particular permission is for accessing the information of the signed-in user from the `https://graph.microsoft.com/v1.0/me` endpoint.

   - Click on the **Add permissions** button in the bottom.

   :::image type="content" source="../media/api-permissions.png" alt-text="Screenshot showing the API permissions blade of an app registered with Azure Active Directory on Azure portal.":::

## Run the application

You can try the Graph API call on the application that you have running from the previous exercise.

1. Open your browser and navigate to `http://localhost:8080/msal4j-servlet-graph/`. If you are not already signed in, you will be redirected to login with Azure Active Directory. On successful login, you should see a page as shown in the below image.

    :::image type="content" source="../media/app-sign-in.png" alt-text="Screenshot showing the button to call graph displayed on the page after successfully signing in to sample application.":::

2. Click the **Call Graph** button to make a call to Microsoft Graph's `/me` endpoint and see the user details displayed.

## Overview of code for Microsoft Graph access

The code for accessing Microsoft Graph API can be found in the servlet class `CallGraphServlet.java` under the `msal4j/callgraphwebapp/` directory of the sample project. It defines the `/call_graph` endpoint in the application which makes authorized calls to the Microsoft Graph API's `https://graph.microsoft.com/v1.0/me` endpoint to retrieve the profile information of the signed in user. Here are more details of the Graph access code.

1. In the `./src/main/resources/authentication.properties` file, the value of `aad.scopes` is set to the **User.Read** scope.

    Scopes tell Azure Active Directory the level of access that the application is requesting and map to the permissions in the app registration. Based on the requested scopes, Azure Active Directory presents a consent dialogue to the user upon signing in. If the user consents to one or more scopes , the scopes consented to are encoded into the resulting `access_token` returned in the authentication response.

2. When the user navigates to `/call_graph`, the application creates an instance of the IGraphServiceClient (Microsoft Graph SDK Java), passing along the signed-in user's access token. The Graph client from hereon places the access token in the Authorization headers of its requests. The app then asks the Graph Client to call the Microsoft Graph's `/me` endpoint to yield details for the currently signed-in user.

    The following code is all that is required for an application developer to write for accessing the `/me` endpoint, provided that they already have a valid access token for Graph Service with the `User.Read` scope.

    ```Java
    //CallGraphServlet.java
    User user = GraphHelper.getGraphClient(contextAdapter).me().buildRequest().get();
    ```
