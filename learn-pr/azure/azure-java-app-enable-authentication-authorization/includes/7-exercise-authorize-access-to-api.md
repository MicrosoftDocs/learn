In this exercise, you will configure the applications with permissions and use MSAL to access user profile information from the Microsoft Graph (MS Graph) API.

## Add MS Graph permissions to app registration
1. In the app's registration screen, click on the **API permissions** blade in the left to open the page where we add access to the Apis that your application needs.
   - Click the **Add permissions** button and then,
   - Ensure that the **Microsoft APIs** tab is selected.
   - In the *Commonly used Microsoft APIs* section, click on **Microsoft Graph**
   - In the **Delegated permissions** section, select the **User.Read** in the list. Use the search box if necessary.
   - Click on the **Add permissions** button in the bottom.

## Run the application

1. Make certain that your Tomcat server is running and you have privileges to deploy a web app to it. Make certain that your server host address is `http://localhost:8080`.

2. Compile and package the project using **Maven**:

    ```Shell
    cd ~/javawebapp/2-Authorization-I/call-graph
    mvn clean package
    ```

3. Find the resulting `.war` file in `./target/msal4j-servlet-graph.war`. To deploy to Tomcat, copy this `.war` file to the `/webapps/` directory in your Tomcat installation directory and start the Tomcat server.

4. Open your browser and navigate to `http://localhost:8080/msal4j-servlet-graph/`. You will be redirected to login with Azure AD. On successful login, you should see a page as shown in the below image.

    ![Screenshot of successful sign in](../media/app-signin.png)

5. Click the **Call Graph** button to make a call to Microsoft Graph's `/me` endpoint and see the user details displayed.

## Overview of authentication code for MS Graph access

### Call Graph

When the user navigates to `/call_graph`, the application creates an instance of the IGraphServiceClient (Java Graph SDK), passing along the signed-in user's access token. The Graph client from hereon places the access token in the Authorization headers of its requests. The app then asks the Graph Client to call the  `/me` endpoint to yield details for the currently signed-in user.

The following code is all that is required for an application developer to write for accessing the `/me` endpoint, provided that they already have a valid access token for Graph Service with the `User.Read` scope.

  ```java
  //CallGraphServlet.java
  User user = GraphHelper.getGraphClient(contextAdapter).me().buildRequest().get();
  ```

### Scopes

- [Scopes](https://docs.microsoft.com/azure/active-directory/develop/v2-permissions-and-consent) tell Azure AD the level of access that the application is requesting.
- Based on the requested scopes, Azure AD presents a consent dialogue to the user upon signing in.
- If the user consents to one or more scopes and obtains a token, the scopes-consented-to are encoded into the resulting `access_token`.
- Note the scope requested by the application by referring to [authentication.properties](./src/main/resources/authentication.properties). By default, the application sets the scopes value to `User.Read`.
- This particular MS Graph API scope is for accessing the information of the currently-signed-in user. The graph endpoint for accessing this info is `https://graph.microsoft.com/v1.0/me`
- Any valid requests made to this endpoint must bear an `access_token` that contains the scope `User.Read` in the Authorization header.