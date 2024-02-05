This unit describes common issues with the Remote Desktop client and how to fix them.

## Remote Desktop client for Windows 10 stops responding or cannot be opened

You can reset the user data from the About page or using a command.

Use the following command to remove your user data, restore default settings and unsubscribe from all Workspaces.

```
msrdcw.exe /reset [/f]

```

## Web client won't open

First, test your internet connection by opening another website in your browser; for example, `[www.bing.com](http://www.bing.com/)`.

Use **nslookup** to confirm DNS can resolve the FQDN:

```
nslookup rdweb.wvd.microsoft.com

```

Try connecting with another client, like Remote Desktop client for Windows 10, and check to see if you can open the web client.

### Can't open other websites while connected to the web client.

If you can't open other websites while you're connected to the web client, there might be network connection problems or a network outage. We recommend you contact network support.

### Nslookup can't resolve the name.

If nslookup can't resolve the name, then there might be network connection problems or a network outage. We recommend you contact network support.

### Your client can't connect but other clients on your network can connect.

If your browser starts acting up or stops working while you're using the web client, follow these instructions to troubleshoot it:

1.  Restart the browser.
2.  Clear browser cookies.
3.  Clear browser cache.
4.  Open browser in Private mode.

## Client doesn't show my resources

First, check the Microsoft Entra account you're using. If you've already signed in with a different Microsoft Entra account than the one you want to use for Azure Virtual Desktop, you should either sign out or use a private browser window.

If that doesn't work, make sure your app group is associated with a workspace.

## Web client stops responding or disconnects

Try connecting using another browser or client.

### Other browsers and clients also malfunction or fail to open.

If issues continue even after you've switched browsers, the problem may not be with your browser, but with your network.

### Web client keeps prompting for credentials.

If the Web client keeps prompting for credentials, follow these instructions:

1.  Confirm the web client URL is correct.
2.  Confirm that the credentials you're using are for the Azure Virtual Desktop environment tied to the URL.
3.  Clear browser cookies.
4.  Clear browser cache.
5.  Open your browser in Private mode.
