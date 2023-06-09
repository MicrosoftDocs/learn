Tailwind Traders has asked you to work on an app that has some outdated dependencies. The app is small and has only a few dependencies. Updating the code should be straightforward. See if you can update the app to take advantage of the latest features. While you're at it, if you find any vulnerabilities, fix them.

## Upgrade app dependencies

> [!NOTE]
> If you closed your terminal window after the previous exercise, you might need to set up your environment again. Open a terminal window, and clone the exercise repo by running the command `git clone https://github.com/MicrosoftDocs/node-essentials/`. You can ignore warning messages about the cloned folder already existing or the directory not being empty.

1. In your terminal window, change to the folder that has the cloned files for this exercise:

   ```bash
   cd node-essentials/node-dependencies/7-exercise-dependency-management
   ```

1. Install the dependencies by running this command:

   ```bash
   npm install
   ```

   You should see output similar to this example:

   ```output
   added 5 packages, and audited 6 packages in 3s

   found 0 vulnerabilities
   ```

   > [!Important]
   > If the output shows a **critical vulnerability**, run the `npm audit fix --force` command to resolve the vulnerabilities.

1. Open the index.js file:

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

   This code pulls data from a REST API by using the `node-fetch` library. It processes the response by sorting it and takes the top three results by using the `lodash` library. The result is stored in a file.

   Close the file.

1. Open the package.json file and look at the `dependencies` section:

   ```json
   "lodash": "^1.1.0",
   "node-fetch": "^1.0.2"
   ```
   
   Notice the patterns specify the insert (^) character, which indicates updates to the minor version to support dependencies.
   
   Close the file.

1. In the terminal, run this command to check for outdated dependencies:

   ```bash
   npm outdated
   ```

   You should see output similar to this example:

   ```output
   Package       Current    Wanted    Latest    Location                   Depended by
   lodash        1.1.0      1.3.1     4.17.21   node_modules/lodash        7-exercise-dependency-management
   node-fetch    1.0.2      1.7.3     3.2.3     node_modules/node-fetch    7-exercise-dependency-management
   ```

1. You can, with some level of confidence, update the outdated packages to the **Wanted** version. This level of update ensures the dependencies get the latest features and patches in the minor version. Run the following command to do the update:

   ```bash
   npm update
   ```

   You should see output similar to this example:

   ```output
   Updating lodash to 1.3.1, which is a SemVer minor change.
   Updating node-fetch to 1.7.3, which is a SemVer minor change.

   changed 2 packages, and audited 6 packages in 6s
   
   found 0 vulnerabilities
   ```

   The output states your project dependencies have been updated.

   At this point, you've upgraded the dependencies as far as the patterns in your package.json file will allow.
   
   Now, you can either install the latest version by running the `npm install <name of package>@<known latest version>` command or use the `latest` keyword: `npm install <name of package>@latest`.

1. In the terminal, run this command:

   ```bash
   npm install node-fetch@latest lodash@latest
   ```

   Your output should look similar to this example:

   ```output
   Updating lodash to 4.17.21, which is a SemVer major change.
   Updating node-fetch to 3.2.3, which is a SemVer major change.

   added 5 packages, removed 3 packages, changed 2 packages, and audited 8 packages in 10s

   found 0 vulnerabilities
   ```

   Your results might be slightly different. The versions listed should correspond to the latest available versions of the packages.

Congratulations. You've upgraded the two dependencies in your app. Well done!
