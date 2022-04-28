Before you start creating applications with Go, you need to set up your development environment. 

If you prefer not to install Go locally, you can use the [Go Playground][GoPlay]. The playground is a web service that can run Go applications in a browser. This option is helpful when you want to run code examples quickly and easily. We recommend setting up your local environment when you build applications that require a more complex code organization.

::: zone pivot="linux"
## Install Go on Linux

To install Go on Linux, download the Go installer from the [Go downloads page][GoDownload]. If you already have Go installed, you can upgrade to the latest version. First, remove the existing version of Go, and then do a fresh install of the most recent version.

**Step 1: Download the Go installer**

On the [Go downloads page][GoDownload], in the "Featured downloads" section, select the **Linux** option.  

You might see a window prompting you to allow downloading files from golang.org. If so, select **Allow**.

You can also download the installer by running the following command from your Terminal prompt:

> [!NOTE]
> In the following command, you might need to change the version number if version 1.15.4 isn't the [most recent release][GoLatest].

```console
wget https://golang.org/dl/go1.15.4.linux-amd64.tar.gz
```

**Step 2: Extract the Go installer.**

After you download the Go installer locally, you can start setting up Go on your workstation.

Extract the installer at */usr/local/go*, and run the following command as root or through sudo:

```console
tar -C /usr/local -xzf go1.15.4.linux-amd64.tar.gz
```

Next, add the path */usr/local/go/bin* to the **$PATH** environment variable. To make Go available system-wide, you can add the following command to either your $HOME/.profile or your /etc/profile:

```console
export PATH=$PATH:/usr/local/go/bin
```

Close and reopen the Terminal prompt to update the $PATH environment variable. You can also force the update by running the following command:

```console
source $HOME/.profile
```

**Step 3: Confirm Go is installed correctly**

After you configure the Go distribution, confirm Go works by running the following command:

```console
go version
```

You should see the details of the Go version that's installed on your workstation.

::: zone-end

::: zone pivot="macos"
## Install Go on macOS

To install Go on macOS, download the installer from the [Go downloads page][GoDownload].

### Install Go by using the Go installer

You can also install the latest version of Go by using these steps:

**Step 1: Download the Go installer**

On the [Go downloads page][GoDownload], in the "Featured downloads" section, select the **Apple macOS** option.

You might see a window that prompts you to allow downloading files from golang.org. If so, select **Allow**.

**Step 2: Run the Go installer**

After you download the Go installer locally, you can start with the installation. Double-click the .pkg file, and follow the instructions to install Go.

By default, the .pkg file installs Go at */usr/local/go*, and the path */usr/local/go/bin* should now be part of the $PATH environment variable.

**Step 3: Confirm Go is installed correctly**

After the installation finishes, open a new Terminal prompt, and run the following command:

```console
go version
```

You should see the details of the Go version that's installed on your workstation.

::: zone-end

::: zone pivot="windows"
## Install Go on Windows

To install Go on Windows, download the Go installer from the [Go downloads page][GoDownload]. 

**Step 1: Download the Go installer**

On the [Go downloads page][GoDownload], in the "Featured downloads" section, select the **Microsoft Windows** option.  

You might see a dialog prompting you to allow downloading files from golang.org. If so, select **Allow**.

**Step 2: Run the MSI Go installer**

After you download the Go installer locally, you can start installing Go. To do so, double-click the .msi file, and then follow the instructions.

By default, the .msi file installs Go at *C:\Program Files\Go*, and the folder location *C:\Program Files\Go\bin* should now be part of the **$PATH** system environment variable.

**Step 3: Confirm Go is installed correctly**

After you configure the Go distribution, confirm Go works. Open a new Command or PowerShell prompt, and then run the following command:

```console
go version
```

You should see the details of the Go version that's installed on your workstation.

::: zone-end


## Configure your Go workspace

Be sure to read this section carefully before you continue.

Go differs from other programming languages in how it organizes project files. First, Go works under the concept of *workspaces*. A workspace is simply a location where your application source code lives. All Go projects share the same workspace. But Go has started to change this approach beginning with version 1.11. You don't have to worry about that yet because we'll cover workspaces in the next module. For now, your Go workspace is located at $HOME/go, but you can set up a different location for all your projects, if needed. 

To set your workspace to a different location, you can use the **$GOPATH** environment variable. This environment variable helps to avoid future problems when working with more complex projects.

::: zone pivot="linux"
Configure your workspace by adding the following command to your ~/.profile:

```console
export GOPATH=$HOME/go
```

Then run the following command to update your environment variables:

```console
source ~/.profile
```

::: zone-end

::: zone pivot="macos"
Configure your workspace by adding the following command to your ~/.zshenv:

```console
export GOPATH=$HOME/go
```

Then run the following command to update your environment variables:

```console
source ~/.zshenv
```

::: zone-end

::: zone pivot="windows"
To configure your workspace, specify the location of your Go project folder in a local Go environment variable.

1. Create a top-level folder for all your Go projects. For example, *C:\Projects\Go*.

1. Open a PowerShell prompt, and then run the following cmdlet to set the $GOPATH environment variable.

   Replace `<project-folder>` with the top-level project folder you created in the previous step.

   ```powershell
   [Environment]::SetEnvironmentVariable("GOPATH", "<project-folder>", "User")
   ```

   We use PowerShell for this step, so we can call the prebuilt cmdlet to set the environment variable.
   
   After you set the $GOPATH value, close the PowerShell prompt.

1. Confirm the $GOPATH variable shows your correct workspace location. In a new prompt window, run the following command:

   ```console
   go env GOPATH
   ```

   The output shows your top-level project folder as the current workspace location:

   ```console
   C:\Projects\Go
   ```

   > [!Note]
   > If the $GOPATH variable doesn't show your top-level project folder, make sure you opened a new prompt window before you ran the command. After you change the value of an environment variable, you need to close and reopen the window, or open a new window, for the value change to take effect.

   You can use a short version of the command to see all the environment variables used by Go:

   ```console
   go env
   ```

::: zone-end


## Add Go workspace folders

Each Go workspace has three basic folders:

- *bin*: Contains executables from applications.
- *src*: Includes all application source code that lives in your workstation.
- *pkg*: Contains compiled versions of the available libraries. The compiler can link against these libraries without recompiling them.

For instance, your workstation folder structure tree might look like this example:

> bin/<br>
> &nbsp;&nbsp;&nbsp;&nbsp;hello<br> 
> &nbsp;&nbsp;&nbsp;&nbsp;coolapp<br>
> pkg/<br>
> &nbsp;&nbsp;&nbsp;&nbsp;github.com/gorilla/<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mux.a<br>
> src/<br>
> &nbsp;&nbsp;&nbsp;&nbsp;github.com/golang/example/<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.git/<br>
> &nbsp;&nbsp;&nbsp;&nbsp;hello/<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hello.go

Run the following commands to create three subfolders for your workspace:

::: zone pivot="linux,macos"
```console
cd $GOPATH
mkdir bin
mkdir src
mkdir pkg

```
::: zone-end

::: zone pivot="windows"
```console
cd %GOPATH%
mkdir bin
mkdir src
mkdir pkg

```
::: zone-end


## Next steps

We'll talk more about workspace concepts in the next module. You'll also learn how to maintain your project outside the $GOPATH environment. 

You can study more about Go by visiting the official documentation site, [How to Write Go Code][GoCode].


<!-- Links -->
[GoCode]: https://golang.org/doc/gopath_code.html?azure-portal=true
[GoDownload]: https://golang.org/dl/?azure-portal=true
[GoLatest]: https://golang.org/doc/devel/release.html?azure-portal=true
[GoPlay]: https://play.golang.org/?azure-portal=true
