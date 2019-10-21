public async Task<CustomerOrder> GetById(int id)
{
    CustomerOrder order = await GetOrderById(id)
        .Select(o => new CustomerOrder
        {
            OrderId = o.Id,
            CustomerName = $"{o.Customer.LastName}, {o.Customer.FirstName}",
            OrderFulfilled = o.OrderFulfilled.HasValue ? 
                o.OrderFulfilled.Value.ToShortDateString() : string.Empty,
            OrderPlaced = o.OrderPlaced.ToShortDateString(),
            OrderLineItems = (o.ProductOrders.Select(po => new OrderLineItem
            {
                ProductQuantity = po.Quantity,
                ProductName = po.Product.Name
            }))
        })
        .TagWith(nameof(GetById))
        .FirstOrDefaultAsync();

    return order;
}