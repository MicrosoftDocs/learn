Here, the learner clones a sample .NET Core project from GitHub and builds/runs it locally.

I'm thinking we use the integrated Cloud Shell here.

Ideas for sections:

## What is source control?

## What is Git?

Git is ...

Perhaps mention other options that are available (the JTA mentions "TFVC, GitHub, & Bitbucket"). Why choose Git? ("Git is popular with the development community because ...")

## What is GitHub?

## What is cloning and forking?

## Create your GitHub account

## Get the project

1. Fork the reference app.
1. Clone it locally to Cloud Shell

    ```bash
    git clone ...
    ```

1. Build it locally.

    ```bash
    dotnet build src --configuration Release
    ```

1. Run it locally.

    ```bash
    dotnet run --project src/Xamarin.Web.DevConnect &>/dev/null &
    ```

1. Verify it (in practice, you would open up a browser and check it. Here, we don't have an IP address to access.)

    ```bash
    curl -I http://localhost:32372
    ```

    (The app is non-interactive at this point because curl provides just the raw HTML. Point again to our running reference implementation to see what the app does.)