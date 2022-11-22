Content Delivery Networks (CDNs) have particular troubleshooting steps as well as connectivity issues. It is important to consider specific CDN issues, such as the amount of time it takes to create some CDN services and compression issues.

## 404 status

If an HTTP 404 error is returned, you should complete the following troubleshooting steps:

- Wait 90 minutes after CDN creation.
  - Depending on the type of CDN, it can take up to 90 minutes to be available.

- Verify that the origin file is available.
  - Open a private or incognito browsing session and browse directly to the file to ensure that it is available.

- Check endpoint settings.
  - Browse to the CDN profile in the Azure portal, select the relevant endpoint, and select the origin.
  - Verify the origin type, hostname, HTTP port, and HTTPS port.
  - For the endpoint page, select **Configure**, and verify the **Origin host header** and **Origin path**.

## Compression errors

If compression is enabled for the endpoint, but files are returned uncompressed, perform the following troubleshooting steps:

- In the browser’s developer tools, verify that the request is being sent to the endpoint URL and the request contains an **Accept-Encoding** header which contains **gzip**, **deflate**, or **bzip2**.

- Verify that compression is enabled and the relevant file types are included.

- For Verizon CDN profiles, use your browser’s developer tools to verify that the file is cached in the same region as the request.

- For Verizon CDN profiles, verify that the file is between 128 bytes and 3 MB.

- Check for a **Via** header in the request at the origin server. A **Via** HTTP header signifies that the request is going through a proxy server. By default, Microsoft IIS servers do not compress responses that contain a **Via** header. To override this, you would need to reconfigure your IIS server.

## CA certificates

Verify that the CA certificate is in the **Included CA Certificate list** at the **Common CA Database** (CCADB).

## Subscription type

Check the subscription type because **Free**, **Trial**, and **Pay-as-you-go** subscriptions will limit the CDN services available and might apply bandwidth throttling.
