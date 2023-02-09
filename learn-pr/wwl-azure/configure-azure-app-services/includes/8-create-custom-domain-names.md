When you create a web app, Azure assigns the app to a subdomain of `azurewebsites.net`. Suppose your web app is named `contoso`. Azure creates a URL for your web app as `contoso.azurewebsites.net`. Azure also assigns a virtual IP address for your app. For a production web app, you might want users to see a custom domain name.

:::image type="content" source="../media/app-service-custom-domain-1aa14379.png" alt-text="Screenshot that shows the Custom domains page in the Azure portal and a custom domain named contoso with the app URL constoso dot-com." border="false":::

### Configure a custom domain name for your app

There are three steps to create a custom domain name. The following steps outline how to create a domain name in the Azure portal.

> [!Important]
> To map a custom DNS name to your app, you need a paid tier of an App Service plan for your app.

1. **Reserve your domain name**. If you haven't registered for an external domain name for your app, the easiest way to set up a custom domain is to buy one directly in the Azure portal. (This name isn't the Azure assigned name of `\*.azurewebsites.net`.) The registration process enables you to manage your web app's domain name directly in the Azure portal instead of going to a third-party site. Configuring the domain name in your web app is also a simple process in the Azure portal. 

1. **Create DNS records to map the domain to your Azure web app**. The Domain Name System (DNS) uses data records to map domain names to IP addresses. There are several types of DNS records.

   - For web apps, you create either an `A` (Address) record or a `CNAME` (Canonical Name) record.
      - An `A` record maps a domain name to an IP address.
      - A `CNAME` record maps a domain name to another domain name. DNS uses the second name to look up the address. Users still see the first domain name in their browser. As an example, you could map `contoso.com` to your `webapp.azurewebsites.net` URL.

   - If the IP address changes, a `CNAME` entry is still valid, whereas an `A` record must be updated. 
   
   - Some domain registrars don't allow `CNAME` records for the root domain or for wildcard domains. In such cases, you must use an `A` record.

1. **Enable the custom domain**. After you have your domain and create your DNS record, use the Azure portal to validate your custom domain and add it to your web app. Be sure to test your domain before publishing.