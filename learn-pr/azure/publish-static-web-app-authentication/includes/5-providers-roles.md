With user authentication in place, your shopping list web app needs a way to restrict access to some pages for users that aren't logged in, and allow login only through specific providers.

We'll look into routing configuration and roles in Azure Static Web Apps to fine tune user access to our web app.

## Configuration file for Azure Static Web Apps

Configuration for Azure Static Web Apps is defined in the `staticwebapp.config.json` file, which controls the following settings:

- Routing
- Authentication
- Authorization
- Fallback rules
- HTTP response overrides
- Global HTTP header definitions
- Custom MIME types

The recommended location for the `staticwebapp.config.json` is in the folder set as the `app_location` setting that we chose during the deployment. However, the file may be placed in any location within your application source code folder.

For our use case, we'll look into routing configuration to achieve what we want.

## Restrict authentication providers

In a previous section, we saw that by default all authentication providers are enabled. We can change that by adding routing rules in the configuration.

For example, to disable login through the GitHub provider, you can add a routing rule like this in the `staticwebapp.config.json` file.

```json
{
  "routes": [
    {
      "route": "/.auth/login/github",
      "statusCode": 404
    }
  ]
}
```

We force the route `/.auth/login/github` used to authenticate with the GitHub provider to return a `404` (not found) error, so the users can't access it. You can add as many routes rules we want to disable all providers you don't want to use.

## Secure routes with roles

Routes are by default accessible to everyone without any restrictions. You can secure routes by adding one or more role names into a rule's `allowedRoles` array. By default, every user belongs to the built-in `anonymous` role, and all logged-in users are members of the `authenticated` role.

That means to restrict a route to only authenticated users, you can add the built-in `authenticated` role to the `allowedRoles` array.

```json
{
  "routes": [
    {
      "route": "/profile",
      "allowedRoles": ["authenticated"]
    }
  ]
}
```

With that configuration, if an unauthenticated user tries to access the `/profile` route an error `401` (unauthorized) will be returned.

You can also restrict specific HTTP methods for a given route, like the following:

```json
{
  "routes": [
    {
      "route": "/profile",
      "methods": ["PUT", "POST", "DELETE"],
      "allowedRoles": ["authenticated"]
    }
  ]
}
```

In this example, all users can access the `GET` method on the `/profile` route, but only authenticated users can use `PUT`, `POST` or `DELETE`.

### Use a wildcard

You can use a wildcard at the end of route to match all routes following the base pattern. For example, to restrict all URLs starting with `/api` to authenticated users, you can write:

```json
{
  "routes": [
    {
      "route": "/api/*",
      "allowedRoles": ["authenticated"]
    }
  ]
}
```

## Next steps

Next, we'll implement access restrictions in our app.
