The following code is one possible solution for the challenge from the previous unit.

	```c#
	string[,] corporate = 
	{
		{"Robert", "Bavin"}, {"Simon", "Bright"},
		{"Kim", "Sinclair"}, {"Aashrita", "Kamath"},
		{"Sarah", "Delucchi"}, {"Sinan", "Ali"}};

	string[,] external = 
	{
		{"Vinnie", "Ashton"}, {"Cody", "Dysart"},
		{"Shay", "Lawrence"}, {"Daren", "Valdes"}
	};

	string externalDomain = "hayworth.com";

	for (int i = 0; i < corporate.GetLength(0); i++) 
	{
		DisplayEmail(first: corporate[i,0], last: corporate[i,1]);
	}

	for (int i = 0; i < external.GetLength(0); i++) 
	{
		DisplayEmail(first: external[i,0], last: external[i,1], domain: externalDomain);
	}

	void DisplayEmail(string first, string last, string domain = "contoso.com") 
	{
		string email = first.Substring(0, 2) + last;
		email = email.ToLower();
		Console.WriteLine($"{email}@{domain}");
	}
	```

This code is just "*one possible solution*" because you may have added line feeds in different spots, used variables differently, or formatted the code differently.

Regardless of minor code differences, your method should apply the default value of an optional parameter to display `contoso.com`. 

When you run the code, you should see the following output:

	```Output
	robavin@contoso.com
	sibright@contoso.com
	kisinclair@contoso.com
	aakamath@contoso.com
	sadelucchi@contoso.com
	siali@contoso.com
	viashton@hayworth.com
	codysart@hayworth.com
	shlawrence@hayworth.com
	davaldes@hayworth.com
	```

If you completed this challenge, congratulations! Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, consider reviewing the previous units before you continue on. All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.