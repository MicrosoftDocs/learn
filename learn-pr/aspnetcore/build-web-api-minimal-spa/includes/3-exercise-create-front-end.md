In this exercise, you build the front-end app. You start with a scaffold, and then you build out the view you need and add data to the app.

## Scaffold an app

To scaffold an app, you use the `Vite` scaffolder. By using `npx`, you can call the scaffolder and have it create a working React app in a matter of seconds.

1. In a command terminal (with all the prerequisites installed), create the app by using `npx create vite@latest pizza-web --template react`:

    ```bash
    npx create vite@latest pizza-client --template react
    ```

    What you get is a directory, _pizza-web_, that contains your scaffolded React app.

1. Start the app by calling `npm run dev`:

   ```bash
   cd pizza-client
   npm run dev
   ```

1. In your browser, go to `http://localhost:5173`.

   You should see the page render like this example:

   :::image type="content" source="../media/react.png" alt-text="Screenshot that shows a rendered SPA app.":::

   Press **Ctrl+C** to end execution.

## Build the Pizza component

Build the parent component that manages state for the pizza list.

1. Open the app directory in Visual Studio Code.

   ```bash
   code .
   ```

1. Create a file in the _src_ subdirectory named  _Pizza.jsx_ and give it the following content:

    ```javascript
    import { useState, useEffect } from 'react';
    import PizzaList from './PizzaList';
    
    const term = "Pizza";
    const API_URL = '/pizza';
    const headers = {
      'Content-Type': 'application/json',
    };
    
    type PizzaType = {
      id: string;
      name: string;
      description: string;
    };
    
    function Pizza() {
      const [data, setData] = useState<PizzaType[]>([]);
      const [error, setError] = useState(null);
    
      useEffect(() => {
        fetch(API_URL)
          .then(response => response.json())
          .then(data => setData(data))
          .catch(error => setError(error));
      }, []);
    
      const handleCreate = (item) => {
    
        console.log(`add item: ${JSON.stringify(item)}`)
    
        fetch(API_URL, {
          method: 'POST',
          headers,
          body: JSON.stringify({ ...item } as PizzaType),
        })
          .then(response => response.json())
          .then(returnedItem => setData([...data, returnedItem] as any[]))
          .catch(error => setError(error));
      };
    
      const handleUpdate = (updatedItem) => {
    
        console.log(`update item: ${JSON.stringify(updatedItem)}`)
    
        fetch(`${API_URL}/${updatedItem.id}`, {
          method: 'PUT',
          headers,
          body: JSON.stringify(updatedItem),
        })
          .then(() => setData(data.map(item => item.id === updatedItem.id ? updatedItem : item)))
          .catch(error => setError(error));
      };
    
      const handleDelete = (id) => {
        fetch(`${API_URL}/${id}`, {
          method: 'DELETE',
          headers,
        })
          .then(() => setData(data.filter(item => item.id !== id)))
          .catch(error => console.error('Error deleting item:', error));
      };
    
      return (
        <div>
          <PizzaList
            name={term}
            data={data}
            error={error}
            onCreate={handleCreate}
            onUpdate={handleUpdate}
            onDelete={handleDelete}
          />
        </div>
      );
    }
    
    export default Pizza;
    ```

    This component is responsible for fetching the data from the back end and passing it to the `PizzaList` component. It also handles the `create`, `update`, and `delete` operations. This component has no visible UI. The `PizzaList` component renders the UI.

    The `Pizza` component uses the `useState` and `useEffect` hooks to manage state. The `useState` hook is used to manage the `data` and `error` state. The `useEffect` hook is used to fetch the data from the back end on the initial page request. The `Pizza` component passes the `data` and `error` state to the `PizzaList` component.

## Build a Pizza list component

Create a file in the _src_ subdirectory named  _PizzaList.js_ and give it the following content:

```javascript
import { useState, useEffect } from 'react';

function PizzaList({ name, data, onCreate, onUpdate, onDelete, error }) {

    console.log(`PizzaList: ${JSON.stringify(data)}`);
    
    const [formData, setFormData] = useState({ id: '', name: '', description: '' });
    const [editingId, setEditingId] = useState(null);
    
    useEffect(() => {
       if (editingId === null) {
          setFormData({ id: '', name: '', description: '' });
       } else {
          const currentItem = data.find(item => item.id === editingId);
          setFormData(currentItem);
       }
    }, [editingId, data]);
    
    const handleFormChange = (event) => {
    
       console.log(`handleFormChange: ${event.target.name} ${event.target.value}`)
    
       const { name, value } = event.target;
       setFormData(prevData => ({
          ...prevData,
          [name]: value,
       }));
    };
    
    const handleSubmit = (event) => {
       event.preventDefault();
    
       console.log(`formData: ${JSON.stringify(formData)}`)
    
       if (editingId !== null) {
          console.log(`update item: ${JSON.stringify(formData)}`)
          onUpdate(formData);
       } else {
          console.log(`crreate item: ${JSON.stringify(formData)}`)
          onCreate(formData);
       }
    
       setFormData({ id: '', name: '', description: '' });
       setEditingId(null);
    };
    
    const handleEdit = (item) => {
       console.log(`edit item: ${JSON.stringify(item)}`)
       setEditingId(item.id);
    };
    
    const handleCancelEdit = () => {
       console.log(`cancel edit`)
       setEditingId(null);
    };
    
    const handleDelete = (id) => {
       console.log(`delete item: ${id}`)
       onDelete(id);
    };
    
    return (
       <div>
          <h2>New {name}</h2>
          <form onSubmit={handleSubmit}>
          <input
             type="text"
             name="name"
             placeholder="Name"
             value={formData.name}
             onChange={handleFormChange}
          />
          <input
             type="text"
             name="description"
             placeholder="Description"
             value={formData.description}
             onChange={handleFormChange}
          />
          <button type="submit">{editingId !== null ? 'Update' : 'Create'}</button>
          {editingId !== null && <button type="button" onClick={handleCancelEdit}>Cancel</button>}
          </form>
          {error && <div>{error}</div>}
    
          <h2>{name}s</h2>
          <ul>
          {data.map(item => (
             <li key={item.id}>
                <div>{item.id}: {item.name} - {item.description}</div>
                <div>
                <button onClick={() => handleEdit(item)}>Edit</button>
                <button onClick={() => handleDelete(item.id)}>Delete</button>
                </div>
             </li>
          ))}
          </ul>
       </div>
    );
}

export default PizzaList;
```

This component is responsible for rendering the list of pizzas. It also handles the `create`, `update`, and `delete` actions submitted by the user.

## What you have at this point are two components:

- **Pizza:** This component manages the state of the data and manages API calls.
- **PizzaList:** This component renders the data and allows users to interact with it.
