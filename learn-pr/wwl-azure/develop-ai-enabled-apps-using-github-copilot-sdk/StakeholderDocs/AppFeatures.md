# ContosoShop E-commerce Support Portal – Feature Description

This document describes the functional features of the ContosoShop E-commerce Support Portal. The application is a simplified customer-facing support website for an online retailer, focused on allowing a user to manage orders and get post-purchase support. Below is a breakdown of the key features, user workflows, and how they operate in the base application (before adding the AI agent).

## 1. User and Authentication (Simplified for Lab)

**User Profile:** In this sample, the application assumes a single demo user (e.g., "John Doe") representing the signed-in customer. In a full production app, we would have an authentication system (allowing each real customer to log in and view their own data). For the purposes of this lab and to keep things simple, authentication is not fully implemented – the frontend automatically uses a preset user identity. This means:

- When the app is launched, it behaves as if John Doe is logged in. His user ID is used for data retrieval (orders, etc.).
- No login page is presented in the base app. (In a real scenario, adding Azure AD B2C or Identity for auth is straightforward, but beyond our current scope.)

**Authorization:** Since there's effectively one user context, all features are available to that user. The backend endpoints in this lab do not enforce authorization rules (again, assuming a trusted environment or that auth would be added later). However, the design assumes that in a real system, every API call would verify the caller's identity and restrict data (e.g., you can only retrieve orders that belong to your user ID).

**Cloud-readiness note:** The app is structured to easily plug in an auth mechanism later. For instance, controllers are coded in a way that obtaining the current user's ID is abstracted (currently, it's a constant in our demo; later it could come from an Auth token or HttpContext). This prepares the ground for using Azure AD or another identity provider in the future without major refactoring.

## 2. Order Management Features

These features allow the user to see information about their purchases. All order-related data is stored in a database and accessed via the backend API.

**Order History Page:** The "Orders" page on the Blazor client displays a list of the user's past orders. For each order, it shows an overview: Order Number/ID, date of purchase, total amount, and current status.

- Example: Order #1001 – Placed on Jan 5, 2026 – Total: $59.99 – Status: Delivered.
- The data is fetched from the backend by calling GET /api/orders (which returns all orders for the demo user). In the base app, this API uses the user's ID to query the database (in our simplified scenario, it returns a static list of sample orders seeded for John Doe).
- If no orders exist (e.g., in a fresh database), the page will indicate that the user has no order history.

**Order Details View:** By clicking on an order in the history list, the user navigates to an Order Details page. This shows more granular information:

- Items in the order (product names, quantities, prices).
- Order timeline information: purchase date, shipment date (if shipped), delivery date (if delivered), etc.
- The current status is highlighted (e.g., "Delivered on Feb 10, 2026").
- This page calls GET /api/orders/{orderId} to fetch details for the selected order. The API returns a detailed order object including associated items. In the UI, a list of order items is displayed with their name, SKU, price, and quantity.
- If the order is still in process (not delivered yet), the page might show an estimated delivery or current shipping step (for example, "Your package is in transit – expected by Jul 20" if such info were available; our base sample keeps it simple with basic statuses).
- If the order ID requested doesn't belong to the user or doesn't exist, the base API would return an error. However, since our demo user only sees their own seed data, this situation doesn't occur in normal use.

**Order Status Indicators:** The possible order statuses in the base system include: Processing, Shipped, Delivered, Returned. Each status is assigned automatically by the system logic or via data seeding.

- **Processing:** Order placed but not yet shipped.
- **Shipped:** Order handed over to carrier, on the way.
- **Delivered:** Order delivered to the customer (eligible for return).
- **Returned:** Order was returned by the customer and refund processed.

These statuses are shown on both the Order History and Details pages for clarity. If an order is returned, it's clearly labeled as such (and items might be shown as returned).

**Data Persistence:** In the base app, order information is stored in a local SQLite database via Entity Framework Core. There are two main tables (entities):

- **Orders:** Contains fields like OrderId, UserId, OrderDate, Status, TotalAmount, etc. Possibly also a field for DeliveryDate.
- **OrderItems:** Contains individual line items for each order (OrderItemId, OrderId (foreign key), ProductName, Quantity, Price).

Each time the user requests their orders, the API queries this DB. The SQLite DB is pre-populated with a few orders for demonstration. (For example, Order #1001 might be a delivered order with two items, Order #1002 a shipped order with one item, etc.)

## 3. Return and Refund Capability

One of the major support functions of an e-commerce site is handling returns. The base application includes a simplified return/refund workflow:

**Return Eligibility & UI:** If an order's status is Delivered, the Order Details page will display a "Return Order" or "Initiate Return" button. This is the entry point for the user to request a return/refund for that order. (For orders not delivered or already returned, no such button is shown, preventing invalid actions.)

- The base app determines eligibility by checking the status field. Optionally, it could also check a timeframe (e.g., only allow returns within 30 days of delivery). In our demo, we assume all delivered orders are returnable (the training focus is AI integration, so we keep business rules simple).

**Return Process (Base Implementation):** When the user clicks "Return Order," in the base app the following happens:

- The frontend calls POST /api/orders/{orderId}/return (this endpoint is implemented in the ASP.NET Core API). The request includes the order ID (and could include a reason for return, though our UI doesn't ask for one in the base version).
- The backend API ReturnOrder handler will verify that the order is indeed deliverable/returnable. (It checks the status isn't already "Returned" and belongs to the user, etc. If any check fails, it returns an appropriate error or status code.)
- If valid, the API updates the Order's status to Returned in the database. It also creates a Refund record or, in this simple case, just notes that a refund is due. (We have a conceptual Refunds table or simply treat the status change as implying the refund is processed.)
- The API then (in the base app) simulates sending a confirmation email to the customer. Rather than actually sending an email, it uses a service that logs the email content. For example, it might log: "Refund initiated for Order #1001 – amount $59.99 will be returned to your original payment method." This log simulates what an email would contain. (This design uses an EmailService interface, with a development implementation that just writes to console. Later, this can be swapped with a real email sender backed by SendGrid or SMTP without changing the controller logic – demonstrating a production-oriented design even in a local app.)
- Finally, the API responds to the client indicating success. The Blazor UI, upon success, might show a confirmation message like "Your return has been processed. You will receive a confirmation email shortly." and update the order status on the page to "Returned".

**Post-Return Behavior:** After a return, if the user checks the order list, Order #1001's status will now show as Returned. If they go into details, they'll see it marked returned (and no return button, since it's already done). Essentially, the system now treats it as a completed return. (The base app does not track refunds money movement beyond the status, but in a real system this is where integration with a payment gateway would happen.)

**Partial Returns:** For simplicity, the base app's return is all-or-nothing per order (we assume one order = one shipment). Partial item returns are not separately handled in our scenario. In a real world, you might have per-item returns; for this lab's scope, we consider the whole order returned.

## 4. Customer Support Interface

The application has a section dedicated to customer support, which is where our AI integration will come into play. In the base application:

**Contact Support Page:** There is a page (likely accessible via a "Support" or "Contact Us" link) that is meant to assist the user in getting help. Currently, this page contains static content, such as:

- Support contact information (e.g., "For any issues, email support@contososhop.com or call 1-800-CONTOSO").
- Perhaps an input form or button that says "Chat with an Agent" or "Ask a question" – but it might be non-functional or placeholder in the base version. For example, a disabled text box that says "Support chat coming soon" or instructions like "Type your question below and click send." However, since we haven't wired up the backend for chat yet, clicking send might either do nothing or show a dummy response ("Thanks, we will get back to you.").
- The reason to include a stub here is to set the stage for the lab: this page is exactly where we'll embed the AI agent.

**Current Limitations:** Without the AI agent, the support page cannot dynamically answer user queries. If a user wanted to know "Where is my order?" currently they would have to look at the Orders page themselves. The support page might just say "Contact us via email." In essence, the base app doesn't yet have interactive Q&A or support automation.

**Vision for Enhancement:** The design anticipates adding an interactive element. The page already has a layout conducive to a chat interface (e.g., an area where conversation could be displayed and an input box at the bottom). This was done intentionally to make the integration of the Copilot SDK agent smoother. After the lab, this page will allow the user to ask questions in natural language and receive answers or actions (like initiating returns) from the AI agent, instead of the static info.

## 5. Error Handling and User Feedback

Even in a simple app, providing feedback for errors or important events is crucial:

**API Error Handling:** The backend APIs return proper HTTP status codes for error scenarios. For example, if a return is requested for an order that's not delivered (say status is Shipped), the API might return a 400 Bad Request with a message "Order not deliverable, cannot return yet." In the base UI, such error messages would be caught and displayed to the user, possibly as a notification or modal. (The current UI has a basic mechanism for showing an error alert if an API call fails – this uses Blazor's error boundary or a simple try/catch around the API call followed by showing a message in the page.)

**Confirmation Messages:** Conversely, when actions succeed (like a return processed), the UI immediately reflects the change (status updated) and may show a one-time confirmation message, e.g., "Return processed successfully." The base app's Order Details page, for instance, might have a banner that appears after a successful return action.

**Input Validation:** There is minimal user input in the base app (mostly just the action of clicking return). The forms that do exist – e.g., if we had a support question form – validate that required fields are filled. In the "Contact Support" stub form, if present, we ensure the user can't send an empty query (the send button might be disabled until they type something, for example). These checks are done on the client side (Blazor can data-bind and validate inputs easily), and critical checks are repeated on the server (never trust client entirely; for instance, the ReturnOrder API double-checks that the order is valid for return regardless of what the UI did or didn't show).

**Navigation & State:** The single-page nature of Blazor means users can navigate between pages (Orders list -> Order details -> Support, etc.) without full reloads. The app preserves necessary state (like selected order details are fetched each time or cached briefly). If the user performs an action and then goes back, the Orders list will refresh to show updated status (our base implementation simply re-calls the API on navigation, but we could optimize with caching). This approach ensures that the user always sees up-to-date info, even though it might re-fetch data (acceptable in a small app).

## 6. Roadmap for Cloud-Scale Features

While the base application is feature-complete for a demo, it leaves out some advanced features that a production system would have, which can be added later without restructuring:

**User Authentication & Profiles:** As noted, adding a robust authentication system (with identity management, password reset, multi-user support) is a logical next step. The front-end nav bar already has a placeholder for "Hello, [Username]" which in our case is fixed, but could tie into an auth system easily. Azure AD B2C or Identity Server could be integrated so each user sees only their orders. The database already associates orders with a UserId, which is how multi-tenancy would be enforced.

**Payment and Refund Integration:** The return process is simulated. In real life, upon marking an order as Returned, we'd call a Payment Gateway API to actually issue the refund to the customer's credit card or account. The code is structured so that the step of "issue refund" can be abstracted to a service class. Currently it's a stub that just logs, but one could plug in, say, Stripe or PayPal API calls in that spot.

**Inventory and Product Catalog:** Our focus was customer support, so we don't have product browsing or inventory management in this project. However, if one were to extend this into a full e-commerce app, one could add a Products API and pages for browsing items, adding to cart, placing orders, etc. The addition of those features would not conflict with what's built – the Orders and Support parts would continue to function and would benefit from more data.

**Admin Portal:** Another extension might be an admin interface for support reps to intervene. For instance, an admin could use a similar web UI to look up any customer's orders and manually process returns or answer queries. That would require authentication roles and exposing data by admin queries. The base app doesn't include this, but our API and DB design (with clear user IDs and order relationships) would allow an admin to retrieve any order by ID if authorized.

**Internationalization and Localization:** Currently all text is in English and amounts are in dollars. The app could be localized (Blazor has support for localization) to different languages and currencies. We didn't do it here to avoid complexity in the lab, but it's a consideration for production. Similarly, date and number formats are fixed in code but could be culture-sensitive.

The above features are outside the immediate scope of the lab, but it's important to note that the base app's design does not paint us into a corner; it can evolve. For now, the primary mission is to integrate an AI agent into the Contact Support experience. This will transform the static support page into a smart assistant that can leverage the app's existing Order and Return features. The next document (TechStack.md) explains how this app is built under the hood, which will clarify where and how the AI agent will hook into the system.
