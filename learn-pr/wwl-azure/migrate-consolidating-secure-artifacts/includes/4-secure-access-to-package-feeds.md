## Trusted sources

Package feeds are a trusted source of packages. The offered packages will be consumed by other codebases and used to build software that needs to be secure.

Imagine what would happen if a package feed would offer malicious components in its packages.

Each consumer would be affected when installing the packages onto its development machine or build server.

It also happens at any other device that will run the end product, as the malicious components will be executed as part of the code.

Usually, the code runs with high privileges, giving a large security risk if any packages cannot be trusted and might contain unsafe code.

## Securing access

Package feeds must be secured for access by authorized accounts, so only verified and trusted packages are stored there.

None should push packages to a feed without the proper role and permissions.

It prevents others from pushing malicious packages. It still assumes that the persons who can push packages will only add safe and secure packages.

Especially in the open-source world, It's done by the community. A package source can further guard its feed with the use of security and vulnerability scan tooling.

Additionally, consumers of packages can use similar tooling to do the scans themselves.

## Securing availability

Another aspect of security for package feeds is about the public or private availability of the packages.

The feeds of public sources are available for anonymous consumption.

Private feeds have restricted access most of the time.

It applies to the consumption and publishing of packages. Private feeds will allow only users in specific roles or teams access to its packages.

Package feeds need to have secure access for different kinds of reasons.

The access should involve allowing:

 -  **Restricted access for consumption** Whenever a particular audience should only consume a package feed and its packages, it's required to restrict its access. Only those allowed access will consume the packages from the feed.
 -  **Restricted access for publishing** Secure access is required to restrict who can publish so feeds and unauthorized or untrusted persons and accounts can't modify their packages.
