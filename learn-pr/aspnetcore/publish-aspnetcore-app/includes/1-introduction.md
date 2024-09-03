An ASP.NET Core app is composed of source code files, assets, and configuration files. When you build an ASP.NET Core app, the source code is compiled into an executable form that can be run with the .NET runtime. Publishing an ASP.NET Core app is the process of packaging the executable app into a form that can be deployed and run on a server.

```markdown
## Introduction

## Build vs. Publish

1. Explain publishing
1. Explain framework-dependent vs. self-contained
1. Knowledge check

## Exercise - Build and Publish an ASP.NET Core app

1. dotnet new webapp
1. dotnet build
1. dotnet run
1. dotnet publish (framework-dependent)
1. run the app

## Exercise - Publish a self-contained app

1. dotnet publish
1. grant execute permission (macOS/Linux)
1. run the app

## Publishing to Azure

1. App Service
1. Containers
1. Knowledge check

## Summary
```

## Example scenario

Suppose you are an entry-level ASP.NET Core developer at a small company. You have been tasked with developing a new web application for the company's customers and deploying it to a web server. 

## What will we be doing?

In this module, you'll use the .NET SDK to create a boilerplate ASP.NET Core web application. After ensuring it runs correctly, you'll publish the app in two different ways: as a framework-dependent deployment and as a self-contained deployment. Finally, you'll learn about the different ways to deploy an ASP.NET Core app to Azure.

## What is the main goal?

By the end of this module, you'll be able to build and publish an ASP.NET Core app for deployment. You'll also be able to describe the different methods to deploy an ASP.NET Core app to Azure.