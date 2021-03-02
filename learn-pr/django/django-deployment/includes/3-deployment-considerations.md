An application running on production has a different set of needs and requirements than when running in development. In particular, security and performance concerns are not as critical during development as they are when deployed to production. As a result, we need to ensure our website is properly configured before deployment.

Django provides a [full checklist of configuration updates](https://docs.djangoproject.com/en/3.1/howto/deployment/checklist/?azure-portal=true) before deployment. Below are some of the more common changes you will want to make.

## Disable debug mode

As a developer, we want to see any error messages our application may generate. However this information can provide an attacker with insights into how our application runs, potentially allowing then unauthorized access. Inside of **settings.py** there is a `DEBUG` option which should be set to `False` when running on production.

## Secret key

To protect sensitive information, Django uses a secret key to sign any values which must not be tampered with. During development, the secret key is stored in clear text in **settings.py**. When deployed to production, this should be read from a more secure location, such as Azure App Settings or Azure Key Vault.

## Allowed hosts

**settings.py** contains a list of server names called `ALLOWED_HOSTS`, which determines from where your application can run. By default the empty list allows it to be run from localhost; this needs to be updated when deploying to your production host.

## Static files

Static files are any files which aren't part of the Django templating system. These typically include JavaScript or CSS files, but may also include static HTML files. In particular, the admin site uses static files for style and formatting.

While running on development, Django automatically serves any static files. On production, you need to configure a service to serve any static files. One common solution is to use a library called [whitenoise](http://whitenoise.evans.io/en/stable/index.html/?azure-portal=true) to manage static files.

During the deployment process, all static files are collected and placed into the location indicated by `STATIC_ROOT` in **settings.py**. This is done by running **python manage.py collectstatic**. Azure automatically runs this command, so you do not need to run it locally before deployment.
