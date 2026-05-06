While the Windows PowerShell script execution policy provides a safety net for inexperienced users, it offers only limited control. An execution policy can only verify whether a script was downloaded and whether it's signed.

> [!NOTE]
> Windows includes two application control technologies for securing PowerShell scripts: **AppLocker** and **App Control for Business** (formerly Windows Defender Application Control). Microsoft recommends **App Control for Business** as the primary solution — it receives ongoing investment and feature development. AppLocker remains available and continues to receive security fixes, but is no longer receiving new features.

Another alternative for controlling the use of Windows PowerShell scripts is AppLocker. With AppLocker, you can set various restrictions that limit the running of specific scripts or scripts in specific locations. Unlike the **AllSigned** execution policy, AppLocker can allow scripts that are signed only by specific publishers.

Windows PowerShell 5.0 added a new level of AppLocker security for scripts. If a script pauses at an interactive prompt, such as during debugging, those interactive commands are also restricted. When Windows PowerShell detects an AppLocker policy in **Allow** mode, it limits interactive prompts to **ConstrainedLanguage** mode.

**ConstrainedLanguage** mode allows all core Windows PowerShell functionality, such as scripting constructs. It also lets you load modules that ship with Windows. However, it restricts access to arbitrary code execution and Microsoft .NET objects. **ConstrainedLanguage** mode blocks one of the vectors that an attacker could use to run unauthorized code.

> **Additional reading:** For more information about **ConstrainedLanguage** mode, refer to about_Language_Modes in the Windows PowerShell help or [About Language Modes](https://aka.ms/nxcyid).

