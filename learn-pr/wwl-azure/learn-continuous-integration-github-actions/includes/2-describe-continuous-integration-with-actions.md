It's an example of a basic continuous integration workflow created by using actions:

```YAML
name: dotnet Build

on:
  push:
    branches:
    - main

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

- :::no-loc text="On:"::: Specifies what will occur when code is pushed.
- :::no-loc text="Jobs:"::: There's a single job called **`build`.**
- :::no-loc text="Strategy:"::: It's being used to specify the Node.js version.
- :::no-loc text="Steps:"::: Are doing a checkout of the code and setting up dotnet.
- :::no-loc text="Run:"::: Is building the code.
