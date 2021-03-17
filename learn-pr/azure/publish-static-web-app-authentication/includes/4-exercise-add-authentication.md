Your shopping list web app needs user authentication. In this exercise, you'll implement login and logout in your app, and display the current user login status. 

In this exercise, you'll complete the following steps:

1. Install the Static Web Apps CLI for local development.
1. Run the app and API locally with local authentication emulation.
1. Add login buttons for multiple authentication providers.
1. Add a logout button if the user is logged in.
1. Display the login status of the user.
1. Test the authentication workflow locally.
1. Deploy the updated app.

## Prepare for local development

The Static Web Apps CLI, also known as SWA CLI, is a local development tool that allows you to run your web app and API locally and emulate authentication and authorization servers.

1. Open a terminal on your computer.
1. Install the CLI using this command:

    ```bash
    npm install -g @azure/static-web-apps-cli
    ```
    
## Run the app locally

We'll now run the app and API locally with a development server. This way you'll be able to see and test your changes, as your make them in the code.

1. Open the project in Visual Studio Code.
1. In Visual Studio Code, open the command palette by pressing <kbd>F1</kbd>
1. Type and select **Terminal: Create New Integrated Terminal**
1. Go to the folder of your preferred front-end framework, as shown below:

   ::: zone pivot="angular"

   ```bash
   cd angular-app
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   cd react-app
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   cd svelte-app
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   cd vue-app
   ```

   ::: zone-end

1. Run the front-end client application using a development server.

   ::: zone pivot="angular"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   npm run dev
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   npm run serve
   ```

   ::: zone-end

Leave this server running in the background. We'll now run the API and authentication server emulator using the SWA CLI.

1. In Visual Studio Code, open the command palette by pressing <kbd>F1</kbd>
1. Type and select **Terminal: Create New Integrated Terminal**
1. Run the SWA CLI using this command:

   ::: zone pivot="angular"

   ```bash
   swa start http://localhost:4200 --api ./api
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   swa start http://localhost:3000 --api ./api
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   swa start http://localhost:5000 --api ./api
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   swa start http://localhost:8080 --api ./api
   ```

   ::: zone-end

1. Browse to `http://localhost:4280`

Now let the application running while we modify the code.

## Get the user login status

First, we need to access the user login status by making a query to `/.auth/me` in the client.

::: zone pivot="angular"

1. Create the file `angular-app/src/app/core/models/user-info.ts`:

   ```typescript
    export interface UserInfo {
      identityProvider: string;
      userId: string;
      userDetails: string;
      userRoles: string[];
    }
    ```

1. Edit the file `angular-app/src/app/core/components/nav.component.ts` and add this method in the `NavComponent` class:

    ```typescript
    async getUserInfo() {
      try {
        const response = await fetch('/.auth/me');
        const payload = await response.json();
        const { clientPrincipal } = payload;
        return clientPrincipal;
      } catch (error) {
        console.error('No profile could be found');
        return undefined;
      }
    }
    ```

1. Create a new class property `userInfo` and store the result of `getUserInfo()` when the component is initialized. For that, you also need to implement the `OnInit` interface and update the imports:

    ```typescript
    import { Component, OnInit } from '@angular/core';
    import { UserInfo } from '../model/user-info';
    ...
    export class NavComponent implements OnInit {
        userInfo: UserInfo;

        async ngOnInit() {
          this.userInfo = await this.getUserInfo();
        }
        ...
    }
    ```

    When the component is created, the user information is fetched automatically.

1. Finally, add this at the bottom of the template to display the login status.
    
    ```html
    <div class="user" *ngIf="userInfo">
      <p>Welcome</p>
      <p>{{ userInfo?.userDetails }}</p>
      <p>{{ userInfo?.identityProvider }}</p>
    </div>
    ```
    
::: zone-end

::: zone pivot="react"

```bash
```

::: zone-end

::: zone pivot="svelte"

```bash
```

::: zone-end

::: zone pivot="vue"

```bash
```

::: zone-end

## Add login and logout buttons

The user information will be `null` if we are not logged in. It's now time to add login buttons for the different providers.

::: zone pivot="angular"

1. Edit the file `angular-app/src/app/core/components/nav.component.ts` to add a list of providers in the `NavComponent` class:

    ```typescript
    providers = ['twitter', 'github', 'aad', 'google', 'facebook'];
    ```

1. Add the `redirect` property just below, to capture the current URL for the post login redirection:

    ```typescript
    redirect = window.location.pathname;
    ```

1. Add this at the bottom of the template to display the login and logout buttons.

    ```typescript
    <nav class="menu auth">
      <p class="menu-label">Auth</p>
      <div class="menu-list auth">
        <ng-container *ngIf="!userInfo; else logout">
          <ng-container *ngFor="let provider of providers">
            <a href="/.auth/login/{{provider}}?post_login_redirect_uri={{redirect}}">{{provider}}</a>
          </ng-container>
        </ng-container>
        <ng-template #logout>
          <a href="/.auth/logout?post_logout_redirect_uri={{redirect}}">Logout</a>
        </ng-template>
      </div>
    </nav>
    ```

    If the user is not logged in, we display the login button for each provider. Each button links to `/.auth/login/<AUTH_PROVIDER>` and set the redirection URL to the current page.

    Otherwise if the user is already logged in, we display a logout button that links to `/.auth/logout` adn also set the redirection URL to the current page.

You should now see this in your browser:

:::image type="content" source="../media/my-shopping-list-app-angular.png" alt-text="Angular web app with login buttons":::
    
::: zone-end

::: zone pivot="react"

```bash
```

::: zone-end

::: zone pivot="svelte"

```bash
```

::: zone-end

::: zone pivot="vue"

```bash
```

::: zone-end

## Display the user login status

Before testing our authentication workflow, let's display the user details about the logged in user.

::: zone pivot="angular"

1. Edit the file `angular-app/src/app/core/components/nav.component.ts` and add this at the bottom of the template:

    ```html
    <div class="user" *ngIf="userInfo">
      <p>Welcome</p>
      <p>{{ userInfo?.userDetails }}</p>
      <p>{{ userInfo?.identityProvider }}</p>
    </div>
    ```

    Note that the `userDetails` property can be either a username or email address, depending of the identity provided used to log in.

Your completed file should now look like this:

```typescript
import { Component, OnInit } from '@angular/core';
import { UserInfo } from '../model/user-info';

@Component({
  selector: 'app-nav',
  template: `
    <nav class="menu">
      <p class="menu-label">Menu</p>
      <ul class="menu-list">
        <a routerLink="/products" routerLinkActive="router-link-active">
          <span>Products</span>
        </a>
        <a routerLink="/about" routerLinkActive="router-link-active">
          <span>About</span>
        </a>
      </ul>
    </nav>
    <nav class="menu auth">
      <p class="menu-label">Auth</p>
      <div class="menu-list auth">
        <ng-container *ngIf="!userInfo; else logout">
          <ng-container *ngFor="let provider of providers">
            <a href="/.auth/login/{{provider}}?post_login_redirect_uri={{redirect}}">{{provider}}</a>
          </ng-container>
        </ng-container>
        <ng-template #logout>
          <a href="/.auth/logout?post_logout_redirect_uri={{redirect}}">Logout</a>
        </ng-template>
      </div>
    </nav>
    <div class="user" *ngIf="userInfo">
      <p>Welcome</p>
      <p>{{ userInfo?.userDetails }}</p>
      <p>{{ userInfo?.identityProvider }}</p>
    </div>
  `,
})
export class NavComponent implements OnInit {
  providers = ['twitter', 'github', 'aad', 'google', 'facebook'];
  redirect = window.location.pathname;
  userInfo: UserInfo;

  async ngOnInit() {
    this.userInfo = await this.getUserInfo();
  }

  async getUserInfo() {
    try {
      const response = await fetch('/.auth/me');
      const payload = await response.json();
      const { clientPrincipal } = payload;
      return clientPrincipal;
    } catch (error) {
      console.error('No profile could be found');
      return undefined;
    }
  }
}
```
    
::: zone-end

::: zone pivot="react"

```bash
```

::: zone-end

::: zone pivot="svelte"

```bash
```

::: zone-end

::: zone pivot="vue"

```bash
```

::: zone-end

## Test authentication locally

Everything is now in place, the final step is to test if everything is working as expected.

1. In your web app, select one of the identity providers to log in.
1. You will be redirected to this page:

    :::image type="content" source="../media/swa-cli-auth-screen.png" alt-text="Screenshot showing SWA CLI fake authentication screen":::

    This is a fake authentication screen provided by the SWA CLI, allowing you to test authentication locally by providing yourself user details.

1. Enter `mslearn` as username and `1234` for the user ID.
1. Select **Login**.

After the login, you are redirected to the previous page. You can notice this time that the different login buttons have been replaced by a logout button. You can also see your username and the selected provider below the logout button.

## Deploy your changes

1. In Visual Studio Code, open the command palette by pressing <kbd>F1</kbd>
1. Type and select **Git: Commit All**
1. Enter `Add authentication` as the commit message.
1. Press <kbd>Enter</kbd>
1. Open the command palette by pressing <kbd>F1</kbd>
1. Type and select **Git: Push**
1. Press <kbd>Enter</kbd>

