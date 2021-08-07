using System;
using clothing_store.Common.DAL;


namespace clothing_store.DAL
{
    using clothing_store.Common.Rsp;
    using clothing_store.DAL.Models;
    using System.Linq;

    public class CartsRep : GenericRep<OnlineStoreContext, Carts>
    {
        #region -- Override --
        public override Carts Read(int id)
        {
            var res = All.FirstOrDefault(p => p.UserId == id);
            return res;
        }

        public int Remove(int id)
        {
            var m = base.All.FirstOrDefault(p => p.UserId == id);
            m = base.Delete(m);
            return m.UserId;
        }
        #endregion

        #region -- Methods --

        //Tạo - Chia làm 2 trường hợp
        public SingleRsp CreateCart(Carts carts)
        {
            var res = new SingleRsp();
            var pro = Context.Carts.Where(x => x.UserId == carts.UserId)
                .Where(x => x.ProductId == carts.ProductId)
                .Where(x => x.Size == carts.Size).ToList();
            if (pro.Count != 0)
            {
                carts.Quantity += pro.FirstOrDefault().Quantity;
                res = UpdateCart(carts.UserId, carts.ProductId, carts.Size, carts.Quantity);
            }
            else
                using (var context = new OnlineStoreContext())
                {
                    using (var tran = context.Database.BeginTransaction())
                    {
                        try
                        {
                            var t = context.Carts.Add(carts);
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

        //Update -- chỉ sửa size và số lượng
        public SingleRsp UpdateCart(int UserId, int ProductId, string Size, short Quantity)
        {
            var res = new SingleRsp();
            
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        Carts carts = Context.Carts.Where(x => x.UserId == UserId)
                            .Where(x => x.ProductId == ProductId)
                            .Where(x => x.Size == Size).FirstOrDefault();
                        carts.Quantity = Quantity;
                        var t = context.Carts.Update(carts);
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

        //Xóa
        public SingleRsp DeleteCart(int userId)
        {
            var res = new SingleRsp();
            var list = Context.Carts
               .Where(x => x.UserId == userId)
               .ToList();

                using (var context = new OnlineStoreContext())
                {
                    using (var tran = context.Database.BeginTransaction())
                    {
                        foreach (Carts cart in list)
                        {
                            try
                            {

                                var t = context.Carts.Remove(cart);
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
                }
           
            return res;
        }

        //Tìm kiếm
        public object FindCart(int userId)
        {
            var list = Context.Carts
               .Where(x => x.UserId == userId).ToList();
            return list;
        }

        //Xóa sản phẩm trong Cart
        public SingleRsp DeleteProductCart(Carts cart)
        {
            var res = new SingleRsp();
            


            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.Carts.Remove(cart);
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
            res.Data = "Delete-OK";
            return res;
        }

        public object GetCart_Linq(int UserId)
        {
            var res = Context.Carts
                .Join(Context.Products, a => a.ProductId, b => b.ProductId, (a, b) => new
                {
                    a.ProductId,
                    a.Size,
                    a.Quantity,
                    b.Price,
                    b.PromotionId,
                    b.DateCreate,
                    b.ImageSource,
                    a.UserId,
                    b.ProductName
                })
                .Join(Context.Promotion, a => a.PromotionId, b => b.PromotionId, (a, b) => new
                {
                    a.ProductId,
                    a.Size,
                    a.Quantity,
                    a.Price,
                    a.PromotionId,
                    a.DateCreate,
                    a.ImageSource,
                    a.UserId,
                    b.DiscountPercent,
                    PriceSale = (decimal)(1 - b.DiscountPercent) * a.Price,
                    a.ProductName,
                    Total = (decimal)(1 - b.DiscountPercent) * a.Price * a.Quantity

                }).Where(x => x.UserId == UserId).ToList();
            
            return res;
        }
        #endregion
    }
}
