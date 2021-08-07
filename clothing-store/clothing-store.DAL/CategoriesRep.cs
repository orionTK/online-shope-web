using System;
using clothing_store.Common.DAL;
using clothing_store.Common.Rsp;
using clothing_store.DAL.Models;
using System.Linq;

namespace clothing_store.DAL
{
    // Đây là lớp đại diện cho đối tượng Categories
    public class CategoriesRep : GenericRep<OnlineStoreContext, Categories>
    {
        #region -- Overrides --
        public override Categories Read(int id)
        {
            var res = All.FirstOrDefault(p => p.CategoryId == id);
            return res; // thay vi ghi base.All thi ghi All no cung hieu
        }

        public int Remove(int id)
        {
            var m = base.All.First(i => i.CategoryId == id);
            m = base.Delete(m);
            return m.CategoryId;
        }
        #endregion

        #region -- methods --

        public SingleRsp CreateCategory(Categories categories)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.Categories.Add(categories);
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

        public SingleRsp UpdateCategory(Categories categories)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.Categories.Update(categories);
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

        public SingleRsp DeleteCategory(Categories categories)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.Categories.Remove(categories);
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

        public object SearchCategory(String keyword, int page, int size)
        {
            var category = Context.Categories.Select(p => new
            {
                p.CategoryId,
                p.CategoryName,
                p.Title,
                p.Description,
                p.Gender,
                GioiTinh = p.Gender == true ? "Nữ" : "Nam"
            });
            if (!string.IsNullOrEmpty(keyword))
            {
                category = category.Where(x => x.CategoryName.Contains(keyword));
            }

            var offset = (page - 1) * size;
            var total = category.Count();
            int totalPages = (total % size) == 0 ? (int)(total / size) : (int)((total / size) + 1);
            var data = category.OrderBy(x => x.CategoryName).Skip(offset).Take(size).ToList();

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

        #endregion

        public object GetCategoryNameByGender_Linq(bool gender)
        {
            var res = Context.Categories
                .Where(x => x.Gender == gender)
                .Select(p => new { p.CategoryName }).ToList();
            return res;
        }
       
    }
}
