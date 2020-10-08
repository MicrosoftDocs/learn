
Supports: add, remove, list

1. Look at all packages installed
	
	```shell
	dotnet list package
	```
	```output
	Top-level Package      Requested   Resolved
	> Humanizer            2.7.9        2.7.9
	```


1. Check for updates
	
	```shell
	dotnet list package --outdated
	```

	You will see

	```output
	Project `ManipulateData` has the following updates to its packages
	   [net5.0]:
	   Top-level Package      Requested   Resolved   Latest
	   > Humanizer            2.7.9       2.7.9      2.8.26
	```

	you can also check for pre-releases
	```shell
	--include-prerelease
	```


1. Update packages
	
	```shell
	dotnet add package Humanizer 
	```

	```output
	info : PackageReference for package 'Humanizer' version '2.8.26' updated in file 'C:\Users\jamont\Desktop\LearnDependencies\LearnDependencies.csproj'.
	```
	You can also install a specific version

	```shell
	dotnet add package Humanizer --version 2.8.26
	```

	You can check install the latest prerelease

	```shell
	dotnet add package Humanizer --prerelease
	```


Your results might be slightly different. The versions listed should correspond to the latest available versions of the packages.

Congratulations. You've upgraded the two dependencies in your app. Well done!