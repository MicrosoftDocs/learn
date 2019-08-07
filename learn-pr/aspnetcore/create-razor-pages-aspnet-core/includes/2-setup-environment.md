In this unit, you'll set up the development environment for the module, which will contain the ContosoPets.UI example project.

## Set up development environment

Run the following command in the command shell. Be patient, as setup can take a few minutes to complete.

```bash
. <(wget -q -O - https://aka.ms/create-razor-pages-aspnet-core-setup)
```

When the development environment has completed set up, the project *:::no-loc text="ContosoPets.UI":::* project directory opens in the [Azure Cloud Shell editor](https://docs.microsoft.com/azure/cloud-shell/using-cloud-shell-editor).

You'll see the following list of ContosoPets.UI project directories and files:

* *:::no-loc text="bin":::*
* *:::no-loc text="Extensions/":::*
* *:::no-loc text="Models/":::*
* *:::no-loc text="obj/":::*
* *:::no-loc text="Pages/":::*
* *:::no-loc text="Services/":::*
* *:::no-loc text="wwwroot/":::*
* *:::no-loc text=".gitignore":::*
* *:::no-loc text="appsettings.Development.json":::*
* *:::no-loc text="appsettings.json":::*
* *:::no-loc text="ContosoPets.UI.csproj":::*
* *:::no-loc text="Program.cs":::*
* *:::no-loc text="StartUp.cs":::*

A web API has also been deployed to a public endpoint. The *:::no-loc text="ContosoPets.UI":::* example will provide a client front end for the web API. This endpoint will be called in a later step.