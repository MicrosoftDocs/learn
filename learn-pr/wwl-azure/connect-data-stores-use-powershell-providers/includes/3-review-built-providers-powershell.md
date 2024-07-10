The generic commands that you use to work with providers offer a superset of every feature that a provider might support. For example, the **Get-ChildItem** command includes the *–UseTransaction* parameter. However, the only built-in provider that supports the Transactions capability is the Registry provider. If you try to use the *-UseTransaction* parameter in any other provider, you'll receive an error message. You'll also receive an error message whenever you use a common parameter that the provider doesn't support.

Running the **Get-PSProvider** cmdlet lists the capabilities of each provider that loads into Windows PowerShell. The capabilities of each provider will be different because each provider connects to a different underlying technology.

Some important capabilities include:

- **ShouldProcess** for providers that can support the *–WhatIf* and *–Confirm* parameters.
- **Filter** for providers that support filtering.
- **Include** for providers that can include items in the data store based on the name. Supports using wildcards.
- **Exclude** for providers that can exclude items in the data store based on the name. Supports using wildcards.
- **ExpandWildcards** for providers that support wildcards in their paths.
- **Credentials** for providers that support alternative credentials.
- **Transactions** for providers that support transacted operations.

You should always review the capabilities of a provider before you work with it. This helps you avoid unexpected errors when you try to use unsupported capabilities.

