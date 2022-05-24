Here, you'll learn about the different GitHub access tokens, their applications, limitations, and rate limits.

When it comes to granting access to a user within your company, authentication is incredibly important. User access should be tightly scoped and only include what's necessary for users to complete their tasks. Understanding the different access tokens is important as you help guide users within the company to use the best option for their use cases.

GitHub uses various tokens that allow users to authenticate to the different activities they need to perform. Usually, these different tokens are straightforward, and it's easy to know what token to use. But sometimes multiple tokens can be used to accomplish the same outcome, so choosing a token can come down to a decision of good, better, and best. In these situations, it's important to identify the characteristics of GitHub's tokens and how to correctly scope a token's access. Below is a list of the different access tokens that are available: 

- GitHub personal access tokens
- GitHub user-to-server tokens
- GitHub server-to-server tokens
- OAuth access tokens
- Refresh tokens

It's important to encourage your development team to use tokens with the right scope so that when a security vulnerability is discovered, the risk can be mitigated quickly. Let's take a closer look into each of these access tokens.

### Personal Access Tokens

A personal access token (PAT) is an alternative to using a password for authenticating to GitHub. In order to push and pull in repositories, GitHub needs to verify user access. The verification is done through a user's verified email address. You can create as many personal access tokens as your workflow requires, and you should treat them as securely as passwords. Using different tokens for different applications is the best practice for security. To create a personal access token in GitHub, you navigate to *Settings*, and under *Developer settings*, you'll find *Personal access tokens*.

:::image type="content" source="../media/pat.png" alt-text="Example of a GitHub personal access token." :::

An individual token can be scoped to only the access required to authenticate the job for which it will be assigned. The token is tied to a specific user, and aligns with the user's access to the organization and repositories. You can revoke a personal access token at any time, which is especially important when a security hack occurs. It is important to communicate to your team that their personal access tokens should be treated as securely as a username and password. If a token does become compromised, you should take immediate action to revoke the token.

Detailed steps for creating a PAT are available here: [Creating a personal access token - GitHub Docs](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)

### Device Tokens

A Device Token is basically a machine-account version of a PAT, used in the context of a device, which gives access to a specific repository in specific use cases that are non-user bound. An application setup using an OAuth flow uses a device token. They are typically used with runners, special application services, Cron jobs (in Linux), or other similar scenarios related to automated tasks. Just like the personal access token, it's tied to an individual account, and the account for which you create the device token consumes a license.

### GitHub Application Installation Tokens

An installation token allows a GitHub app to make authenticated API requests for the application’s installation in an organization. Before creating an installation token, the GitHub app to which the token will be applied needs to be installed in the destination repository. Installation tokens are valid for 1 hour, and because they are generated for a specific purpose and expire in a relatively short amount of time, they are secure.

### OAuth Access Tokens

OAuth2 tokens are used to authorize users for standard OAuth apps that run in the browser, and for headless apps such as CLI tools. They allow your app to access the API with a user-access token. These tokens let you connect your GitHub user identity to third-party applications, allowing the app to perform actions on your behalf. For example, if you want to use an app that requests `user:email` scope, the app will have read-only access to your private email addresses. These tokens can be acquired using the [web application flow](https://docs.github.com/en/developers/apps/authorizing-oauth-apps#web-application-flow) for production applications. Because these tokens are short term and expire in 10 minutes, they are also secure.

### Refresh Tokens

A refresh token is connected with an OAuth token. When a new OAuth token (via a user-to-server request) is granted, a refresh token is included in the response. When the user token is expiring, the refresh token can be exchanged for a new user token with a call-back request. Every time a new OAuth token is issued, a refresh token is included. Refresh tokens are valid for six months, and are a good reminder to update your OAuth tokens.

### Identifiable prefixes

As we see across the industry, token prefixes are a clear way to make tokens identifiable. GitHub includes three-letter prefixes to represent each token, starting with a company signifier, `gh`, followed the first letter of the token type. The results for the above token types are:

- `ghp` for GitHub personal access tokens
- `ghu` for GitHub user-to-server tokens
- `ghs` for GitHub server-to-server tokens
- `gho` for OAuth access tokens
- `ghr` for refresh tokens

Additionally, these prefixes have a separator (`_`) within the token to improve readability. An underscore is not a Base64 character, which helps ensure that these tokens cannot be accidentally duplicated by randomly generated strings like SHAs. These prefixes also help reduce the false-positive rate for secret scanning, which is a GitHub advanced security feature to further improve the security within your GitHub repository.

## Token rate limits

Exceeding rate limits can lead to lost development time. Let's talk about rate limits for GitHub Apps and OAuth apps. By understanding rate limits, you can be a resource to developers on your team, helping optimize your organization's investment in these GitHub resources.

Rate limits help control the rate of traffic on GitHub, and are based on requests per hour.

- A GitHub App installed on a GitHub enterprise account has the request rate limit at 15,000 requests per hour.
- An OAuth App is authenticated to an individual user and is limited to 5,000 requests per hour.

For Enterprise administrators, you should monitor app rate limits and work with the developers to adjust their scripts to stay within the limits. Commonly, the rate limits are not a concern until your developer does something like writing a script that requests too much information in a workflow. Suddenly development comes to a halt and rate limits become a bottleneck. These rate-limit overage issues can be avoided by limiting the number of requests per hour or changing a workflow to wait between requests. If you exceed your rate limit using Basic Authentication or OAuth, you can likely fix the issue by caching API responses and using [conditional requests](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#conditional-requests). 

From the management console, you can set up a custom rate limit for unauthenticated users in your enterprise and create an exempt list, allowing certain users to utilize the full API rate limit. 

:::image type="content" source="../media/api-rate-limits-checkbox.png" alt-text="Screenshot of the management console setting the API rate limits." :::

You can check your current rate-limit status at any time using the Rate Limit API shown below. The returned HTTP headers of any API request show your current rate limit status.

```http
curl \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/rate_limit
```

Example response

```json
{
  "resources": {
    "core": {
      "limit": 5000,
      "remaining": 4999,
      "reset": 1372700873,
      "used": 1
    },
    "search": {
      "limit": 30,
      "remaining": 18,
      "reset": 1372697452,
      "used": 12
    },
    "graphql": {
      "limit": 5000,
      "remaining": 4993,
      "reset": 1372700389,
      "used": 7
    },
    "integration_manifest": {
      "limit": 5000,
      "remaining": 4999,
      "reset": 1551806725,
      "used": 1
    },
    "code_scanning_upload": {
      "limit": 500,
      "remaining": 499,
      "reset": 1551806725,
      "used": 1
    }
  },
  "rate": {
    "limit": 5000,
    "remaining": 4999,
    "reset": 1372700873,
    "used": 1
  }
}
```

For more detailed information about rate limits, see [Rate limiting](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting) on GitHub Docs.
