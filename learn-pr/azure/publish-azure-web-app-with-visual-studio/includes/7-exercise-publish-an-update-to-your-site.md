Your Alpine Ski House web app is up and running, but now you need to show it to your boss. You are going to have to update the site and publish those updates to Azure.

## Update your web app

### Replace the boilerplate code

1. In the **Pages** folder, open the **About.cshtml** file.

1. At the bottom of the code, locate 
    `<p> Use this area to provide additional information. </p>`.

1. Replace this boilerplate text with
    `<p>Welcome to the Alpine Ski House!</p>`.

1. Save the file.

1. Open the **About.cshtml.cs** file.

1. Replace the `Message` string to say
    **Alpine Ski House is the premier ski hill in Northeast.**

1. Save the file.

### Publish your updates

1. In Solution Explorer, right-click the project.

1. Select **Publish**. You should have an option that includes your [website]-web deploy.

1. Select your site, and Visual Studio will send your changes to Azure.

### View your changes

Once you've published your changes, Visual Studio will open the site in your browser. Navigate to the **About** page, and see that your changes are reflected.

## Congrats!

You have successfully updated your web app using Visual Studio 2017.
