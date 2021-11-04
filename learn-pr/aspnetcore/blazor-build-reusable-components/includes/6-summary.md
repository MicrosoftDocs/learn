In this module, we faced a problem with building, packaging, and sharing Blazor components that could be used and reused across Blazor applications.

We learned how to build a Razor class library that contains components we would like to share with many applications.  We took several steps to assemble our library:

- We created a new Razor class library from the .NET template
- We added a `.razor` file with a Blazor component and a `.razor.css` file containing its Stylesheet
- We added package metadata to the project file that defined the package for other developers
- We created a NuGet package from our Razor class library using the .NET command line

Blazor components are the building blocks that make it easier for us to build more complex applications.  Components and pages referencing other components means that we can more quickly deliver applications that take advantage of the user-interface paradigms shared by other developers.

When we can depend on components built and shared by other developers, we can save time and money by reusing the investment they made in creating that component.  

## References
- [Consume ASP.NET Core Razor components from Razor class libraries](/aspnet/core/blazor/components/class-libraries)
