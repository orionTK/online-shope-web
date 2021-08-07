using System;
using System.Collections.Generic;
using System.Text;

using clothing_store.Common.Rsp;
using clothing_store.Common.BLL;

namespace clothing_store.BLL
{
    using clothing_store.Common.Req;
    using clothing_store.DAL.Models;
    using DAL;
    using System.Linq;
    using System.Reflection.Metadata.Ecma335;

    public class OrderSvc : GenericSvc<OrderRep, Orders>
    {
        #region -- Overrides --
        public override SingleRsp Read(int id)
        {
            var res = new SingleRsp();

            var m = _rep.Read(id);
            res.Data = m;

            return res;
        }


        #endregion


        public SingleRsp CreateOrder(OrderReq order)
        {
            DateTime now = DateTime.Now;
            order.OrderDate = now;
            var res = new SingleRsp();
            Orders orders = new Orders();
            orders.OrderId = order.OrderId;
            orders.UserId = order.UserId;
            orders.OrderDate = order.OrderDate;
            orders.ShipName = order.ShipName;
            orders.ShipAddress = order.ShipAddress;
            orders.ShipPhoneNumber = order.ShipPhoneNumber;
            orders.Status = order.Status;

            res = _rep.CreateOrder(orders);
            return res;
        }

        public SingleRsp CreateOrderDetail(OrderDetailsReq orderDetail)
        {
            var res = new SingleRsp();
            OrderDetails orderDetails = new OrderDetails();
            orderDetails.OrderId = orderDetail.OrderId;
            orderDetails.ProductId = orderDetail.ProductId;
            orderDetails.Size = orderDetail.Size;
            orderDetails.UnitPrice = orderDetail.UnitPrice;
            orderDetails.Quantity = orderDetail.Quantity;
            orderDetails.Discount = orderDetail.Discount;

            res = _rep.CreateOrderDetails(orderDetails);
            return res;
        }

        


    }
}
