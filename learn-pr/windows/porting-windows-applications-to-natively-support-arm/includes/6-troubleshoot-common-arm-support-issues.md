Recall that you're a developer for a company that owns a popular Windows accounting application. The company has decided to update the application to include support for Windows on Arm. In preparation, you began reviewing the code base. You quickly realize a 3rd-party dependency that provides *data-charting components* (as an example) inside the application doesn't offer an Arm-based version - only x64. Let's review some potential strategies to help reach your goal of delivering an Arm build for the application.

## Step 1: Reach out to the owner of any dependencies that do not support Arm

As a first step, you should contact the 3rd-party dependency owner and ask for whether there are plans to update the dependency to support Arm. The dependency owner may already have an initiative underway or may want to add this effort to their ongoing roadmap. Updated assemblies can be provided directly or via package management services, including [NuGet](https://www.nuget.org/) and [vcpkg](https://vcpkg.io/en/). In this example, let's say that the 3rd-party dependency owner is unresponsive to our request.

## Step 2: Reach out to the Arm open source ecosystem for help

Another strategy is to reach out to a company specialized in updating code to support Arm, such as [Linaro](https://www.linaro.org/windows-on-arm/), which is actively working to grow the Arm open source ecosystem for Windows. In this example, let's pretend that Linaro can't support your request for updating the dependency in the time frame you need.

## Step 3: Rewrite the dependency yourself with help from the App Assure program

The remaining options to reach the goal of a fully Arm-native build are replacing or rewriting the *data-charting components* dependency. In this example, let's say that your company decides to take the approach of resourcing your time to rewrite the dependency to support Arm in-house. You feel comfortable with this decision as you have recently learned of [Microsoft's "App Assure" program](https://www.microsoft.com/fasttrack/microsoft-365/app-assure) that offers assistance in addressing blocking issues to ensure that any apps that worked on Windows 7, Windows 8.1, Windows 10, and Windows 11 also work on Windows 10/11 on Arm64 devices.

## Step 4: Rewrite your Windows app using Arm64EC

You're motivated to publish a version of your application that will be able to take advantage of native Arm device performance as soon as possible. As it turns out, rewriting the blocking dependency will take a significant amount of time due to some complicating factors. You discussed removing the dependency altogether, but don't want the Arm version of your app to have less functionality than any other versions of your app. You also don't want this delay to interfere with your customer's experience of optimized performance on Arm devices. You decide to explore "Arm64EC", which enables you to mix x64 and Arm64 code for a partial Arm-native implementation.

An Arm64EC (“Emulation Compatible”) build allows you to rebuild parts of your Windows application as Arm-native, optimizing the high-impact areas of your app, while leaving the 3rd-party dependency blocking you to run as emulated x64 code. Arm64EC will provide a path to transition your code base to being Arm-native incrementally over time. As a result, the performance of your app will improve as more of your code is transitioned to native Arm.

Keep in mind, creating an Arm64EC build is a more advanced and complicated route to porting an application and not a solution to pursue unless deemed necessary by a blocker.
