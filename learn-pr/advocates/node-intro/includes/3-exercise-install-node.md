As a Node.js developer on Tailwind Traders you are running applications on many different systems with a multitude of operating systems. Also not all of our Node.js apps can for various reasons run on the same version of Node.js. For that reason we will take a closer look at the tool `nvm` to help us manage our installations.

## Learn to leverage NVM

We've introduced NVM in the conceptual part. Let's now show how we install and use it. There are different ways of installing. Here's how you install it on a Mac/Linux:

```bash
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
```

The above uses cURL to fetch and install NVM. If you need to install cURL first you can find an executable on this page:

```bash
https://curl.haxx.se/download.html
```

If you are a Windows machine please check out this docs link:

[NVM install on Windows](https://docs.microsoft.com/en-us/windows/nodejs/setup-on-windows).

> [!NOTE]
> nvm on Windows is called windows-nvm. It might differe slightly in what the commands are called and how they are used. It's worth checking out the doc page above.

Once we've installed NVM it's time to run some commands.

### Check installation

After install you might need to reload your terminal. Ensure your installation worked fine by typing this command:

```bash
nvm --version
```

It should output the version number of the installed NVM:

```bash
0.35.3
```

### Install a specific version

You might already have a certain version in mind that yuo want to install. If you don't then you can list all the different versions you can download with the following command:

```bash
nvm ls-remote
```

If you are on windows machine the command looks like this:

```bash
nvm ls available
```

Just a heads up though. This will list all versions that was ever published so it will be a long list.

If you are on Mac/Linux you can an use `less` or `grep` to reduce the output size.

```bash
nvm ls-remote | less
```

The above produces an output of the first page and you can then list each available install one by one or y jumping one page at a time.

The other alternative `grep` allows you to narrow down your size by adding a search term like so:

```bash
nvm ls-remote | grep v10
```

This will list everything starting with the term `v10`.

At this point we can decide on a specific version that we want to install and with this command we install just that:

```bash
nvm install v10
```

The above will install `v10` of the Node.js runtime.

### Use a specific version

Now that we have more than one version of Node.js runtime installed on our system we can select which version should be the default one. First, let's list the installed Node.js runtime versions on our system with this command:

```bash
nvm list
```

Once you decide which one you want you can type the following command to set which version should be the default one:

```bash
nvm use <version>
```

An example can look like this:

```bash
nvm use v12.16.2
```

NVM just expects you to add an installed version above as an argument. You can verify the switch has been made by this command:

```bash
node --version
```

Your system should now output something like this:

```bash
v12.16.2
```

## Run app on a specific version

In the previous section we change the *default* version apps will be run with but we can be more granular and decide for every app what version of Node.js we want to run it with. It's accomplished with this command:

```bash
nvm run <version of Node.js> app.js
```

An example can look like this:

```bash
nvm run v10.20.1 app.js
```

It's powerful to be to able to see how your app performs on a different Node.js version

### Uninstall a specific version

We might end up having a lot of different versions installed of Node.js if we have apps that support different versions of Node.js To mitigate that that we completely clutter our system with Node.js installations we can uninstall specific versions when we no longer need them. We can perform an install with the following command:

```bash
nvm uninstall <version>
```

An example can look like this:

```bash
nvm uninstall v10.20.1
```

