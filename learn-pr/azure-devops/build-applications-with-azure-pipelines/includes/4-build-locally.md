Here, the learner clones a sample .NET Core project from GitHub and builds/runs it locally.

I'm thinking we use the integrated Cloud Shell here.

Ideas for sections:

### What is source control?

### What is Git?

Git is ...

Perhaps mention other options that are available (the JTA mentions "TFVC, GitHub, & Bitbucket"). Why choose Git? ("Git is popular with the development community because ...")

### What is GitHub?

### Get the project

1. Fork the sample repo.
1. Clone it locally to Cloud Shell

    ```bash
    git clone ...
    ```

1. Build it locally.

    ```bash
    dotnet build ...
    ```

1. Run it locally.

    ```bash
    dotnet run ...
    ```

1. Verify it's working.

    `curl localhost` or some sort to verify that it's running.