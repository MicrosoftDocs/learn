In this unit, you'll use your Communication Services phone number to send an SMS message from a console application.

## Create a console application

1. In a console window (such as cmd, PowerShell, or Bash), use the `dotnet new` command to create a new console app with the name `SmsQuickstart`. This command creates a simple "Hello World" C# project with a single source file: `Program.cs`.

    ``` console
    dotnet new console -o SmsQuickstart
    ```

1. Change your directory to the newly created app folder and use the `dotnet build` command to compile your application.

    ```console
    cd SmsQuickstart
    dotnet build
    ```

## Add the SMS client library

1. While still in the application directory, install the Azure Communication Services SMS client library for .NET package by using the `dotnet add package` command.

    ```console
    dotnet add package Azure.Communication.Sms --version 1.0.0-beta.3
    ```

1. Open the project by using the following code:

    ```console
    code .
    ```

1. Add a `using` directive to the top of `Program.cs` to include the `Azure.Communication` namespace.

    ```c-sharp
    using Azure.Communication;
    using Azure.Communication.Sms;
    ```

## Send an SMS

1. Replace the body of the `Main` method with code to initialize an `SmsClient` with your connection string.

   ```c-sharp
   string connectionString = <your-connection-string>;
   SmsClient smsClient = new SmsClient(connectionString);
   ```

1. Send an SMS message by calling the `Send` method. Add this code to the end of `Main` method in `Program.cs`:

    ```c-sharp
    smsClient.Send(
       from: new PhoneNumber("<leased-phone-number>"),
       to: new PhoneNumber("<to-phone-number>"),
       message: "Hello World via SMS"
    );
    ```

    Replace \<leased-phone-number\> with an SMS-enabled phone number you provisioned in the previous unit, and \<to-phone-number\> with the phone number you wish to send a message to.

1. Run the application from your application directory with the dotnet run command.

    ```console
    dotnet run
    ```