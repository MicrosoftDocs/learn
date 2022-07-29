Set up your application for production by updating some of the most common settings.

## Add libraries

You'll use two new libraries for your project:

- `whitenoise` to serve static files
- `psycopg2-binary` to connect to PostgreSQL, the production database

Install those libraries in your project:

1. In Visual Studio Code, open *requirements.txt*.
1. Add the following code to the end of *requirements.txt*.

    ```text
    whitenoise
    psycopg2-binary
    ```

1. Open a new terminal pane by selecting **Terminal** > **New terminal**.
1. Install the libraries by running the following command.

    ```bash
    pip install -r requirements.txt
    ```

## Create a production settings file

The values you assign to two core settings, `ALLOWED_HOSTS` and `DATABASES`, depend on the environment that hosts the application. The default settings are designed for development. To run your app in production, ensure these settings are updated properly.

`ALLOWED_HOSTS` controls the servers that are allowed to host or run your application. You'll configure it to allow the site to run from Azure and locally. `DATABASES` contains the list of available connection strings.

A common way to configure the settings is to create a second Python file that contains the collection of settings for production. Then a flag in *manage.py* reads the appropriate file.

Now you'll create a production settings file. Then you'll update *manage.py* to load the file when your application is running in production:

1. Create a new file inside *project*. Name it *azure.py*.
1. Add the following code to import `os`.

    ```python
    import os
    ```

1. Add the following code to the end of the file to override `ALLOWED_HOSTS` to allow Azure to host the application.

    ```python
    ALLOWED_HOSTS = [os.environ['WEBSITE_HOSTNAME']] if 'WEBSITE_HOSTNAME' in os.environ else []
    ```

    > [!NOTE]
    > Azure App Service automatically creates an environmental variable named `WEBSITE_HOSTNAME`. This variable contains the URL for your website. You can use this variable to determine whether your application is running on Azure.

1. Add the following code to configure the database connection string for PostgreSQL.

    ```python
    hostname = os.environ['DBHOST']
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql',
            'NAME': os.environ['DBNAME'],
            'HOST': hostname + ".postgres.database.azure.com",
            'USER': os.environ['DBUSER'],
            'PASSWORD': os.environ['DBPASS'] 
        }
    }
    ```

    > [!NOTE]
    > You'll set the environmental variables on Azure in a later step.

    > [!NOTE]
    > The database connection is for [PostgreSQL Flexible Server](/azure/postgresql/flexible-server/). For [PostgreSQL Single Server](/azure/postgresql/single-server/), set the `USER` value to  `os.environ['DBUSER'] + "@" + hostname`.

    The connection string you're using is for PostgreSQL. You provide the following information:

      - **ENGINE**: Database type
      - **NAME**: Name of the database
      - **HOST**: URL for the server
      - **USER**: Username to use to connect to the database
      - **PASSWORD**: Password for the user

1. Add the following code to the bottom of the file to enable `whitenoise`, which will serve static files.

    ```python
    MIDDLEWARE = [
        'django.middleware.security.SecurityMiddleware',
        # Enables whitenoise for serving static files
        'whitenoise.middleware.WhiteNoiseMiddleware',
        'django.contrib.sessions.middleware.SessionMiddleware',
        'django.middleware.common.CommonMiddleware',
        'django.middleware.csrf.CsrfViewMiddleware',
        'django.contrib.auth.middleware.AuthenticationMiddleware',
        'django.contrib.messages.middleware.MessageMiddleware',
        'django.middleware.clickjacking.XFrameOptionsMiddleware',
    ]
    STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
    ```

    WhiteNoise is middleware that reads user requests for static files such as CSS or JavaScript. It also ensures the files are served correctly. You registered the middleware by updating the `MIDDLEWARE` array. You registered a `STATIC_ROOT` to store static files.

1. Set the `SECRET_KEY` with one read from environmental variables by adding the following code.

    ```python
    SECRET_KEY = os.getenv('SECRET_KEY')
    ```

    You'll create a new secret key after you deploy the application and store it as an application setting.

1. Disable debugging mode by adding the following code.

    ```python
    DEBUG = False
    ```

## Configure your app to use the production settings file

Now that you've created the production settings file, you can update your application to load the file in production. Start by looking for the `WEBSITE_HOSTNAME` environmental variable. This variable indicates the application is running on Azure.

1. Open *settings.py*.
1. Add the following code to the end of the file to override the necessary settings when the app runs in production.

    ```python
    if 'WEBSITE_HOSTNAME' in os.environ: # Running on Azure
        from .azure import *
    ```

1. Save all files by selecting **File** > **Save all**.

You've now configured a Django application for production.
