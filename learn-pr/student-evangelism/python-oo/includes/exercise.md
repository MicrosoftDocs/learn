## Moving from procedural to OO

- procedural, what is it. What does it look like

 variables, functions, simpler program, POS file ?

```output
Order  ItemId  Quantity Price
1      11      1        100
1      11      1        50
1      10      1        30
2      13      2        100
```

row_id
row_item_id
row_quantity
row_price

load_row() # ()
load_by_id(id) # [(),(),()]
create_row()
update_row()
remove_row()

### OO analysis

OO has the notion of grouping things together, thinks about the world differently. Given the same file:

```output
Order  ItemId  Quantity Price
1      11      1        100
1      11      1        50
1      10      1        30
2      13      2        100
```

What do I see?

- What is the bigger context?

   ```bash
   Order, order items, managing orders, creating updating, removing orders
   ```

- What properties does it have?

   ```bash
   Order
     id
     order_items (orderId, itemId, quantity, price)
   ```

- Can I anticipate useful info based on that?

   Yes I can, specific_items, total, quantity_total 

   ```bash
   Order
     id
     order_items (orderId, itemId, quantity, price)
     specific_items 
     total
     quantity_total 
   ```

Could I have gotten here with procedural, yes, but people think in Objects and we reason in objects and when we do we assign not only what we see but we are able to anticipate what we might need from it.
