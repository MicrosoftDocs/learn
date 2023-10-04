Now that you have deployed your application on Code to Cloud, you need to manage and monitor the provisioned resources, which may include web apps, APIs and databases. Code to cloud provides a simplified and consolidated view for all your resources with extra insights on your app performance.

### What to manage

Generally, when deploying an app, there are some key things we need to manage once the app is deployed. Some important topics are.

- **Hosting**, hosting is an important topic, we need to ensure our app is always available for users. Availability is something we can control by configuring how it should scale whether horizontally or vertically. We can also make sure our app is deployed and hosted close to where our customers are.
- **Data**. Our app most likely uses data. Data could live anywhere from databases, unstructured data in blob storages and more. We need to make sure we have a clear strategy to manage data so we can change it, its structure and ensure it scales and is secured as well as regularly backed up.
- **Monitoring health**. We want to be proactive to ensure we detect issues with our app and can respond to deal with anything that comes up.
- **Security**. A vital concern is to ensure only trusted parties can access our app and its data. We need to be able to configure and monitor to keep things safe. Hosting. We need to ensure our applications are always available for users with no downtime. Availability is something we can control by configuring how it should scale whether horizontally or vertically. We can also make sure our app is deployed and hosted close to where our customers are.

### How to manage your app in Code to Cloud

Once your app is deployed in code to cloud, the service helps you manage it. Code to cloud offers you a component section that’s easily accessible and that gives you an overview of things to manage.
You can manage the following things via the Components section:

- **Hosting**, this section lets you manage web apps, API endpoints and the container registry where any container images are places that you use as part of the app.

- **Data**. Here you can manage your database and caching, if you use REDIS for example.

- **Monitoring**. In the monitoring section, you can inspect various logs and there’s even a dashboard to better understand how your app is doing.

### Hosting
In here, you find your web app instances and API endpoints. Select the appropriate link for what you want to learn more about

:::image type="content" source="../media/5-hosting.png" alt-text="Screenshot showing an example of the hosting section after deployment.":::

#### An example – A deployed sample app

Let’s explain what the above sections can contain with a sample app as an example. Given the sample app, here’s what these items represent:
- **api-service**, this is a container app with the To Do app's API.
- **web-service** – the web application for your To Do app.
- **container registry**, the last item in the hosting list is the container registry where all container images your app is using are placed.

When you select a resource from the hosting list, you’re shown a top card and a bottom section, let’s look at those next and learn what these sections can tell us.

#### Top card

Once you select one of the three options above, you are shown a card with more detailed information.

:::image type="content" source="../media/5-api-service.png" alt-text="Screenshot showing api-service information like URL, SKU and more.":::

Using this detailed information, you can inspect the resource by selecting “Go to advanced view”, or you can navigate to its URL or repository, if available (depends on the resource what’s available).

#### Bottom section

The bottom section that appears when you select a resource from the hosting list contains a number of menu options.  You can manage:

- **Secrets**, here you can manage secrets the app is using, for example add or remove keys.
- **Container details**, in the container details section you can learn more about the registry used, the image CPU and memory usage and more.
- **Log Stream**, here you can see logs coming through from the instances used.
- **Deployment**, to learn more about deployments, you should select the “Overview” option located above the hosting section in the left side of the screen.

    :::image type="content" source="../media/5-api-service-secrets.png" alt-text="Screenshot showing the bottom section highlighting the secrets.":::

> [!NOTE]
> Secrets and environment variables for these Container Apps can be managed, (added or deleted), on the Code to Cloud under the respective tabs, providing a centralized management experience for your project.

### Data

In the “Data” section, you see deployed databases and any caching instances. Here’s an example below:

:::image type="content" source="../media/5-data.png" alt-text="Screenshot showing data section with a database instance and Redis instance.":::

Just like with the “Hosting” section, you can select an instance and be shown a top card and bottom section with menu options to manage secrets, logs and more.

### Monitoring

The monitoring sections contain several instances that combined lets you get a good overview on how your app is doing. The following instances exist in this section

- **Application Insights** - A tool to monitor and diagnose the performance and usage of web services.

- **Log Analytics Workspace** - A tool to collect, analyze and visualize log and performance data from the resources deployed in the Code to Cloud instance, providing insights into their health and performance

- **Shared dashboard** - A tool to display and share visualizations and insights with other users

    The shared dashboard is worth mentioning as it shows you several interesting things. Select the dashboard instance and “Go to advanced view” in the top section. You see a dashboard like this one:

    :::image type="content" source="../media/5-monitoring-dashboard.png" alt-text="Screenshot showing a dashboard on usage, reliability, responsiveness and browser stats.":::

In the image above you see how various areas are covered that you want to monitor, those are:

- Usage, how many users, sessions and availability.
- Reliability, here it covers success and failure for requests, errors and IO
- Responsiveness, how long does it take for the server to respond.
- Browser, and closer to the user, actual page load time and exceptions in the browser.

All of these are interesting and relevant metrics that tell you how the user is perceiving your app.
