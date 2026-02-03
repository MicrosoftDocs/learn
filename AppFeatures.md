# AppFeatures.md

## Core Features Implemented

The ContosoShop E-commerce Support Portal offers the following key features in its base implementation:

### 1. User Experience & Authentication

- **Single-user simulation**: The application runs locally without requiring complex authentication. A user identity ("John Doe") is assumed for development and demo purposes.
- **Session-based state**: While authentication isn't enforced in development, the architecture supports adding identity providers (like Azure AD or Auth0) for production.
- **Navigation & layout**: Provides a navigation menu with links to "Orders" and "Contact Support" pages, ensuring intuitive access to primary functions.

### 2. Order Management

- **Order listing**: Display a list of orders for the current user, showing order ID, date, status, and total amount.
- **Order details**: Drill down into individual orders to view line items, quantities, prices, delivery information, and current status (Processing, Shipped, Delivered, or Returned).
- **Status tracking**: Orders have multiple states that reflect their lifecycle (Processing → Shipped → Delivered or Returned). Each state change is tracked with timestamps where applicable (e.g., DeliveryDate).
- **Data persistence**: Orders are stored in a SQLite database (local file) with Entity Framework Core. The database is seeded with sample orders on first run, simulating real-world e-commerce data.

### 3. Return & Refund Capability

- **Eligibility check**: Users can initiate returns only for delivered orders. The UI displays a "Return" button for eligible orders and enforces business rules (e.g., orders must be Delivered to be returnable).
- **Automated return process**: When a return is requested:
  - Order status is updated to "Returned"
  - A ReturnDate timestamp is recorded
  - A refund confirmation is logged
  - An automated email is sent to the customer confirming the refund details
- **Email notifications**: Uses a placeholder IEmailService that can be swapped with a real implementation (like SendGrid or SMTP) for production.
- **Error handling**: Provides user-friendly error messages if a return request fails (e.g., order not found or ineligible status).

### 4. Customer Support Interface

- **Contact Support page**: A dedicated page where users can submit queries or requests for assistance.
- **Placeholder agent interaction**: In the base app, this is a static form that acknowledges submissions with a placeholder message. The lab exercise enhances this page by integrating the GitHub Copilot SDK to create a live AI-powered agent.
- **Query submission**: Users can type questions (e.g., "Where is my order?") and receive responses. The base version is a simple stub that will be replaced with intelligent responses in the lab.

### 5. Error Handling & Validation

- **Client-side validation**: Blazor components validate user input (e.g., ensuring required fields are filled before submission).
- **Server-side validation**: API endpoints check data integrity (e.g., verifying order IDs exist before processing returns).
- **Exception handling**: Try-catch blocks in service methods catch and log errors without exposing sensitive details to end users. Error messages are user-friendly (e.g., "Sorry, we couldn't find that order. Please check the order number.").
- **Fallback UI**: If an API call fails, the UI displays an error alert with guidance on what to do next (e.g., "Please try again later or contact support.").

### 6. Cloud-Ready Features & Roadmap

While the base application runs entirely locally (for ease of learning and development), it is designed with cloud deployment in mind. Key cloud-ready aspects include:

- **Scalable architecture**: The frontend and backend can be deployed separately (e.g., Blazor WASM on a CDN, API on Azure App Service).
- **Database migration path**: The SQLite database can be replaced with Azure SQL Database with minimal code changes (just updating the connection string and EF Core provider).
- **Configuration management**: Uses appsettings.json and environment variables for secrets and settings, making it easy to integrate with Azure Key Vault or Azure App Configuration.
- **Logging & telemetry**: Supports standard .NET logging interfaces that can pipe to Application Insights or other cloud monitoring tools.
- **Email service abstraction**: The IEmailService interface can be backed by SendGrid, Azure Communication Services, or other cloud email providers without changing business logic.

These features collectively provide a realistic e-commerce support portal experience. The application is complete enough to demonstrate order tracking and returns in action, yet simple enough to serve as a learning platform for integrating advanced features like AI agents.
