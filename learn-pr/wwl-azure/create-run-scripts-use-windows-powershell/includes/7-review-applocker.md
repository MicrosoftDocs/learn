While the Windows PowerShell script execution policy provides a safety net for inexperienced users, it's not very flexible. When you set an execution policy, you can only check that the script was downloaded and that it's signed.

Another alternative for controlling the use of Windows PowerShell scripts is AppLocker. With AppLocker, you can set various restrictions that limit the running of specific scripts or scripts in specific locations. Also, unlike the **AllSigned** execution policy, AppLocker can allow scripts that are signed only by specific publishers.

In Windows PowerShell 5.0, a new level of security was added for using AppLocker to secure scripts. If a script is stopped at an interactive prompt for a purpose such as debugging, the commands entered at the interactive prompt can also be limited. When an AppLocker policy in **Allow** mode is detected, interactive prompts when running scripts are limited to **ConstrainedLanguage** mode.

**ConstrainedLanguage** mode allows all core Windows PowerShell functionality, such as scripting constructs. It also allows modules included in Windows to be loaded. However, it does limit access to running arbitrary code and accessing Microsoft .NET objects. **ConstrainedLanguage** mode blocks one of the vectors that an attacker could use to run unauthorized code.

> **Additional reading:** For more information about **ConstrainedLanguage** mode, refer to about_Language_Modes in the Windows PowerShell help or [About Language Modes](https://aka.ms/nxcyid).

