private IQueryable<Order> GetOrderById(int id) =>
    from o in _context.Orders.AsNoTracking()
                             .TagWith(nameof(GetOrderById))
    where o.Id == id
    select o;