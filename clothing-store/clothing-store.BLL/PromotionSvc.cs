using clothing_store.Common.BLL;
using clothing_store.Common.Req;
using clothing_store.Common.Rsp;
using clothing_store.DAL;
using clothing_store.DAL.Models;
using System;
using System.Linq;

namespace clothing_store.BLL
{
    public class PromotionSvc : GenericSvc<PromotionRep, Promotion>
    {
        #region -- Overrides --
        public override SingleRsp Read(int id)
        {
            var res = new SingleRsp();

            var m = _rep.Read(id);
            res.Data = m;

            return res;
        }

        public override SingleRsp Update(Promotion m)
        {
            var res = new SingleRsp();

            var m1 = m.PromotionId > 0 ? _rep.Read(m.PromotionId) : _rep.Read(m.PromotionId);
            if (m1 == null)
            {
                res.SetError("EZ103", "No data.");
            }
            else
            {
                res = base.Update(m);
                res.Data = m;
            }

            return res;
        }

        #endregion

        #region -- Methods --

        public object GetAll()
        {
            return _rep.GetAll();
        }
        public SingleRsp CreatePromotion(PromotionReq prom)
        {
            var res = new SingleRsp();
            Promotion promotion = new Promotion();
            promotion.PromotionId = prom.PromotionId;
            promotion.PromotionName = prom.PromotionName;
            promotion.DiscountPercent = prom.DiscountPercent;

            res = _rep.CreatePromotion(promotion);
            return res;
        }

        public SingleRsp UpdatePromotion(PromotionReq prom)
        {
            var res = new SingleRsp();
            Promotion promotion = new Promotion();
            promotion.PromotionId = prom.PromotionId;
            promotion.PromotionName = prom.PromotionName;
            promotion.DiscountPercent = prom.DiscountPercent;

            res = _rep.UpdatePromotion(promotion);
            return res;
        }

        public SingleRsp DeletePromotion(Promotion prom)
        {
            var res = new SingleRsp();
            res = _rep.DeletePromotion(prom);
            return res;
        }

        public object SearchPromotion(String keyword, int page, int size)
        {
            return _rep.SearchPromotion(keyword, page, size);
        }
        
        #endregion
    }
}
