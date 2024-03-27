
Actions often can use secrets within pipelines. Common examples are passwords or keys.

In GitHub actions, It's called **Secrets**.

## Secrets

Secrets are similar to environment variables but encrypted. They can be created at two levels:

 -  Repository
 -  Organization

If secrets are created at the organization level, access policies can limit the repositories that can use them.

## Creating secrets for a repository

To create secrets for a repository, you must be the repository's owner. From the repository **Settings**, choose **Secrets**, then **New Secret**.

:::image type="content" source="../media/new-secret-5ba1255e.png" alt-text="Screenshot of new secret creation from settings.":::


For more information on creating secrets, see [Encrypted secrets](https://docs.github.com/actions/security-guides/encrypted-secrets).
