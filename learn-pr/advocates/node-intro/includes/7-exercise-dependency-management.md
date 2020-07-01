Tailwind Traders has tasked you with working on an app with some outdated dependencies. The app is fairly small and only has a couple of dependencies. Updating it should be straight forward. See if you can update the app to take advantage of the latest features and if you find any vulnerabilities fix them while you are at it.

## Upgrading the app dependencies

1. Clone the following repo TODO . You should now have access to the following files:

   -| index.js
   -| package.json

1. Open up the `index.js` file. It should look like so:

   ```javascript
   const fetch = require('node-fetch')
   const _ = require('lodash');
   const path = require('path');
   const fs = require('fs');

   async function run() {
     const response = await fetch("https://dev.to/api/articles?state=rising");
     const json = await response.json();
     const sorted = _.sortBy(json, ["public_reactions_count"], ['desc']);
     const top5 = _.take(sorted, 3);

     const filePrefix = new Date().toISOString().split('T')[0];
     fs.writeFileSync(path.join(__dirname, `${filePrefix}-feed.json`), JSON.stringify(top5, null, 2));
    }

    run();
   ```

   The above code is pulling some data from a REST API using the `node-fetch` library. Then it goes on to process the response by sorting it and taking the top three results using the library `lodash`. The result is stored in a file.

1. Have a look at the `package.json` file and locate the `dependencies` section. It should look like so:

   ```json
   "lodash": "^1.1.0",
   "node-fetch": "^1.0.2"
   ```

   Type the following command in the terminal to find out if your dependencies pose a risk:

   ```bash
   npm audit
   ```

   The output, a bit shortened down for brevity, shows the following:

   ```output
   found 3 vulnerabilities (1 low, 2 high) in 5 scanned packages
   3 vulnerabilities require semver-major dependency updates.
   ```

   You have vulnerabilities, two on high and one low. The high vulnerabilities say you should upgrade. It tells you that *3 vulnerabilities require semver-major dependency updates*. This fact means you need to upgrade the major version of the dependency to get rid of these vulnerabilities. The audit report suggests how to resolve these issues. It states the command to run at the top Run `npm install lodash@4.17.15`.

1. Type the command in the terminal the audit report told you to:

   ```bash
   npm install lodash@4.17.15
   ```

   At the end of the output from the above command, you see this text:

   ```output
   found 0 vulnerabilities
   ```

   The output means you from a vulnerability standpoint are now safe. You might have some other reasons to update though so let's look at what those reasons might be next.

1. You've upgraded the `lodash` dependency. You have a `node-fetch` dependency as well. Looking at the `package.json` entry for it, it says the following `"node-fetch": "^1.0.2"`. Let's see what versions are available with the following command:

   ```bash
   npm show node-fetch versions
   ```

   You look through the resulting response of the above command and you see the latest version seems to be `2.6.0`.

1. Locate the entry `"node-fetch": "^1.0.2"` in `package.json` and change it to `"node-fetch": ""`.
1. Run the following command in the terminal:

   ```bash
   npm update node-fetch
   ```

   You should have gotten an output looking something like this:

   ```output
   + node-fetch@2.6.0
   removed 3 packages, updated 1 package and audited 2 packages in 0.925s
   found 0 vulnerabilities
   ```

Congratulations you've managed to upgrade the two dependencies in your app. In doing so you've managed to fix three vulnerabilities, 2 of them on high, nice. You've also managed to upgrade the second dependency because you wanted the latest and greatest features. Well done!
