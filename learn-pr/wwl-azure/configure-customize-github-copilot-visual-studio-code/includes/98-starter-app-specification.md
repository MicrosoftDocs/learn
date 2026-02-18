# ContosoInventory Starter Application — Product Specification

## 1. Overview

### Purpose

This document specifies the **ContosoInventory** starter application, designed for use in the Microsoft Learn training module "Configure and customize GitHub Copilot in Visual Studio Code." The starter application provides a pre-built C# web application that learners import, clone, and use as the foundation for lab exercises focused on GitHub Copilot customization features.

### Relationship to the training module

The lab exercise teaches learners to configure custom instruction files, path-specific instructions, prompt files, and custom agents (Planner, Implementer, Reviewer) that chain through handoffs. The starter application provides an operational **Categories** feature so that:

- Custom instruction files can be verified against existing code patterns.
- Path-specific instructions apply to existing controller and service files.
- Prompt files generate meaningful API documentation from existing endpoints.
- The Planner agent can analyze the existing Category architecture and generate informed implementation plans.
- The Implementer agent follows established patterns when adding new features.
- The Reviewer agent can compare new code against existing code for consistency.

During the lab exercise, learners use the chained-agent workflow to add a **Product** management feature to the application, modeled after the existing Category feature.

### Audience

This specification is intended for developers or AI agents building the starter application. All implementation details needed to produce a fully functional application are included.

---

## 2. Application Description

**Contoso's IT department** manages the company's technology inventory — tracking categories of equipment (laptops, monitors, networking gear, etc.) used across the organization. The **ContosoInventory** application is a web portal that lets IT administrators manage inventory categories and, eventually, track individual products.

The starter application ships with a fully functional **Categories** feature. During the lab exercise, learners add a **Product Inventory** feature using GitHub Copilot's customization capabilities.

### Key application features (starter)

- User authentication with role-based authorization (Admin and Viewer roles).
- Category management CRUD operations (create, read, update, delete).
- Toggle active/inactive status for categories.
- Responsive web UI for viewing and managing categories.
- Dashboard landing page with category statistics.
- Swagger/OpenAPI documentation for all API endpoints.

---

## 3. Technical Requirements

| Requirement | Value |
|---|---|
| Target framework | .NET 8.0 (with guidance for updating to .NET 9 or .NET 10) |
| Database | SQLite (via Entity Framework Core) |
| ORM | Entity Framework Core 8.x with SQLite provider |
| Authentication | ASP.NET Core Identity with cookie-based sessions |
| Frontend | Blazor WebAssembly (standalone, hosted by the server) |
| API documentation | Swagger / Swashbuckle |
| Source control | Git |
| Cross-platform | Must run on Windows, macOS, and Linux |

### NuGet packages — Server project

| Package | Purpose |
|---|---|
| `Microsoft.EntityFrameworkCore.Sqlite` | SQLite database provider for EF Core |
| `Microsoft.EntityFrameworkCore.Design` | EF Core design-time tooling (migrations) |
| `Microsoft.AspNetCore.Identity.EntityFrameworkCore` | ASP.NET Core Identity with EF Core stores |
| `Microsoft.AspNetCore.Components.WebAssembly.Server` | Host the Blazor WebAssembly client from the server |
| `Swashbuckle.AspNetCore` | Swagger/OpenAPI middleware and UI |

### NuGet packages — Client project

| Package | Purpose |
|---|---|
| `Microsoft.AspNetCore.Components.WebAssembly` | Blazor WebAssembly runtime |
| `Microsoft.AspNetCore.Components.Authorization` | Authentication/authorization components for Blazor |
| `Microsoft.Extensions.Http` | `IHttpClientFactory` for typed HTTP clients |

### NuGet packages — Shared project

| Package | Purpose |
|---|---|
| `System.ComponentModel.Annotations` | Data annotation attributes for DTO validation |

---

## 4. Architecture

The application uses a **three-project solution** architecture:

| Project | Description |
|---|---|
| **ContosoInventory.Server** | ASP.NET Core Web API with Entity Framework Core, ASP.NET Core Identity authentication, and SQLite. Hosts the Blazor WebAssembly client in production. |
| **ContosoInventory.Client** | Blazor WebAssembly SPA that runs in the browser and communicates with the server via HTTP API calls. |
| **ContosoInventory.Shared** | Shared class library containing models, DTOs, and enums referenced by both the server and client projects. |

### Architectural patterns

- **Repository/Service pattern**: All data access goes through service interfaces (e.g., `ICategoryService`). Controllers never access the `DbContext` directly.
- **Dependency injection**: All services are registered in `Program.cs` and injected via constructors.
- **DTO pattern**: API endpoints accept and return DTOs. Database entities are never exposed directly in API responses.
- **Async/await**: All I/O-bound operations use `async/await`.

---

## 5. Project Structure

```plaintext
ContosoInventory/
├── ContosoInventory.Server/
│   ├── App_Data/                           (SQLite database file location)
│   ├── Controllers/
│   │   ├── AuthController.cs               (Login, Logout, GetCurrentUser)
│   │   └── CategoriesController.cs         (CRUD + toggle-active)
│   ├── Data/
│   │   ├── InventoryContext.cs             (EF Core DbContext)
│   │   ├── DbInitializer.cs               (Database seeding)
│   │   └── Migrations/                     (EF Core migrations)
│   ├── Models/
│   │   └── Category.cs                     (Category entity)
│   ├── Services/
│   │   ├── ICategoryService.cs             (Category service interface)
│   │   └── CategoryService.cs              (Category service implementation)
│   ├── Properties/
│   │   └── launchSettings.json
│   ├── appsettings.json
│   ├── appsettings.Development.json
│   ├── ContosoInventory.Server.csproj
│   └── Program.cs
├── ContosoInventory.Client/
│   ├── Layout/
│   │   ├── MainLayout.razor                (Application shell with nav bar)
│   │   └── NavMenu.razor                   (Navigation menu component)
│   ├── Pages/
│   │   ├── Home.razor                      (Dashboard with category stats)
│   │   ├── Login.razor                     (Login form)
│   │   └── Categories.razor                (Category management page)
│   ├── Services/
│   │   ├── CategoryApiService.cs           (HTTP client for category API)
│   │   └── CookieAuthStateProvider.cs      (Custom AuthenticationStateProvider)
│   ├── wwwroot/
│   │   ├── css/
│   │   │   └── app.css                     (Application styles)
│   │   └── index.html                      (Blazor host page)
│   ├── _Imports.razor
│   ├── App.razor                           (Root component with routing)
│   ├── ContosoInventory.Client.csproj
│   └── Program.cs
├── ContosoInventory.Shared/
│   ├── DTOs/
│   │   ├── CategoryResponseDto.cs
│   │   ├── CreateCategoryDto.cs
│   │   ├── UpdateCategoryDto.cs
│   │   ├── LoginDto.cs
│   │   └── UserInfoDto.cs
│   ├── ContosoInventory.Shared.csproj
│   └── GlobalUsings.cs
├── ContosoInventory.sln
├── .gitignore
└── README.md
```

---

## 6. Data Model

### Category entity (`ContosoInventory.Server/Models/Category.cs`)

| Property | Type | Constraints | Description |
|---|---|---|---|
| `Id` | `int` | Primary key, auto-increment | Unique identifier |
| `Name` | `string` | Required, max length 100 | Category display name |
| `Description` | `string` | Required, max length 500 | Category description |
| `DisplayOrder` | `int` | Required | Sort order for UI display |
| `IsActive` | `bool` | Default: `true` | Whether the category is active |
| `CreatedDate` | `DateTime` | Set on creation | Timestamp of record creation (UTC) |
| `LastModifiedDate` | `DateTime` | Updated on modification | Timestamp of last modification (UTC) |

EF Core configuration:

- `Name` has a unique index.
- `Name` column: `nvarchar(100)`.
- `Description` column: `nvarchar(500)`.

### User model (ASP.NET Core Identity)

The application uses the built-in `IdentityUser` class from ASP.NET Core Identity. No custom user entity is needed. The `IdentityUser` provides:

- `Id` (string, GUID)
- `UserName`
- `Email`
- `NormalizedEmail`
- Password hash, security stamp, and other Identity fields

Additional user profile information (display name) is stored in Identity claims.

### Planned Product entity (for lab exercise reference)

The following entity definition is **not included in the starter application** but represents the feature that learners add during the lab exercise. It is documented here to inform design decisions that ensure the starter app supports the planned extension.

| Property | Type | Constraints | Description |
|---|---|---|---|
| `Id` | `int` | Primary key, auto-increment | Unique identifier |
| `Name` | `string` | Required, max length 200 | Product display name |
| `Sku` | `string` | Required, max length 50 | Stock Keeping Unit identifier |
| `Description` | `string` | Max length 1000 | Product description |
| `Price` | `decimal` | Required, precision 18,2 | Unit price |
| `StockQuantity` | `int` | Required, default 0 | Current stock level |
| `CategoryId` | `int` | Foreign key to Category | Associated category |
| `Category` | `Category` | Navigation property | Category reference |
| `CreatedDate` | `DateTime` | Set on creation | Timestamp (UTC) |
| `LastUpdatedDate` | `DateTime` | Updated on modification | Timestamp (UTC) |

> **Design note**: The Category entity intentionally does **not** include a `Products` navigation collection in the starter application. When learners add the Product entity during the lab, the Copilot agents will need to determine whether to add this reverse navigation property as part of their implementation plan.

---

## 7. Database Configuration

### DbContext (`ContosoInventory.Server/Data/InventoryContext.cs`)

```csharp
public class InventoryContext : IdentityDbContext<IdentityUser>
{
    public DbSet<Category> Categories { get; set; } = null!;

    public InventoryContext(DbContextOptions<InventoryContext> options)
        : base(options) { }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.Entity<Category>(entity =>
        {
            entity.HasKey(c => c.Id);
            entity.Property(c => c.Name).IsRequired().HasMaxLength(100);
            entity.Property(c => c.Description).IsRequired().HasMaxLength(500);
            entity.HasIndex(c => c.Name).IsUnique();
        });
    }
}
```

### Connection string

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Data Source=App_Data/ContosoInventory.db"
  }
}
```

The `App_Data` directory must be created at application startup if it doesn't exist. The SQLite database file is created automatically by EF Core when migrations are applied.

### Migrations

- Generate an initial migration named `InitialCreate` that includes the Identity tables and the `Categories` table.
- Apply the migration automatically at startup via `context.Database.Migrate()`.

### Database initialization (`ContosoInventory.Server/Data/DbInitializer.cs`)

The `DbInitializer` class handles:

1. Ensuring the database is migrated.
2. Creating roles (`Admin`, `Viewer`) if they don't exist.
3. Creating seed users if they don't exist.
4. Seeding category data if the `Categories` table is empty.

The initializer is called from `Program.cs` at application startup:

```csharp
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    await DbInitializer.InitializeAsync(services);
}
```

---

## 8. API Endpoints

### Authentication controller (`/api/auth`)

| Method | Route | Authorization | Request Body | Response | Description |
|---|---|---|---|---|---|
| POST | `/api/auth/login` | Anonymous | `LoginDto` | 200: `UserInfoDto` / 401: error message | Authenticates a user and sets the auth cookie |
| POST | `/api/auth/logout` | Authenticated | None | 200: success message | Signs the user out and clears the auth cookie |
| GET | `/api/auth/me` | Authenticated | None | 200: `UserInfoDto` / 401: Unauthorized | Returns the current authenticated user's info |

**Login implementation details**:

- Use `SignInManager<IdentityUser>.PasswordSignInAsync` with `isPersistent: false` and `lockoutOnFailure: false`.
- On successful login, return a `UserInfoDto` containing the user's email, display name, and role.
- On failure, return `Unauthorized` with a generic message: "Invalid email or password."
- Include a 1-second artificial delay on login failure to mitigate timing attacks.

**Logout implementation details**:

- Use `SignInManager<IdentityUser>.SignOutAsync()`.
- Return `Ok` with message "Logged out successfully."

### Categories controller (`/api/categories`)

| Method | Route | Authorization | Request Body | Response | Description |
|---|---|---|---|---|---|
| GET | `/api/categories` | Authenticated | None | 200: `CategoryResponseDto[]` | Returns all categories, ordered by `DisplayOrder` |
| GET | `/api/categories/{id}` | Authenticated | None | 200: `CategoryResponseDto` / 404 | Returns a category by ID |
| POST | `/api/categories` | Admin only | `CreateCategoryDto` | 201: `CategoryResponseDto` / 400 | Creates a new category |
| PUT | `/api/categories/{id}` | Admin only | `UpdateCategoryDto` | 200: `CategoryResponseDto` / 400 / 404 | Updates an existing category |
| DELETE | `/api/categories/{id}` | Admin only | None | 204 / 404 | Deletes a category |
| POST | `/api/categories/{id}/toggle-active` | Admin only | None | 200: `CategoryResponseDto` / 404 | Toggles the `IsActive` status |

**Controller implementation details**:

- Inherit from `ControllerBase` and apply the `[ApiController]` attribute.
- Use `[Route("api/[controller]")]` on the class.
- Apply `[Authorize]` at the class level for all endpoints.
- Apply `[Authorize(Roles = "Admin")]` on POST, PUT, DELETE, and toggle-active endpoints.
- Include `[ProducesResponseType]` attributes on all action methods.
- Inject `ICategoryService` through the constructor.
- Include XML documentation comments on all public methods.
- Log requests using `ILogger<CategoriesController>`.

---

## 9. Data Transfer Objects (DTOs)

All DTOs are located in `ContosoInventory.Shared/DTOs/`.

### LoginDto

| Property | Type | Annotations | Description |
|---|---|---|---|
| `Email` | `string` | `[Required]`, `[EmailAddress]` | User's email address |
| `Password` | `string` | `[Required]` | User's password |

### UserInfoDto

| Property | Type | Description |
|---|---|---|
| `Email` | `string` | User's email address |
| `DisplayName` | `string` | User's full name |
| `Role` | `string` | User's role (Admin or Viewer) |

### CategoryResponseDto

| Property | Type | Description |
|---|---|---|
| `Id` | `int` | Category identifier |
| `Name` | `string` | Category name |
| `Description` | `string` | Category description |
| `DisplayOrder` | `int` | Sort order |
| `IsActive` | `bool` | Active status |
| `CreatedDate` | `DateTime` | Creation timestamp |
| `LastModifiedDate` | `DateTime` | Last modification timestamp |

### CreateCategoryDto

| Property | Type | Annotations | Description |
|---|---|---|---|
| `Name` | `string` | `[Required]`, `[StringLength(100, MinimumLength = 2)]` | Category name |
| `Description` | `string` | `[Required]`, `[StringLength(500)]` | Category description |
| `DisplayOrder` | `int` | `[Range(1, 1000)]` | Sort order position |

### UpdateCategoryDto

| Property | Type | Annotations | Description |
|---|---|---|---|
| `Name` | `string` | `[Required]`, `[StringLength(100, MinimumLength = 2)]` | Category name |
| `Description` | `string` | `[Required]`, `[StringLength(500)]` | Category description |
| `DisplayOrder` | `int` | `[Range(1, 1000)]` | Sort order position |
| `IsActive` | `bool` | None | Active status |

---

## 10. Service Layer

### ICategoryService (`ContosoInventory.Server/Services/ICategoryService.cs`)

```csharp
/// <summary>
/// Defines operations for managing inventory categories.
/// </summary>
public interface ICategoryService
{
    /// <summary>
    /// Retrieves all categories ordered by display order.
    /// </summary>
    Task<IEnumerable<CategoryResponseDto>> GetAllCategoriesAsync();

    /// <summary>
    /// Retrieves a category by its unique identifier.
    /// </summary>
    /// <param name="id">The category identifier.</param>
    /// <returns>The category DTO, or null if not found.</returns>
    Task<CategoryResponseDto?> GetCategoryByIdAsync(int id);

    /// <summary>
    /// Creates a new category.
    /// </summary>
    /// <param name="dto">The category creation data.</param>
    /// <returns>The created category DTO.</returns>
    /// <exception cref="InvalidOperationException">Thrown when a category with the same name already exists.</exception>
    Task<CategoryResponseDto> CreateCategoryAsync(CreateCategoryDto dto);

    /// <summary>
    /// Updates an existing category.
    /// </summary>
    /// <param name="id">The category identifier.</param>
    /// <param name="dto">The updated category data.</param>
    /// <returns>The updated category DTO, or null if not found.</returns>
    /// <exception cref="InvalidOperationException">Thrown when a category with the same name already exists.</exception>
    Task<CategoryResponseDto?> UpdateCategoryAsync(int id, UpdateCategoryDto dto);

    /// <summary>
    /// Deletes a category by its unique identifier.
    /// </summary>
    /// <param name="id">The category identifier.</param>
    /// <returns>True if the category was deleted, false if not found.</returns>
    Task<bool> DeleteCategoryAsync(int id);

    /// <summary>
    /// Toggles the active status of a category.
    /// </summary>
    /// <param name="id">The category identifier.</param>
    /// <returns>The updated category DTO, or null if not found.</returns>
    Task<CategoryResponseDto?> ToggleActiveAsync(int id);
}
```

### CategoryService implementation requirements

The `CategoryService` class implements `ICategoryService` and follows these patterns:

- Inject `InventoryContext` and `ILogger<CategoryService>` via constructor.
- Prefix private fields with underscore (`_context`, `_logger`).
- Use `async/await` for all database operations.
- Map between `Category` entities and `CategoryResponseDto` using a private helper method (`MapToDto`).
- Set `CreatedDate` and `LastModifiedDate` to `DateTime.UtcNow` on creation.
- Update `LastModifiedDate` to `DateTime.UtcNow` on any modification.
- Check for duplicate category names (case-insensitive) on create and update, throwing `InvalidOperationException` if a duplicate is found.
- Use structured logging with `ILogger<T>` for significant operations (create, update, delete, toggle).
- Wrap database operations in `try-catch` blocks and log exceptions.
- Use `AsNoTracking()` for read-only queries.

---

## 11. Security Requirements

### Authentication

| Setting | Value |
|---|---|
| Authentication type | ASP.NET Core Identity with cookie-based sessions |
| Cookie name | `.ContosoInventory.Auth` |
| Cookie HttpOnly | `true` |
| Cookie SecurePolicy | `SameAsRequest` (allows HTTP in development) |
| Cookie SameSite | `Strict` |
| Login path | `/api/auth/login` |
| Access denied path | `/api/auth/login` |
| Sliding expiration | `true` |
| Expiration timeout | 30 minutes |

### Authorization

| Role | Capabilities |
|---|---|
| **Admin** | Full CRUD on categories. Create, update, delete, and toggle-active operations. |
| **Viewer** | Read-only access to categories. Can view all categories and individual category details. |

- All API endpoints except login require authentication (`[Authorize]` at the controller level).
- Write operations (POST, PUT, DELETE, toggle-active) require the Admin role (`[Authorize(Roles = "Admin")]`).
- The Blazor client checks the user's role to conditionally display or hide Admin-only UI elements (Add, Edit, Delete buttons).

### CORS configuration

```csharp
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.WithOrigins("https://localhost:5240", "http://localhost:5240")
              .AllowAnyMethod()
              .AllowAnyHeader()
              .AllowCredentials();
    });
});
```

### CSRF protection

- Enable anti-forgery services: `builder.Services.AddAntiforgery()`.
- Apply anti-forgery middleware: `app.UseAntiforgery()`.
- The Blazor WebAssembly client includes anti-forgery tokens in state-changing requests.

### Rate limiting

```csharp
builder.Services.AddRateLimiter(options =>
{
    options.AddFixedWindowLimiter("fixed", limiterOptions =>
    {
        limiterOptions.PermitLimit = 100;
        limiterOptions.Window = TimeSpan.FromMinutes(1);
        limiterOptions.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
        limiterOptions.QueueLimit = 10;
    });
    options.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
});
```

### Security headers middleware

Add the following security headers via custom middleware or inline middleware in `Program.cs`:

| Header | Value |
|---|---|
| `X-Content-Type-Options` | `nosniff` |
| `X-Frame-Options` | `DENY` |
| `X-XSS-Protection` | `0` |
| `Referrer-Policy` | `strict-origin-when-cross-origin` |
| `Content-Security-Policy` | `default-src 'self'; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-eval' 'wasm-unsafe-eval'` |

The CSP allows `unsafe-inline` for styles and `wasm-unsafe-eval` for the Blazor WebAssembly runtime.

### Password requirements

| Setting | Value |
|---|---|
| Minimum length | 8 characters |
| Require uppercase | true |
| Require lowercase | true |
| Require digit | true |
| Require non-alphanumeric | true |

> **Note**: The seed user passwords (`Password123!`) satisfy all of these requirements.

### Input validation

- All DTOs use data annotation attributes for validation (`[Required]`, `[StringLength]`, `[Range]`, `[EmailAddress]`).
- The `[ApiController]` attribute on controllers enables automatic model validation. Invalid requests receive a `400 Bad Request` response with validation error details.
- The service layer performs additional business rule validation (e.g., duplicate name checks).

---

## 12. Frontend (Blazor WebAssembly Client)

### Pages

#### Login page (`/login`)

- Route: `/login`
- Displays a centered login card with the Contoso branding.
- Form fields: Email, Password.
- Submit button: "Sign in".
- On success: redirects to `/` (Home).
- On failure: shows an inline error message.
- Unauthenticated users are redirected to this page automatically.

#### Home page (`/`)

- Route: `/`
- Requires authentication (`[Authorize]`).
- Displays a welcome message with the user's display name.
- Shows category statistics cards:
  - Total categories count
  - Active categories count
  - Inactive categories count
- Includes a "Manage Categories" link/button to navigate to the Categories page.

#### Categories page (`/categories`)

- Route: `/categories`
- Requires authentication (`[Authorize]`).
- Displays a table of all categories with columns: Name, Description, Display Order, Status (active/inactive badge), Actions.
- Admin users see action buttons: Edit, Delete, Toggle Active.
- Admin users see an "Add Category" button above the table.
- Viewer users see the table without action buttons.
- Add/Edit operations use a modal dialog or inline form with validation.
- Delete operations show a confirmation dialog before proceeding.
- The categories table is sorted by `DisplayOrder`.

### Layout

#### MainLayout.razor

- Bootstrap 5.x-based layout.
- Top navigation bar with:
  - Application name/logo: "ContosoInventory".
  - Navigation links: Home, Categories.
  - User display: Shows the current user's name and role badge.
  - Logout button (visible when authenticated).
- Footer with copyright text.

#### NavMenu.razor

- Renders navigation links in the top nav bar.
- Highlights the active page.

### Client services

#### CategoryApiService.cs

- Typed HTTP client registered via `IHttpClientFactory`.
- Methods mirror `ICategoryService`:
  - `GetAllCategoriesAsync()` → GET `/api/categories`
  - `GetCategoryByIdAsync(int id)` → GET `/api/categories/{id}`
  - `CreateCategoryAsync(CreateCategoryDto dto)` → POST `/api/categories`
  - `UpdateCategoryAsync(int id, UpdateCategoryDto dto)` → PUT `/api/categories/{id}`
  - `DeleteCategoryAsync(int id)` → DELETE `/api/categories/{id}`
  - `ToggleActiveAsync(int id)` → POST `/api/categories/{id}/toggle-active`
- Handles HTTP errors and returns appropriate results to the UI.

#### CookieAuthStateProvider.cs

- Custom `AuthenticationStateProvider` implementation.
- Calls `GET /api/auth/me` to determine the current authentication state.
- Caches the authentication state and invalidates it on login/logout.
- Parses user claims (name, email, role) from the API response.

### Styling

- Use Bootstrap 5 classes for layout and components.
- Minimal custom CSS in `app.css`.
- Consistent with Microsoft Learn lab exercise visual style.
- Responsive design that works on both desktop and tablet viewports.

---

## 13. Seed Data

### Users

| Display Name | Email | Password | Role |
|---|---|---|---|
| Mateo Gomez | `mateo@contoso.com` | `Password123!` | Admin |
| Megan Bowen | `megan@contoso.com` | `Password123!` | Viewer |

User creation:

1. Create the `Admin` and `Viewer` roles if they don't exist using `RoleManager<IdentityRole>`.
2. Create each user with `UserManager<IdentityUser>.CreateAsync`.
3. Set the email as confirmed: `user.EmailConfirmed = true`.
4. Assign roles with `UserManager<IdentityUser>.AddToRoleAsync`.
5. Add a `DisplayName` claim with `UserManager<IdentityUser>.AddClaimAsync` for each user.

### Categories

| Id | Name | Description | DisplayOrder | IsActive | CreatedDate | LastModifiedDate |
|---|---|---|---|---|---|---|
| 1 | Laptops & Desktops | Portable and desktop computing devices for employee workstations | 1 | true | 2025-01-15 | 2025-06-01 |
| 2 | Monitors & Displays | Screens, monitors, and display equipment for workstations | 2 | true | 2025-01-15 | 2025-06-01 |
| 3 | Networking Equipment | Routers, switches, access points, and network cables | 3 | true | 2025-01-15 | 2025-06-01 |
| 4 | Peripherals | Keyboards, mice, webcams, headsets, and other accessories | 4 | true | 2025-01-15 | 2025-06-01 |
| 5 | Software Licenses | Operating system, productivity, and developer tool licenses | 5 | true | 2025-01-15 | 2025-06-01 |
| 6 | Printers & Scanners | Printing, scanning, and imaging devices | 6 | true | 2025-01-15 | 2025-06-01 |
| 7 | Storage Devices | External hard drives, USB drives, and NAS devices | 7 | true | 2025-01-15 | 2025-06-01 |
| 8 | Decommissioned | Retired equipment pending disposal or recycling | 8 | false | 2024-03-20 | 2025-09-15 |

> **Note**: Category 8 ("Decommissioned") is seeded as inactive (`IsActive = false`) to provide a meaningful test case for the toggle-active feature during testing.

---

## 14. Application Configuration

### appsettings.json

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Data Source=App_Data/ContosoInventory.db"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning",
      "Microsoft.EntityFrameworkCore": "Warning"
    }
  },
  "AllowedHosts": "*"
}
```

### appsettings.Development.json

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Information",
      "Microsoft.EntityFrameworkCore.Database.Command": "Information"
    }
  }
}
```

### launchSettings.json

```json
{
  "profiles": {
    "ContosoInventory.Server": {
      "commandName": "Project",
      "dotnetRunMessages": true,
      "launchBrowser": true,
      "applicationUrl": "http://localhost:5240",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    }
  }
}
```

> **Note**: The application runs on HTTP (port 5240) in development to simplify the lab setup. HTTPS configuration is omitted to avoid certificate management issues across different platforms and lab environments.

---

## 15. Cross-Platform Considerations

The application must run identically on Windows, macOS, and Linux. The following considerations apply:

### File paths

- Use `Path.Combine()` for all file path construction — never hardcode backslashes.
- The `App_Data` directory should be created using `Directory.CreateDirectory()` at startup.
- The SQLite database path in the connection string (`Data Source=App_Data/ContosoInventory.db`) uses forward slashes, which are valid on all platforms.

### Line endings

- Configure `.gitattributes` to normalize line endings:

    ```gitattributes
    * text=auto
    *.cs text eol=lf
    *.razor text eol=lf
    *.json text eol=lf
    *.md text eol=lf
    *.csproj text eol=lf
    *.sln text eol=lf
    ```

### SQLite

- SQLite is a file-based database that works identically across all platforms.
- No separate database server installation is required.
- The `Microsoft.EntityFrameworkCore.Sqlite` NuGet package includes SQLite native binaries for all supported platforms.

### .NET SDK

- The application targets `net8.0`, which is available on Windows, macOS (x64 and ARM64), and Linux (x64 and ARM64).
- The `.csproj` files should not include platform-specific runtime identifiers.

### Terminal commands

- All terminal commands in the lab instructions use cross-platform syntax compatible with PowerShell (Windows), bash (macOS/Linux), and zsh (macOS).
- Use `dotnet` CLI commands (e.g., `dotnet build`, `dotnet run`) which are consistent across platforms.

---

## 16. Build and Run Instructions

### Prerequisites

- .NET SDK 8.0 or later
- Git 2.48 or later

### Build

From the solution root directory:

```bash
cd ContosoInventory.Server
dotnet build
```

Expected output: Build succeeded with 0 errors.

### Run

```bash
dotnet run
```

Expected output:

- Console output indicates database migration and seeding completed.
- Server starts listening on `http://localhost:5240`.

### First run behavior

On the first run, the application:

1. Creates the `App_Data` directory if it doesn't exist.
2. Applies EF Core migrations to create the SQLite database.
3. Seeds the database with roles, users, and categories.
4. Console output includes messages such as:
   - `Database migrated successfully.`
   - `Roles created: Admin, Viewer.`
   - `Users seeded: mateo@contoso.com (Admin), megan@contoso.com (Viewer).`
   - `Categories seeded: 8 categories.`

### Verification steps

1. Open a browser and navigate to `http://localhost:5240`.
2. The application should display the login page.
3. Sign in with `mateo@contoso.com` / `Password123!`.
4. The Home page should display welcome text and category statistics (8 categories total, 7 active, 1 inactive).
5. Navigate to the Categories page and verify 8 categories are listed.
6. Verify that Admin actions (Add, Edit, Delete, Toggle Active) are visible.
7. Log out and sign in with `megan@contoso.com` / `Password123!`.
8. Navigate to the Categories page and verify that Admin-only action buttons are not visible.
9. Log out.
10. Navigate to `http://localhost:5240/swagger` to verify the Swagger UI displays all API endpoints.

---

## 17. Azure Extension Path

The starter application is designed so that it can be extended to use Azure services with minimal code changes. The following migration paths are supported by the application's architecture:

### SQLite → Azure SQL Database

- Replace the `Microsoft.EntityFrameworkCore.Sqlite` NuGet package with `Microsoft.EntityFrameworkCore.SqlServer`.
- Update the connection string in `appsettings.json` to point to an Azure SQL Database instance.
- Regenerate EF Core migrations for the SQL Server provider.
- No changes to the service layer, controllers, or DTOs are required because the application uses EF Core's provider-agnostic API.

### Local hosting → Azure App Service

- The application can be deployed directly to Azure App Service using `dotnet publish` and standard deployment methods (ZIP deploy, GitHub Actions, Azure DevOps pipelines).
- The Blazor WebAssembly client is served as static files from the server project, so no separate hosting is needed for the frontend.
- Update `launchSettings.json` and `appsettings.Production.json` with Azure-specific configuration.

### Hardcoded secrets → Azure Key Vault

- The connection string and any future secrets can be moved to Azure Key Vault.
- Add the `Azure.Extensions.AspNetCore.Configuration.Secrets` NuGet package.
- Configure the Key Vault provider in `Program.cs`:

    ```csharp
    builder.Configuration.AddAzureKeyVault(
        new Uri("https://your-vault-name.vault.azure.net/"),
        new DefaultAzureCredential());
    ```

### Local Identity → Microsoft Entra ID

- Replace ASP.NET Core Identity with Microsoft Entra ID (formerly Azure AD) authentication.
- Add the `Microsoft.Identity.Web` NuGet package.
- Configure OpenID Connect authentication in `Program.cs`.
- Update the Blazor client to use MSAL.js for token acquisition.

### Monitoring → Application Insights

- Add the `Microsoft.ApplicationInsights.AspNetCore` NuGet package.
- Configure telemetry in `Program.cs`:

    ```csharp
    builder.Services.AddApplicationInsightsTelemetry();
    ```

- Enable distributed tracing, request logging, and custom metrics.

### Static assets → Azure Blob Storage

- Category images or other static assets can be stored in Azure Blob Storage.
- Add the `Azure.Storage.Blobs` NuGet package.
- Create a `BlobStorageService` that implements an `IStorageService` interface.
- Update the Category model to include an optional `ImageUrl` property.

---

## 18. Repository Setup

### Repository details

| Setting | Value |
|---|---|
| Organization | MicrosoftLearning |
| Repository name | `copilot-customization-starter-app` |
| Visibility | Public |
| Default branch | `main` |
| License | MIT |

### Repository root files

| File | Description |
|---|---|
| `README.md` | Project overview, prerequisites, setup instructions, and architecture description |
| `.gitignore` | Standard .NET gitignore (Visual Studio, Rider, VS Code, bin/obj, App_Data/*.db) |
| `.gitattributes` | Line ending normalization (see Cross-Platform Considerations) |
| `LICENSE` | MIT license |
| `ContosoInventory.sln` | Solution file |

### README.md content outline

1. **ContosoInventory** — brief description.
2. **Prerequisites** — .NET 8.0 SDK, Git.
3. **Getting Started** — clone, build, run instructions.
4. **Demo Credentials** — Mateo (Admin) and Megan (Viewer) credentials.
5. **Project Structure** — three-project architecture overview.
6. **API Documentation** — link to Swagger at `/swagger`.
7. **License** — MIT.

### .gitignore entries

Include standard .NET entries plus:

```gitignore
# SQLite database files
App_Data/*.db
App_Data/*.db-shm
App_Data/*.db-wal

# User secrets
secrets.json
```

---

## 19. Verification Checklist

After building the application, verify the following before publishing:

### Build verification

- [ ] `dotnet build` succeeds with 0 errors from the Server project directory.
- [ ] `dotnet build` succeeds with 0 errors for all three projects (Server, Client, Shared).

### Runtime verification

- [ ] First run creates the SQLite database and seeds all data.
- [ ] Login page loads at `http://localhost:5240`.
- [ ] Mateo (Admin) can sign in with `mateo@contoso.com` / `Password123!`.
- [ ] Megan (Viewer) can sign in with `megan@contoso.com` / `Password123!`.
- [ ] Home page shows correct category statistics (8 total, 7 active, 1 inactive).
- [ ] Categories page displays all 8 categories sorted by display order.

### CRUD verification (Admin user)

- [ ] Create: Adding a new category succeeds and appears in the list.
- [ ] Read: Viewing category details shows all fields.
- [ ] Update: Editing a category's name, description, or display order saves correctly.
- [ ] Delete: Deleting a category removes it from the list.
- [ ] Toggle: Toggling "Decommissioned" category changes it to active, and toggling again changes it back to inactive.

### Authorization verification

- [ ] Viewer user (Megan) can view categories but cannot see Add, Edit, Delete, or Toggle Active buttons.
- [ ] Unauthenticated API requests to `/api/categories` return 401.
- [ ] Viewer API requests to POST/PUT/DELETE `/api/categories` return 403.
- [ ] Login with incorrect credentials returns 401 with generic error message.

### API verification

- [ ] Swagger UI loads at `http://localhost:5240/swagger`.
- [ ] All endpoints are documented in Swagger (Auth and Categories controllers).
- [ ] API responses use DTOs (no raw entity properties like navigation properties leak through).

### Cross-platform verification

- [ ] Application builds and runs on Windows.
- [ ] Application builds and runs on macOS.
- [ ] Application builds and runs on Linux.

### Security verification

- [ ] Auth cookies are set with HttpOnly, SameSite=Strict.
- [ ] Security headers (X-Content-Type-Options, X-Frame-Options) are present in responses.
- [ ] Invalid model state returns 400 with validation details.
- [ ] Rate limiting returns 429 when exceeded.

---

## 20. Program.cs Configuration Reference

The `Program.cs` file for the Server project configures the application in the following order:

### Service registration (builder.Services)

1. **Controllers**: `builder.Services.AddControllers()`
2. **Swagger**: `builder.Services.AddEndpointsApiExplorer()` and `builder.Services.AddSwaggerGen()`
3. **EF Core**: `builder.Services.AddDbContext<InventoryContext>(options => options.UseSqlite(connectionString))`
4. **Identity**: `builder.Services.AddIdentity<IdentityUser, IdentityRole>(options => { ... }).AddEntityFrameworkStores<InventoryContext>()`
5. **Cookie configuration**: `builder.Services.ConfigureApplicationCookie(options => { ... })`
6. **CORS**: `builder.Services.AddCors(options => { ... })`
7. **Rate limiting**: `builder.Services.AddRateLimiter(options => { ... })`
8. **Anti-forgery**: `builder.Services.AddAntiforgery()`
9. **Application services**: `builder.Services.AddScoped<ICategoryService, CategoryService>()`

### Middleware pipeline (app.Use...)

1. `app.UseSwagger()` / `app.UseSwaggerUI()` (development only)
2. Security headers middleware
3. `app.UseHttpsRedirection()` (if configured)
4. `app.UseBlazorFrameworkFiles()`
5. `app.UseStaticFiles()`
6. `app.UseRouting()`
7. `app.UseCors()`
8. `app.UseRateLimiter()`
9. `app.UseAuthentication()`
10. `app.UseAuthorization()`
11. `app.UseAntiforgery()`
12. `app.MapControllers()`
13. `app.MapFallbackToFile("index.html")`

### Database initialization

After `app` is built, before `app.Run()`:

```csharp
// Ensure App_Data directory exists
var appDataPath = Path.Combine(app.Environment.ContentRootPath, "App_Data");
Directory.CreateDirectory(appDataPath);

// Initialize database
using (var scope = app.Services.CreateScope())
{
    await DbInitializer.InitializeAsync(scope.ServiceProvider);
}

app.Run();
```

---

*End of specification.*
