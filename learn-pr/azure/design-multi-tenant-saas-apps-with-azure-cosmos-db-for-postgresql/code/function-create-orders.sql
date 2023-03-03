CREATE OR REPLACE FUNCTION create_orders(batch_size int)
RETURNS void 
LANGUAGE plpgsql
AS
$$
DECLARE
	ord_id bigint;
	st_id bigint;
	prod_id bigint;
	prod_price numeric;
	quantity int;
	line_amt numeric;
	store_count bigint := (SELECT COUNT(*) FROM stores);
	product_count bigint;
BEGIN
	FOR j IN 1..batch_size LOOP
		-- Retrieve a random store, skewing to store_id 5.
		IF j % 3 = 0 THEN
			st_id := 5;
		ELSE
			st_id := floor(random() * store_count + 1);
		END IF;

		ord_id := (SELECT nextval('orders_order_id_seq'));

		-- Insert a new order
		INSERT INTO orders (order_id, store_id, status, billing_address, shipping_address, ordered_at)
		VALUES(ord_id, st_id, 'Pending', '123 Main St.', null, NOW()::date);

		-- Insert 1-3 line items for the order
		FOR i IN 1..floor(random() * (3) + 1) LOOP
			-- Retrieve a random product associated with the selected store.
			product_count := (SELECT count(*) FROM products WHERE store_id = st_id);
			prod_id = (SELECT product_id FROM products WHERE store_id = st_id OFFSET floor(random() * product_count) LIMIT 1);
			prod_price = (SELECT price FROM products WHERE store_id = st_id AND product_id = prod_id);
			quantity = floor(random() * (4) + 1);
			line_amt = prod_price * quantity;

			-- Insert a new line_item row
			INSERT INTO line_items (line_item_id, product_id, order_id, quantity, line_amount)
			VALUES(DEFAULT, prod_id, ord_id, quantity, line_amt);
		END LOOP;
	END LOOP;
END;
$$;