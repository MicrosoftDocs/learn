The developers at Tailwind Traders realize that they're about to put extensive resources into developing apps for the .NET platform. These apps are going to need process information that have complex date and time information. After some analysis, they find that .NET has some support for this, but not everything that they need. So they need to use a framework. They've found Noda Time in the NuGet package registry. It seems to be widely used and promises to express date and time data more clearly and express operations on that data more precisely. At this point, they just want you to install Noda Time, write a couple test calculations, and run them to see if Noda Time delivers on its promise.

```bash
dotnet new console -n LearnDependencies
```

```bash
cd LearnDependencies
```

```bash
code .
```

Add NodaTime:

```bash
dotnet add package NodaTime
```

Look at LearnDependencies.csproj

```xml
<ItemGroup>
    <PackageReference Include="NodaTime" Version="3.0.0" />
</ItemGroup>
```

Update Program.cs

Add usign statements at the top:
```csharp
using NodaTime;
using NodaTime.Extensions;
```

with:

```csharp
static void Main(string[] args)
{
    var birthDate = new LocalDate(2002, 2, 12);
    var today = SystemClock.Instance.InTzdbSystemDefaultZone().GetCurrentLocalDateTime().Date;
    var age = Period.Between(birthDate, today);
    Console.WriteLine($".NET is: {age.Years} years, {age.Months} months, {age.Days} days old.");
}
```

## Run application

Type the following command to run the application

```bash
dotnet run
```

You should see:

```bash
C:\Users\jamont\Desktop\LearnDependencies>dotnet run
.NET is: 18 years, 7 months, 25 days old.
```

Congratulations. You've managed to successfully install Noda Time as a dependency and write date and time logic for application code. Noda Time seems to deliver on its promise, and Tailwind Traders is likely to be happy with this evaluation.


