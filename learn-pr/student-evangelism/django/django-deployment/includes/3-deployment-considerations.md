An application running in a production environment has a different set of needs and requirements than it does in a development environment. In particular, security and performance concerns aren't as critical during development as they are in production. So you need to ensure your website is properly configured before deployment.

Django provides a full [checklist of predeployment configuration updates](https://docs.djangoproject.com/en/3.1/howto/deployment/checklist/?azure-portal=true). The following sections describe a few common changes you'll want to make before you deploy your app to production.

## Debug mode

As a developer, you want to see any error messages your application might generate. But this information can provide an attacker with insights into how your application runs, potentially allowing unauthorized access. So in *settings.py*, set the `DEBUG` option to `False` before you deploy your app to production.

## Secret key

To protect sensitive information, Django uses a secret key to sign any values that must not be tampered with. During development, the secret key is stored in cleartext in *settings.py*. When you deploy to production, the secret key should be read from a more secure location, such as Azure App Settings or Azure Key Vault.

## Allowed hosts

The *settings.py* file contains a list of server names called `ALLOWED_HOSTS`. This list determines where your application can run from. By default, the empty list allows the app to run from localhost. Update this setting before you deploy to your production host.

## Static files

Static files are any files that aren't part of the Django templating system. These files typically include JavaScript or CSS files. But they might also include static HTML files. In particular, the admin site uses static files for style and formatting.

While your app is in development, Django automatically serves any static files. In production, you need to configure a service to serve any static files. One common solution is a [WhiteNoise](http://whitenoise.evans.io/en/stable/?azure-portal=true) library.

During the deployment process, all static files are collected into the location indicated by `STATIC_ROOT` in *settings.py*. They're collected by running `python manage.py collectstatic`. Azure automatically runs this command, so you don't need to run it locally before deployment.
