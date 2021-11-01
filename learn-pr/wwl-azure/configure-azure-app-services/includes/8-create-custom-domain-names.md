When you create a web app, Azure assigns it to a subdomain of azurewebsites.net. For example, if your web app is named contoso, the URL is contoso.azurewebsites.net. Azure also assigns a virtual IP address. For a production web app, you may want users to see a custom domain name.

:::image type="content" source="../media/app-service-custom-domain-1aa14379.png" alt-text="Screenshot of the custom domain name blade with a custom domain name.":::


## Configuration steps

1.  **Reserve your domain name**. If you haven't already registered for an external domain name (i.e. not \*.azurewebsites.net) already, the easiest way to set up a custom domain is to buy one directly in the Azure portal. The process enables you to manage your web app's domain name directly in the Portal instead of going to a third-party site to manage it. Likewise, configuring the domain name in your web app is greatly simplified. If you do not use the portal, you can use any domain registrar. When you sign up, the registration site will help you through the process.
2.  **Create DNS records that map the domain to your Azure web app.** The Domain Name System (DNS) uses data records to map domain names into IP addresses. There are several types of DNS records. For web apps, you’ll create either an A record or a CNAME record. If the IP address changes, a CNAME entry is still valid, whereas an A record must be updated. However, some domain registrars do not allow CNAME records for the root domain or for wildcard domains. In that case, you must use an A record.

 -  An A (Address) record maps a domain name to an IP address.
 -  A CNAME (Canonical Name) record maps a domain name to another domain name. DNS uses the second name to look up the address. Users still see the first domain name in their browser. For example, you could map contoso.com to yourwebapp.azurewebsites.net.

3.  **Enable the custom domain**. After obtaining your domain and creating your DNS record, you can use the portal to validate the custom domain and add it to your web app. Be sure to test.

> [!NOTE]
> To map a custom DNS name to a web app, the web app's App Service plan must be a paid tier.
