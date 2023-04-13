Let's start implementing the design for the app by creating a new project and specifying some user interface for entering the project name.

## Create a solution

The .NET CLI is the simplest way to create an ASP.NET Core web API. The CLI is pre-installed when you install the .NET SDK.

In this unit, you'll use the .NET CLI to create a web API locally. You'll also gain an understanding of the resulting project.

## Create and explore a web API project

To set up a .NET project to work with a web API, we'll use Visual Studio Code. Visual Studio Code includes an integrated terminal, which makes creating a new project easy. If you don't want to use another code editor, you can use a terminal to run the commands in this module.

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a folder named **AccessibleWeb** in the location of your choice, and then select **Select Folder**.

1. Open the integrated terminal in Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command:

    ```dotnetcli
    dotnet new webapp
    ```

    This command creates the files for a basic web API project. Those files include a C# project file named *AccessibleWeb.csproj*, which includes a few pages to get started. 

    You might receive a prompt from Visual Studio Code to add assets to debug the project. Select **Yes** in the dialog.  

    You should now have access to the files.

    ```bash
    -| obj
    -| Pages
      -| Shared
      -| _ViewImports.cshtml
      -| _ViewStart.cshtml
      -| Error.cshtml
      -| Error.cshtml.cs
      -| Index.cshtml
      -| Index.cshtml.cs
      -| Privacy.cshtml
      -| Privacy.cshtml.cs
    -| Properties
    -| appsettings.Development.json
    -| appsettings.json
    -| ContosoPizza.csproj
    -| Program.cs
    -| Startup.cs
    ```

## Create the data entry form

1. Open *Index.cshtml*.
1. Replace the contents of the page with the following markup:  

   ```razor
   @page
   @model IndexModel
   @{
     ViewData["Title"] = "Home page";
   }

   <div class="text-center">
     <h1 class="display-4">Welcome</h1>
     <p>We hope you like pizza. That's what we make here.</p>
   </div>

   <style>
     div.button {
       width: 200px;
       height: 50px;
       border-radius: 20px;
       background-color: lightgray;
       text-align: center;
       padding: 10px;
       margin: 50px;
     }
   </style>


   <h1 class="display-6">Join our mailing list</h1>
   <p>Sign up to hear about all our special offers!</p>

   <form name="CustomerInfo">
     <div class="container w-50 p-3">
       <div class="row">
         <div class="col-4 text-primary">
           First Name
         </div>
         <div class="col-8">
           <input type="text" id="Name">
         </div>
       </div>
       <div class="row">
         <div class="col-4 text-primary">
           Last Name
         </div>
         <div class="col-8">
           <input type="text" id="Name">
         </div>
       </div>
       <div class="row text-black-50">
         <div class="col-4">
           Phone
         </div>
         <div class="col-8">
           <input type="text" id="Phone">
         </div>
       </div>
       <div class="row text-black-50">
         <div class="col-4">
           Birthday
         </div>
         <div class="col-8">
           <input type="text" id="Birthday">
         </div>
       </div>
       <div class="row text-primary">
         <div class="col-4">
           E-mail Address
         </div>
         <div class="col-8">
           <input type="text" id="E-mail">
         </div>
       </div>
       <div class="button">
         <a href="#" onclick="document.getElementById('CustomerInfo').Submit();">
           Submit Form
         </a>
       </div>
     </div>
   </form>

   <p style="font-size: 30px"><b>All about our wonderful pizza!</b></p>
   <p class="bg-light text-muted">We make it fresh every day, sometimes up to two or three times a day!<br><br>
   We love to make pizza!
   </p>

   <div class="text-center">
     <img width="120" src="data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg'%3e%3cpath d='M.226 112L36.2.2c60 
   16 74 49 81 84z' fill='%23ea8'/%3e%3cpath d='M.197 112L31 14C84 29 96 57 103 88z' fill='%23fea' /%3e%3c/svg%3e">
   </div>

   <p style="font-size: 30px"><b>We take your privacy seriously!</b></p>
   <p class="bg-light text-muted">Unlike other pizza restaurants that share your pizza preferences, we care about your privacy.<br><br>
   Want to know more? <a href="/Privacy">Click here.</a>
   </p>

   <p style="font-size: 30px"><b>Delivery options</b></p>
   <p class="bg-light text-muted">There are a few ways we can get the pizza to you:<br>
     - Postal mail<br>
     - Dog sled<br>
     - Drone (experimental!)
   </p>
   ```

## Run the application

1. Run the application by entering the following command in the terminal window:

    ```dotnetcli
    dotnet run
    ```

2. In your web browser, go to https://localhost:5001. You'll see the home page of the pizza restaurant's website. This page might look OK at first glance, but it contains many issues that limit its accessibility. In the following units, you'll find and fix these issues.
