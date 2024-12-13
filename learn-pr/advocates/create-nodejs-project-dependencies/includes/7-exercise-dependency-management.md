Tailwind Traders has asked you to work on an app that has some outdated dependencies. The app is small and has only a few dependencies. Updating the code should be straightforward. See if you can update the app to take advantage of the latest features. While you're at it, if you find any vulnerabilities, fix them.

## Get started

1. In a new terminal window (<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>`</kbd>), change to the folder that has the files for this exercise:

   ```bash
   cd ../7-exercise-dependency-management
   ```

1. Install the dependencies by running this command:

   ```bash
   npm install
   ```

   You should see output about the packages installed and any vulnerabilities. 

1. Open the package.json file and look at the `dependencies` section:

   ```json
   "lodash": "^1.1.0",
   "node-fetch": "^1.0.2"
   ```
   
   Notice the patterns specify the insert (^) character, which indicates updates to the minor version to support dependencies: `1.x`. 

1. Open the index.js file to understand how the package dependencies are used in the app:

    ```javascript
    const fetch = require('node-fetch')
    const _ = require('lodash');
    const path = require('path');
    const fs = require('fs');
    
    async function run() {
      const response = await fetch("https://dev.to/api/articles?state=rising");
      const json = await response.json();
      const sorted = _.sortBy(json, ["public_reactions_count"], ['desc']);
      const top3 = _.take(sorted, 3);
    
      const filePrefix = new Date().toISOString().split('T')[0];
      fs.writeFileSync(path.join(__dirname, `${filePrefix}-feed.json`), JSON.stringify(top3, null, 2));
    }
    
    run();
    ```

   This code pulls data from a REST API by using the `node-fetch` package. It processes the response by sorting it and takes the top three results by using the `lodash` package. The result is stored in a file.


## npm audit


To understand if there are any vulnerabilities, run this command:

```bash
npm audit
```

You should see output similar to this example:

```output
# npm audit report

lodash  <=4.17.20
Severity: critical
Regular Expression Denial of Service (ReDoS) in lodash - https://github.com/advisories/GHSA-x5rq-j2xg-h7qm
Prototype Pollution in lodash - https://github.com/advisories/GHSA-fvqr-27wr-82fm
Prototype Pollution in lodash - https://github.com/advisories/GHSA-jf85-cpcp-j695
Command Injection in lodash - https://github.com/advisories/GHSA-35jh-r3h4-6jhm
Prototype Pollution in lodash - https://github.com/advisories/GHSA-4xc9-xhrj-v574
Regular Expression Denial of Service (ReDoS) in lodash - https://github.com/advisories/GHSA-29mw-wpgm-hmr9
fix available via `npm audit fix --force`
Will install lodash@4.17.21, which is a breaking change
node_modules/lodash

node-fetch  <=2.6.6
Severity: high
The `size` option isn't honored after following a redirect in node-fetch - https://github.com/advisories/GHSA-w7rc-rwvf-8q5r
node-fetch forwards secure headers to untrusted sites - https://github.com/advisories/GHSA-r683-j2x4-v87g
fix available via `npm audit fix --force`
Will install node-fetch@3.3.2, which is a breaking change
node_modules/node-fetch

2 vulnerabilities (1 high, 1 critical)

To address all issues (including breaking changes), run:
npm audit fix --force
```

The output states the vulnerabilities and the version of the package that fixes the issue. 
   
```
Will install lodash@4.17.21, which is a breaking change
Will install node-fetch@3.3.2, which is a breaking change
```


## npm outdated

In the terminal, run this command to check for outdated dependencies:

```bash
npm outdated
```

You should see output similar to this example:

```output
Package     Current  Wanted   Latest  Location                 Depended by
lodash        1.3.1   1.3.1  4.17.21  node_modules/lodash      7-exercise-dependency-management
node-fetch    1.7.3   1.7.3    3.3.2  node_modules/node-fetch  7-exercise-dependency-management
```

The current and wanted versions are the same, but the latest version is different. The semantic update strategy specified in the `package.json` has been met but the vulnerabilities still exist. 

## npm update

1. Edit the `package.json` file to explicitly allows for major changes to fix the vulnerabilities starting with the more significant package:

   ```json
   "node-fetch": "^2.6.6"
   ```

1. Run this command to see what update would do:
    
   ```bash
   npm update --dry-run
   ```

   ```output
   added 3 packages, removed 4 packages, and changed 1 package in 508ms
   ```

1. Run this command to update the project based on the `package.json`:

   ```bash
   npm update
   ```

1. Run this command to see the vulnerability for `node-fetch` has been fixed:

   ```bash
   npm audit
   ```

    ```output
    # npm audit report
    
    lodash  <=4.17.20
    Severity: critical
    Regular Expression Denial of Service (ReDoS) in lodash - https://github.com/advisories/GHSA-x5rq-j2xg-h7qm
    Prototype Pollution in lodash - https://github.com/advisories/GHSA-fvqr-27wr-82fm
    Prototype Pollution in lodash - https://github.com/advisories/GHSA-jf85-cpcp-j695
    Command Injection in lodash - https://github.com/advisories/GHSA-35jh-r3h4-6jhm
    Prototype Pollution in lodash - https://github.com/advisories/GHSA-4xc9-xhrj-v574
    Regular Expression Denial of Service (ReDoS) in lodash - https://github.com/advisories/GHSA-29mw-wpgm-hmr9
    fix available via `npm audit fix --force`
    Will install lodash@4.17.21, which is a breaking change
    node_modules/lodash
    
    1 critical severity vulnerability
    
    To address all issues (including breaking changes), run:
      npm audit fix --force
    ```

1. If your project has any tests, run them to verify the update didn't break anything. 
1. Use these same steps to update `lo-dash` to the `4.17.20` version without vulnerabilities.

    The vulnerabilities are fixed but the `node-fetch` version is still a major version behind. If all your tests pass, correct the version specified in the `package.json` file to the latest version:

    ```json
    "node-fetch": "^3.3.2"
    ```

1. Then run the following command to update the project:

   ```bash
   npm update
   ```

    Your project should now have no npm vulnerabilities and be on the current major version.

1. Check in your `package.json` and `package-lock.json` files.
    
   Congratulations! You've updated the dependencies and fixed the vulnerabilities in the project. 


## Cleanup development container

After completing the project, you may wish to clean up your development environment or return it to its typical state.

#### [Remote development (browser)](#tab/github-codespaces)

Deleting the GitHub Codespaces environment ensures that you can maximize the amount of free per-core hours entitlement you get for your account.

> [!IMPORTANT]
> For more information about your GitHub account's entitlements, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Sign into the GitHub Codespaces dashboard (<https://github.com/codespaces>).

    :::image type="content" source="../media/codespaces/codespace-dashboard.png" alt-text="Screenshot of all the running codespaces including their status and templates.":::

1. Open the context menu for the codespace and select **Delete**.

    :::image type="content" source="../media/codespaces/codespace-delete.png" alt-text="Screenshot of the context menu for a single codespace with the delete option highlighted.":::

#### [Local development (Docker)](#tab/visual-studio-code)

You aren't necessarily required to clean up your local environment, but you can stop the running development container and return to running Visual Studio Code in the context of a local workspace.

1. Open the **Command Palette**, search for the **Dev Containers** commands, and then select **Dev Containers: Reopen Folder Locally**.

    :::image type="content" source="../media/codespaces/reopen-local-command-palette.png" alt-text="Screenshot of the Command Palette option to reopen the current folder within your local environment.":::

> [!TIP]
> Visual Studio Code will stop the running development container, but the container still exists in Docker in a stopped state. You always have the option to deleting the container instance, container image, and volumes from Docker to free up more space on your local machine.

---
