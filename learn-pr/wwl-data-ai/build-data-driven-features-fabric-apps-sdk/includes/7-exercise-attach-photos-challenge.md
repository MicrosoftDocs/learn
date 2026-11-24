In this exercise, you add Storage to the issue tracker and manage photos of defective parts through the typed client. A short challenge then connects a photo to an issue and combines the skills from the module.

## Prerequisites

Storage lets an app upload, download, list, and delete files through the same client and signed-in session as data. Files live in OneLake behind the app's backend. Folder permissions control access to files, just as entity permissions control access to records.

Use the issue-tracker project from the exercises in this module and a development workspace on a trial or paid capacity. Storage requires the Data service and isn't supported in Power BI Pro workspaces. There is no local Storage emulator: the frontend on `localhost` reads and writes remote files.

Storage also relies on the tenant setting **Users can access data stored in OneLake with apps external to Fabric**, which is on by default for the organization. If uploads are refused, ask a Fabric administrator to check it.

## Add Storage

1. In the project root, add the Storage capability pack.

    ```bash
    npm run pack:add -- storage
    ```

    The pack enables Storage and the Data service, adds a starter `Attachment` folder with owner-scoped access, and registers Storage on the typed client.

1. Open `packages/storage/` and find the `Attachment` class. Confirm that it extends `StorageObject` and has a `@blob()` decorator and an authenticated role rule. The starter declaration uses this pattern:

    ```typescript
    import { blob, mb, role, StorageObject } from '@microsoft/rayfin-core';

    @blob({ maxSize: mb(10) })
    @role('authenticated', '*', {
      policy: (claims, item) => claims.sub.eq(item.owner_id),
    })
    export class Attachment extends StorageObject {}
    ```

    `owner_id` is the uploader's `sub` claim, so this rule limits each signed-in user to their own files. Every folder needs at least one authenticated rule. Anonymous Storage permissions aren't supported.

    Folder options include `name`, `onConflict` (`'error'` by default), `maxSize`, and `allowedContentTypes`. Keep the folder name stable. Without an explicit name, renaming the class renames the folder, and applying the change treats the old folder as removed.
1. Open the client module, `packages/frontend/src/lib/rayfin-client.ts`, and confirm that `storageService` is registered.
1. Deploy and apply the folder. Don't interrupt the command. If the output reports a storage warning, run `npx rayfin up storage apply` to retry only the folder step.

    ```bash
    npx rayfin up
    npx rayfin up status
    ```

1. Stop and restart `npm run dev` after adding the Storage pack. Storage is remote-only, so the app on `localhost` reads and writes the same remote folder as the deployed app. Use your development app and avoid production data.

    During development, `npx rayfin dev storage apply` applies folder changes without restarting the session.

> [!WARNING]
> Removing a folder declaration and applying the change permanently deletes every object in that folder. Apply refuses to remove a non-empty folder unless you pass `--force`. Don't use `--force` to clean up one file, and don't interrupt an upload or deletion to test error handling. Interrupted operations can block a path for about 70 minutes.

## Upload, list, download, and delete

Each file has a complete path inside its folder, including the file name. A file at the folder root uses its name alone. Directory segments can group files, such as `<issue-id>/photo.png`. Paths use `/` as a separator and can't start or end with `/` or contain empty, `.`, or `..` segments.

Paths organize files but don't grant access. Folder permissions still govern each operation. Any per-user path segment comes from the signed-in session, not user input.

1. Create `packages/frontend/src/Attachments.tsx` with the following code. The component uses the template's `getRayfinClient()` function, lets you pick an image, and uploads it to the `Attachment` folder.

    ```tsx
    import { useState } from 'react';
    import { isStorageError } from '@microsoft/rayfin-storage';
    import { getRayfinClient } from './lib/rayfin-client';

    export function Attachments() {
      const [items, setItems] = useState<{ path: string; size: number }[]>([]);
      const [message, setMessage] = useState('');
      async function refresh() {
        const client = await getRayfinClient();
        setItems((await client.storage.Attachment.list({ limit: 20 })).items);
      }

      async function upload(file: File) {
        try {
          const client = await getRayfinClient();
          await client.storage.Attachment.upload(file.name, file);
          setMessage('Uploaded.');
          await refresh();
        } catch (error) {
          setMessage(isStorageError(error) ? `${error.code}: ${error.message}` : 'Upload failed.');
        }
      }

      async function remove(path: string) {
        try {
          const client = await getRayfinClient();
          await client.storage.Attachment.delete(path);
          setMessage('Deleted.');
          await refresh();
        } catch (error) {
          setMessage(isStorageError(error) ? `${error.code}: ${error.message}` : 'Delete failed.');
        }
      }

      return (
        <section>
          <input type="file" accept="image/*" onChange={(e) => e.target.files?.[0] && upload(e.target.files[0])} />
          <p>{message}</p>
          <ul>
            {items.map((item) => (
              <li key={item.path}>
                {item.path} ({item.size} bytes)
                <button
                  type="button"
                  onClick={() => remove(item.path)}
                  className="bg-primary text-primary-foreground px-400 py-200 rounded-md"
                >
                  Delete
                </button>
              </li>
            ))}
          </ul>
        </section>
      );
    }
    ```

    `upload` builds its returned `object` from the request. Calling `list` after the upload retrieves server-assigned metadata. Storage operations throw a `StorageError` with a code such as `Conflict`, `TooLarge`, `UnsupportedContentType`, or `PermissionDenied`. The component uses `isStorageError` to display that code and message. The client doesn't retry automatically.

1. In `packages/frontend/src/App.tsx`, add `import { Attachments } from './Attachments';` alongside the existing imports. Replace the `App` component with the following code, keeping the default export. Run the app, sign in, and upload a small image.

    ```tsx
    function App() {
      return (
        <>
          <IssueList />
          <Attachments />
        </>
      );
    }
    ```

1. Confirm that the file appears in the list. Upload the same file name again and confirm that you see a `Conflict` message, because the folder doesn't overwrite by default.
1. In `packages/frontend/src/Attachments.tsx`, add a preview that downloads the selected photo and displays it. Make the following changes inside the existing component rather than pasting the original download snippet at the top of the file.

    Change the React import to include `useEffect`:

    ```tsx
    import { useEffect, useState } from 'react';
    ```

    Inside `Attachments`, immediately after the `message` state declaration, add this state and effect. The effect releases the previous object URL when the preview changes or the component unmounts.

    ```tsx
    const [preview, setPreview] = useState<{ path: string; url: string } | null>(null);

    useEffect(() => {
      return () => {
        if (preview) URL.revokeObjectURL(preview.url);
      };
    }, [preview]);
    ```

    Insert this handler after `remove` and before the component's `return` block. The `path` argument comes from the file selected in the list.

    ```typescript
    async function previewFile(path: string) {
      try {
        const client = await getRayfinClient();
        const result = await client.storage.Attachment.download(path);
        const blob = await new Response(result.stream, {
          headers: result.contentType ? { 'Content-Type': result.contentType } : undefined,
        }).blob();
        setPreview({ path, url: URL.createObjectURL(blob) });
        setMessage('Photo downloaded.');
      } catch (error) {
        setMessage(isStorageError(error) ? `${error.code}: ${error.message}` : 'Download failed.');
      }
    }
    ```

    Inside `items.map`, insert this button immediately before the existing **Delete** button:

    ```tsx
    <button
      type="button"
      onClick={() => previewFile(item.path)}
      className="bg-primary text-primary-foreground px-400 py-200 rounded-md"
    >
      Preview
    </button>
    ```

    After `</ul>` and before `</section>`, insert the preview image:

    ```tsx
    {preview && (
      <img
        src={preview.url}
        alt={`Photo attachment at ${preview.path}.`}
        className="max-w-full h-auto"
      />
    )}
    ```

    In `remove`, immediately after `await client.storage.Attachment.delete(path);`, add this line so deleting the previewed file also clears its image and releases the object URL:

    ```typescript
    if (preview?.path === path) setPreview(null);
    ```

    Select **Preview** for the uploaded file and confirm that the photo appears below the list.

1. Select **Delete** for the file and confirm that the list and preview are empty.

> [!IMPORTANT]
> Don't remove the folder declaration to delete one file. Removing a declaration deletes every object in the folder.

## Challenge

Without step-by-step instructions, complete these tasks:

1. Add a `severity` filter to the issue list, and confirm that the filter works across all pages, not only the first one.
1. Attach a photo to an issue and retrieve it, using the existing `Attachment` folder. Use the issue's `id` as a directory segment in the path, for example `<issue-id>/photo.png`.

If you need a hint: filter with `where` and keep `select` and `orderBy` identical across pages. For the second task, compose the path from the `id`, and don't take any path segment from user input.

## Clean up

1. Delete test files from the `Attachment` folder with `delete`. Don't remove the folder declaration to clean up.
1. Delete the app item from your Fabric workspace, and check whether any child items remain.
