The first step to implementing compliance in a cloud-native application is to classify the data. Data classification is the process of identifying data your application uses by its sensitivity. Data classification is done by assigning a label to each data type. For example, you might label a user's name as "sensitive" and a user's age as "nonsensitive".

In this unit, you'll explore some of the compliance features of .NET. Then you'll learn how to classify data in a cloud-native application.

## What is compliance?

Organizations need to comply with their own internal policies and with external regulations. For example, a company might have a policy that says that customer data can't be stored in a log file. Or a government might have create regulations to enforce the appropriate handling of customers data. These policies and regulations are often referred to as *compliance requirements*.

Compliance requirements are implemented by creating a set of rules that are applied to an organization's applications. Usually a compliance team is responsible for implementing compliance rules and then ensuring that they're followed.

## What is data classification?

Data classification is a term used in cybersecurity and information governance. Data classification describes the process of identifying, categorizing, and protecting content according to its sensitivity or impact level. Data classification protects your organizations data from unauthorized disclosure, alteration, or destruction based on how sensitive or impactful it is.

Your company decides to implement a data classification policy. This policy classifies data into two taxonomies:

- **End User Identifiable Information (EUII)** - Information that can be used to identify an individual. For example, a user's name,  address, or phone number.
- **End User Pseudonymous Identifiers (EUPI)** - Information that can be used to identify an individual, but only if data are combined with other information. For example, a user's ID for their data in a database, or IP address.

## How to classify data in a cloud-native application

Microsoft has added a new extension to .NET that makes it easy to implement data classification. The `Microsoft.Extensions.Compliance.Classification` extension enables you to define `DataClassification` and `DataClassificationAttribute` properties.

To use the extension in your solution, add the `Microsoft.Extensions.Compliance.Redaction` NuGet package to your project.

For example the code to create the above taxonomies could look like this:

```csharp
using Microsoft.Extensions.Compliance.DataClassification;

public static DataClassification EUIIDataClassification {get;} = new DataClassification("EUIIDataTaxonomy", "EUIIData");

public static DataClassification EUPDataClassification {get;} = new DataClassification("EUPDataTaxonomy", "EUPData");

public class EUIIDataAttribute : DataClassificationAttribute
{
    public EUIIDataAttribute() : base(DataClassifications.EUIIDataClassification) { }
}

public class EUPDataAttribute : DataClassificationAttribute
{
    public EUPDataAttribute() : base(DataClassifications.EUPDataClassification) { }
}
```

With your taxonomies defined, you can now annotate your data types with the appropriate attribute. For example:

```csharp
public class User
{
    [EUIIData]
    public string Name { get; set; }

    [EUIIData]
    public string Address { get; set; }

    [EUPData]
    public string UserId { get; set; }
}
```

Let's see how to implement data classification in an example cloud-native application.