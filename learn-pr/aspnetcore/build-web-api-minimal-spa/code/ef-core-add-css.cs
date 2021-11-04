   import React, { useState } from "react";
   <b>import styled from "styled-components";</b>

   const PizzaFrame = styled.div\`
        &nbsp;border: solid 1px gray;
        &nbsp;padding: 10px;
        &nbsp;margin: 15px 10px;
        &nbsp;border-radius: 5px;
        &nbsp;box-shadow: 0 0 5px grey;
        &nbsp;font-family: Arial;
    `;

    const Input = styled.input\`
     &nbsp;border: solid 1px black;
      &nbsp;padding: 5px;
      &nbsp;border-radius: 3px;
    `;

    const Title = styled(Input)\`
      &nbsp;text-transform: uppercase;
    `;

    const Save = styled.button\`
      &nbsp;width: 100px;
      &nbsp;margin: 10px;
      &nbsp;background: green;
      &nbsp;color: white;
      &nbsp;font-size: 16px;
      &nbsp;padding: 10px;
      &nbsp;border-radius: 5px;
    `;

    let pizzas = [{
    &nbsp;id: 1, name: 'Cheese pizza', description: 'very cheesy'
    },
    {
    &nbsp;id: 2, name: 'Al Tono pizza', description: 'lots of tuna'
    }];

    const Pizza = ({ pizza }) => {
      &nbsp;const [data, setData] = useState(pizza);
      &nbsp;const [dirty, setDirty] = useState(false);

      function update(value, fieldName, obj) {
      &nbsp;setData({ ...obj, [fieldName] : value });
      &nbsp;setDirty(true);
      }

      function onSave() {
      &nbsp;setDirty(false);
      &nbsp;// make rest call
      }

      return (<React.Fragment>
        &nbsp;<b>&lt;PizzaFrame></b>
        &nbsp;&lt;h3>
          &nbsp;<b><Title onChange={(evt) => update(evt.target.value, 'name', data)} value={data.name} /></b> 
        &nbsp;&lt;/h3>
        <div>
          &nbsp;<b>&lt;Input onChange={(evt) => update(evt.target.value, 'description', data)} value={data.description} /></b>
        </div>
        {dirty ? 
         &lt;div><b>&lt;Save onClick={onSave}>Save&lt;/Save></b>&lt;/div> : null
        }
        &nbsp;<b>&lt;/PizzaFrame></b>
      </React.Fragment>);
    }

    const Main = () => {
      const data = pizzas.map(pizza => <Pizza pizza={pizza} />)

      return (<React.Fragment>
        {data}
      </React.Fragment>)
    }

    export default Main;
