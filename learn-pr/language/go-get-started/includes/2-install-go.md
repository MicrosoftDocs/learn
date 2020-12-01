Before you start creating applications with Go, you need to set up your development environment. 

In case you don’t want to install Go locally, you can use the [Go Playground](https://play.golang.org/) which is a web service that can run applications written in Go in a browser. This is a great option when you want to quickly and easily run code examples. However, we do recommend setting up your local environment when building applications that require a more complex code organization.


::: zone pivot="macos"
## Install Go on macOS
To install Go on macOS, you can do it using Homebrew, or download the Go installer from the downloads page at [https://golang.org/dl/](https://golang.org/dl/). Here you can find both approaches, choose only one.

### Install Go using Homebrew
The simplest way to install Go is using [Homebrew](https://brew.sh/).

Open a terminal prompt, and run the following commands to install the latest version of Go:

```
brew update
brew install go
```

Homebrew installs Go at `/usr/local/go`, and the path `/usr/local/go/bin` should now be part of the **$PATH** environment variable. You might need to restart your terminal prompt to confirm that Go is installed correctly.

To confirm that Go is installed by running the following command:

```
go version
```

### Install Go using the Go Installer

Alternatively, you can follow these steps to install the latest version of Go.

**Step 1: Download the Go installer**

Head over to the [Go download page](https://golang.org/dl/). In the “Feature downloads” section, click on the “Apple macOS” option to download the Go installer.

You might see a window prompting you to allow downloading files from golang.org; select “Allow” to start downloading the Go installer.

**Step 2: Run the Go installer**

Once you have the Go installer locally, you can start with the installation. Double click on the .pkg file, and follow the instructions to install Go.

By default, the .pgk file installs go at `/usr/local/go`, and the path `/usr/local/go/bin` should now be part of the **$PATH** environment variable.

**Step 3: Confirm that Go is installed correctly**

Once the installation finishes, open a new terminal prompt and run the following command:

```
go version
```

You should see the details of the Go version installed on your workstation.

::: zone-end

::: zone pivot="linux"
## Install Go on Linux

To install Go on Linux, you need to download the Go installer from the downloads page at [https://golang.org/dl/](https://golang.org/dl/). If, for some reason, you have Go already installed and want to install the latest version, remove the existing installation before proceeding.

**Step 1: Download the Go installer**

Head over to the [Go download page](https://golang.org/dl/). In the “Feature downloads” section, click on the “Linux” option to download the Go installer.  You might see a window prompting you to allow downloading files from golang.org; select “Allow” to start downloading the Go installer.

Alternatively, you can download the installer using the following command (you might need to change the version number if 1.15.4 it’s not the [latest version](https://golang.org/doc/devel/release.html) at the time you’re following this guide):


```
wget https://golang.org/dl/go1.15.4.linux-amd64.tar.gz
```

**Step 2: Extract the Go installer**
Once you have the Go installer locally, you can start setting up Go in your workstation.

Extract the installer at `/usr/local/go `and run the following command as root or through sudo:

```
tar -C /usr/local -xzf go1.15.4.linux-amd64.tar.gz
```

You need to add the path `/usr/local/go/bin` to the **$PATH** environment variable. You can either add the following command to your $HOME/.profile or /etc/profile (so Go is system-wide available):

```
export PATH=$PATH:/usr/local/go/bin
```

You need to log out and log in again to update the **$PATH** environment variable. Alternatively, you can run the following command to force the update:

```
source $HOME/.profile
```

**Step 3: Confirm that Go is installed correctly**
Once you have the Go distribution configured, confirm that Go works by running the following command:

```
go version
```

You should see the details of the Go version installed on your workstation.

::: zone-end

::: zone pivot="windows"
## Install Go on Windows
To install Go on Windows, you need to download the Go installer from the downloads page at [https://golang.org/dl/](https://golang.org/dl/). 

**Step 1: Download the Go installer**

Head over to the [Go download page](https://golang.org/dl/). In the “Feature downloads” section, click on the “Microsoft Windows” option to download the Go installer.  

You might see a window prompting you to allow downloading files from golang.org; select “Allow” to start downloading the Go installer.

**Step 2: Run the MSI Go installer**

Once you have the Go installer locally, you can start with the installation. Double click on the .msi file, and follow the instructions to install Go.

By default, the .pgk file installs go at `C:\Go`, and the path `C:\Go\bin` should now be part of the **$PATH** environment variable.

**Step 3: Confirm that Go is installed correctly**
Once you have the Go distribution configured, confirm that Go works. 

Open a new command prompt window (cmd) or Powershell, and run the following command:

```
go version
```

You should see the details of the Go version installed on your workstation.

::: zone-end

## How To Organize Your Code Projects
Please read this section carefully before you continue.

Go differs from other programming languages regarding how to organize project files. First, Go works under the concept of workspaces, which is nothing but a location where your application source code lives. In Go, all projects share the same workspace. However, since version 1.11 Go started to change this approach. You don’t have to worry about that yet, we’ll cover this part in the next module. So, typically, the Go’s workspace is located at $HOME/go, but you can set up a different location for all your projects if needed. 

To define a different workspace location, set a value to the **$GOPATH** environment variable. Make sure you have a value for this environment variable to avoid having problems in the future when you create complex projects.

In macOS or Linux, you can configure your workspace by adding the following command to your `~/.profile`:

```
export GOPATH=$HOME/go
```

Then run the following command to update your environment variables:

```
source ~/.profile
```

In Windows, create a folder like  `C:\Projects\Go `where you’ll create all Go projects`.` Open a PowerShell prompt, and run the following command:

```
[Environment]::SetEnvironmentVariable("GOPATH", "C:\Projects\Go", "User")
```

You can get the workspace’s location in Go by printing the value of the **$GOPATH** environment variable for future references. Or, getting the environment variables that matters to Go running the following command

```
go env
```

In your Go’s workspace, you’ll find the following folders

* **bin** which contains executables from applications
* **src** which includes all applications source code that lives in your workstation
* **pkg** which contains compiled versions of the available libraries; the compiler can link against these libraries without recompiling them

For instance, this is how it can look like the folder structure tree in a workstation:

```
bin/
    hello                          
    coolapp                        
pkg/
    github.com/gorilla/
        mux.a 
src/
    github.com/golang/example/
        .git/                      
	hello/
	    hello.go    
```

We’ll go back to talk about this topic in the next module, and what you need to do if you need or want to have your project outside of the **$GOPATH**. Additionally, you can go deeper into this topic by [visiting the official documentation site](https://golang.org/doc/gopath_code.html).
