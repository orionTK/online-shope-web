using System;
using clothing_store.Common.Rsp;
using clothing_store.Common.BLL;

namespace clothing_store.BLL
{
    using clothing_store.Common.Req;
    using clothing_store.DAL.Models;
    using DAL;
    using System.Linq;

    public class CategoriesSvc:GenericSvc<CategoriesRep, Categories>
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

        public override SingleRsp Update(Categories m)
        {
            var res = new SingleRsp();

            var m1 = m.CategoryId > 0 ? _rep.Read(m.CategoryId) : _rep.Read(m.CategoryName);
            if(m1==null)
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
        public SingleRsp CreateCategory(CategoriesReq category)
        {
            var res = new SingleRsp();
            Categories categories = new Categories();
            categories.CategoryId = category.CategoryId;
            categories.CategoryName = category.CategoryName;
            categories.Title = category.Title;
            categories.Description = category.Description;
            categories.Gender = category.Gender;
            
            res = _rep.CreateCategory(categories);
            return res;
        }

        public SingleRsp UpdateCategory(CategoriesReq category)
        {
            var res = new SingleRsp();
            Categories categories = new Categories();
            categories.CategoryId = category.CategoryId;
            categories.CategoryName = category.CategoryName;
            categories.Title = category.Title;
            categories.Description = category.Description;
            categories.Gender = category.Gender;

            res = _rep.UpdateCategory(categories);
            return res;
        }

        public SingleRsp DeleteCategory(Categories categories)
        {
            var res = new SingleRsp();
            res = _rep.DeleteCategory(categories);
            return res;
        }

        public object SearchCategory(String keyword, int page, int size)
        {
            return _rep.SearchCategory(keyword, page, size);
        }

        public object GetCategoryNameByGender_Linq(bool gender)
        {
            return _rep.GetCategoryNameByGender_Linq(gender);
        }
        #endregion
    }
}
