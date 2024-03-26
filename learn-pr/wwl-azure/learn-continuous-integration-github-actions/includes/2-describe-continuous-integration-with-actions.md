
It's an example of a basic continuous integration workflow created by using actions:

```YAML
name: dotnet Build

on: [push]

jobs:
    build:
        runs-on: ubuntu-latest
        strategy:
            matrix:
                node-version: [10.x]
        steps:

        - uses: actions/checkout@main
        - uses: actions/setup-dotnet@v1
            with:
                dotnet-version: '3.1.x'

        - run: dotnet build awesomeproject

```

 -  **On:** Specifies what will occur when code is pushed.
 -  **Jobs:** There's a single job called **build.**
 -  **Strategy:** It's being used to specify the Node.js version.
 -  **Steps:** Are doing a checkout of the code and setting up dotnet.
 -  **Run:** Is building the code.
