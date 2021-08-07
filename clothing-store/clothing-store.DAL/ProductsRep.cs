using System;
using clothing_store.Common.DAL;


namespace clothing_store.DAL
{
    using clothing_store.Common.Rsp;
    using clothing_store.DAL.Models;
    using System.Linq;

    public class ProductsRep : GenericRep<OnlineStoreContext, Products>
    {
        #region -- Override --
        public override Products Read(int id)
        {
            var res = All.FirstOrDefault(p => p.ProductId == id);
            return res;
        }


        public int Remove(int id)
        {
            var m = base.All.FirstOrDefault(p => p.ProductId == id);
            m = base.Delete(m);
            return m.ProductId;
        }
        #endregion

        #region -- Methods --
        // Lấy tất cả sản phẩm của nam hoặc nữ, nam: false; nữ: true
        public object GetAllProductByGender_Linq(bool gender)
        {
            var res = Context.Products
                .Join(Context.Categories, a => a.CategoryId, b => b.CategoryId, (a, b) => new
                {
                    a.ProductId,
                    a.CategoryId,
                    a.ProductName,
                    a.Price,
                    a.Stock,
                    a.DateCreate,
                    a.Description,
                    a.ImageSource,
                    a.PromotionId,
                    b.Gender
                }).Where(x => x.Gender == gender).ToList();
            return res;
        }
       
        // Lấy sản phẩm theo loại sản phẩm
        public object GetProductByCategoryName_Linq(String keyword, int page, int size, string categoryName, bool gender)
        {
            var pro = Context.Products
                .Join(Context.Categories, a => a.CategoryId, b => b.CategoryId, (a, b) => new
                {
                    a.ProductId,
                    a.CategoryId,
                    a.ProductName,
                    a.Price,
                    a.Stock,
                    a.DateCreate,
                    a.Description,
                    a.ImageSource,
                    a.PromotionId,
                    b.CategoryName,
                    b.Gender
                }).Where(x => x.CategoryName == categoryName && x.Gender == gender).ToList();
            var offset = (page - 1) * size;
            var total = pro.Count();
            int totalPages = (total % size) == 0 ? (int)(total / size) : (int)((total / size) + 1);
            var data = pro.OrderBy(x => x.ProductName).Skip(offset).Take(size).ToList();

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

        // Lấy sản phẩm có khuyến mãi theo giới tính
        public object GetProductByPromotion_Linq(bool gender)
        {
            var res = Context.Products
                .Join(Context.Categories, a => a.CategoryId, b => b.CategoryId, (a, b) => new
                {
                    a.ProductId,
                    a.CategoryId,
                    a.ProductName,
                    a.Price,
                    a.Stock,
                    a.DateCreate,
                    a.Description,
                    a.ImageSource,
                    a.PromotionId,
                    b.Gender
                }).Where(x => x.Gender == gender && x.PromotionId > 0).ToList();
            return res;
        }

        public SingleRsp CreateProduct(Products products)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.Products.Add(products);
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

        public SingleRsp UpdateProduct(Products pro)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.Products.Update(pro);
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

        public SingleRsp DeleteProduct(Products pro)
        {
            var res = new SingleRsp();
            using (var context = new OnlineStoreContext())
            {
                using (var tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        var t = context.Products.Remove(pro);
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

        // Product-Sale promotionId > 0 (Tested)
        public object GetSP_ProductSale(String keyword, int page, int size)
        {
            var emp = Context.Products
                .Join(Context.Promotion, a => a.PromotionId, b => b.PromotionId, (a, b) => new
                {
                    a.ProductId,
                    a.ProductName,
                    a.Price,
                    a.PromotionId,
                    a.Description,
                    b.DiscountPercent,
                    a.ImageSource,
                    SalePrice = a.Price * (1 - ((decimal)b.DiscountPercent))
                }).Where(x => x.PromotionId > 0).ToList();

            var offset = (page - 1) * size;
            var total = emp.Count();
            int totalPages = (total % size) == 0 ? (int)(total / size) : (int)((total / size) + 1);
            var pro = emp.GroupBy(x => x.ProductId)
                .Select(x => new
                {
                    ProductID = x.First().ProductId,
                    ProductName = x.First().ProductName,
                    Price = x.First().Price,
                    Description = x.First().Description,
                    DiscountPercent = x.First().DiscountPercent,
                    ImageSource = x.First().ImageSource,
                    SalePrice = x.First().SalePrice
                }).ToList();
            var data = pro.OrderBy(x => x.ProductName).Skip(offset).Take(size).ToList();

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

        //Product-Accessories CategoryName include "Phụ kiện" (Tested)
        public object GetSP_ProductAccessories(String keyword, int page, int size)
        {
            var emp = Context.Products
                .Join(Context.Categories, a => a.CategoryId, b => b.CategoryId, (a, b) => new
                {
                    a.ProductId,
                    a.ProductName,
                    a.Price,
                    a.Description,
                    a.ImageSource,
                    a.PromotionId,
                    b.CategoryName
                })
                .Join(Context.Promotion, a => a.PromotionId, b => b.PromotionId, (a, b) => new
                {
                    a.ProductId,
                    a.ProductName,
                    a.Price,
                    a.Description,
                    a.ImageSource,
                    b.DiscountPercent,
                    a.CategoryName
                }).Where(x => x.CategoryName.Contains("Phụ kiện")).ToList();
            var offset = (page - 1) * size;
            var total = emp.Count();
            int totalPages = (total % size) == 0 ? (int)(total / size) : (int)((total / size) + 1);
            var pro = emp.GroupBy(x => x.ProductId)
                .Select(x => new
                {
                    ProductID = x.First().ProductId,
                    ProductName = x.First().ProductName,
                    Price = x.First().Price,
                    Description = x.First().Description,
                    ImageSource = x.First().ImageSource,
                    DiscountPercent = x.First().DiscountPercent

                }).ToList();
            var data = pro.OrderBy(x => x.ProductName).Skip(offset).Take(size).ToList();

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

        public object SearchProduct(String keyword, int page, int size)
        {
            var pro = Context.Products
                .Join(Context.Categories, a => a.CategoryId, b => b.CategoryId, (a, b) => new
                {
                    a.ProductId,
                    a.ProductName,
                    a.Price,
                    a.Stock,
                    a.DateCreate,
                    a.Description,
                    a.ImageSource,
                    a.CategoryId,
                    a.PromotionId,
                    b.CategoryName
                })
                .Join(Context.Promotion, a => a.PromotionId, b => b.PromotionId, (a, b) => new
                {
                    a.ProductId,
                    a.ProductName,
                    a.Price,
                    a.Stock,
                    a.DateCreate,
                    a.Description,
                    a.ImageSource,
                    a.CategoryId,
                    a.PromotionId,
                    a.CategoryName,
                    b.DiscountPercent,
                    SalePercent = String.Format("{0:0}%", b.DiscountPercent * 100),
                    SalePrice = a.Price * (1 - ((decimal)b.DiscountPercent))
                });
            if(!string.IsNullOrEmpty(keyword))
            {
                pro = pro.Where(x => x.ProductName.Contains(keyword));
            }

            var offset = (page - 1) * size;
            var total = pro.Count();
            int totalPages = (total % size) == 0 ? (int)(total / size) : (int)((total / size) + 1);
            var data = pro.OrderBy(x => x.ProductName).Skip(offset).Take(size).ToList();

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

        public object SearchProductByGender(String keyword, int page, int size, bool gender)
        {
            var pro = Context.Products
                .Join(Context.Categories, a => a.CategoryId, b => b.CategoryId, (a, b) => new
                {
                    a.ProductId,
                    a.ProductName,
                    a.Price,
                    a.Description,
                    a.ImageSource,
                    a.PromotionId,
                    b.Gender
                }).Where(x => x.ProductName.Contains(keyword) && x.Gender == gender);

            var offset = (page - 1) * size;
            var total = pro.Count();
            int totalPages = (total % size) == 0 ? (int)(total / size) : (int)((total / size) + 1);
            var data = pro.OrderBy(x => x.ProductName).Skip(offset).Take(size).ToList();

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

        public object getProductsId(int id)
        {
            var res = Context.Products
                .Join(Context.Promotion, a => a.PromotionId, b => b.PromotionId, (a, b) => new
                {
                    a.ProductId,
                    a.CategoryId,
                    a.ProductName,
                    a.Price,
                    a.ImageSource,
                    a.DateCreate,
                    a.Stock,
                    a.Description,
                    a.PromotionId,
                    b.DiscountPercent,
                    SalePercent = String.Format("{0:0}%", b.DiscountPercent * 100)
                }).Where(x => x.ProductId == id).First();

            return res;
        }

        #endregion
    }
}
