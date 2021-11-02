using BlazingPizza.Server.Extensions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;

namespace BlazingPizza.Server.Hubs
{
    [Authorize]
    public class OrderStatusHub : Hub<IOrderStatusHub>
    {
        /// <summary>
        /// Adds the current connection to the order's unique group identifier, where 
        /// order status changes will be notified in real-time.
        /// </summary>
        public Task StartTrackingOrder(Order order) =>
            Groups.AddToGroupAsync(
                Context.ConnectionId, order.ToOrderTrackingGroupId());

        /// <summary>
        /// Removes the current connection from the order's unique group identifier, 
        /// ending real-time change updates for this order.
        /// </summary>
        public Task StopTrackingOrder(Order order) =>
            Groups.RemoveFromGroupAsync(
                Context.ConnectionId, order.ToOrderTrackingGroupId());
    }
}
