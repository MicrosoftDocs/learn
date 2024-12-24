The final step is to test the Front Door environment and verify if routing rules are configured correctly to direct web traffic. We also want to test availability of the origin web servers and if cached contents can still be accessed when servers are down.

## Test traffic distribution for vehicle registration web app

1. In Cloud Shell, run the following command to generate the URL for your Front Door endpoint.

    ```azurecli
    echo https://$(az afd endpoint show \
        --profile-name vehicleFrontDoor \
        --endpoint-name $endpoint \
        --resource-group $RG \
        --query hostName \
        --output tsv)
    ```

1. Using a web browser, navigate to the web site at the URL returned in the previous command. This URL is the address of the endpoint you created in the Front Door profile. Verify that the home page of the vehicle registration web app appears. Notice that the name of the web server is shown on the page to let you know which instance is serving your request.

    :::image type="content" source="./../media/6-web-server-1.png" alt-text="Screenshot of web server 1 responding to web browser request.":::

1. Refresh the browser by pressing **F5** a few times on your keyboard. Notice the server name changing back and forth between *webServer1* and *webServer2*. Both web servers are located in the same region and have similar latency. So, both servers have equal chances to serve your requests.

    :::image type="content" source="./../media/6-web-server-2.png" alt-text="Screenshot of web server 2 responding to web browser request.":::

## Test routing

Now let's test the routing of the route configuration to each website. You configured a route that matches `/VehicleRegistration/` and `/VehicleRegistration/*` to go to the private endpoint for the web servers. For requests that match `/LicenseRenewal/` and `/LicenseRenewal/*` you routed them to the App service. In this lab, communication between your Azure Front Door and the origin resources are private because you're using Private Link service to establish connectivity.

1. To test routing to other pages for the Vehicle registration website, select **Register a Vehicle**. 

    :::image type="content" source="./../media/6-web-server-1-registration.png" alt-text="Screenshot of web server 1 register a vehicle link.":::

1. Notice the URL changed to contain the path `/VehicleRegistration/Create`. Since we have a *pattern to match* of `/VehicleRegistration/*`, the wildcard matches anything after `/` and is routed to the web servers hosting the Vehicle registration web site.

    :::image type="content" source="./../media/6-vehicle-registration-page.png" alt-text="Screenshot of vehicle registration page.":::

1. Next let's test routing to license renewal website. Change the path from `/VehicleRegistration/Create` to `/LicenseRenewal/`. This path routes to the App service origin.

    :::image type="content" source="./../media/6-license-renewal-home.png" alt-text="Screenshot of license renewal home page.":::

1. Select **Renew a License** to see the path change to `/LicenseRenewal/Create`. Just like the route for Vehicle registration, there's a pattern to match of `/LicenseRenewal/*` that has a wildcard to match anything after `/` and direct that traffic to the App service.

    :::image type="content" source="./../media/6-license-renewal-create.png" alt-text="Screenshot of renew a license page.":::

With this configuration, you can direct your users to both web sites through the Front Door. You can set up a custom domain that can easily be remembered and direct users to the correct page for their needs. With Front Door you can expand to host multiple web sites, enable caching to improve performance of static resources, and deliver a high scalable and available web application.

## Test security policy

1. Download and install [Go for Windows](https://go.dev/doc/install). Use all default settings during installation. You need Go to run the **GoTestWAF** application.

1. Download and install [Git for Windows](https://git-scm.com/download/win). Use all default settings during installation. You need Git to clone the **gotestwaf** repository to your local machine.

1. Once you've installed both Go and Git for Windows, open **Git Bash** and run `git clone https://github.com/wallarm/gotestwaf.git` to download the **GoTestWAF** files to your local machine.

    :::image type="content" source="./../media/6-clone.png" alt-text="Screenshot of cloning the gotestwaf repository with Git.":::

1. Change the directory to **gotestwaf** folder with `cd gotestwaf` command.

    :::image type="content" source="./../media/6-change-directory.png" alt-text="Screenshot of changing directory to gotestwaf folder with Git.":::

1. Now run the following command to test if the security policy is working. Replace `<EVALUATE_SECURITY_SOLUTION_URL> with the URL of the endpoint at the beginning of this unit.

    ```bash
    go run ./cmd --url=<EVALUATED_SECURITY_SOLUTION_URL> --verbose
    ```

1. If you configured the WAF policy settings correctly, you should see a `Baseline attack status code: 999` in the output. This response status code is the same one you configured if WAF blocks a request.

    :::image type="content" source="./../media/6-test.png" alt-text="Screenshot of running GoTestWAF with Git and displaying 999 status code.":::

You now have a fully functional motor vehicle web application protected by a Web Application Firewall (WAF) policy.
