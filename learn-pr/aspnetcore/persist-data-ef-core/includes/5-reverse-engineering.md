## Promotions database

1. Open Promotions.db
1. View Coupons table

## Scaffold the Coupon model

1. Run scaffold command

    ```dotnetcli
    dotnet ef dbcontext scaffold ... --context-dir Data --output-dir Models
    ```

1. Inspect the files

> [!TIP]
> New scaffolded files can be generated if the database changes. However, be aware that any manual changes you've made to the original scaffolded files will need to be recreated in the replacement files.

## Wire it up

1. Add PromotionContext to DI
1. app.MapGet to get a ref to PromotionContext and serialize all coupons

## Test it

1. HTTP Repl