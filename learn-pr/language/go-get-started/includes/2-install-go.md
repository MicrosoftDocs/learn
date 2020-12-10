Before you start creating applications with Go, you need to set up your development environment. 

If you don’t want to install Go locally, you can use the [Go Playground](https://play.golang.org/), a web service that can run applications written in Go in a browser. This is a great option when you want to run code examples quickly and easily. However, we do recommend setting up your local environment when you build applications that require a more complex code organization.


::: zone pivot="macos"
## Install Go on macOS
To install Go on macOS, you can use Homebrew, or download the installer from the [Go downloads page](https://golang.org/dl/). You'll find both approaches on this page, but choose only one.

### Install Go by using Homebrew
The simplest way to install Go is by using [Homebrew](https://brew.sh/).

Open a Terminal prompt, and then run the following commands:

```
brew update
brew install go
```

Homebrew installs Go at `/usr/local/go`, and the path `/usr/local/go/bin` should now be part of the **$PATH** environment variable. You might need to reopen your Terminal prompt to confirm that Go is installed correctly.

To confirm that Go is installed, run the following command:

```
go version
```

### Install Go by using the Go installer

Alternatively, you can install the latest version of Go by doing the following:

**Step 1: Download the Go installer**

On the [Go downloads page](https://golang.org/dl/), in the “Featured downloads” section, select the **Apple macOS** option.

You might see a window that prompts you to allow downloading files from golang.org. If so, select **Allow**.

**Step 2: Run the Go installer**

After you've downloaded the Go installer locally, you can start with the installation. Double-click the .pkg file, and follow the instructions to install Go.

By default, the .pkg file installs Go at `/usr/local/go`, and the path `/usr/local/go/bin` should now be part of the **$PATH** environment variable.

**Step 3: Confirm that Go is installed correctly**

After the installation finishes, open a new Terminal prompt, and run the following command:

```
go version
```

You should see the details of the Go version that's installed on your workstation.

::: zone-end

::: zone pivot="linux"
## Install Go on Linux

To install Go on Linux, download the Go installer from the [Go downloads page](https://golang.org/dl/). If, for some reason, you already have Go installed and want to install the latest version, remove the existing version before you proceed.

**Step 1: Download the Go installer**

On the [Go downloads page](https://golang.org/dl/), in the “Featured downloads” section, select the **Linux** option.  

You might see a window prompting you to allow downloading files from golang.org. If so, select **Allow**.

Alternatively, you can download the installer by running the following command from your Terminal prompt:

> [!NOTE]
> You might need to change the version number in the command if 1.15.4 isn't the [latest version](https://golang.org/doc/devel/release.html) as you're reading this guide.

```
wget https://golang.org/dl/go1.15.4.linux-amd64.tar.gz
```

**Step 2: Extract the Go installer**
After you've downloaded the Go installer locally, you can start setting up Go on your workstation.

Extract the installer at `/usr/local/go`, and run the following command as root or through sudo:

```
tar -C /usr/local -xzf go1.15.4.linux-amd64.tar.gz
```

You need to add the path `/usr/local/go/bin` to the **$PATH** environment variable. To make Go available system-wide, you can add the following command to either your $HOME/.profile or your /etc/profile:

```
export PATH=$PATH:/usr/local/go/bin
```

You need to close and reopen the Terminal prompt to update the **$PATH** environment variable. Alternatively, you can force the update by running the following command:

```
source $HOME/.profile
```

**Step 3: Confirm that Go is installed correctly**
After you've configured the Go distribution, confirm that Go works by running the following command:

```
go version
```

You should see the details of the Go version that's installed on your workstation.

::: zone-end

::: zone pivot="windows"
## Install Go on Windows
To install Go on Windows, download the Go installer from the [Go downloads page](https://golang.org/dl/). 

**Step 1: Download the Go installer**

On the [Go downloads page](https://golang.org/dl/), in the “Featured downloads” section, select the **Microsoft Windows** option.  

You might see a window prompting you to allow downloading files from golang.org. If so, select **Allow**.

**Step 2: Run the MSI Go installer**

After you've downloaded the Go installer locally, you can start installing Go. To do so, double-click the .msi file, and then follow the instructions.

By default, the .msi file installs Go at `C:\Go`, and the path `C:\Go\bin` should now be part of the **$PATH** environment variable.

**Step 3: Confirm that Go is installed correctly**
After you've configured the Go distribution, confirm that Go works. To do so, open a new Command Prompt or PowerShell window, and then run the following command:

```
go version
```

You should see the details of the Go version that's installed on your workstation.

::: zone-end

## Organize your code projects
Be sure to read this section carefully before you continue.

Go differs from other programming languages in how it organizes project files. First, Go works under the concept of *workspaces*, in which a workspace is simply a location where your application source code lives. In Go, all projects share the same workspace. However, as of version 1.11, Go started to change this approach. You don’t have to worry about that yet, because we’ll cover workspaces in the next module. For now, your Go workspace is located at $HOME/go, but you can set up a different location for all your projects, if needed. 

To define a different workspace location, set a value to the **$GOPATH** environment variable. You need to set a value for the environment variable to avoid future problems, when you begin creating more complex projects.

In macOS or Linux, you can configure your workspace by adding the following command to your `~/.profile`:

```
export GOPATH=$HOME/go
```

Then run the following command to update your environment variables:

```
source ~/.profile
```

In Windows, create a folder (for example, `C:\Projects\Go`), where you’ll create all Go projects. Open a PowerShell prompt, and run the following command:

```
[Environment]::SetEnvironmentVariable("GOPATH", "C:\Projects\Go", "User")
```

For future reference, you can get the workspace location in Go by printing the value of the **$GOPATH** environment variable. Or you can get the environment variables that matter to Go by running the following command:

```
go env
```

In your Go workspace, you’ll find the following folders:

* **bin**: Contains executables from applications.
* **src**: Includes all application source code that lives in your workstation.
* **pkg**: Contains compiled versions of the available libraries. The compiler can link against these libraries without recompiling them.

For instance, this is how your workstation folder structure tree might look:

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

We’ll return to this topic in the next module, and we'll discuss what to do if you need or want to maintain your project outside the **$GOPATH** environment. 

Additionally, you can go deeper into this topic by visiting the official documentation site, [How to Write Go Code](https://golang.org/doc/gopath_code.html).
