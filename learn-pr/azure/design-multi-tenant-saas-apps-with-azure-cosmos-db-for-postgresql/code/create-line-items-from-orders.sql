-- Create line_items data from existing orders
DO $$
    DECLARE
		ord record;
        prod_id bigint;
        prod_price numeric;
        quantity int;
        line_amt numeric;
		prod_count bigint;
		line_id bigint;
	BEGIN
    FOR ord IN (SELECT order_id, store_id FROM orders ORDER BY order_id) LOOP
		-- Insert 1-3 line items for the order
        FOR i IN 1..floor(random() * (3) + 1) LOOP
			-- Retrieve a random product associated with the selected store.
			prod_count := (SELECT count(*) FROM products WHERE store_id = ord.store_id);
            prod_id = (SELECT product_id FROM products WHERE store_id = ord.store_id OFFSET floor(random() * prod_count) LIMIT 1);
            prod_price = (SELECT price FROM products WHERE product_id = prod_id);
            quantity = floor(random() * (4) + 1);
            line_amt = prod_price * quantity;
			line_id := (SELECT CASE WHEN MAX(line_item_id) ISNULL THEN 1 ELSE MAX(line_item_id)+1 END FROM line_items);
			-- Insert a new line item
			INSERT INTO line_items (line_item_id, product_id, order_id, quantity, line_amount)
			VALUES(line_id, prod_id, ord.order_id, quantity, line_amt);
        END LOOP;
		COMMIT;
    END LOOP;
END $$;
