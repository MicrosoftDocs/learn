Let's set up our application for production by updating some of the most common settings.

## Add libraries

We'll use two new libraries for our project:

- `whitenoise` to serve static files
- `psycopg2-binary` to connect to PostgreSQL, our production database

Let's install those into our project.

1. Inside **Visual Studio Code**, open **requirements.txt**.
1. Add the following to the end of **requirements.txt**:

    ```text
    whitenoise
    psycopg2-binary
    ```

1. Open a new terminal window by clicking **Terminal** > **New terminal**.
1. Install the libraries by executing the following command:

    ```bash
    pip install -r requirements.txt
    ```

## Create a production settings file

Two core settings, `ALLOWED_HOSTS` and `DATABASES`, need to be set to different values depending on the environment hosting our application. The default settings are designed for development. When running in production, we will need to ensure these are updated properly.

`ALLOWED_HOSTS` controls the servers allowed to host or run your application. We will configure it to allow our site to run from Azure and locally. `DATABASES` contains the list of available connection strings.

A common way to configure these options is to create a second Python file with the collection of settings for production. We then have a flag in **manage.py** to read the appropriate file. let's create a production settings file, and then update **manage.py** to load the file when our application is running on production.

1. Create a new file inside **project** named **azure.py**
1. Add the following code to import `os`:

    ```python
    import os
    ```

1. Add the following code to the end of the file to override `ALLOWED_HOSTS` to allow Azure to host our application:

    ```python
    ALLOWED_HOSTS = [os.environ['WEBSITE_HOSTNAME']] if 'WEBSITE_HOSTNAME' in os.environ else []
    ```

    > [!NOTE]
    > Azure App Services automatically creates an environmental variable named **WEBSITE_HOSTNAME** which contains the URL for our website. We can also use this to determine if our application is running on Azure.

1. Add the following code to configure the database connection string for PostgreSQL:

    ```python
    hostname = os.environ['DBHOST']
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql',
            'NAME': os.environ['DBNAME'],
            'HOST': hostname + ".postgres.database.azure.com",
            'USER': os.environ['DBUSER'] + "@" + hostname,
            'PASSWORD': os.environ['DBPASS'] 
        }
    }
    ```

    > [!NOTE]
    > We'll set the environmental variables on Azure in a later step

    The connection string we are using is for PostgreSQL. We provide the following information:

      - **ENGINE**: Database type
      - **NAME**: Name of the database
      - **HOST**: URL to the server
      - **USER**: Username to use to connect to the database
      - **PASSWORD**: Password for the user

1. Add the following to the bottom of the file to enable **whitenoise**, which will serve static files

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

    **whitenoise** is middleware which reads requests from the user for static files such as CSS or JavaScript and ensures they are served correctly. We registered the middleware by updating the `MIDDLEWARE` array, and registered a `STATIC_ROOT` for storing static files.

1. Set the `SECRET_KEY` with one read from environmental variables by adding the following code:

    ```python
    SECRET_KEY = os.getenv('SECRET_KEY')
    ```

    We will create a new secret key after we deploy our application and store it as an application setting.

1. Disable debugging mode by adding the following code:

    ```python
    DEBUG = False
    ```

## Configuring your application to use the production settings file

With the production settings file created we can now update our application to load it when running on production. We will do this by looking for **WEBSITE_HOSTNAME** environmental variable, which will indicate our application is running on Azure.

1. Open **settings.py**.
1. Add the following code to the end of the file to override the necessary settings when running in production:

    ```python
    if 'WEBSITE_HOSTNAME' in os.environ: # Running on Azure
        from .azure import *
    ```

1. Save all files by clicking **File** > **Save all**.

You have now configured a Django application for production.
