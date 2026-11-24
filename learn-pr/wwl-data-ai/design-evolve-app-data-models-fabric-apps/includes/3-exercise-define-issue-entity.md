In this exercise, you prepare a Fabric Apps project for the Adventure Works Cycles issue-reporting tool and define its first entity. You keep the project for the exercises that follow.

## Prepare the project

You need a Universal App project that you can sign in from. If you don't have one, scaffold it in a workspace that's assigned to a Fabric trial or paid capacity.

1. Scaffold the default template. On Windows PowerShell, use `npm.cmd` instead of `npm` if the `--template` flag doesn't reach the tool.

    ```bash
    npm create @microsoft/rayfin@latest issue-tracker -- --template blankapp
    cd issue-tracker
    npm install
    ```

1. Sign in to Fabric. A browser window opens for Microsoft Entra sign-in.

    ```bash
    npx rayfin login
    ```

A trial capacity allows only a few SQL databases, so reuse this one app for the whole module.

## Enable the data service

1. In the project root, run the `data-modeling` capability pack.

    ```bash
    npm run pack:add -- data-modeling
    ```

    The command turns on the data service in `rayfin/rayfin.yml`, adds a starter `Item` entity, and registers it. Your output looks similar to this example:

    ```output
     ~/git/fabric-apps/issue-tracker  npm run pack:add -- data-modeling

    > issue-tracker@0.0.0 pack:add
    > node scripts/scaffold.mjs data-modeling


    > Scaffolding pack: data-modeling
      Rayfin data service: turns the database on and plants a starter entity with owner-scoped access, so an agent edits a working schema instead of inventing one.
      - rayfin.yml: data.enabled = true
      - rayfin.yml: data.dialect = mssql
      - package.json composed script: build
      - package.json composed script: build:fabric
      - package.json: 0 dependency change(s)
      - copied 3 file(s)

    (pack declares no dependencies - skipping install)

    [done] Pack ready. Next, read these skills as you build:
      -> .agents/skills/crud-ui/SKILL.md
      -> .agents/skills/app-design/SKILL.md
    ```

1. Open `packages/data/src/Item.ts`. Notice the `@role('authenticated', '*', ...)` decorator with a `policy`, and the `owner_id` field that the policy compares to the signed-in user.

1. Open `packages/data/src/index.ts` and find the `schema` array. Open `packages/shared/src/index.ts` and find `ItemRecord` and `UniversalAppSchema`. You extend both files in the next section.

## Define the `Issue` entity

1. In `packages/data/src/`, create `Issue.ts` with the following code.

    ```typescript
    import {
      entity,
      authenticated,
      uuid,
      text,
      int,
      date,
      set,
    } from '@microsoft/rayfin-core';

    @entity()
    @authenticated('*', {
      policy: (claims, item) => claims.sub.eq(item.owner_id),
    })
    export class Issue {
      @uuid() id!: string;
      @text({ max: 200 }) title!: string;
      @text({ max: 2000, optional: true }) description?: string;
      @set('low', 'medium', 'high') severity!: 'low' | 'medium' | 'high';
      @int({ min: 1, default: 1 }) unitsAffected!: number;
      @date() reportedOn!: Date;
      @text({ max: 200 }) owner_id!: string;
    }
    ```

1. In `packages/data/src/index.ts`, import `Issue` with a `.js` extension and add it to the `schema` array. Keep the existing lines.

    ```typescript
    import { Issue } from './Issue.js';

    export const schema = [Item, Issue];
    ```

1. In `packages/shared/src/index.ts`, add a record type for `Issue` and add it to `UniversalAppSchema`. The frontend imports this file, so it doesn't import the decorated classes.

    ```typescript
    export interface IssueRecord {
      id: string;
      title: string;
      description?: string;
      severity: 'low' | 'medium' | 'high';
      unitsAffected: number;
      reportedOn: Date;
      owner_id: string;
    }

    export type UniversalAppSchema = {
      Item: ItemRecord;
      Issue: IssueRecord;
    };
    ```

## Check that the model compiles

1. Build the data package from the project root.

    ```bash
    npm run build -w @rayfin-app/data
    ```

1. If the build reports `TS2835`, a relative import is missing its `.js` extension. Fix it and build again.

The build finishes without errors. Nothing changes in the database yet, because you apply the model in a later exercise.