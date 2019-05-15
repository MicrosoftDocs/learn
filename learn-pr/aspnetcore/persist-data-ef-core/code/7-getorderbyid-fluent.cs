private IQueryable<Order> GetOrderById(int id) =>
    _context.Orders.AsNoTracking()
        .TagWith(nameof(GetOrderById))
        .Where(o => o.Id == id);