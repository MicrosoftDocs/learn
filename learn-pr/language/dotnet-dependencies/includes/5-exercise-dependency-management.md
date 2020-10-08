Dependencies that you use in your applications can be updated often and may contain new features, bug fixes, and critical security updates. The app that we created is small and has only a single dependency. Updating it should be straightforward. See if you can update the app to take advantage of the latest features.

## Upgrade app dependencies

1. Look at the `dependencies` in the ManipulateData.csproj file. It should look like this code:

    ```xml
    <ItemGroup>
        <PackageReference Include="Humanizer" Version="2.7.9 />
    </ItemGroup>
    ```

1. You can also see installed dependencies by running this command:
	
	```shell
	dotnet list package
	```

	This should output the requested version and the final resolved (installed) version:

	```output
	Top-level Package      Requested   Resolved
	> Humanizer            2.7.9        2.7.9
	```


1. Run this command to see what dependencies are outdated
	
	```shell
	dotnet list package --outdated
	```

	The output should look something like the following output. You might see different values in the `Latest` column.

	```output
	Project `ManipulateData` has the following updates to its packages
	   [net5.0]:
	   Top-level Package      Requested   Resolved   Latest
	   > Humanizer            2.7.9       2.7.9      2.8.26
	```

	By default this command will check for the latest stable version. To check for pre-release packages you can add the following ot the command:

	```shell
	--include-prerelease
	```

1. You, can with some level of confidence, update to the `Latest` version. Doing so will ensure the dependencies get the latest features and patches in that major version. Run the following command to install the Latest version:
	
	```shell
	dotnet add package Humanizer 
	```

	Your output should contain something like this output:

	```output
	info : PackageReference for package 'Humanizer' version '2.8.26' updated in file 'C:\Users\jamont\Desktop\ManipulateData\ManipulateData.csproj'.
	```
	The output states that your project dependencies have been updated.

	If you want to upgrade to a specific version of the dependency, you can append on the `--version` parameter and specify the specific version.

	```shell
	dotnet add package Humanizer --version 2.8.26
	```

	Finally, you can also install the latest pre-release package by appending on the `--prerelease` parameter.

	```shell
	dotnet add package Humanizer --prerelease
	```
	Your results might be slightly different. The version listed should correspond to the latest available versions of the package.

Congratulations. You've upgraded the dependency in your app. Well done!