using clothing_store.Common.Rsp;
using clothing_store.Common.BLL;

namespace clothing_store.BLL
{
    using clothing_store.Common.Req;
    using clothing_store.DAL.Models;
    using DAL;

    public class OrderDetailsSvc : GenericSvc<OrderDetailsRep, OrderDetails>
    {
        #region -- Overrides --
        public override SingleRsp Read(int id)
        {
            var res = new SingleRsp();

            var m = _rep.Read(id);
            res.Data = m;

            return res;
        }

        public override int Remove(int id)
        {
            var res = new SingleRsp();

            var m = _rep.Remove(id);
            res.Data = m;

            return 0;
        }

       
        #endregion

        #region -- Methods --
        public SingleRsp CreateOrderDetails(OrderDetailsReq orderDetail)
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

       
        #endregion
    }
}
