You want to create an application which allows a user to create bookings on a cruise to the moon. Over the course of a couple of exercises, you will create a component for the form the user will complete, to create a booking, and another to display the list of created bookings. The first component you will create, will host both of child components.

## Install Visual Studio Code extensions

Visual Studio Code has numerous extensions the [marketplace](https://marketplace.visualstudio.com/vscode/?azure-portal=true) to aid you in your development endeavors. We will take advantage of two:

- [Vetur](https://marketplace.visualstudio.com/items?itemName=octref.vetur/?azure-portal=true) which enables support for *.vue* files in Visual Studio Code.
- [Vue VSCode Snippets](https://marketplace.visualstudio.com/items?itemName=sdras.vue-vscode-snippets/?azure-portal=true) from Sarah Drasner to enable snippets in Visual Studio Code.

1. Inside Visual Studio Code, open the *Extensions* workbench.
    ![Screenshot of the extensions icon.](./images/extensions.png)
1. Type *Vue VSCode Snippets* into the search dialog.
1. Press *Install* under *Vue VSCode Snippets* to install both *Vue VSCode Snippets* and *Vetur*.
    ![Screenshot of search results for Vue VSCode Snippets.](./images/snippets.png)

## Create the Host component

Let's create the *Host* component.

1. Inside *src/components*, create a new file named *Host.vue*.
1. Inside *Host.vue*, type `vue`, and select *\<vue\> with default.vue* from the snippets menu.
    ![Screenshot of the snippets menu with \<vue\> with default.vue selected.](./images/vue-create.png)
    The default structure will be created by the snippet.

## Update the script section

The snippet creates the `script` element for us with `export default` already created. `export default` allows this component to be loaded by another component in Vue. We will add the needed code into this section.

1. Inside the curly braces (`{ }`) of `export default`, add the following code to name the component, register our data, and add two comments for the future:

    ```javascript
    name: 'Host',
    data() {
        return {
            cruise: {
                name: 'Cruise to the moon',
                description: 'Cruise to the moon in our luxurious shuttle. Watch the astronauts working outside the International Space Station.',
                cabins: [
                    { name: 'Coach', price: 125000 },
                    { name: 'Business', price: 275000 },
                    { name: 'First', price: 430000 },
                ]
            },
            bookings: [
                { name: 'Sample', price: 0 }
            ]
        }
    },

    // TODO: Add components

    // TODO: Add methods

    ```

    The `name` field sets the name of the component. `data()` registers the `cruise` object as data for the component, and `bookings` which we will use later to store a list of cruise bookings. The three `TODO` comments will serve as markers for the future.

    > [!NOTE]
    > `TODO` comments are a great way to place notes in your code of tasks which need to be completed later.

## Add the template

With our data registered, let's add the HTML to the `template` element to display the core information. We will also add a couple of placeholders for the future.

1. Inside the `template` element in *Host.vue*, add the following HTML to display the name and description of the cruise, as well as a placeholder for two components we will create later:

    ```html
    <section>
    <div class="nav-bar"></div>
    <h1>Relecloud Galaxy Tours</h1>

    <div>
        <h2>{{ cruise.name }}</h2>
        <div>{{ cruise.description }}</div>
        <hr />

        <div class="row">
            <div>
                <!-- TODO: Add booking-form -->

            </div>
            <div>
                <!-- TODO: Add booking-list -->

            </div>
        </div>
    </div>
    </section>
    ```

## Add the style

With the HTML created, let's add the style for our application.

Inside the `style` element inside *Host.vue*, add the following CSS:

    ```css
    body {
        background-color: #f2f2f2;
        margin: 0, 5%;
        font-family: tahoma;
    }

    .row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        vertical-align: middle;
        margin: 2em;
    }

    .button {
        background-color: #39495c;
        border-radius: 5px;
        color: white;
        text-align: center;
    }

    .nav-bar {
        background: linear-gradient(-50deg, #010801, #0d0d60);
        height: 60px;
        margin-bottom: 25px;
    }
    ```

    This will add a little bit of structure and color to our application.

## Set the Host component as the entry point into the application

Vue CLI creates a *main.js* file which loads *App.vue* as the entry point into the application. We created a new component called *Host* for this purpose. We will update *main.js* to use our component.

Open *main.js* and *replace* the contents with the following:

    ```javascript
    import { createApp } from 'vue'
    import Host from './components/Host.vue'

    createApp(Host).mount('#app')
    ```

## Test the application

With our component created and the script updated, let's test the page.

1. Save all files by selecting *File* > *Save all*.
1. Return to your browser and refresh the tab displaying `http://localhost:8080`
1. Your updated page will now display:

    ![Screenshot of Host component displaying the name and description of the cruise.](./images/host-component.png)

You have now created your first single-file component in Vue.js!
