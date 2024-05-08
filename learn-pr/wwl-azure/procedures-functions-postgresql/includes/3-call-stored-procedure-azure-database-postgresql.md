To call a stored procedure, use the CALL keyword. Any defined input parameters must be passed to the stored procedure, unless the parameter is defined with a default value.

For example, the **myprocedure** stored procedure makes it easier to insert data into a table.

```sql
CALL insert_data (1, 2);
```

In this example, **myprocedure** is used to insert just two values into a table. As the table structure gets more complicated, and you want to include error checking, the body of the stored procedure would be more complicated. But, the user's call would still just need to pass the required parameters. In this way, any complexity is hidden from the user, making the insert procedure easier.

For stored procedures with many input parameters, you can specify the name of parameter to make your code easier to read, and reduce errors. The syntax is:

```sql
name => value
```

For example:

```sql
CALL new_exhibit
    (
        prm_enc_id => 21,
        prm_enclosure => 'West Enclosure',
        prm_number_of_animals => 5,
        prm_animal_name => 'Lemur',
        prm_weight_kg => 5.0,
        prm_cat_id => 8
    );
```
