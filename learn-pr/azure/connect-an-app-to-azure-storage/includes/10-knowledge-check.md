# Knowledge check

## 1. Design consideration
<<max_attempts:1; weight:1.0>>

>> What is a consideration when determining if Azure Storage is right for your app? Select 2 answers<<

() Are you creating a web, mobile or desktop application?
(x) Graceful degradation of features if network unavailable or there are connectivity issues
() Usage of either XML or JSON configuration file formats.
(x) Availability of client libraries for your language/platform.

---

## 2. Access keys
<<max_attempts:1; weight:1.0>>

>> How many access keys are provided for accessing your Storage account?<<

[] 1
[x] 2
[] 3
[] 4

---

## 3. Connection string
<<max_attempts:1; weight:1.0>>

>> Where are Azure Storage connection strings typically stored within your app?<<

[] Hardcoded in the application code.
[x] Within a configuration system such as a configuration file. environment variable or database.
[] Entered into the app at runtime.
[] Compiled and embedded into the app assembly as a resource file.

---

## 4. Object Model
<<max_attempts:1; weight:1.0>>

>> The code below performs the following:
```c#
var account = CloudStorageAccount.Parse("your-connection-string");
```

[] Creates a storage account.
[] Connects to the storage account
[x] Validates the connection string only, returning a a client that can be used to connect to the storage account.

---
