using System;
using clothing_store.Common.DAL;
using clothing_store.Common.Rsp;
using clothing_store.DAL.Models;
using System.Linq;

namespace clothing_store.DAL
{
    // Đây là lớp đại diện cho đối tượng Categories
    public class OrderRep : GenericRep<OnlineStoreContext, Orders>
    {
        #region -- Overrides --
        public override Orders Read(int id)
        {
            var res = All.FirstOrDefault(p => p.OrderId == id);
            return res; // thay vi ghi base.All thi ghi All no cung hieu
        }

        public int Remove(int id)
        {
            var m = base.All.First(i => i.OrderId == id);
            m = base.Delete(m);
            return m.OrderId;
        }
        #endregion

        #region -- methods --

        public SingleRsp CreateOrder(Orders orders)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {


                    try
                    {
                        var t = context.Orders.Add(orders);
                        context.SaveChanges();
                        tran.Commit();
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        res.SetError(ex.StackTrace);
                    }
                }
            }
            return res;
        }

        public SingleRsp CreateOrderDetails(OrderDetails orderDetails)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.OrderDetails.Add(orderDetails);
                        context.SaveChanges();
                        tran.Commit();
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        res.SetError(ex.StackTrace);
                    }
                }
            }
            return res;
        }

        public SingleRsp CheckOut(int OrderId)
        {
            var res = new SingleRsp();
            
            return res;
        }
        #endregion


    }
}
