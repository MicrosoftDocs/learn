public async Task<CustomerOrder> GetById(int id)
{
    CustomerOrder order = await (
        from o in GetOrderById(id)
        select new CustomerOrder
        {
            OrderId = o.Id,
            CustomerName = $"{o.Customer.LastName}, {o.Customer.FirstName}",
            OrderFulfilled = o.OrderFulfilled.HasValue ? 
                o.OrderFulfilled.Value.ToShortDateString() : string.Empty,
            OrderPlaced = o.OrderPlaced.ToShortDateString(),
            OrderLineItems = (from po in o.ProductOrders
                                select new OrderLineItem
                                {
                                    ProductQuantity = po.Quantity,
                                    ProductName = po.Product.Name
                                })
        })
        .TagWith(nameof(GetById))
        .FirstOrDefaultAsync();

    return order;
}