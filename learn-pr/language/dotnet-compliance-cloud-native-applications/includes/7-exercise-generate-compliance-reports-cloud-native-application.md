Your compliance team has asked you to produce compliance reports for all the projects in your app.

In the exercise you'll learn how to:

* Add the `Microsoft.Extensions.AuditReports` NuGet package to the relevant projects.
* Edit the project files to include compliance report settings.
* Test and review the reports.

## Add the audit reports package

You should still have the codespace or Visual Studio code window open. If not, open it now.

1. In the **TERMINAL** window, enter this command:

    ```bash
    cd /workspaces/mslearn-dotnet-cloudnative/dotnet-compliance/eShopLite/Store/
    ```

1. Add the `Microsoft.Extensions.AuditReports` NuGet package to the project:

    ```bash
    dotnet add package Microsoft.Extensions.AuditReports
    ```

1. In the **EXPLORER** pane, expand the **dotnet-compliance/eShopLite/Store** folder, then select the **Store.csproj** file.
1. In the editor, add the following code to the **PropertyGroup** section:

    ```xml
    <GenerateComplianceReport>true</GenerateComplianceReport>
    <ComplianceReportOutputPath>$(MSBuildThisFileDirectory)\..\ComplianceReport\Store</ComplianceReportOutputPath>
    ```

    The above code tells the compiler to generate a compliance report for this project and to save the **ComplianceReport.json** file to a folder called **ComplianceReport/Store** in the parent folder.

Repeat these steps for the **DataEntities** project.

1. In the **TERMINAL** window, enter this command:

    ```bash
    cd /workspaces/mslearn-dotnet-cloudnative/dotnet-compliance/eShopLite/DataEntities/
    ```

1. Add the `Microsoft.Extensions.AuditReports` NuGet package to the project:

    ```bash
    dotnet add package Microsoft.Extensions.AuditReports
    ```

1. In the **EXPLORER** pane, expand the **dotnet-compliance/eShopLite/DataEntities** folder, then select the **DataEntities.csproj** file.
1. In the editor, add the following code to the **PropertyGroup** section:

    ```xml
    <GenerateComplianceReport>true</GenerateComplianceReport>
    <ComplianceReportOutputPath>$(MSBuildThisFileDirectory)\..\ComplianceReport\DataEntities</ComplianceReportOutputPath>
    ```

    The above code tells the compiler to generate a compliance report for this project and to save the **ComplianceReport.json** file to a folder called **ComplianceReport/DataEntities** in the parent folder.

## Build the app

1. In the **TERMINAL** window, enter this command:

    ```bash
    cd /workspaces/mslearn-dotnet-cloudnative/dotnet-compliance/eShopLite/
    ```

1. Build the app:

    ```bash
    dotnet build
    ```

    The above command builds the app and generates the compliance reports.
1. In the **EXPLORER** pane, expand the **dotnet-compliance/eShopLite/** folder, then select the **ComplianceReport** folder.
1. Open the DataEntities folder, then open the **ComplianceReport.json** file.
1. Review the contents.
1. Open the Store folder, then open the **ComplianceReport.json** file.
1. Review the contents.

You've now seen how to classify data, redact sensitive date from log files, and generate compliance reports for your app.