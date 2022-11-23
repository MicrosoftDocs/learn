It’s critical that your model enforces data permissions correctly and efficiently. The following list provides you with good development practices to apply.

- Strive to define fewer datasets (data models) with well-designed roles.

- Strive to create fewer roles by using dynamic rules. A data-driven solution is easier to maintain because you don’t need to add new roles.

- When possible, create rules that filter dimension tables instead of fact tables. It will help to deliver faster query performance.

- Validate that the model design, including its relationships and relationship properties, are correctly set up.

- Use the `USERPRINCIPALNAME` function instead of `USERNAME` function. It provides consistency when validating the roles in Power BI Desktop and the Power BI service.

- Rigorously validate RLS and OLS by testing all roles.

- Ensure that the Power BI Desktop data source connection uses the same credentials that will be applied when set up in the Power BI service.