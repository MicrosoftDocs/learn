Sample flow/ideas:

1. Move the card from Backlog to Doing.
1. Note the secure data in the sources. Perhaps it's an SSH key, certificate, or other plaintext file.
1. Run credscan (or similar tool) locally to see what other files it finds.
  1. It finds the file you discovered manually.
1. Add credscan (or similar tool) to the build process. Run it and watch it fail.
1. Remove the offending file from the sources.
1. Generate a fresh secret (can't recycle the existing one because it's part of the Git history.)
1. Use Azure Key Vault to store the secret. Configure the pipeline to retrieve it during the build.
1. Watch the build turn green. Watch credscan pass in the build output. (you now have a process in place to catch further errors.)
1. Perhaps also add a widget to the dashboard.
1. Move the card from Doing to Done.

[Inspriation](https://blogs.msdn.microsoft.com/visualstudio/2017/11/17/managing-secrets-securely-in-the-cloud/)
