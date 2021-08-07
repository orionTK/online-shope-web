using clothing_store.Common.DAL;
using clothing_store.Common.Rsp;
using clothing_store.DAL.Models;
using System;
using System.Linq;

namespace clothing_store.DAL
{
    public class PromotionRep : GenericRep<OnlineStoreContext, Promotion>
    {
        #region -- Override --
        public override Promotion Read(int id)
        {
            var res = All.FirstOrDefault(p => p.PromotionId == id);
            return res;
        }

        public int Remove(int id)
        {
            var m = base.All.FirstOrDefault(p => p.PromotionId == id);
            m = base.Delete(m);
            return m.PromotionId;
        }
        #endregion

        #region -- Methods --

        public object GetAll()
        {
            var res = Context.Promotion.Select(p => new
                {
                    p.PromotionId,
                    p.PromotionName,
                    p.DiscountPercent,
                    SalePercent = String.Format("{0:0}%", p.DiscountPercent * 100),
                    Discount = Math.Round(p.DiscountPercent * 100)
                }).ToList();
            return res;
        }

        public SingleRsp CreatePromotion(Promotion promotion)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.Promotion.Add(promotion);
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

        public SingleRsp UpdatePromotion(Promotion promotion)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.Promotion.Update(promotion);
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

        public object SearchPromotion(String keyword, int page, int size)
        {
            var pro = Context.Promotion.Select(p => new
            {
                p.PromotionId,
                p.PromotionName,
                p.DiscountPercent,
                SalePercent = String.Format("{0:0}%", p.DiscountPercent * 100),
                Discount = p.DiscountPercent * 100
            });
            if (!string.IsNullOrEmpty(keyword))
            {
                pro = pro.Where(x => x.PromotionName.Contains(keyword));
            }

            var offset = (page - 1) * size;
            var total = pro.Count();
            int totalPages = (total % size) == 0 ? (int)(total / size) : (int)((total / size) + 1);
            var data = pro.OrderBy(x => x.PromotionName).Skip(offset).Take(size).ToList();

            var res = new
            {
                Data = data,
                TotalRecord = total,
                TotalPages = totalPages,
                Page = page,
                Size = size
            };
            return res;
        }

        public SingleRsp DeletePromotion(Promotion prom)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.Promotion.Remove(prom);
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

        #endregion

    }
}
