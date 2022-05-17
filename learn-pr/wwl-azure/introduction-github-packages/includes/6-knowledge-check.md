## Multiple Choice
Which of the following choices contains valid packages that GitHub Packages can host?
( ) Apache Maven, Gradle and Go modules. {{Incorrect. GitHub Packages do not support Go modules.}}
(x) RubyGems, Docker and NuGet. {{Correct. GitHub Packages can host npm, RubyGems, Apache Maven, Gradle, Docker, NuGet, and GitHub's Container registry.}}
( ) NuGet, Conan (for C/C++), and Cargo (for Rust). {{Incorrect. GitHub Packages do not support Conan (for C/C++) and Cargo (for Rust).}}

## Multiple Choice
Which of the following choices is the most secure and recommended authentication method for GitHub Packages?
(x) Personal Access Token (PAT). {{Correct. It's recommended to use PAT for a secure GitHub Packages authentication.}}
( ) User and Password. {{Incorrect. User and Password isn't the most secure authentication method.}}
( ) OAuth token. {{Incorrect. GitHub Packages don't support OAuth tokens for authentication.}}

## Multiple Choice
Which of the following choices is the minimum user or team permission within the GitHub organization that allows a package delete action?
( ) Write. {{Incorrect. Write permission can upload and download packages and read and write package metadata.}}
( ) Read. {{Incorrect. Read permission can download packages and read package metadata.}}
(x) Admin. {{Correct. Admin permission can upload, download, delete, and manage packages. Also, the admin can read and write package metadata and grant package permissions.}}

