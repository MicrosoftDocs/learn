Prioritizing code quality in the development process should start with local code development. It's important to identify opportunities for this practice even before starting pull requests to detect and rectify potential code quality issues.

Git hooks offer a great opportunity. They serve as a mechanism for executing custom scripts in response to significant events within the Git lifecycle, such as commits, merges, and pushes. The scripts, located within the .git\\hooks directory of the repository, provide practically unlimited flexibility in automating software development tasks and enforcing development standards.<br>

## How to implement Git hooks

Let's start by exploring client-side Git hooks. Navigate to the repo .git\\hooks directory – you find there many files with the extension `sample`. This extension not only indicates their purpose, but also effectively prevents them from running. The file names designate the Git actions that trigger their execution once you remove the `sample` extension.<br>

:::image type="content" source="../media/git-hook-files-8bce9eb8.png" alt-text="Screenshot of Git hook files for automation.":::


Rename the pre-commit `sample` file to pre-commit. As the name of the file indicates, the script it contains will run whenever you invoke the git commit action. The commit follows only if your pre-commit script exits with the 0 return value.

However, it's important to note that, by default, this won't work as intended in any of the Windows operating systems. The commonly overlooked reason for this behavior is the first line of the script:<br>

```Bash
#!/bin/sh
```

On Linux operating systems, the \#! prefix indicates to the program loader that the remainder of the file contains a script to be interpreted and /bin/sh is the full path to the interpreter that should be used.

While Git for Windows supports Bash commands and shell scripts, it doesn't follow the same convention when designating file system paths. Instead, you need to provide full path to the sh.exe file, starting with the drive letter.

However, there's an extra caveat, which results from the fact Git for Windows by default gets installed in the C:\\Program Files directory. Since this directory contains a space in its name, the resulting path to the sh.exe file would be interpreted as two separate paths, resulting in a failure. To avoid it, it's necessary to add a single backslash (\\) in front of the space to serve as an escape character. Effectively, when using the 64-bit version of Git for Windows, the first line of the script should have the following format:

```Bash
#!C:/Program\ Files/Git/usr/bin/sh.exe
```

## How to do it

How can you use the newly discovered functionality of Git pre-commit scripts? How about stopping you from accidentally leaking secrets to GitHub?

Let's use the Git hook to scan the code being committed into your local repository for specific keywords. Replace the content of the pre-commit shell file with the following code:

```Bash
#!C:/Program\ Files/Git/usr/bin/sh.exe
matches=$(git diff-index --patch HEAD | grep '^+' | grep -Pi 'password|secret')
if [ ! -z "$matches" ]
then
  cat <<\EOT
Error: Words from the blocked list were present in the diff:
EOT
echo $matches
exit 1
fi
```

This example is meant to illustrate the concept rather than a full-fledged solution, so the keyword list is intentionally trivial. By using regular expressions, you can significantly extend it scope and flexibility. You also have the option of referencing an external file, which would considerably simplify ongoing maintenance.

## How It Works

Once invoked, the pre-commit hook script uses the git diff and grep commands to identify keywords or patterns within the incremental changes to the code that are being committed. If any matches are detected, the script generates an error message and prevents the commit from taking place.

## There's More:

Other, common use cases of pre-commit hook scripts include code formatting, linting, or running custom tests to ensure the commit adheres to project standards. Prepare-commit-msg runs before the commit message editor is launched. It allows for dynamic generation of commit messages in order to enforce naming conventions, such as the use of designated prefixes (for example, feat: for features or fix: for bug fixes).

For example, the following prepare-commit-msg script automatically prepends the current branch name to the commit message when creating a new commit. It modifies the commit message file ($1) by adding the branch name followed by a colon and space at the beginning of the file.

```Bash
#!C:/Program\ Files/Git/usr/bin/sh.exe
# Get the current branch name
branch_name=$(git branch --show-current)
# Check if the commit message file exists
if [[ -f "$1" ]]; then
  # Prepend the branch name to the commit message
  sed -i "1s/^/$branch_name: /" "$1"
fi
```

Post-commit scripts executes after a commit completes. It can be used to trigger notifications or generate documentation.

For example, the following script sends an email notification to a designated recipient after each commit. The script can be customized by modifying the recipient email address, SMTP server, and subject and body of the email. Additionally, you may need to configure your system to send emails using the Send-MailMessage PowerShell cmdlet or use a different method to send notifications, depending on your environment and requirements.

```Bash
#!C:/Program\ Files/Git/usr/bin/sh.exe
# Set the recipient email address
$recipient="your@email.com"
# Set the subject of the email
$subject="Git Commit Notification"
# Set the body of the email
$body="A new commit has been made to the repository."
# Send the email notification
Send-MailMessage -To $recipient -Subject $subject -Body $body -SmtpServer "your.smtp.server"
```

It's worth noting that the repo .git\\hooks folder isn't committed into source control. You may wonder whether there's a way to share the scripts you developed with other member of your development team. The good news is that, starting with Git version 2.9, you can map Git hooks to a folder that can be committed into source control. You could do that by updating the global settings configuration for your Git repository:

```Bash
Git config --global core.hooksPath '~/.githooks'
```

If you ever need to overwrite the Git hooks you have set up on the client-side, you can do so by using the no-verify switch:

```Bash
Git commit --no-verify
```

### Server-Side Hooks

While client-side Git hooks offer robust capabilities for enhancing the development workflow, Azure Repos also provides server-side hooks to further augment the development process, including support for creating pull requests. For more information, see the Azure Repos [Service hooks events](/azure/devops/service-hooks/events) reference.<br>
