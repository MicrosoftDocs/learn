SUBSCRIBE staff.newhire

SUBSCRIBE orders.new orders.delete

PSUBSCRIBE inventory.*

PSUBSCRIBE *.new

PSUBSCRIBE *orders* *staff*

UNSUBSCRIBE staff.newhire

UNSUBSCRIBE orders.new orders.delete

UNSUBSCRIBE

PUNSUBSCRIBE inventory.*

PUNSUBSCRIBE inventory.* orders.* staff.*

PUNSUBSCRIBE

PUBLISH orders.delete sad348957298s534gh

PUBLISH staff.newhire 02a67b49-9da1-487e-8b49-d5aad3f514ae