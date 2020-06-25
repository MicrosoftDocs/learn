Tailwind Traders wants you to find out how updating packages works. There will be Node.js apps running in production and it's important to learn how to update in a predictable way. Find out how to update to specific versions. Additionally find out how to configure the `package.json` file so that it updates to patch, minor and major versions, so there's no surprises when updating.

## Upgrade to patch version only

For this exercise, you will install a package from NPM and configure `package.json` in way that it only fetches new versions if there are patches released. It should ignore all other types of updates. Ensure you have opened the terminal in an empty directory of your choice.

1. Run the following command to create a Node.js project

   ```bash
   node init -y
   ```

   This command should create a `package.json` file with some defaults.

1. Install the `lodash` package with the following command:

   ```bash
   npm install lodash@1.0.0
   ```

1. Open up `package.json` and locate the `dependencies` section. It should state the following information:

   ```json
   "lodash": "^1.3.1"
   ```

   You need to change this instruction as it's currently set to upgrading to highest possible minor release. Change the above instruction to:

   ```json
   "lodash": "1.0.x"
   ```

   Now run the command `npm upgrade lodash` and afterwards go to `node_module/lodash/package.json`. Locate the following field at the top:

   ```json
   "_id": "lodash@1.0.2"
   ```

    As you can see your instruction to only update if there are patch versions, works perfectly.

## Upgrade to minor version

Only updating to the latest patch version is considered a careful approach. In fact, if the library author follows semantic versioning you should be safe to update to the latest minor version. New minor versions should signal that there is only new functionality. Only major versions potentially break the code, in theory. So how can you instruct your `package.json` to upgrade to latest minor version?

1. Open up `package.json` and locate the following instruction in the `dependencies` section:

   ```json
   "lodash": "^1.0.2"
   ```

   Note how the instruction has changed from `1.0.x` to `^1.0.2`. This change is because NPM changed the configuration.  It changed it to set you up so that it will in fact update your library to the latest minor release, where you to try to upgrade it.

1. You are all set up so type the following command:

  ```bash
  npm upgrade lodash
  ```

  Note how the output from the above command says something like this:

  ```output
  + lodash@1.3.1
  updated 1 package and audited 1 package in 0.362s
  found 3 vulnerabilities (1 low, 2 high)
  ```

  It has updated your package to the latest minor release `1.3.1` and the latest patch version even. You can verify that this is the case by running the following command:

  ```bash
  npm show lodash versions
  ```

  The above command will list all the versions. By inspecting the output, you should find `1.3.1` to be the last minor version. Next version after that is `2.0.0`, a new major version. You specified to only update to the latest minor version.

## Upgrade to the latest version

It's definitely possible to update to the latest version available. It's an ok approach if you are working on a small project and is just starting out.

1. Open up `package.json` and locate the `dependencies` section and the entry that looks like this:

   ```json
   "lodash": "^1.3.1"
   ```

   Change it to the following:

   ```json
   "lodash": "^1.3.1"
   ```

   Now type the following command in the terminal:

   ```bash
   npm upgrade lodash
   ```

   You should see an output like this:

   ```output
   npm WARN updating@1.0.0 No description
   npm WARN updating@1.0.0 No repository field.

   + lodash@4.17.15
   updated 1 package and audited 1 package in 0.598s
   found 0 vulnerabilities
   ```

   From the above output, you can see how your library `lodash` updated itself `4.17.15` and thereby updated several major versions.
