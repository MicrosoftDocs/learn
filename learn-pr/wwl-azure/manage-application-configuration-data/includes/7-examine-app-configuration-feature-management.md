
Feature management is a modern software development practice that decouples feature release from code deployment and enables quick changes to feature availability on demand.

Feature Flags are discussed in another module, but at this point, it's worth noting that Azure App Configuration Service can be used to store and manage feature flags. (It's also known as feature toggles, feature switches, and other names).

## Basic concepts

Here are several new terms related to feature management:

 -  **Feature flag**: A feature flag is a variable with a binary state of *on* or *off*. The feature flag also has an associated code block. The state of the feature flag triggers whether the code block runs or not.
 -  **Feature manager**: A feature manager is an application package that handles the lifecycle of all the feature flags in an application. The feature manager typically provides more functionality, such as caching feature flags and updating their states.
 -  **Filter**: A filter is a rule for evaluating the state of a feature flag. A user group, a device or browser type, a geographic location, and a time window are all examples of what a filter can represent.

Effective implementation of feature management consists of at least two components working in concert:

 -  An application that makes use of feature flags.
 -  A separate repository that stores the feature flags and their current states.

How these components interact is illustrated in the following examples.

## Feature flag usage in code

The basic pattern for implementing feature flags in an application is simple. You can think of a feature flag as a Boolean state variable used with an `if` conditional statement in your code:

```csharp
if (featureFlag) {
    // Run the following code.
}

```

In this case, if `featureFlag` is set to `True`, the enclosed code block is executed; otherwise, it's skipped. You can set the value of `featureFlag` statically, as in the following code example:

```csharp
bool featureFlag = true;

```

You can also evaluate the flag's state based on certain rules:

```csharp
bool featureFlag = isBetaUser();

```

A slightly more complicated feature flag pattern includes an `else` statement as well:

```csharp
if (featureFlag) {
    // This following code will run if the featureFlag value is true.
} else {
    // This following code will run if the featureFlag value is false.
}

```

## Feature flag declaration

Each feature flag has two parts: a name and a list of one or more filters used to evaluate if a feature's state is *on* (that is when its value is `True`).

A filter defines a use case for when a feature should be turned on.

When a feature flag has multiple filters, the filter list is traversed until one of the filters determines the feature should be enabled.

At that point, the feature flag is *on*, and any remaining filter results are skipped. If no filter indicates the feature should be enabled, the feature flag is *off*.

The feature manager supports *appsettings.json* as a configuration source for feature flags.

The following example shows how to set up feature flags in a JSON file:

```JSON
"FeatureManagement": {
    "FeatureA": true, // Feature flag set to on
    "FeatureB": false, // Feature flag set to off
    "FeatureC": {
        "EnabledFor": [
            {
                "Name": "Percentage",
                "Parameters": {
                    "Value": 50
                }
            }
        ]
    }
}

```

## Feature flag repository

To use feature flags effectively, you need to externalize all the feature flags used in an application.

This approach allows you to change feature flag states without modifying and redeploying the application itself.

Azure App Configuration is designed to be a centralized repository for feature flags.

You can use it to define different kinds of feature flags and manipulate their states quickly and confidently.

You can then use the App Configuration libraries for various programming language frameworks to easily access these feature flags from your application.
