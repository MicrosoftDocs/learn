The multi-stage dockerfile on the previous page is based on a Visual Studio solution.

The complete example can be found in this [GitHub repo](https://github.com/SteveLasker/AspNetCoreMultiProject) representing a Visual Studio solution with a Web and API project.

The extra unit tests are under the AddingUnitTests branch.

The challenge with solutions is they represent a collection of projects. We often think of dockerfiles specific to a single image. While true, that single image may be the result of multiple "projects."

Consider the common pattern to develop shared DLLs representing your data access layer:

 -  Your logging component.
 -  Your business logic.
 -  Authentication library.
 -  Shipping calculation.

The Web or API project may include each reference in specific project(s). They each need to take the compiled output from those projects and place them in the optimized image.

It is not to say we are building yet another monolithic application.

There will undoubtedly be other services, such as checkout, authentication, profile management, communicating with the telco switch.

But there's a balance. Microservices don't mean every shared piece of code is its service.

If we look at the solution, we'll notice a few key aspects:

 -  Each project, which will represent a final docker image, has its multi-stage Dockerfile.
 -  Shared component projects that are referenced by other-resulting docker images don't have Dockerfiles.
 -  Each dockerfile assumes its context is the solution directory. It gives us the ability to copy in other projects.
 -  There's a docker-compose.yml at the root of the solution. It gives us a single file to build multiple images and specify build parameters, such as the image name:tag.

```docker
Multi.sln
docker-compose.yml
[Api]
  Dockerfile
[Web]
  Dockerfile

```

We can now build the solution with a single docker command. We'll use docker-compose as our compose file has our image names and the individual build definitions.

```docker
version: '3'

services:
  web:
    image: stevelas.azurecr.io/samples/multiproject/web
    build:
      context: .
      dockerfile: Web/Dockerfile

api:
  image: stevelas.azurecr.io/samples/multiproject/api
  build:
    context: .
    dockerfile: Api/Dockerfile

```

Opening a command or PowerShell window, open the root directory of the solution:

```docker
PS> cd C:\Users\stevelas\Documents\GitHub\SteveLasker\AspNetCoreMultiProject
PS> docker-compose build

```

Elements of the output contain:

```docker
Building web
Step 1/17: FROM microsoft/aspnetcore: 2.0 AS base
Step 4/17: FROM microsoft/aspnetcore-build: 2.0 AS builder
Step 12/17: FROM builder AS publish
Step 14/17: FROM base AS production
Successfully tagged stevelas.azurecr.io/samples/multiproject/web: latest
Building api
Step 1/17: FROM microsoft/aspnetcore: 2.0 AS base
Step 4/17: FROM microsoft/aspnetcore-build: 2.0 AS builder
Step 6/17: COPY *.sln ./
Step 7/17: COPY Api/Api.csproj Api/
Step 8/17: RUN dotnet restore
Step 11/17: RUN dotnet build -c Release -o /app
Step 12/17: FROM builder AS publish
Step 13/17 : RUN dotnet publish -c Release -o /app
Step 14/17 : FROM base AS production
Step 16/17 : COPY --from=publish /app .
Successfully tagged stevelas.azurecr.io/samples/multiproject/api:latest

```

## Coming into port

With multi-stage dockerfiles, we can now encapsulate our entire build process.

By setting the context to our solution root, we can build multiple images or build and aggregate shared components into images.

By including our build environment in our multi-stage dockerfile, the development team owns the requirements to build their code, helping the CI/CD team maintain a cattle farm without maintaining individual build environments.
