An app that shows the right data in its interface isn't necessarily secure. Anyone can call the data API without using your screens, so protections that live only in the UI don't hold. In a Fabric app, you secure data by choosing how users sign in and by writing permissions on the data model, where the server enforces them on every request.

You build a tool for store issue reports at Adventure Works Cycles. Store managers must see only their own store's reports, regional leads need a wider view, and a recall notice must be visible to the public without sign-in. You choose a sign-in path, express the access rules in the data model, and then test the rules by calling the API directly, including a request with no sign-in and a record that belongs to someone else.

In this module, you explore the sign-in paths that Fabric Apps supports and how Fabric single sign-on works in a React app. You learn how role-based permissions, row-level policies, and field-level rules compile into server-side checks, and when anonymous access is appropriate. Hands-on exercises in your own Fabric tenant let you add sign-in and sign-out, enforce owner-only access, and verify that unauthenticated requests are denied.

By the end of this module, you're able to secure a Fabric app by choosing a sign-in path and enforcing data permissions on the server.
