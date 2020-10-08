

dotnet list package

   Top-level Package      Requested   Resolved
   > Humanizer            2.7.9        2.7.9


1. Install global tool
dotnet tool install --global dotnet-outdated-tool


1. Check for updates
dotnet outdated

» ManipulateData
  [.NETCoreApp,Version=v5.0]
  Humanizer  2.7.9 -> 2.8.26

Version color legend:
<red>   : Major version update or pre-release version. Possible breaking changes.
<yellow>: Minor version update. Backwards-compatible features added.
<green> : Patch version update. Backwards-compatible bug fixes.


1. Update packages
dotnet outdated -u

» LearnDependencies
  [.NETCoreApp,Version=v5.0]
  Humanizer  2.7.9 -> 2.8.26

Version color legend:
<red>   : Major version update or pre-release version. Possible breaking changes.
<yellow>: Minor version update. Backwards-compatible features added.
<green> : Patch version update. Backwards-compatible bug fixes.

Upgrading package Humanizer...
Project LearnDependencies [.NETCoreApp,Version=v5.0] upgraded successfully

Your results might be slightly different. The versions listed should correspond to the latest available versions of the packages.

Congratulations. You've upgraded the two dependencies in your app. Well done!